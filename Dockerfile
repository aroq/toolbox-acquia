FROM composer:1.9.3

COPY Dockerfile.packages.txt /etc/apk/packages.txt
COPY acquiacli.yml /root/.acquiacli/acquiacli.yml

RUN apk add --no-cache --update $(grep -v '^#' /etc/apk/packages.txt)

RUN git clone -b master --depth=1 --single-branch https://github.com/typhonius/acquia_cli.git /root/acquia_cli && \
    cd /root/acquia_cli && \
    composer install && \
    ln -s /root/acquia_cli/bin/acquiacli /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/acquiacli"]
