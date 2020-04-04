FROM php:7.4.4-cli-alpine3.11

COPY Dockerfile.packages.txt /etc/apk/packages.txt
RUN apk add --no-cache --update $(grep -v '^#' /etc/apk/packages.txt)

RUN wget https://github.com/typhonius/acquia_cli/releases/latest/download/acquiacli.phar && \
    mv acquiacli.phar /usr/local/bin/acquiacli && \
    chmod +x /usr/local/bin/acquiacli

ENTRYPOINT ["/usr/local/bin/acquiacli"]
