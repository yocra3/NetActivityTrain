// Import generic module functions
include { initOptions; saveFiles; getSoftwareName } from './functions'

params.options = [:]
options        = initOptions(params.options)

process R_EXPORT_GROUP {

    label 'process_low'
    label 'process_medium_memory'

    container 'yocra3/episignatures_rsession:1.3'

    input:
    tuple val(prefix), path(hdf5), path(rds)

    output:
    tuple val(prefix), path("*group_labels.txt"), emit: labels

    script:
    """
    export_group.R $hdf5
    """
}
