// Import generic module functions
include { initOptions; saveFiles; getSoftwareName } from './functions'

params.options = [:]
options        = initOptions(params.options)

process R_EXPORT_GENES {

    label 'process_low'
    label 'process_medium_memory'

    container 'yocra3/netactivitytrain_rsession:1.0'

    input:
    tuple val(prefix), path(hdf5), path(rds)

    output:
    tuple val(prefix), path("*genes.txt"), emit: genes

    script:
    """
    export_genes.R $hdf5
    """
}
