<h1></h1>
${grailsApplication.config.aws}<br/>

<g:each in="${s3Service.listObjects(bucket)}" var="obj">
${obj}
</g:each>
