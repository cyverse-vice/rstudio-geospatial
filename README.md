[![Project Supported by CyVerse](https://de.cyverse.org/Powered-By-CyVerse-blue.svg)](https://learning.cyverse.org/projects/vice/en/latest/)  [![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active) [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.4527797.svg)](https://doi.org/10.5281/zenodo.4527797)
 [![license](https://img.shields.io/badge/license-GPLv2-blue.svg)](https://opensource.org/licenses/gpl-2.0)

# rstudio-geospatial

Based on the [Rocker-Project.org](https://rocker-project.org) Docker [RStudio `geospatial` container](https://hub.docker.com/r/rocker/geospatial) for CyVerse Discovery Environment (DE) data science workbench. CyVerse DE requires additional configuration files (e.g. `nginx`) to be compatible with our Condor and Kubernetes orchestration. 

[An Introduction to Rocker: Docker Containers for R](https://journal.r-project.org/archive/2017/RJ-2017-065/RJ-2017-065.pdf) Carl Boettiger and Dirk Eddelbuettel, The R Journal (2017) 9:2, pages 527-536. [https://doi.org/10.32614/RJ-2017-065 ](https://doi.org/10.32614/RJ-2017-065)

[![CircleCI](https://circleci.com/gh/cyverse-vice/rstudio-geospatial.svg?style=svg)](https://circleci.com/gh/cyverse-vice/rstudio-geospatial) ![GH actions branch parameter](https://github.com/github/docs/actions/workflows/main.yml/badge.svg?branch=main) ![GitHub commits since tagged version](https://img.shields.io/github/commits-since/cyverse-vice/rstudio-geospatial/latest/main?style=flat-square) [![Docker Pulls](https://img.shields.io/docker/pulls/cyversevice/rstudio-geospatial?color=blue&logo=docker&logoColor=white)](https://hub.docker.com/r/cyversevice/rstudio-geospatial) 

quick launch | size | 
------------ | ---- | 
<a href="https://de.cyverse.org/apps/de/07e2b2e6-becd-11e9-b524-008cfa5ae621/launch" target="_blank"><img src="https://img.shields.io/badge/Geospatial-latest-blue?style=plastic&logo=rstudio"></a> | [![SIZE](https://img.shields.io/docker/image-size/cyversevice/rstudio-geospatial/latest.svg)](https://img.shields.io/docker/image-size/cyversevice/rstudio-geospatial/latest)
<a href="https://de.cyverse.org/apps/de/07e2b2e6-becd-11e9-b524-008cfa5ae621/launch" target="_blank"><img src="https://img.shields.io/badge/Geospatial-4.0.5-blue?style=plastic&logo=rstudio"></a> | [![SIZE](https://img.shields.io/docker/image-size/cyversevice/rstudio-geospatial/4.0.5.svg)](https://img.shields.io/docker/image-size/cyversevice/rstudio-geospatial/4.0.5)
<a href="https://de.cyverse.org/apps/de/01d05704-a784-11eb-98a3-008cfa5ae621/launch" target="_blank"><img src="https://img.shields.io/badge/Geospatial-4.0.0ubuntu18.04-blue?style=plastic&logo=rstudio"></a> | [![SIZE](https://img.shields.io/docker/image-size/cyversevice/rstudio-geospatial/4.0.0-ubuntu18.04.svg)](https://img.shields.io/docker/image-size/cyversevice/rstudio-geospatial/4.0.0-ubuntu18.04) | [![Docker Pulls](https://img.shields.io/docker/pulls/cyversevice/rstudio-geospatial?color=blue&logo=docker&logoColor=white)](https://hub.docker.com/r/cyversevice/rstudio-geospatial)
<a href="https://de.cyverse.org/apps/de/1903c788-1947-11eb-8f3e-008cfa5ae621/launch" target="_blank"><img src="https://img.shields.io/badge/Geospatial-3.6.3-blue?style=plastic&logo=rstudio"></a> | [![SIZE](https://img.shields.io/docker/image-size/cyversevice/rstudio-geospatial/3.6.3.svg)](https://img.shields.io/docker/image-size/cyversevice/rstudio-geospatial/3.6.3) 

# Instructions

## Run this Docker locally or on a Virtual Machine

To run these containers, you must first pull them from DockerHub

```
docker pull harbor.cyverse.org/vice/rstudio/geospatial:latest
```

```
docker run -it --rm -v /$HOME:/app --workdir /app -p 8787:80 -e REDIRECT_URL=http://localhost:8787 harbor.cyverse.org/vice/rstudio/geospatial:latest
```

The default username is `rstudio` and password is `rstudio1`. To reset the password, add the flag `-e PASSWORD=<yourpassword>` in the `docker run` statement.

## Build your own Docker container and deploy on CyVerse VICE

This container is intended to run on the CyVerse data science workbench, called [VICE](https://cyverse-visual-interactive-computing-environment.readthedocs-hosted.com/en/latest/index.html). 

Unless you plan on making changes to this container, you should just use the existing launch button above. 

###### Developer notes

To build your own container with a Dockerfile and additional dependencies, pull the pre-built image from DockerHub:

```
FROM harbor.cyverse.org/vice/rstudio/geospatial:latest
```

Follow the instructions in the [VICE manual for integrating your own tools and apps](https://cyverse-visual-interactive-computing-environment.readthedocs-hosted.com/en/latest/developer_guide/building.html).
