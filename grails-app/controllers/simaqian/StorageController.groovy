package simaqian

import org.jets3t.service.*
import org.jets3t.service.model.S3Object
import org.jets3t.service.security.AWSCredentials
import org.jets3t.service.impl.rest.httpclient.RestS3Service

class StorageController {

	//S3AssetService s3AssetService
	//S3ClientService s3ClientService
	
    def index() { }
    
	def list = {
		
		def awsCredentials = new AWSCredentials(
			grailsApplication.config.aws.accessKey,
			grailsApplication.config.aws.secretKey
		)
		
		def s3Service = new RestS3Service(awsCredentials)
		
		def bucket = s3Service.getBucket(grailsApplication.config.aws.bucketName)
		
		if(!params.max) params.max = 10
		[ s3Service: s3Service, bucket: bucket ]
	}

}
