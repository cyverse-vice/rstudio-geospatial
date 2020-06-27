FROM rocker/geospatial:latest
MAINTAINER "Tyson Lee Swetnam tswetnam@cyverse.org"
# This image uses the Rocker Geospatial RStudio image - thanks R OpenSci!

## Install CyVerse VICE Depends
RUN apt-get install -y software-properties-common &&  apt-add-repository universe
RUN apt-get update && apt-get install -y lsb-release wget apt-transport-https curl supervisor nginx gnupg2 libfuse2 htop nano

###### iRODS depends on Python 2 which is no longer supported in Ubuntu 20.04 ######
## Install irods-icommands + depends
RUN apt install -y python2 gdebi
RUN wget http://mirrors.kernel.org/ubuntu/pool/universe/p/python-urllib3/python-urllib3_1.24.1-1ubuntu1_all.deb \
    && gdebi -n python-urllib3_1.24.1-1ubuntu1_all.deb \
    && rm python-urllib3_1.24.1-1ubuntu1_all.deb 
RUN wget http://mirrors.kernel.org/ubuntu/pool/universe/r/requests/python-requests_2.21.0-1_all.deb \
    && gdebi -n python-requests_2.21.0-1_all.deb \
    && rm python-requests_2.21.0-1_all.deb 
RUN wget http://security.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu5.3_amd64.deb \
    && dpkg -i libssl1.0.0_1.0.2n-1ubuntu5.3_amd64.deb \
    && rm libssl1.0.0_1.0.2n-1ubuntu5.3_amd64.deb
### iCommands
RUN wget -qO - https://packages.irods.org/irods-signing-key.asc | apt-key add - \
    && echo "deb [arch=amd64] https://packages.irods.org/apt/ bionic main" | tee /etc/apt/sources.list.d/renci-irods.list \
    && apt-get update && apt-get install -y irods-runtime irods-icommands


ADD https://github.com/hairyhenderson/gomplate/releases/download/v2.5.0/gomplate_linux-amd64 /usr/bin/gomplate
RUN chmod a+x /usr/bin/gomplate

# provide read and write access to Rstudio users for default R library location
# RUN chmod -R 777 /usr/local/lib/R/site-library

ENV PASSWORD "rstudio1"
RUN bash /etc/cont-init.d/userconf

COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

COPY nginx.conf.tmpl /nginx.conf.tmpl
COPY rserver.conf /etc/rstudio/rserver.conf
COPY supervisor-nginx.conf /etc/supervisor/conf.d/nginx.conf
COPY supervisor-rstudio.conf /etc/supervisor/conf.d/rstudio.conf

ENV REDIRECT_URL "http://localhost/"

ENTRYPOINT ["/usr/local/bin/run.sh"]
