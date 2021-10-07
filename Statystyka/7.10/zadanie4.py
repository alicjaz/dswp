import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from pandas import plotting
data = pd.read_csv(r'C:\Users\Ala\PycharmProjects\dswp\Statystyka\7.10\brain_size.csv', sep=';', na_values=".")

srednia = pd.DataFrame(data,columns=['VIQ']).mean()
print("Średnia: ", srednia,"\n")
print("Felame/Male Counter: \n", data['Gender'].value_counts())


plotting.hist_frame(data[['VIQ','PIQ','FSIQ']])
plt.show()

woman = data[data.Gender == "Female"] 

plotting.hist_frame(woman[['Weight','Height','MRI_Count']])
plt.show()