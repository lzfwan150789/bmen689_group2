print(__doc__)

import numpy as np
from numpy import genfromtxt
from scipy import interp
import matplotlib.pyplot as plt
import os	
from sklearn import svm, datasets, preprocessing
<<<<<<< HEAD
from sklearn.metrics import roc_curve, auc
from sklearn.model_selection import StratifiedKFold
=======
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import roc_curve, auc
from sklearn.model_selection import StratifiedKFold
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis
>>>>>>> master
from sklearn.utils import shuffle
import time
import datetime

<<<<<<< HEAD
N_SPLITS = 10
=======
N_SPLITS = 5
>>>>>>> master


DPI = 300
FIG_SIZE = (20, 20)

ts = time.time()
timeStamp = datetime.datetime.fromtimestamp(ts).strftime('%Y%m%d_%H_%M_%S')
userName = os.getlogin()
<<<<<<< HEAD
outputFileName = "C:/Users/" + userName  + r"/Dropbox/PhD/Courses/2019 - C - Fall/BMEN689 - ML and CV in BMEN/Project/prog/results/" + timeStamp + '_10fold.png'
train_path = "C:/Users/" + userName  + r"/Dropbox/PhD/Courses/2019 - C - Fall/BMEN689 - ML and CV in BMEN/Project/prog/github/bmen689_group2/trainingSet.csv"
=======
outputFileName = "C:/Users/" + userName  + r"/Dropbox/PhD/Courses/2019 - C - Fall/BMEN689 - ML and CV in BMEN/Project/prog/results/" + timeStamp + '_5fold_SVM_nonlinear_c2.png'
train_path = "C:/Users/" + userName  + r"/Dropbox/PhD/Courses/2019 - C - Fall/BMEN689 - ML and CV in BMEN/Project/prog/github/bmen689_group2/testingSet.csv"
>>>>>>> master



###############################################################################
# Data reading
my_data = genfromtxt(train_path, delimiter=',')
numSamples = my_data.shape[0]
numFeatures = my_data.shape[1]-1

X = my_data[:,0:numFeatures]
y = my_data[:,numFeatures]


X = preprocessing.scale(X)

X, y = shuffle(X,y)

###############################################################################
# Classification and ROC analysis

# Run classifier with cross-validation and plot ROC curves
cv = StratifiedKFold(n_splits=N_SPLITS)
cv.get_n_splits(X, y)
<<<<<<< HEAD
classifier = svm.SVC(kernel='linear', probability=True)

=======
#classifier = svm.SVC(kernel='linear', probability=True)
classifier = svm.SVC(kernel='rbf', C = 2, probability=True)
#classifier = LogisticRegression(random_state=0, solver='lbfgs', multi_class='multinomial')
#classifier = LinearDiscriminantAnalysis()
>>>>>>> master
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


###############################################################################
#plot  
<<<<<<< HEAD
fig_r = plt.figure(1, figsize=FIG_SIZE)
plt.rcParams["figure.dpi"] = DPI  	
plt.plot([0, 1], [0, 1], '--', color=(0.6, 0.6, 0.6), label='Luck')
=======
fig = plt.figure(1, figsize=FIG_SIZE)
plt.rcParams["figure.dpi"] = DPI  	
ax = fig.add_subplot(111)
ax.plot([0, 1], [0, 1], '--', color=(0.6, 0.6, 0.6), label='Luck')
>>>>>>> master

mean_tpr /= i-1
mean_tpr[-1] = 1.0
mean_auc = auc(mean_fpr, mean_tpr)
<<<<<<< HEAD
plt.plot(mean_fpr, mean_tpr, 'k--', label='Mean ROC (area = %0.2f)' % mean_auc, lw=2)
plt.xlim([-0.05, 1.05])
plt.ylim([-0.05, 1.05])
plt.xlabel('False Positive Rate')
plt.ylabel('True Positive Rate')
plt.title('Receiver operating characteristic example')
plt.legend(loc="lower right")
fig_r.savefig(outputFileName, bbox_inches='tight')
=======
ax.plot(mean_fpr, mean_tpr, 'k--', label='Mean ROC (area = %0.2f)' % mean_auc, lw=2)
ax.set_xlim([-0.05, 1.05])
ax.set_ylim([-0.05, 1.05])
ax.set_xlabel('False Positive Rate')
ax.set_ylabel('True Positive Rate')
ax.set_title('Receiver operating characteristic example')
ax.legend(loc="lower right")
fig.savefig(outputFileName, bbox_inches='tight')
>>>>>>> master
plt.close()