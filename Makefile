commit:
	#git checkout
	git commit . -m 'development update'
	git push

update:
	git pull

war:
	grails clean
	grails war

deploy:
	service tomcat6 stop
	rm -rf /var/lib/tomcat6/webapps-contpub/ROOT.war
	rm -rf /var/lib/tomcat6/webapps-contpub/ROOT
	cp target/SimaQian.war /var/lib/tomcat6/webapps-contpub/ROOT.war
	service tomcat6 start
	tail -f /var/lib/tomcat6/logs/catalina.out
