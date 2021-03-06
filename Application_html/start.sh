#!/bin/bash

echo "server {
    listen       80;
    server_name  localhost;

    location / {
        root   /usr/share/nginx/html;
        index  index.html index.html;
    }

    location /api {
        proxy_pass http://$PROXY_URL/api;
        proxy_http_version 1.1;
    }

    #error_page  404              /404.html;

    # redirect server error pages to the static page /50x.html
    #
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}" > /etc/nginx/conf.d/default.conf