
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split
import warnings
warnings.filterwarnings('ignore')


fd = pd.read_csv('heart.csv')
print(fd.head())
print(fd.info())
print(fd.describe())

plt.figure(figsize=(10, 10))
sns.heatmap(fd.corr(), annot=True, fmt='.1f')
plt.show()
