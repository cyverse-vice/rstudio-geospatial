#!/bin/sh

touch /home/rstudio/.irods/irods_environment.json
echo '{"irods_host": "data.cyverse.org", "irods_port": 1247, "irods_user_name": "$IPLANT_USER", "irods_zone_name": "iplant"}' >> /home/rstudio/.irods/irods_environment.json

echo "export PATH=$PATH:/opt/conda/bin" >> ~/.bashrc

if [ -f /data-store/iplant/home/$IPLANT_USER/.gitconfig ]; then
  cp /data-store/iplant/home/$IPLANT_USER/.gitconfig ~/
fi

if [ -d /data-store/iplant/home/$IPLANT_USER/.ssh ]; then
  cp -r /data-store/iplant/home/$IPLANT_USER/.ssh ~/
fi

gomplate -f /nginx.conf.tmpl -o /etc/nginx/nginx.conf
# Drop privileges to rstudio user to run the services
sudo supervisord -c /etc/supervisor/supervisord.conf -n