import numpy as np
from numpy import genfromtxt
from sklearn.model_selection import train_test_split
from sklearn.model_selection import cross_val_score
from sklearn import datasets
from sklearn import svm

# read data
train_path = "trainingSet.csv"
my_data = genfromtxt(train_path, delimiter=',')
numSamples = my_data.shape[0]
numFeatures = my_data.shape[1]-1
x_train = my_data[:,0:numFeatures]
y_train = my_data[:,numFeatures]

#clf = svm.SVC(kernel='linear', C=1)
clf = svm.SVC(kernel='linear', C=1)
scores = cross_val_score(clf, x_train, y_train, cv=10)
print(scores)