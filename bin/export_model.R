#! /usr/local/bin/Rscript
#'#################################################################################
#'#################################################################################
#' Export model weights for NetActivity
#'#################################################################################
#'#################################################################################

## Capture arguments
args <- commandArgs(trailingOnly=TRUE)
prefix <- args[1]

## Load libraries
library(HDF5Array)

## Load files ####
paths_names <- read.table("pathways_names.txt", header = TRUE)
genes_names <- read.table("input_genes.txt", header = FALSE)
weights <- h5read(paste0(prefix, "_model_weights.h5"),"weights_paths")p
rownames(weights) <- paths_names$X0
colnames(weights) <- genes_names$V1

weights <- weights[, !apply(weights == 0, 2, all)]

save(weights, file = paste0(prefix, "_NetActivity_weights.Rdata"))
