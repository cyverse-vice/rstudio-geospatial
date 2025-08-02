FROM harbor.cyverse.org/vice/rstudio/geospatial:latest

USER root

# Ubuntu package dependencies (base geospatial image already has most GDAL packages)
RUN apt update && apt install -y libudunits2-dev libpq-dev -y

USER rstudio

# EcocomDP base packages
# https://cran.r-project.org/web/packages/ecocomDP/index.html 
RUN R -e "install.packages(c('eml', 'vegan', 'jqr'), \
  repos='https://cran.rstudio.com/', dependencies=TRUE)"

# EcocomDP base packages
# https://cran.r-project.org/web/packages/ecocomDP/index.html 
# install from sokole/ecocomDP from github
RUN R -e "install.packages(c('remotes', 'devtools'), \
    repos='https://cran.rstudio.com/', dependencies=TRUE)"

# EcocomDP development version
# RUN R -e "remotes::install_github('sokole/ecocomDP@development')"

RUN R -e "install.packages(c('neonUtilities', 'arrow', 'neonOS', 'ecocomDP'), \
    repos='https://cran.rstudio.com/', dependencies=TRUE)"

USER root
