print(__doc__)

import numpy as np
from numpy import genfromtxt
from scipy import interp
import matplotlib.pyplot as plt
import os
from sklearn import svm, datasets
from sklearn.metrics import roc_curve, auc
from sklearn.model_selection import StratifiedKFold

N_SPLITS = 10

###############################################################################
# Data reading
userName = os.getlogin()
train_path = "C:/Users/" + userName  + r"/Dropbox/PhD/Courses/2019 - C - Fall/BMEN689 - ML and CV in BMEN/Project/prog/github/bmen689_group2/trainingSet.csv"
my_data = genfromtxt(train_path, delimiter=',')
numSamples = my_data.shape[0]
numFeatures = my_data.shape[1]-1

X = my_data[:,0:numFeatures]
y = my_data[:,numFeatures]

###############################################################################
# Classification and ROC analysis

# Run classifier with cross-validation and plot ROC curves
cv = StratifiedKFold(n_splits=N_SPLITS)
cv.get_n_splits(X, y)
classifier = svm.SVC(kernel='linear', probability=True)

mean_tpr = 0.0
mean_fpr = np.linspace(0, 1, 100)
all_tpr = []
i = 1
for (train, test) in cv.split(X, y):
    probas_ = classifier.fit(X[train], y[train]).predict_proba(X[test])
    # Compute ROC curve and area the curve
    fpr, tpr, thresholds = roc_curve(y[test], probas_[:, 1])
    mean_tpr += interp(mean_fpr, fpr, tpr)
    mean_tpr[0] = 0.0
    roc_auc = auc(fpr, tpr)
    plt.plot(fpr, tpr, lw=1, label='ROC fold %d (area = %0.2f)' % (i, roc_auc))
    i = i + 1

plt.plot([0, 1], [0, 1], '--', color=(0.6, 0.6, 0.6), label='Luck')

mean_tpr /= i-1
mean_tpr[-1] = 1.0
mean_auc = auc(mean_fpr, mean_tpr)
plt.plot(mean_fpr, mean_tpr, 'k--', label='Mean ROC (area = %0.2f)' % mean_auc, lw=2)
plt.xlim([-0.05, 1.05])
plt.ylim([-0.05, 1.05])
plt.xlabel('False Positive Rate')
plt.ylabel('True Positive Rate')
plt.title('Receiver operating characteristic example')
plt.legend(loc="lower right")
plt.show()