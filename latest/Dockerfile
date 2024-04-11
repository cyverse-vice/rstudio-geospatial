FROM ghcr.io/rocker-org/geospatial:latest
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
      org.label-schema.schema-version="1.0.0"

# Install a few dependencies for iCommands, text editing, and monitoring instances
RUN apt update && apt install -y apt-transport-https \
    apt-utils \
    ca-certificates \
    curl \
    gcc \
    glances \
    gnupg2 \
    htop \
    less \
    libfuse2 \
    lsb-release \  
    nano \
    nginx \
    nodejs \
    software-properties-common \
    supervisor \ 
    wget

# Add gomplate
ADD https://github.com/hairyhenderson/gomplate/releases/download/v3.9.0/gomplate_linux-amd64 /usr/bin/gomplate
RUN chmod a+x /usr/bin/gomplate

# provide read and write access to Rstudio users for default R library location
RUN chmod -R 777 /usr/local/lib/R/site-library

ENV PASSWORD "rstudio1"
#RUN bash /etc/cont-init.d/userconf

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

# Install GoCommands
# https://learning.cyverse.org/ds/gocommands/
RUN cd /usr/local/bin && \
    curl -L -o gocmd.tar.gz https://github.com/cyverse/gocommands/releases/download/v0.6.3/gocmd-v0.6.3-linux-amd64.tar.gz && \
    tar zxvf gocmd.tar.gz && rm gocmd.tar.gz

USER rstudio

# GitHub CLI
RUN sudo mkdir -p -m 755 /etc/apt/keyrings && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
      && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
      && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
      && sudo apt update \
      && sudo apt install gh -y
    
RUN echo 'export PS1="[\u@cyverse] \w $ "' >> /home/rstudio/.bashrc
USER root

ENTRYPOINT ["/usr/local/bin/run.sh"]
