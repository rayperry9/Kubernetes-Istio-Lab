FROM nginx:latest

ARG PROXY_URL
ENV PROXY_URL $PROXY_URL

COPY ./app.html /usr/share/nginx/html/index.html
COPY ./start.sh /usr/share/nginx/html/

WORKDIR /usr/share/nginx/html/

CMD ["sh", "-c", "./start.sh ; service nginx restart; tail -f /dev/null"]
