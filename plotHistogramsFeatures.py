import seaborn as sns
import numpy as np
from numpy import genfromtxt
from sklearn import preprocessing
from sklearn.metrics import roc_curve, auc
import matplotlib.pyplot as plt
import matplotlib as mpl 
import time
import datetime
import os	



ts = time.time()
timeStamp = datetime.datetime.fromtimestamp(ts).strftime('%Y%m%d_%H_%M_%S')
userName = os.getlogin()

pathTraining = r'C:\Users\rmjch\Dropbox\PhD\Courses\2019 - C - Fall\BMEN689 - ML and CV in BMEN\Project\prog\github\bmen689_group2\trainingSet_full_v2.csv'
outputPath  = outputFileName = "C:/Users/" + userName  + r"/Dropbox/PhD/Courses/2019 - C - Fall/BMEN689 - ML and CV in BMEN/Project/prog/results/" + timeStamp + '_featureDistribution.png'
outputPathCSV  = outputFileName = "C:/Users/" + userName  + r"/Dropbox/PhD/Courses/2019 - C - Fall/BMEN689 - ML and CV in BMEN/Project/prog/results/" + timeStamp + '_featureDistribution.csv'

# reading data from csv
my_data = genfromtxt(pathTraining, delimiter=',')
numSamples = my_data.shape[0]
numFeatures = my_data.shape[1]-1

X = my_data[:,0:numFeatures]
y = my_data[:,numFeatures]

X = preprocessing.scale(X)
DPI = 300
FIG_SIZE = (20, 20)
FIG_SIZE_WIDE = (30,20)
FONT_SIZE_TITLE = 10
FONT_SIZE_SUBTITLE = 20
FONT_SIZE_TICKS = 2
FONT_WEIGHT = 'bold'

aucs = np.zeros((47,2))



# Plots to see the very low gains, to see if we are reading just dark current
plt.rcParams["figure.dpi"] = DPI  
mpl.rc('xtick', labelsize=FONT_SIZE_TICKS) 
mpl.rc('ytick', labelsize=FONT_SIZE_TICKS)
fig, ax = plt.subplots(nrows = 5, ncols = 10, figsize=FIG_SIZE_WIDE)
rowNum = 0
sns.set(font_scale=0.1)
for row in ax:
    colNum = 0
    for col in row:
        currFeature = rowNum * 10 + colNum
        if (currFeature < 47):
            for label in range(2):
                if label == 0:
                    strLabel = 'Bening'
                else:
                    strLabel = 'Malignant'
                currentFeature = X[y == label, currFeature]
                fpr, tpr, thresholds = roc_curve(y, X[:,currFeature]) #change currFeature for your feature (0,1,2,3 or whatever)
                roc_auc = auc(fpr, tpr)
                aucs[currFeature, : ] = [currFeature, roc_auc]
                sns.distplot(currentFeature, hist = False, kde = True,kde_kws = {'shade': True, 'linewidth': 0.5}, label = strLabel, ax = col)
                col.set_title('%d (AUC %.2f)' % (currFeature + 1,roc_auc), fontsize=FONT_SIZE_SUBTITLE, fontweight= FONT_WEIGHT)
                col.tick_params(direction='in', length=6, width=0.5, colors='k',grid_color='k', grid_alpha=0.5)
        colNum = colNum + 1
    rowNum = rowNum  + 1
fig.subplots_adjust(wspace=0.4)
fig.savefig(outputPath, bbox_inches='tight')
plt.close()

np.savetxt(outputPathCSV, aucs, delimiter=",")
