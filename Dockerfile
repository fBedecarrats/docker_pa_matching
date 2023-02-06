FROM inseefrlab/onyxia-vscode-r-python-julia:r4.2.1

USER root

RUN /rocker_scripts/install_geospatial.sh

# Install R packages that need to be fetched from Github
RUN R -e 'install.packages("remotes")'
# RUN Rscript -e 'remotes::install_github("https://github.com/cran/doMC/tree/fbea362b96cc4469deb6065ff9fbd5d4794ccac1")'
# RUN Rscript -e 'remotes::install_github("jonocarroll/ggeasy")'
RUN Rscript -e 'remotes::install_github("https://github.com/cran/gdalUtils")'
RUN Rscript -e 'remotes::install_github("https://github.com/hunzikp/velox")'
RUN Rscript -e 'remotes::install_github("https://github.com/ropensci/rnaturalearth")'
RUN Rscript -e 'remotes::install_github("paleolimbot/geoarrow")'

USER 1000
