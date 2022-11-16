#! /usr/local/bin/python

#'#################################################################################
#'#################################################################################
#' Split data in training and test
#'#################################################################################
#'#################################################################################

import h5py
import pickle
import sys
import csv
import numpy as np

from sklearn.model_selection import RandomizedSearchCV, train_test_split
from sklearn.preprocessing import LabelEncoder, OneHotEncoder

prefix = sys.argv[1]
h5 = sys.argv[2]
group = sys.argv[3]
prop = float(sys.argv[4])


f = h5py.File(h5, 'r')
methy = f['assay001'][...]
f.close()


with open(group,'r') as file:
    labels = file.read()
labels = labels.split('\n')[0:-1]

## embedding labels
# binary encode
onehot_encoder = OneHotEncoder(sparse=False)
integer_encoded = np.array(labels).reshape(len(labels), 1)
onehot_labels = onehot_encoder.fit_transform(integer_encoded)
index = range(len(labels))

x_train, x_test, y_train, y_test, index_train, index_test = train_test_split(methy, onehot_labels, index,
                                                    stratify = onehot_labels,
                                                    test_size = prop, random_state = 42)

pickle.dump( [x_train, x_train], open( "train.pb", "wb" ), protocol = 4 )
pickle.dump( [x_test, x_test], open( "test.pb", "wb" ), protocol = 4 )

with open(prefix + '_test_indices.csv', 'w', newline='') as csvfile:
    writer = csv.writer(csvfile)
    writer.writerows([index_test[index]] for index in range(len(index_test)))
