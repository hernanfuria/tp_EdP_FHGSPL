FROM alpine

RUN apk update && apk add bash imagemagick curl


WORKDIR /app

ADD src src
ADD assets assets


ENTRYPOINT ["bash", "-f", "/app/src/menu.sh"]
