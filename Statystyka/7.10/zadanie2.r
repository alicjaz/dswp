library(e1071)
data <- read.csv("C:\\Users\\Ala\\PycharmProjects\\dswp\\Statystyka\\7.10\\napoje_po_reklamie.csv", sep=";")

pepsi <- data[2]
fanta <- data[3]

print("=============PEPSI=============")
print(lapply(pepsi,summary))
print("=============FANTA=============")
print(lapply(fanta,summary))