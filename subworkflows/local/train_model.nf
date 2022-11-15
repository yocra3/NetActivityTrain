include { R_EXPORT_GROUP } from '../../modules/local/r/export_group/main'
include { R_EXPORT_GENES } from '../../modules/local/r/export_genes/main'
include { R_NORMALIZE_GEXP } from '../../modules/local/r/normalize_gexp/main'
include { PYTHON_DIVIDE_TRAIN_TEST } from '../../modules/local/python/divide_train_test/main'
include { PYTHON_TRAIN_MODEL } from '../../modules/local/python/train_model/main'
include { PYTHON_MODEL_POSTPROCESSING } from '../../modules/local/python/model_postprocessing/main'
include { R_EXPORT_MODEL } from '../../modules/local/r/export_model/main'


workflow TRAIN_MODEL {

    take:
    input_data // tuple val(prefix), path(hdf5), path(rds)
    network_conf // [val (name), network_structure, network_params]
    test_prop
    pathmap

    main:
    R_EXPORT_GROUP ( input_data)
    R_EXPORT_GENES ( input_data)
    R_NORMALIZE_GEXP ( input_data )

    ch_comb = R_NORMALIZE_GEXP.out.res.join(R_EXPORT_GROUP.out.labels)

    PYTHON_DIVIDE_TRAIN_TEST ( ch_comb, test_prop )

    ch_train = PYTHON_DIVIDE_TRAIN_TEST.out.data.join(R_EXPORT_GENES.out.genes)

    PYTHON_TRAIN_MODEL( ch_train, network_conf, pathmap )
    PYTHON_MODEL_POSTPROCESSING( PYTHON_TRAIN_MODEL.out.model.join(PYTHON_TRAIN_MODEL.out.history))
    R_EXPORT_MODEL ( PYTHON_MODEL_POSTPROCESSING.out.weights.join(R_EXPORT_GENES.out.genes), PYTHON_TRAIN_MODEL.out.pathway_labels )

    emit:
    model = PYTHON_TRAIN_MODEL.out.model
    // TODO nf-core: edit emitted channels
    // bam      = SAMTOOLS_SORT.out.bam           // channel: [ val(meta), [ bam ] ]
    // bai      = SAMTOOLS_INDEX.out.bai          // channel: [ val(meta), [ bai ] ]
    // csi      = SAMTOOLS_INDEX.out.csi          // channel: [ val(meta), [ csi ] ]
    //
    // versions = ch_versions                     // channel: [ versions.yml ]
}
