FROM rocker/geospatial:3.6.3
# This image uses the Rocker-Project Geospatial RStudio image - thanks R OpenSci and Rocker!

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="CyVerse RStudio Geospatial" \
      org.label-schema.description="Built from Rocker-Project RStudio Geospatial, additional depends for CyVerse K8s workbench" \
      org.label-schema.url="https://cyverse.org" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="e.g. https://github.com/cyverse-vice/rstudio-geospatial" \
      org.label-schema.vendor="CyVerse" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

MAINTAINER "Tyson Lee Swetnam tswetnam@cyverse.org"

## Install CyVerse VICE Depends
RUN apt-get update && apt-get install -y lsb-release wget apt-transport-https python2.7 python-requests curl supervisor nginx gnupg2 libfuse2 nano htop xorg-dev

RUN curl "http://ftp.se.debian.org/debian/pool/main/o/openssl/libssl1.0.0_1.0.1t-1+deb8u8_amd64.deb" -O && \
    dpkg -i libssl1.0.0_1.0.1t-1+deb8u8_amd64.deb && \
    rm libssl1.0.0_1.0.1t-1+deb8u8_amd64.deb

### iCommands
RUN wget https://files.renci.org/pub/irods/releases/4.1.10/ubuntu14/irods-icommands-4.1.10-ubuntu14-x86_64.deb && dpkg -i *.deb

ADD https://github.com/hairyhenderson/gomplate/releases/download/v2.5.0/gomplate_linux-amd64 /usr/bin/gomplate
RUN chmod a+x /usr/bin/gomplate

# provide read and write access to Rstudio users for default R library location
RUN chmod -R 777 /usr/local/lib/R/site-library

# lidR depends
RUN apt-get update
RUN apt-get install -y libgdal-dev libgeos++-dev libudunits2-dev libproj-dev libx11-dev libgl1-mesa-dev libglu1-mesa-dev libfreetype6-dev libnode-dev libxt-dev libfftw3-dev 
RUN apt-get install -y bzip2 cairo fontconfig freetype fribidi glib2 harfbuzz libX11 libXext libXt libcurl libicu libjpeg libpng libtiff libtirpc libxcrypt ncurses pango pcre2 readline tcl tk xz zlib

ENV PASSWORD "rstudio1"
RUN bash /etc/cont-init.d/userconf

COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

COPY nginx.conf.tmpl /nginx.conf.tmpl
COPY rserver.conf /etc/rstudio/rserver.conf
COPY supervisor-nginx.conf /etc/supervisor/conf.d/nginx.conf
COPY supervisor-rstudio.conf /etc/supervisor/conf.d/rstudio.conf

ENV REDIRECT_URL "http://localhost/"

ARG LOCAL_USER=rstudio
ARG PRIV_CMDS='/bin/ch*,/bin/cat,/bin/gunzip,/bin/tar,/bin/mkdir,/bin/ps,/bin/mv,/bin/cp,/usr/bin/apt*,/usr/bin/pip*,/bin/yum'

RUN if [ -x /usr/bin/apt ]; then \
      apt-get update && apt-get -y install sudo && rm -rf /var/lib/apt/lists/*; \
    elif [ -x /bin/yum ]; then \
      yum -y update && yum -y install sudo && yum clean all; \
    fi

RUN echo "$LOCAL_USER	ALL=NOPASSWD: $PRIV_CMDS" >> /etc/sudoers

ENTRYPOINT ["/usr/local/bin/run.sh"]
