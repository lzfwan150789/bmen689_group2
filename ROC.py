print(__doc__)

import numpy as np
from numpy import genfromtxt
from scipy import interp
import matplotlib.pyplot as plt
import os	
from sklearn import svm, datasets, preprocessing
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import roc_curve, auc
from sklearn.model_selection import StratifiedKFold
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis
from sklearn.utils import shuffle
import time
import datetime

N_SPLITS = 5


DPI = 300
FIG_SIZE = (20, 20)

ts = time.time()
timeStamp = datetime.datetime.fromtimestamp(ts).strftime('%Y%m%d_%H_%M_%S')
userName = os.getlogin()
outputFileName = "C:/Users/" + userName  + r"/Dropbox/PhD/Courses/2019 - C - Fall/BMEN689 - ML and CV in BMEN/Project/prog/results/" + timeStamp + '_5fold_SVM_nonlinear_c2.png'
train_path = "C:/Users/" + userName  + r"/Dropbox/PhD/Courses/2019 - C - Fall/BMEN689 - ML and CV in BMEN/Project/prog/github/bmen689_group2/testingSet.csv"



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
#classifier = svm.SVC(kernel='linear', probability=True)
classifier = svm.SVC(kernel='rbf', C = 2, probability=True)
#classifier = LogisticRegression(random_state=0, solver='lbfgs', multi_class='multinomial')
#classifier = LinearDiscriminantAnalysis()
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
fig = plt.figure(1, figsize=FIG_SIZE)
plt.rcParams["figure.dpi"] = DPI  	
ax = fig.add_subplot(111)
ax.plot([0, 1], [0, 1], '--', color=(0.6, 0.6, 0.6), label='Luck')

mean_tpr /= i-1
mean_tpr[-1] = 1.0
mean_auc = auc(mean_fpr, mean_tpr)
ax.plot(mean_fpr, mean_tpr, 'k--', label='Mean ROC (area = %0.2f)' % mean_auc, lw=2)
ax.set_xlim([-0.05, 1.05])
ax.set_ylim([-0.05, 1.05])
ax.set_xlabel('False Positive Rate')
ax.set_ylabel('True Positive Rate')
ax.set_title('Receiver operating characteristic example')
ax.legend(loc="lower right")
fig.savefig(outputFileName, bbox_inches='tight')
plt.close()