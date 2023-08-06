FROM harbor.cyverse.org/vice/rstudio/geospatial:4.3.1

USER root

# Ubuntu package dependencies
RUN apt update && apt install -y libudunits2-dev libpq-dev libgdal-dev -y

USER rstudio

# EcocomDP base packages
# https://cran.r-project.org/web/packages/ecocomDP/index.html 
RUN R -e "install.packages(c('eml', 'vegan', 'jqr'), \
  repos='http://cran.rstudio.com/', version='4.3.1', dependencies=TRUE)"

# EcocomDP base packages
# https://cran.r-project.org/web/packages/ecocomDP/index.html 
# install from sokole/ecocomDP from github
RUN R -e "install.packages(c('remotes', 'devtools'), \
    repos='http://cran.rstudio.com/', version='4.2.3', dependencies=TRUE)"

RUN R -e "remotes::install_github('sokole/ecocomDP@development')"

RUN R -e "install.packages(c('neonUtilities', 'arrow', 'neonOS'), \
    repos='http://cran.rstudio.com/', version='4.2.3', dependencies=TRUE)"

USER root
