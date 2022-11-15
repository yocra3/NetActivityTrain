// Import generic module functions
include { initOptions; saveFiles; getSoftwareName } from './functions'

params.options = [:]
options        = initOptions(params.options)

process PYTHON_MODEL_POSTPROCESSING {

    label 'process_low'

    container 'yocra3/netactivitytrain:1.0'

    input:
    tuple val(name), path('model'), path("history_model.pb")

    output:
    path("*_training_evaluation.txt"), emit: evaluation
    tuple val(name), path("*_model_weights.h5"), emit: weights

    script:
    """
    model_postprocessing.py $name
    """
}
