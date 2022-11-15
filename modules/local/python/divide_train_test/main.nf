process PYTHON_DIVIDE_TRAIN_TEST {

    label 'process_medium_memory'
    container 'yocra3/netactivitytrain:1.0'

    input:
    tuple val(prefix), path(hdf5), path(rds), path(group)
    val(prop)

    output:
    tuple val(prefix), path("train.pb"), path("test.pb"), emit: data
    path("*test_indices.csv"), emit: indices

    when:
    task.ext.when == null || task.ext.when

    script:
    """
    divide_train_test.py $prefix $hdf5 $group $prop
    """
}
