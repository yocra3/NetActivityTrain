#! /usr/local/bin/python

#'#################################################################################
#'#################################################################################
#' Postprocess model training
#'#################################################################################
#'#################################################################################

import pickle
import os
import csv
import numpy as np
import sys
import pandas as pd
import h5py
import tensorflow as tf

name = sys.argv[1]

## Write weights of first layer to a h5 file
model = tf.keras.models.load_model('model/')
w = model.get_weights()

w0 = w[0] * w[2]

f = h5py.File(name + '_model_weights.h5', 'w')
dataset_input = f.create_dataset('weights_paths', (w0.shape[0], w0.shape[1]))
dataset_input[...] = w0
f.close()



## Output training loss in a txt
A = open('history_model.pb', 'rb')
history = pickle.load(A)
A.close()

with open(name + '_training_evaluation.txt', 'w') as csv_file:
    writer = csv.writer(csv_file, delimiter = '\t', escapechar=' ', quoting = csv.QUOTE_NONE)
    for key, value in history.items():
       writer.writerow([key + '\t' + '\t'.join([str(item) for item in value ])])
