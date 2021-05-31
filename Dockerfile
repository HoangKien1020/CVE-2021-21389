FROM hoangkien1020/lamp:multiphp

MAINTAINER hoangkien1020

ARG WP_URL=https://wordpress.org/latest.tar.gz

ARG BP_URL=https://downloads.wordpress.org/plugin/buddypress.7.2.0.zip

COPY src/wordpress.sql /tmp/wordpress.sql

COPY src/apache2.conf /etc/apache2/apache2.conf

COPY src/.htaccess /var/www/html/.htaccess

RUN set -x \
    && apt update \
    && apt-get install -y nano unzip wget \
    && rm -rf /var/www/html/* \
    && wget -qO /tmp/wordpress.tar.gz  $WP_URL \
    && tar -zxf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1 \
    && rm -rf /tmp/wordpress.tar.gz \
    && wget -qO /tmp/buddypress.7.2.0.zip  $BP_URL \
    && unzip /tmp/buddypress.7.2.0.zip -d /var/www/html/wp-content/plugins \
    && rm -rf /tmp/buddypress.7.2.0.zip \
    && rm -rf /usr/share/phpmyadmin \
    && a2enmod rewrite \
    && service apache2 restart

COPY src/wp-config.php /var/www/html/wp-config.php

RUN set -x \
    && chown -R www-data:www-data /var/www/html/ \
    && /etc/init.d/mysql start \
    && mysql -e "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8;" -uroot -proot \
    && mysql -e "use wordpress;source /tmp/wordpress.sql;" -uroot -proot \
    && rm -f /tmp/wordpress.sql


COPY src/start.sh /start.sh
RUN chmod a+x /start.sh

EXPOSE 80
CMD ["/start.sh"]
