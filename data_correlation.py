import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

pathTraining = r'C:\Users\rmjch\Dropbox\PhD\Courses\2019 - C - Fall\BMEN689 - ML and CV in BMEN\Project\prog\github\bmen689_group2\trainingSet_full_v2.csv'
data = pd.read_csv(pathTraining, header=None)

corr = data.corr()
ax = sns.heatmap(
    corr, 
    vmin=-1, vmax=1, center=0,
    cmap=sns.diverging_palette(20, 220, n=200),
    square=True
)
ax.set_xticklabels(
    ax.get_xticklabels(),
    rotation=45,
    horizontalalignment='right'
);

fig.savefig(outputPath, bbox_inches='tight')