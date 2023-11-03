FROM alpine:3.18

RUN apk update &&  \
    apk add --no-cache  \
      aws-cli  \
      wget  \
      mongodb-tools  \
      bash > /dev/null

ADD ./mongodumper.sh /usr/local/bin/mongodumper.sh

RUN chmod +x /usr/local/bin/mongodumper.sh

CMD ["mongodumper.sh"]