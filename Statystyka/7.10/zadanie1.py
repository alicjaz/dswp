import numpy as np
from scipy.stats import scoreatpercentile

data = np.loadtxt("estimates.csv",delimiter=',', usecols=(10,),  skiprows=1, unpack=True)
print(data)
print("Maksymalny wzrost:", data.max())
print("Maksymalny wzrost, funkcja:", np.max(data))
print("Minimalny wzrost:", data.min())
print("Minimalny wzrost, funkcja:", np.min(data))
print("Średni wzrost:", data.mean())
print("Średni wzrost, funkcja:", np.mean(data))
print("Odchylenie standardowe, wzrost:", data.std())
print("Odchylenie standardowe, wzrost, funkcja:", np.std(data))
print("Mediana:", np.median(data))
print("Wartość na 50 procencie:", scoreatpercentile(data, 50))
