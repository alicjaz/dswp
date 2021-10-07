import numpy as np
from scipy.stats import scoreatpercentile
import statistics as stats

data = np.loadtxt("Wzrost.csv", delimiter=',', skiprows=0, unpack=True)
#print(data)

print("Górna granica mediany: ", stats.median_high(data))
print("Dolna granica mediany: ", stats.median_low(data))
print("Najczęśćiej występująca wartość: ", stats.mode(data))
print("Wariancja: ", stats.pvariance(data))
print("Odchylenie standardowe: ", stats.stdev(data))

