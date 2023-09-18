#!/bin/sh

gomplate -f /nginx.conf.tmpl -o /etc/nginx/nginx.conf
# Drop privileges to rstudio user to run the services
sudo supervisord -c /etc/supervisor/supervisord.conf -n