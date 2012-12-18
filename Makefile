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

clean-cache:
	rm -rf ./web-app/.sass-cache

war:
	grails war

download:
	wget -O target/SimaQian.war http://s3.lyhdev.com/apps/SimaQian.war

upload:
	s3cmd put -P target/SimaQian.war s3://s3.lyhdev.com/apps/

remote-deploy:
	ssh -t kyle@contpub.org 'cd SimaQian && make update download && sudo make deploy'

remote-log:
	ssh -t kyle@contpub.org 'cd SimaQian && make log'

deploy:
	service tomcat7 stop
	rm -rf /var/lib/tomcat7/webapps-contpub/ROOT.war
	rm -rf /var/lib/tomcat7/webapps-contpub/ROOT
	cp target/SimaQian.war /var/lib/tomcat7/webapps-contpub/ROOT.war
	service tomcat7 start

log:
	tail -f /var/lib/tomcat7/logs/catalina.out

syncdb:
	mysqldump -h contpub.org -usynconly -p contpub | mysql -h localhost -ucontpub -pcontpub contpub

services:
	mysqld_safe5 &
	rabbitmq-server &
