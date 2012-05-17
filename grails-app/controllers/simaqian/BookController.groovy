package simaqian

import grails.converters.*

import groovy.json.JsonBuilder

import org.jets3t.service.*
import org.jets3t.service.model.*
import org.jets3t.service.security.*
import org.jets3t.service.impl.rest.httpclient.*

import java.awt.*
import java.awt.image.*
import javax.imageio.*
import java.io.*;

import java.util.zip.*;


/**
 * Book Controller
 */
class BookController {

    def bookService
    def imageService
    def s3Service
    
    /**
     * List of books
     */
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
        def user = User.get(session.userId)
        def books = []

        if (params.id) {
            user = User.get(params.id)
        }

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
    
    /**
     * Permalinks for Download Books, redirect to Amazon S3 Signed URL
     */
    def download = {
        def bookName = params.bookName
        def fileExt = response.format
        
        def user = User.get(session.userId)
        def book = Book.findByName(bookName)

        // book not found
        if (!book) { response.sendError 404; return }

        if (!book.isPublic) {
            def link = UserAndBook.findByBookAndUser(book, user)

            def perms = [UserAndBookLinkType.OWNER, UserAndBookLinkType.BUYER]

            if (!link || !perms.contains(link.linkType)) {
                response.sendError 403
                return
            }
        }

        if (params.redirect != null) {
            def signedUrl = s3Service.createSignedGetUrl("book/${book.name}.${fileExt}", 3)
            redirect (url: signedUrl.replace('https://', 'http://'))
        }
        else {
            try {
                def object = s3Service.getObject("book/${book.name}.${fileExt}")
                response.contentType = object.contentType
                response.setHeader "Content-length", "${object.contentLength}"
                response.setHeader "Content-Disposition", "inline; filename=\"${bookName}.${fileExt}\""
                response.outputStream << object.dataInputStream
            }
            catch (e) {
                e.printStackTrace()
                response.sendError 404
            }
        }
    }
    
    /**
     * Cover image for Book
     */
    def cover = {
        def book = Book.findByName(params.bookName)

        if (!book) { response.sendError 404; return }

        withFormat {
            png {
                response.contentType = 'image/png'

                try {
                    def object = s3Service.getObject("book/${book.name}.png")
                    def bytes = object.dataInputStream.bytes

                    response.setHeader 'Content-length', "${bytes.length}"
                    response.setHeader 'Content-Disposition', "inline; filename=\"${book.name}.png\""
                    response.outputStream << bytes
                }
                catch (e) {
                    response.setHeader 'Content-Disposition', "inline; filename=\"${book.name}.png\""
                    imageService.generateBookCover(book, response.outputStream)
                }
            }
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
     * source of book in xml or zip formats
     */
    def source = {
        def book = Book.get(params.id)

        def files = toSourceFileList(book)

        withFormat {
            json {
                render files as JSON
            }
            xml {
                response.characterEncoding = 'UTF-8'
                render files as XML
            }
            zip {
                response.setHeader('Content-Disposition', "attachment; filename=${book?.id}.zip")

                def zip = new ZipOutputStream(response.outputStream)
                zip.level = 9

                files.each { file ->
                    zip.putNextEntry(new ZipEntry(file.path))
                    zip << file.content
                    zip.closeEntry()
                }
                //zip.flush()
                zip.close()
            }
        }
    }

    /**
     * parse base from file name
     */
    private parseFileName(bookName) {
        def dotPos = bookName.lastIndexOf('.')
        bookName.substring(0, dotPos)
    }

    /**
     * parse extension from file name
     */
    private parseExtName(bookName) {
        def dotPos = bookName.lastIndexOf('.')
        bookName.substring(dotPos+1)
    }

    /**
     * convert book to source file list
     */
    private toSourceFileList(book) {
        def result = []

        if (book) {
            def contents = book.getContentsAsList()

            result << [path: 'index.rst', content: renderIndex(book, contents.size())]
        
            def i = 0
            contents.each { content ->
                result << [path: "content${i+1}.rst", content: content]
                i++
            }
        }

        return result
    }
    
    /**
     * generate index.rst contents
     */
    private renderIndex(book, num = 0) {
        def result = """.. metadata
   @project: ${book.name}
   @title: ${book.title}
   @authors: ${book.authors}
   @language: zh_TW
   @html_theme: nature
   @epub_theme: epub_simple
   @mobi_theme: mobi_simple

${reStructuredText.title(title: book?.title, adornment: '#', style: 'document')}

.. toctree::
   :maxdepth: 1

"""
        if (num > 0) {
            (1..num).each {
                result += "   content${it}\n"
            }
        }
        else {
            result += "   contents\n"
        }

        return result;
    }
}
