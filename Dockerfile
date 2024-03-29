FROM aslubsky/collaborator-docker-base:2.0

RUN apt-get update

RUN apt-get install -y \
    mysql-client

RUN wget -O /usr/bin/phpunit https://phar.phpunit.de/phpunit-5.phar
RUN chmod +x /usr/bin/phpunit

RUN sed -i "s|post_max_size = 8M|post_max_size = 800M|g" /etc/php/7.1/cli/php.ini
RUN sed -i "s|upload_max_filesize = 2M|upload_max_filesize = 800M|g" /etc/php/7.1/cli/php.ini
RUN sed -i "s|max_execution_time = 30|max_execution_time = 30000|g" /etc/php/7.1/cli/php.ini

#
# Remove the packages that are no longer required after the package has been installed
RUN DEBIAN_FRONTEND=noninteractive apt-get autoremove --purge -q -y
RUN DEBIAN_FRONTEND=noninteractive apt-get autoclean -y -q
RUN DEBIAN_FRONTEND=noninteractive apt-get clean -y

# Remove all non-required information from the system to have the smallest
# image size as possible
# ftp://cgm_gebraucht%40used-forklifts.org:bZAo6dH1cyxhJpgJwO@ftp.strato.com/
RUN rm -rf /usr/share/doc/* /usr/share/man/?? /usr/share/man/??_* /usr/share/locale/* /var/cache/debconf/*-old /var/lib/apt/lists/* /tmp/*

WORKDIR /var/www/els

CMD ["php", "-S", "0.0.0.0:8080", "index.php"]
