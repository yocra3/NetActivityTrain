// Import generic module functions
include { initOptions; saveFiles; getSoftwareName } from './functions'

params.options = [:]
options        = initOptions(params.options)

process R_EXPORT_MODEL {

    label 'process_low'
    label 'process_medium_memory'

    container 'yocra3/netactivitytrain_rsession:1.0'

    input:
    tuple val(prefix), path(weights), path("input_genes.txt")
    path("pathways_names.txt")


    output:
    tuple val(prefix), path("*_NetActivity_weights.Rdata"), emit: NetActivity_weights

    script:
    """
    export_model.R $prefix
    """
}
