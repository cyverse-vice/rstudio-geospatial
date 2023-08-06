FROM harbor.cyverse.org/vice/rstudio/geospatial:4.3.1

# Base packages
RUN R -e "install.packages(c('KernSmooth', 'MASS', 'Matrix', 'codetools', 'lattice', 'mgcv', 'nlme'), \
  repos='http://cran.rstudio.com/', version='4.3.1')"

# Database related packages
RUN R -e "install.packages(c('DBI', 'R6', 'bit', 'bit64', 'blob'), \
  repos='http://cran.rstudio.com/', version='4.3.1')"

# Data manipulation and visualization packages
RUN R -e "install.packages(c('dplyr', 'ggplot2', 'plyr', 'reshape2', 'tidyr', 'tidyselect', 'tidyverse'), \
  repos='http://cran.rstudio.com/', version='4.3.1')"

# HTTP and web related packages
RUN R -e "install.packages(c('curl', 'httr', 'httr2', 'httpuv'), \
  repos='http://cran.rstudio.com/', version='4.3.1')"

# String and text related packages
RUN R -e "install.packages(c('stringi', 'stringr'), \
  repos='http://cran.rstudio.com/', version='4.3.1')"

# Date and time related packages
RUN R -e "install.packages(c('lubridate', 'timechange'), \
  repos='http://cran.rstudio.com/', version='4.3.1')"

# IO related packages
RUN R -e "install.packages(c('readr', 'readxl', 'vroom'), \
  repos='http://cran.rstudio.com/', version='4.3.1')"

# Development related packages
RUN R -e "install.packages(c('devtools', 'roxygen2', 'testthat', 'usethis'), \
  repos='http://cran.rstudio.com/', version='4.3.1')"

# Install DevTools for GitHub packages
RUN R -e "install.packages('devtools', repos='http://cran.rstudio.com/', version='4.3.1', dependencies=TRUE)"

# Install GitHub packages
RUN R -e "devtools::install_github('chguiterman/burnr@series-checks-edits')"
RUN R -e "devtools::install_github('chguiterman/rIMPD@match_burnr_checks')"

# Other packages
# renv, 
RUN R -e "install.packages(c('renv'), repos='http://cran.rstudio.com/', version='4.3.1')"