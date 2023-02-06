FROM inseefrlab/onyxia-vscode-r-python-julia:r4.2.1

USER root

RUN /rocker_scripts/install_geospatial.sh

USER 1000
