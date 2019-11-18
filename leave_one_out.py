import numpy as np
from numpy import genfromtxt
import matplotlib.pyplot as plt
from scipy import interp
from sklearn import svm
from sklearn.model_selection import LeaveOneOut
from sklearn.metrics import roc_curve, auc
# read data
train_path = "trainingSet.csv"
my_data = genfromtxt(train_path, delimiter=',')
numSamples = my_data.shape[0]
numFeatures = my_data.shape[1]-1
X = my_data[:,0:numFeatures]
y = my_data[:,numFeatures]

loo = LeaveOneOut()
loo.get_n_splits(X)
classifier = svm.SVC(kernel='linear', probability=True)
print(loo)
mean_tpr = 0.0
mean_fpr = np.linspace(0, 1, 100)
all_tpr = []
i = 0
predictions = np.zeros((10, 4))
for train_index, test_index in loo.split(X):
	X_train, X_test = X[train_index], X[test_index]
	y_train, y_test = y[train_index], y[test_index]
	y_test_hat = classifier.fit(X_train, y_train).predict(X_test)
	y_test = np.squeeze(y_test)
	y_test_hat = np.squeeze(y_test_hat)
	if ( y_test == 1 ):
		if (y_test == y_test_hat):
			predictions[i,0] = 1
		else:
			predictions[i,2] = 1
	elif (y_test == 0):
		if (y_test == y_test_hat):
			predictions[i,3] = 1
		else:
			predictions[i,1] = 1
	i =  i + 1


np.savetxt("leave_one_out_results_svm.csv", a, delimiter=",")
accum_predictions = np.sum(predictions, axis = 0)
print (accum_predictions)
TP  = accum_predictions[0]
FP  = accum_predictions[1]
FN  = accum_predictions[2]
TN  = accum_predictions[3]

sensitivity = TP / (FP + FN)
