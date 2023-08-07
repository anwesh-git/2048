# 100+mb
FROM ubuntu
RUN apt update && apt install -y nginx git
RUN git clone https://github.com/anwesh-git/2048.git /var/www/html/2048
WORKDIR /var/www/html
RUN cp 2048/index.html index.nginx-debian.html
RUN cp -r 2048/style style
RUN cp -r 2048/js js
CMD ["nginx", "-g", "daemon off;"]

## Multi-stage build 40+mb
FROM alpine:latest as builder
RUN apk update && apk add --no-cache git && git clone https://github.com/anwesh-git/2048.git /tmp
FROM nginx:alpine
COPY --from=builder /tmp/2048 /usr/share/nginx/html/
CMD ["nginx", "-g", "daemon off;"]



# 
FROM alpine:latest
RUN apk --update add nginx
COPY /2048 /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]