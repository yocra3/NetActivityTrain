// Import generic module functions
include { initOptions; saveFiles; getSoftwareName } from './functions'

params.options = [:]
options        = initOptions(params.options)

process R_NORMALIZE_GEXP {

    label 'process_low'
    label 'process_medium_memory'

    container 'yocra3/episignatures_rsession:1.3'

    input:
    tuple val(prefix), path(hdf5), path(rds)

    output:
    tuple val(prefix), path("normalize_gexp_assays.h5"), path("normalize_gexp_se.rds"), emit: res

    script:
    """
    normalize_gexp.R $hdf5
    """
}
