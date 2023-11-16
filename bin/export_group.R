#! /usr/local/bin/Rscript
#'#################################################################################
#'#################################################################################
#' Output projects labels
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

if ("Group" %in% colnames(colData(SE))){
  group <- SE$Group
} else {
  group <- rep("Unique", ncol(SE))
}

write.table(group, file = paste0(setPrefix, "group_labels.txt"), quote = FALSE,
            row.names = FALSE, col.names = FALSE)
