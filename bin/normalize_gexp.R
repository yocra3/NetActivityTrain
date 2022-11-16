#! /usr/local/bin/Rscript
#'#################################################################################
#'#################################################################################
#' Normalize gene expression data
#'#################################################################################
#'#################################################################################

## Capture arguments
args <- commandArgs(trailingOnly=TRUE)
h5n <- args[1]
setPrefix <- gsub("assays.h5", "", h5n)

## Load libraries
library(HDF5Array)
library(SummarizedExperiment)

SE <- loadHDF5SummarizedExperiment(dir = "./", prefix = setPrefix)

## Standardize gene expression
vals <- SummarizedExperiment::assay(SE)
mat <- (vals - DelayedArray::rowMeans(vals))/DelayedMatrixStats::rowSds(vals)
mat[is.nan(mat)] <- 0
SummarizedExperiment::assay(SE) <- mat

saveHDF5SummarizedExperiment(SE, dir = "./", prefix = "normalize_gexp_")
