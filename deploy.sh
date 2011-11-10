git pull
grails clean
grails war
sudo service tomcat6 stop
sudo rm -rf /var/lib/tomcat6/webapps-contpub/ROOT.war
sudo rm -rf /var/lib/tomcat6/webapps-contpub/ROOT
sudo cp target/SimaQian.war /var/lib/tomcat6/webapps-contpub/ROOT.war
sudo service tomcat6 start
tail -f /var/lib/tomcat6/logs/catalina.out
