FROM composer:1.9.3

COPY Dockerfile.packages.txt /etc/apk/packages.txt
COPY acquiacli.yml /root/.acquiacli/acquiacli.yml

RUN apk add --no-cache --update $(grep -v '^#' /etc/apk/packages.txt)

RUN git clone -b master --depth=1 --single-branch https://github.com/typhonius/acquia_cli.git /root/acquia_cli && \
    cd /root/acquia_cli && \
    composer install && \
    ln -s /root/acquia_cli/bin/acquiacli /usr/local/bin/

# Set the Drush version.
ENV DRUSH_VERSION 8.3.0

# Install Drush 8 with the phar file.
RUN curl -fsSL -o /usr/local/bin/drush "https://github.com/drush-ops/drush/releases/download/$DRUSH_VERSION/drush.phar" && \
  chmod +x /usr/local/bin/drush

ENTRYPOINT ["/usr/local/bin/acquiacli"]
