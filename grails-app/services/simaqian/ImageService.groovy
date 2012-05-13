package simaqian

import java.awt.*
import java.awt.image.*
import java.io.*;
import javax.imageio.*
import javax.swing.*

import org.springframework.context.* 

/**
 * Service for images creation on-the-fly
 * 
 * Implements ApplicationContextAware for applicationContext Injection
 */
class ImageService implements ApplicationContextAware {
    def applicationContext

    void setApplicationContext(org.springframework.context.ApplicationContext ctx) {
        applicationContext = ctx
    }

    /**
     * Generate book cover images
     */
    def generateBookCover(book, stream) {
        def image = new BufferedImage(95, 115, BufferedImage.TYPE_INT_ARGB)
        def g2d = image.createGraphics()

        def castle = ImageIO.read(applicationContext.getResource('/images/book_cover.png').file)

        g2d.drawImage(castle, 0, 0, null);
        g2d.setRenderingHint(
            RenderingHints.KEY_TEXT_ANTIALIASING,
            RenderingHints.VALUE_TEXT_ANTIALIAS_ON
        )
        g2d.setFont(new Font('sans-serif', Font.PLAIN, 12))

        //title
        def label = new JLabel("<html><div style=\"padding:5px 3px 3px 17px\">${book.title}</div></html>")
        label.foreground = Color.WHITE
        label.setSize(95, 115)
        label.setLocation(0, 0)
        label.setVerticalAlignment(SwingConstants.TOP)
        label.paint(g2d)
        
        //end
        g2d.dispose()

        ImageIO.write(image, 'png', stream)
    }
}
