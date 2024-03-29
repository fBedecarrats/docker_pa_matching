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
        arrow \
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

# Install python packages
RUN pip install \
        earthengine-api \ 
        rasterio \
        pandas \
        pydrive \
        fiona \
        rasterio \
        ray[default] \
        dbfread \ 
        pandas

# Install Julia files
RUN julia -e 'using Pkg ; Pkg.add("ArchGDAL")'
RUN julia -e 'using Pkg ; Pkg.add("DataFrames")'
RUN julia -e 'using Pkg ; Pkg.add("Discretizers")'
RUN julia -e 'using Pkg ; Pkg.add("Shapefile")'
RUN julia -e 'using Pkg ; Pkg.add("FreqTables")'
RUN julia -e 'using Pkg ; Pkg.add("Plots")'
RUN julia -e 'using Pkg ; Pkg.add("StatsBase")'
RUN julia -e 'using Pkg ; Pkg.add("CSV")'
RUN julia -e 'using Pkg ; Pkg.add("LibGEOS")'
RUN julia -e 'using Pkg ; Pkg.add("RCall")'

# Config VS code
RUN R -e "install.packages('languageserver')"

RUN curl -fsSL https://code-server.dev/install.sh | bash && \
    # Install general VSCode extensions
    code-server --install-extension ms-kubernetes-tools.vscode-kubernetes-tools && \
    code-server --install-extension ms-azuretools.vscode-docker && \
    code-server --install-extension njpwerner.autodocstring && \
    code-server --install-extension redhat.vscode-yaml && \
    code-server --install-extension mhutchie.git-graph && \
    # Install language specific VSCode extensions
    code-server --install-extension ms-python.python && \
    code-server --install-extension reditorsupport.r && \
    code-server --install-extension julialang.language-julia && \
    code-server --install-extension quarto.quarto


USER 1000
