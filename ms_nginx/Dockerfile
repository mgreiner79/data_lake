# ms_nginx
FROM nginx:1.21.6-alpine
#RUN apt update
#RUN apt -y install certbot python3-certbot-nginx certbot 
RUN apk --update upgrade
RUN apk add --no-cache python3 python3-dev py3-pip certbot-nginx

VOLUME /etc/nginx/conf.d/
COPY ./config/* /etc/nginx/conf.d/