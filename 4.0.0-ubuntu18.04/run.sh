#!/bin/sh

chown -R rstudio:rstudio /home/rstudio
gomplate -f /nginx.conf.tmpl -o /etc/nginx/nginx.conf
supervisord -c /etc/supervisor/supervisord.conf -n
