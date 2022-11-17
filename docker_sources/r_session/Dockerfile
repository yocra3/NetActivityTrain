# Docker inheritance
FROM bioconductor/bioconductor_docker:RELEASE_3_15

# Install required Bioconductor packages
RUN R -e 'BiocManager::install(c("HDF5Array", "SummarizedExperiment", "DESeq2", "DelayedMatrixStats"))'
