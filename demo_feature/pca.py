# Copyright: Junyi Wang

# This script conducts PCA on the entire feature matrix, which is aroudn 800,000x1024 in size
# The PCA will decrease the number of feature to 63
# Then normalize it
# It will take a loooooong time
# Take two arguments: 1. input feature vec file, file containing all features
# 2. output file, where you want to write to

import numpy as np
from sklearn.decomposition import PCA
from sklearn import preprocessing
import sys
import pickle

#firstHalf = sys.argv[1]
#secondHalf = sys.argv[2]
input = sys.argv[1]
outputFile = sys.argv[2]
data_type = sys.argv[3]

X = np.loadtxt(input, delimiter=",")

#print "The first half input shape is: ", first.shape

#second = np.loadtxt(secondHalf, delimiter=",")

#print "The second half input shape is: ", second.shape

# concatenate

#X=np.concatenate((first,second), axis=0)

print "The total size is: ", X.shape

# we want to downscale to 63 features
nf = 63


if data_type == 'train':
    print "Saving PCA class information"
    pca_info=PCA(n_components=nf)
    pca_info.fit(X)
    pickle.dump(pca_info, open('./pca_info.pickle','wb'))
elif data_type == 'test':
    pca_info = pickle.load(open('./pca_info.pickle'))

print "Can do pca"

X_new = pca_info.transform(X)

print "The output shape is: ", X_new.shape

print "Saving PCA class information"

print "Conduct normalization"

X_normed = preprocessing.scale(X_new)

np.savetxt(outputFile, X_normed, fmt='%1.8f', delimiter=',')
print "The output is saved to: ", outputFile
