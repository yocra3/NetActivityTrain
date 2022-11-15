// Import generic module functions
include { initOptions; saveFiles; getSoftwareName } from './functions'

params.options = [:]
options        = initOptions(params.options)

process PYTHON_TRAIN_MODEL {

    label 'process_high_memory'
    label 'process_long'
    label 'process_cpu_high'

    publishDir "${params.outdir}",
        mode: params.publish_dir_mode,
        saveAs: { filename -> saveFiles(filename:filename, options:params.options, publish_dir:getSoftwareName(task.process), publish_id:'') }

    container 'yocra3/netactivitytrain:1.0'

    input:
    tuple val(name), path(train), path(test), path(genes)
    tuple val(conf_name), path('model.py'), path('params.py')
    path('pathway_map.tsv')


    output:
    tuple val(name), path("*history_model.pb"), emit: history
    tuple val(name), path(name), emit: model
    path('*pathways_names.txt'), emit: pathway_labels

    script:
    """
    train_model.py $name $train $test $genes $task.cpus
    """
}
