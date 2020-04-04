FROM php:7.4.4-cli-alpine3.11

COPY Dockerfile.packages.txt /etc/apk/packages.txt
COPY acquiacli.yml /root/.acquiacli/acquiacli.yml

RUN apk add --no-cache --update $(grep -v '^#' /etc/apk/packages.txt)

RUN wget https://github.com/typhonius/acquia_cli/releases/latest/download/acquiacli.phar && \
    mv acquiacli.phar /usr/local/bin/acquiacli && \
    chmod +x /usr/local/bin/acquiacli && \
    acquiacli self:update

ENTRYPOINT ["/usr/local/bin/acquiacli"]
