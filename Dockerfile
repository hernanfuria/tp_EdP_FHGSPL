FROM alpine

RUN apk update && apk add bash imagemagick

WORKDIR /app

COPY . .

ENTRYPOINT ["bash", "/app/src/menu.sh"]
