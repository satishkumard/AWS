#!/bin/bash

#Download the wordpress tar from web
wget -O /var/www/html/wp.tar.gz https://wordpress.org/latest.tar.gz

#unzip the folder
tar xf /var/www/html/wp.tar.gz -C /var/www/html/

#remove the downloaded tar.gz file
rm /var/www/html/wp.tar.gz

#copy the sample config file to wp-config.php
cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php

#Edit the new wp-config.php with required information

#replace database_name in wp-config.php
sed 's/database_name_here/wordpress/' -i /var/www/html/wordpress/wp-config.php

#replace username in wp-config.php
sed 's/username_here/wpdbadmin/' -i /var/www/html/wordpress/wp-config.php

#replace password in wp-config.php
sed 's/password_here/satish11/' -i /var/www/html/wordpress/wp-config.php

#replace localhost with MySQL RDS endpoint address
sed 's/localhost/wordpressdb.clsm1ij6kl3h.us-west-2.rds.amazonaws.com/' -i /var/www/html/wordpress/wp-config.php

#changes to Apache web server configuration
sed '/Directory \"\/var\/www\/html/,/AllowOverride None/s/AllowOverride None/AllowOverride All/' -i /etc/httpd/conf/httpd.conf

#change file access permission on the wordpress directory
groupadd www
usermod -a -G www apache
chown -R apache:www /var/www
chmod 2775 /var/www
find /var/www -type d -exec chmod 2775 {} \;
find /var/www -type f -exec chmod 0664 {} \;

#restart Apache server
systemctl restart httpd.service
