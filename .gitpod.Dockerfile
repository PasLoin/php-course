# FROM gitpod/workspace-full
                    
# USER gitpod

# Install custom tools, runtime, etc. using apt-get
# For example, the command below would install "bastet" - a command line tetris clone:
#
# RUN sudo apt-get -q update && #     sudo apt-get install -yq bastet && #     sudo rm -rf /var/lib/apt/lists/*
#
# More information: https://www.gitpod.io/docs/config-docker/
### General Settings ###
ENV PHP_VERSION="7.4"
ENV APACHE_DOCROOT="public_html"

FROM gitpod/workspace-full
USER root

### Apache ###
    apt-get -y install apache2 && \
    chown -R gitpod:gitpod /var/run/apache2 /var/lock/apache2 /var/log/apache2 && \
    echo "include ${HOME}/php-course/conf/apache.conf" > /etc/apache2/apache2.conf && \
    echo ". ${HOME}/php-courses/conf/apache.env.sh" > /etc/apache2/envvars && \

### PHP ###
    add-apt-repository ppa:ondrej/php && \
    apt-get update && \
    apt-get -y install \
        libapache2-mod-php \
        php${PHP_VERSION} \
        php${PHP_VERSION}-common \
        php${PHP_VERSION}-cli \
        php${PHP_VERSION}-mbstring \
        php${PHP_VERSION}-curl \
        php${PHP_VERSION}-gd \
        php${PHP_VERSION}-intl \
        php${PHP_VERSION}-mysql \
        php${PHP_VERSION}-xml \
        php${PHP_VERSION}-json \
        php${PHP_VERSION}-zip \
        php${PHP_VERSION}-soap \
        php${PHP_VERSION}-bcmath \
        php${PHP_VERSION}-opcache \
        php-xdebug && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* && \
    cat /home/gitpod/php-course/conf/php.ini >> /etc/php/${PHP_VERSION}/apache2/php.ini && \
    a2dismod php* && \
    a2dismod mpm_* && \
    a2enmod mpm_prefork && \
    a2enmod php${PHP_VERSION} && \


### RUN sudo apt-get update -q \
###    && sudo apt-get install -y php-dev

###RUN wget http://xdebug.org/files/xdebug-2.9.1.tgz \
###    && tar -xvzf xdebug-2.9.1.tgz \
###    && cd xdebug-2.9.1 \
###    && phpize \
###    && ./configure \
###    && make \
###    && sudo cp modules/xdebug.so /usr/lib/php/20170718 \
###    && sudo bash -c "echo -e '\nzend_extension = /usr/lib/php/20170718/xdebug.so\n[XDebug]\nxdebug.remote_enable = 1\nxdebug.remote_autostart = 1\n' >> /etc/php/7.2/cli/php.ini"
