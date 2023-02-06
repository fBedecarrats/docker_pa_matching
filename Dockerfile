FROM inseefrlab/onyxia-vscode-r-python-julia:r4.2.1

USER root

RUN /rocker_scripts/install_geospatial.sh

# Install R packages that need to be fetched from Github
RUN R -e 'install.packages("remotes")'
RUN Rscript -e 'remotes::install_github("https://github.com/cran/gdalUtils")'
RUN Rscript -e 'remotes::install_github("https://github.com/hunzikp/velox")'
RUN Rscript -e 'remotes::install_github("https://github.com/ropensci/rnaturalearth")'
RUN Rscript -e 'remotes::install_github("paleolimbot/geoarrow")'
RUN Rscript -e 'remotes::install_github("jonocarroll/ggeasy")'
RUN Rscript -e 'remotes::install_github("https://github.com/cran/doMC/tree/fbea362b96cc4469deb6065ff9fbd5d4794ccac1")'

# All libraries mentionned in original code
RUN install2.r -e -s aws.s3
RUN install2.r -e -s \
        quarto \
        reticulate \
        JuliaCall \
        aws.s3 \ 
        countrycode \
        cowplot \
        data.table \
        dtplyr \
        fasterize \
        foreach \
        foreign \
        ggforce \
        ggplot2 \
        ggrepel \
        GpGp \
        grid \
        jsonlite \
        landscapetools \
        lme4 \
        MCMC.OTU \
        ncdf4 \
        parallel \
        pbapply \
        plyr \
        raster \
        rasterVis \
        rbounds \
        RColorBrewer \
        RCurl \
        readr \
        reshape2 \
        rgdal \
        rjson \
        rnaturalearth \
        scales \
        sf \
        smoothr \
        spaMM \
        spgwr \
        spmoran \
        spNNGP \
        stars \
        stringr \
        tidyverse \
        unix \
        velox \
        viridis \
        wbstats \
        wdpar

# Create conda environment
RUN conda create n- replication

USER 1000
