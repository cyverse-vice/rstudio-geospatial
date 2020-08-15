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
RUN apt-get update && apt-get install -y lsb-release wget apt-transport-https python2.7 python-requests curl supervisor nginx gnupg2 libfuse2 nano htop

RUN curl "http://ftp.se.debian.org/debian/pool/main/o/openssl/libssl1.0.0_1.0.1t-1+deb8u8_amd64.deb" -O && \
    dpkg -i libssl1.0.0_1.0.1t-1+deb8u8_amd64.deb && \
    rm libssl1.0.0_1.0.1t-1+deb8u8_amd64.deb

### iCommands
RUN wget -qO - https://packages.irods.org/irods-signing-key.asc | apt-key add - \
    && echo "deb [arch=amd64] https://packages.irods.org/apt/ bionic main" | tee /etc/apt/sources.list.d/renci-irods.list \
    && apt-get update && apt-get install -y irods-runtime irods-icommands

ADD https://github.com/hairyhenderson/gomplate/releases/download/v2.5.0/gomplate_linux-amd64 /usr/bin/gomplate
RUN chmod a+x /usr/bin/gomplate

# provide read and write access to Rstudio users for default R library location
RUN chmod -R 777 /usr/local/lib/R/site-library

ENV PASSWORD "rstudio1"
RUN bash /etc/cont-init.d/userconf

COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

COPY nginx.conf.tmpl /nginx.conf.tmpl
COPY rserver.conf /etc/rstudio/rserver.conf
COPY supervisor-nginx.conf /etc/supervisor/conf.d/nginx.conf
COPY supervisor-rstudio.conf /etc/supervisor/conf.d/rstudio.conf

ENV REDIRECT_URL "http://localhost/"
ENV DISABLE_AUTH "true"

ENTRYPOINT ["/usr/local/bin/run.sh"]
