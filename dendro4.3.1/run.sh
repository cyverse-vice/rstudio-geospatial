#!/bin/sh

chown -R 1000:1000 /home/rstudio
gomplate -f /nginx.conf.tmpl -o /etc/nginx/nginx.conf
supervisord -c /etc/supervisor/supervisord.conf -n
