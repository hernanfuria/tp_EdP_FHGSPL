FROM alpine

RUN apk update && apk add bash imagemagick

WORKDIR /app

ADD src src
ADD assets assets

#COPY . .

ENTRYPOINT ["bash", "/app/src/menu.sh"]
