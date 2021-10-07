import pandas as pd
data = pd.read_csv('brain_size.csv', sep=";", na_values=".")
data_pogrupowane= data.grupby("Gender")
print(data_pogrupowane)