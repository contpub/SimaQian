package org.contpub.simaqian

import org.grails.s3.S3Asset
import org.grails.s3.S3AssetService
import org.grails.s3.S3ClientService

class StorageController {

	S3AssetService s3AssetService
	S3ClientService s3ClientService
	
    def index() { }
    
	def list = {
		
		def s3Asset = new S3Asset()
		
		def s3Service = s3ClientService.getS3(
			grailsApplication.config.aws.accessKey,
			grailsApplication.config.aws.secretKey
		)
		
		def bucket = s3Service.getBucket(grailsApplication.config.aws.bucketName)
		
		if(!params.max) params.max = 10
		[ s3Service: s3Service, bucket: bucket ]
	}

}
