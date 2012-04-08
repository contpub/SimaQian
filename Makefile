server:
	grails run-app

commit:
	#git checkout
	git commit . -m 'development update'
	git push

update:
	git pull

clean:
	grails clean

war:
	grails war

download:
	wget -O target/SimaQian.war http://s3.contpub.org/webapps/SimaQian.war

upload:
	s3cmd put -P target/SimaQian.war s3://s3.contpub.org/webapps/

remote-deploy:
	ssh -t kyle@contpub.org 'cd SimaQian && make update download && sudo make deploy'

remote-log:
	ssh -t kyle@contpub.org 'cd SimaQian && make log'

deploy:
	service tomcat6 stop
	rm -rf /var/lib/tomcat6/webapps-contpub/ROOT.war
	rm -rf /var/lib/tomcat6/webapps-contpub/ROOT
	cp target/SimaQian.war /var/lib/tomcat6/webapps-contpub/ROOT.war
	service tomcat6 start

log:
	tail -f /var/lib/tomcat6/logs/catalina.out

syncdb:
	mysqldump -h contpub.org -usynconly -p contpub | mysql -h localhost -ucontpub -pcontpub contpub
