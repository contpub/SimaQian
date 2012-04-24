package simaqian

import groovy.json.JsonBuilder

import org.jets3t.service.*
import org.jets3t.service.model.*
import org.jets3t.service.security.*
import org.jets3t.service.impl.rest.httpclient.*

import java.awt.*
import java.awt.image.*
import javax.imageio.*
import java.io.*;

/**
 * Book Controller
 */
class BookController {

    // Grails S3 Services is not working
    //S3AssetService s3AssetService
    //S3ClientService s3ClientService

    def index = {
        def user = User.get(session.userId)
        def books = []

        (user?.books*.book).each {
            book ->
            if (!book.isDeleted) {
                books << book
            }
        }

        [
            books: books
        ]
    }
    
    /**
     * Read a book
     */
    def read = {
        def bookName = params.bookName
        
        //bookName = bookName?.substring(5)
        def book = Book.findByName(bookName)
        def user = User.get(session.userId)
        
        if (!book || book.isDeleted) {
            response.sendError 404
            return
        }
        
        def link = UserAndBook.findByUserAndBook(user, book)

        if (params.makeowner != null) {
            if (!link) {
                link = new UserAndBook()
                link.user = user
                link.book = book
            }
            link.linkType = UserAndBookLinkType.OWNER
            link.save(flush: true)
        }

        def userBuyBook = link?.linkType?.equals(UserAndBookLinkType.BUYER)
        def userOwnBook = link?.linkType?.equals(UserAndBookLinkType.OWNER)
    
        render (view: 'read', model: [
            book: book,
            userBuyBook: userBuyBook,
            userOwnBook: userOwnBook
        ])
    }

    /**
     * list books for user
     */
    def user = {
        def user = User.get(params.id)
        def books = []

        if (!user) { response.sendError 404; return }

        (user.books).each {
            link ->
            if (link.linkType==UserAndBookLinkType.OWNER) {
                books << link.book
            }
        }

        [
            user: user,
            books: books
        ]
    }

    def parseFileName(bookName) {
        def dotPos = bookName.lastIndexOf('.')
        bookName.substring(0, dotPos)
    }

    def parseExtName(bookName) {
        def dotPos = bookName.lastIndexOf('.')
        bookName.substring(dotPos+1)
    }
    
    /**
     * Permalinks for Download Books, redirect to Amazon S3 Signed URL
     */
    def download = {
        def bookName = parseFileName(params.bookName)
        def fileExt = parseExtName(params.bookName)
        
        def user = User.get(session.userId)
        def book = Book.findByName(bookName)

        // book not found
        if (!book) {
            response.sendError 404
            return
        }

        if (!book.isPublic) {
            def link = UserAndBook.findByBookAndUser(book, user)

            def perms = [UserAndBookLinkType.OWNER, UserAndBookLinkType.BUYER]

            if (!link || !perms.contains(link.linkType)) {
                response.sendError 403
                return
            }
        }
        
        def awsCredentials = new AWSCredentials(
            grailsApplication.config.aws.accessKey,
            grailsApplication.config.aws.secretKey
        )
        
        def s3Service = new RestS3Service(awsCredentials)

        def bucket = s3Service.getBucket(grailsApplication.config.aws.bucketName)
        def bucketName = grailsApplication.config.aws.bucketName
        
        def cal = Calendar.instance
        cal.add(Calendar.MINUTE, 3)
        def expiryDate = cal.time
        
        //def filepath = "${book.name.substring(0,1).toLowerCase()}/${book.name}.${fileExt}"
        def filePath = "book/${book.name}.${fileExt}"
        
        if (params.redirect != null) {
            def signedUrl = s3Service.createSignedGetUrl(bucketName, filePath, awsCredentials, expiryDate, false)        
            //dirty hack for https(ssl) auth failed
            signedUrl = signedUrl.replace('https://', 'http://')
            redirect (url: signedUrl)
        }
        else {
            try {
                def object = s3Service.getObject(bucket, filePath)
                response.contentType = object.contentType
                response.setHeader "Content-length", "${object.contentLength}"
                response.setHeader "Content-Disposition", "inline; filename=\"${bookName}.${fileExt}\""
                response.outputStream << object.dataInputStream
            }
            catch (ex) {
                response.sendError 404
                return
            }
        }
    }
    
    /**
     * Cover image for Book
     */
    def cover = {       
        def bookName = parseFileName(params.bookName)
        def fileExt = parseExtName(params.bookName)

        def book = Book.findByName(bookName)

        if (!book) {
            response.sendError 404
            return
        }

        def awsCredentials = new AWSCredentials(
            grailsApplication.config.aws.accessKey,
            grailsApplication.config.aws.secretKey
        )
        
        def s3Service = new RestS3Service(awsCredentials)

        def bucket = s3Service.getBucket(grailsApplication.config.aws.bucketName)
        def bucketName = grailsApplication.config.aws.bucketName
        
        def cal = Calendar.instance
        cal.add(Calendar.MINUTE, 10)
        def expiryDate = cal.time
        
        //def filepath = "${book.name.substring(0,1).toLowerCase()}/${book.name}.${fileExt}"
        def filePath = "book/${bookName}.png"

        try {
            def object = s3Service.getObject(bucket, filePath)
            def bytes = object.dataInputStream.bytes
            response.contentType = "image/png"
            response.setHeader "Content-length", "${bytes.length}"
            response.setHeader "Content-Disposition", "inline; filename=\"${bookName}.png\""
            response.outputStream << bytes
        }
        catch (e) {
            def image = new BufferedImage(95, 115, BufferedImage.TYPE_INT_ARGB)
            def g2d = image.createGraphics()
            // render to graphics 2d - 
            // graphics2D.drawString(...), graphics2D.drawLine(...), etc.

            def castle = ImageIO.read(grailsAttributes.applicationContext.getResource('/images/book_cover.png').file)

            g2d.drawImage(castle, 0, 0, null);

            g2d.setRenderingHint( RenderingHints.KEY_TEXT_ANTIALIASING,
                            RenderingHints.VALUE_TEXT_ANTIALIAS_ON )
            //g2d.setFont(new Font("Adobe Heiti Std", Font.PLAIN, 12))
            g2d.setFont(new Font("sans-serif", Font.PLAIN, 12))

            FontMetrics fm = g2d.getFontMetrics();
            int lineHeight = fm.getHeight()*0.75;
            def x=22, y=30, width=95-22
            int curX = x;
            int curY = y;
            
            String[] words = "${book.title}".split(" ");
            def c = 0
            for (String word : words) {
                int wordWidth = fm.stringWidth(word + " ");
                if (c++ > 0) {
                    if (curX + wordWidth >= x + width) {
                        curY += lineHeight;
                        curX = x;
                    }
                }
                g2d.drawString(word, curX, curY);
                curX += wordWidth;
            }
            //g2d.drawString("${book.title}", 25, 30)

            g2d.dispose()

            response.contentType = "image/png"
            response.setHeader "Content-Disposition", "inline; filename=\"${bookName}.png\""

            def stream = response.outputStream
            ImageIO.write(image, "png", stream)
            stream.close()
        }
    }

    /**
     * Add a book to shopping cart
     */
    def addToCart = {
        def book = Book.get(params.id)
        
        if (book) {
            //checkout
            redirect (action: 'checkout', id: params.id)
        }
        else {
            redirect (action: 'index')
        }
    }
    
    /**
     * Checkout
     */
    def checkout = {
        def book = Book.get(params.id)
        [book: book]
    }
    
    /**
     * Checkout Save
     */
    def checkoutSave = {
        def user = User.get(session.userId)
        def book = Book.get(params.id)
        
        if (book) {
            def link = new UserAndBook(
                user: user,
                book: book
            )
            link.save(flush: true)
            user.addToBooks(link)
            book.addToUsers(link)
            user.save(flush: true)
            book.save(flush: true)
            
            redirect (action: 'read', id: book.name)
        }
        else {
            redirect (action: 'index')
        }
    }
    
    /**
     * Get embedded contents
     */
    def embed = {
        def contentType = 'text/plain'

        //Implement SecretKey here!!!
        def book = Book.get(params.id)

        if (!book) {
            book = new Book()
        }
        
        if (params.index != null) {
            return renderIndex(book)
        }
        else if (params.syntax != null) {
            return renderSyntax(book)
        }
        
        def contents = book.profile?.contents

        if (!contents) {
            contents = 'empty'
        }

        render (contentType: contentType, encoding: 'UTF-8', text: contents)
    }

    def renderIndex(book) {
        def contents = """.. metadata
   @project: ${book.name}
   @title: ${book.title}
   @authors: ${book.authors}
   @language: zh_TW
   @html_theme: nature
   @epub_theme: epub_simple
   @mobi_theme: mobi_simple

####
${book.title}
####

.. toctree::
   :maxdepth: 1

   contents
"""
        render (contentType: 'text/plain', encoding: 'UTF-8', text: contents)
    }

    //using codemirror layout
    def renderSyntax(book) {
        return render (template: 'codemirror', model: [contents: book.profile?.contents])
    }

    //using pygments layout
    def renderSyntax2(book) {
        try {
            def pygmentize = grailsApplication.config.executable?.pygmentize

            if (!pygmentize) {
                pygmentize = "pygmentize"
            }

            //def options = "full,style=trac,linenos=1,encoding=utf-8"
            def options = "linenos=1,encoding=utf-8"
            def command = "${pygmentize} -O ${options} -l rst -f html"
            def proc = command.execute()

            proc.withWriter { writer ->
                writer << book.profile?.contents
            }

            proc.waitForOrKill(3000)

            return render (template: 'pygments', model: [contents: proc.text])
        }
        catch (e) {
            return render (contentType: 'text/plain', encoding: 'UTF-8', text: e.message)
        }
    }
}
