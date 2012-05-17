package simaqian

import org.jets3t.service.*
import org.jets3t.service.model.*
import org.jets3t.service.security.*
import org.jets3t.service.impl.rest.httpclient.*

class S3Service {

	def grailsApplication

	def getAwsCredentials() {
		new AWSCredentials(
            grailsApplication.config.aws.accessKey,
            grailsApplication.config.aws.secretKey
        )
	}

    def getService() {
        new RestS3Service(getAwsCredentials())
    }

    def getBucket() {
    	getService().getBucket(grailsApplication.config.aws.bucketName)
    }

    def getBucketName() {
    	grailsApplication.config.aws.bucketName
    }

    def getObject(path) {
    	getService().getObject(getBucket(), path)
    }

    def createSignedGetUrl(path, minutes) {
    	def cal = Calendar.instance
        cal.add(Calendar.MINUTE, minutes)
        def expiryDate = cal.time

        getService().createSignedGetUrl(getBucketName(), path, getAwsCredentials(), expiryDate, false)
    }
}
