package simaqian

import org.jets3t.service.*
import org.jets3t.service.acl.GroupGrantee
import org.jets3t.service.acl.Permission
import org.jets3t.service.model.S3Object
import org.jets3t.service.security.AWSCredentials
import org.jets3t.service.impl.rest.httpclient.RestS3Service
import java.awt.*
import java.awt.Toolkit
import java.awt.Transparency
import java.awt.Color
import java.awt.Image
import java.awt.Graphics2D
import java.awt.RenderingHints
import java.awt.AlphaComposite
import java.awt.geom.AffineTransform
import java.awt.image.AffineTransformOp
import java.awt.image.BufferedImage
import java.awt.image.ConvolveOp
import java.awt.image.Kernel
import javax.imageio.ImageIO
import javax.swing.ImageIcon
import com.sun.image.codec.jpeg.JPEGEncodeParam
import com.sun.image.codec.jpeg.JPEGCodec
import com.sun.image.codec.jpeg.JPEGImageEncoder
import sun.awt.image.BufferedImageGraphicsConfig

class BookService {

	def grailsApplication
	
	/**
	 * srcFile: org.springframework.web.multipart.MultipartFile
	 */
	def boolean uploadCoverImage(srcFile, bookName) {
	
		// upload cover image file to Amazon S3
		
		def s3Service = getS3Service()

		def bucket = s3Service.getBucket(getBucketName())
		def bucketName = getBucketName()

		def bucketAcl = s3Service.getBucketAcl(bucket)
		bucketAcl.grantPermission(GroupGrantee.ALL_USERS, Permission.PERMISSION_READ);

		def object = new S3Object("${bookName}.png", createThumbnail(srcFile.inputStream, 95, 115))
		object.setAcl(bucketAcl)
		//println object = s3Service.putObject(bucket, object)
		
		//delete tempoary files
		//
		
		true
	}
	
	private getS3Service() {
		def awsCredentials = new AWSCredentials(
			grailsApplication.config.aws.accessKey,
			grailsApplication.config.aws.secretKey
		)
		
		new RestS3Service(awsCredentials)
	}
	
	private getBucketName() {
		grailsApplication.config.aws.bucketName
	}
	
	private byte[] createThumbnail(inputStream, width, height) {
		def srcImage = ImageIO.read(inputStream)
		
		def srcWidth = srcImage.width
		def srcHeight = srcImage.height
		int dstWidth = srcWidth
		int dstHeight = srcHeight
		
		if (dstWidth > width) {
			dstHeight = dstHeight * (width/dstWidth)
			dstWidth = width
		}
		
		if (dstHeight > height) {
			dstWidth = dstWidth * (height/dstHeight)
			dstHeight = height
		}
		
		//println "w: ${dstWidth}, h: ${dstHeight}"
		def dstImage = resize(srcImage, dstWidth, dstHeight)
		
		ByteArrayOutputStream bao = new ByteArrayOutputStream()
		ImageIO.write(dstImage, 'png', bao)
		bao.toByteArray()
	}
	
	private static BufferedImage resize(BufferedImage image, int width, int height) {
		int type = image.getType() == 0? BufferedImage.TYPE_INT_ARGB : image.getType();
		BufferedImage resizedImage = new BufferedImage(width, height, type);
		Graphics2D g = resizedImage.createGraphics();
		g.setComposite(AlphaComposite.Src);
		g.setRenderingHint(RenderingHints.KEY_INTERPOLATION,RenderingHints.VALUE_INTERPOLATION_BILINEAR);
		g.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
		g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
		g.drawImage(image, 0, 0, width, height, null);
		g.dispose();
		return resizedImage;
	}
}
