FROM cyversevice/rstudio-geospatial:3.6.0
MAINTAINER "Tyson Lee Swetnam" tswetnam@cyverse.org

RUN apt-get update -y &&  \
    apt-get install -y -qq \
         cron \
         emacs-nox \
         imagemagick \
         python2.7-dev \
         python3-dev \
         python3-pip \
         unixodbc-dev \
         odbc-postgresql \
         sqlite3 \
         libopencv-dev \
         libsqliteodbc \
         nco \
         python-matplotlib  \
         libgdal-dev \
         gdal-bin \
         python3-gdal && \
    pip3 install -U \
         numpy \
         python-dateutil \
         six \
         requests==2.21.0 \
         opencv-python==3.4.5.20 \
         scipy==1.2.2 \
         scikit-image==0.14.3 && \
    pip3 install \
         ipython \
         jupyter \
         pandas \
         sympy \
         laspy \
         nose \
         statsmodels \
         matplotlib \
         terrautils && \
     apt-get autoremove -y && \
     apt-get clean && \
     rm -rf /var/lib/apt/lists/*

RUN install2.r --error \
    GGally \
    RCurl \
    convertr \
    ggthemes \
    ncdf.tools \
    ncdf4 \
    rLiDAR \
    leaflet \
    shinythemes 

RUN R -e "devtools::install_github('terraref/traits')"
RUN R -e "devtools::install_github('rstats-db/odbc')"
RUN R -e "devtools::install_github('rstudio/blogdown')"
RUN Rscript -e 'install.packages("BiocManager")'

# Install plantcv and dependencies, only supported under Python 2.x
RUN cd / && git clone https://github.com/danforthcenter/plantcv.git && cd /plantcv && python3 setup.py install
   
USER rstudio

USER root
RUN echo "\n\n if [ ! -d /home/\$USER/tutorials ]; then\n\t git clone https://github.com/terraref/tutorials.git /home/\$USER/tutorials\nfi\n" >> /etc/cont-init.d/userconf && \
    echo "\nchown -R \$USER /home/\$USER/tutorials" >> /etc/cont-init.d/userconf  && \
    echo "\n if [ ! -d /home\$USER/data ]; then\n\tln -s /data/ /home/\$USER/data\nfi\n" >> /etc/cont-init.d/userconf
