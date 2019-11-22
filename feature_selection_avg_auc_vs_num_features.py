print(__doc__)

import numpy as np
from numpy import genfromtxt
from scipy import interp
import matplotlib.pyplot as plt
import matplotlib as mpl 
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
FIG_SIZE = (10, 9)
FONT_SIZE_TICKS = 25
FONT_SIZE_AXIS_LABEL = 25
FONT_SIZE_AXIS_TITLE = 30

ts = time.time()
timeStamp = datetime.datetime.fromtimestamp(ts).strftime('%Y%m%d_%H_%M_%S')
userName = os.getlogin()
train_path = "C:/Users/" + userName  + r"/Dropbox/PhD/Courses/2019 - C - Fall/BMEN689 - ML and CV in BMEN/Project/prog/github/bmen689_group2/trainingSet_full_v2_very_clean.csv"
aucsPath = "C:/Users/" + userName  +"/Dropbox/PhD/Courses/2019 - C - Fall/BMEN689 - ML and CV in BMEN/Project/prog/results/20191121_10_55_32_featureDistribution.csv"

topFeatures = genfromtxt(aucsPath, delimiter=',')
topFeatures = topFeatures[:,0].astype(int)


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

top_aucs = np.zeros((X.shape[1],))
for j in range(X.shape[1]):
    outputFileName = "C:/Users/" + userName  + r"/Dropbox/PhD/Courses/2019 - C - Fall/BMEN689 - ML and CV in BMEN/Project/prog/results/" + timeStamp + '_featureselection_avg_auc_vs_top_features_very_clean.png'
    classifier = svm.SVC(kernel='rbf', C = 0.75 , probability=True)
    #classifier = LogisticRegression(random_state=0, solver='lbfgs', multi_class='multinomial')
    #classifier = LinearDiscriminantAnalysis()
    mean_tpr = 0.0
    mean_fpr = np.linspace(0, 1, 100)
    all_tpr = []
    XX = X[:,topFeatures[:j+1]]
    i = 1
    for (train, test) in cv.split(XX, y):
        probas_ = classifier.fit(XX[train], y[train]).predict_proba(XX[test])
        # Compute ROC curve and area the curve
        fpr, tpr, thresholds = roc_curve(y[test], probas_[:, 1])
        mean_tpr += interp(mean_fpr, fpr, tpr)
        mean_tpr[0] = 0.0
        roc_auc = auc(fpr, tpr)
        i = i +1

    ###############################################################################
    #plot  
    mean_tpr /= i-1
    mean_tpr[-1] = 1.0
    mean_auc = auc(mean_fpr, mean_tpr)
    top_aucs[j] = mean_auc

fig = plt.figure(1, figsize=FIG_SIZE)
plt.rcParams["figure.dpi"] = DPI  	
mpl.rc('xtick', labelsize=FONT_SIZE_TICKS) 
mpl.rc('ytick', labelsize=FONT_SIZE_TICKS) 
ax = fig.add_subplot(111)
ax.plot(top_aucs, '--o', color=(0.1, 0.1, 0.1), label='Average AUC', linewidth=2)
ax.set_xlabel('Top N features', fontsize=FONT_SIZE_AXIS_LABEL)
ax.set_ylabel('Average AUC 5-fold CV', fontsize=FONT_SIZE_AXIS_LABEL)
ax.set_title('Average AUC vs Top N Features', fontsize=FONT_SIZE_AXIS_TITLE)
fig.savefig(outputFileName, bbox_inches='tight')
plt.close()