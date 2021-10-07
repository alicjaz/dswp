import numpy as np
import scipy.stats as scipy

data = np.loadtxt("Wzrost.csv", delimiter=',', skiprows=0, unpack=True)
#print(data)

print("Miara koncentracji: ",scipy.kurtosis(data))
print("Skośność rozkładu: ",scipy.skew(data))
print("Podstawowe statystyki opisowe rozkładu: ",scipy.describe(data))

