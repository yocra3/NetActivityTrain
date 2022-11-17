# Docker inheritance
FROM bioconductor/bioconductor_docker:RELEASE_3_15

ENV OMP_NUM_THREADS=1
ENV OPENBLAS_NUM_THREADS=1

# Install required Bioconductor packages
RUN R -e 'BiocManager::install(c("HDF5Array", "SummarizedExperiment"))'
