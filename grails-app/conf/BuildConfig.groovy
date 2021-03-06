grails.servlet.version = "2.5" // Change depending on target container compliance (2.5 or 3.0)
grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
grails.project.target.level = 1.6
grails.project.source.level = 1.6
//grails.project.war.file = "target/${appName}-${appVersion}.war"
grails.project.war.file = "target/${appName}.war"

//grails.server.port.http=8000

grails.project.dependency.resolution = {
	// inherit Grails' default dependencies
	inherits("global") {
		// uncomment to disable ehcache
		// excludes 'ehcache'
	}
    log 'warn' // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    checksums true // Whether to verify checksums on resolve

    repositories {
        inherits true // Whether to inherit repository definitions from plugins
        grailsPlugins()
        grailsHome()
        grailsCentral()

        mavenLocal()
        mavenCentral()

        // uncomment these to enable remote dependency resolution from public Maven repositories
        //mavenCentral()
        //mavenLocal()
        //mavenRepo "http://snapshots.repository.codehaus.org"
        //mavenRepo "http://repository.codehaus.org"
        //mavenRepo "http://download.java.net/maven/2/"
        //mavenRepo "http://repository.jboss.com/maven2/"
    }
	dependencies {
		// specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes eg.
    	
        //groovy and related
        //compile 'org.codehaus.groovy:groovy:2.0.4'
        //compile('org.codehaus.groovy.modules.http-builder:http-builder:0.5.2') {
        //    excludes "groovy"
        //}
        //runtime 'cglib:cglib:2.2.2'
	
        //require org.apache.xerces.dom
        //compile 'xerces:xercesImpl:2.10.0'
		
        //for mysql datasource
		runtime 'mysql:mysql-connector-java:5.1.20'
		
		//for rst2html
		/*
        runtime ('org.nuiton.jrst:jrst:1.4') {
			//transitive = false
			//excludes "xml-apis", "saxon", "fop"
			excludes "fop", "saxon"
		}
        */
		
		//runtime 'commons-collections:commons-collections:3.2.1'

		runtime 'net.java.dev.jets3t:jets3t:0.9.0'

		//runtime 'org.apache.pdfbox:pdfbox:1.7.0'
		
        //runtime 'com.itextpdf:itextpdf:5.2.0'
		//runtime 'com.itextpdf:itext-asian:5.2.0'
		//runtime 'org.bouncycastle:bcprov-jdk16:1.46'
	}

	plugins {
		compile ":hibernate:$grailsVersion"
		compile ":jquery:1.8.3"
		compile ":resources:1.1.6"
		compile ":rest:0.7"
		
		// either compile & test require latest spock plugin, or UnitSpec compile failed
		//compile ":spock:0.6-SNAPSHOT"

		build ":tomcat:$grailsVersion"

        //runtime ":database-migration:1.1"

        //compile ':cache:1.0.0'
	}
}
