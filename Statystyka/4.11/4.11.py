import pandas as pd
import matplotlib.pyplot as plt
import scipy.stats as scs
import numpy as np

print('\nZadanie 1')
prob = 1/6
table = {'Value': [1, 2, 3, 4, 5, 6], 'Probability':[prob, prob, prob, prob, prob, prob]}
df = pd.DataFrame(data=table)

print(df)
print(df.max())
print(df.min())
print(df.mean())
print(df.std())
print(df.median())

# zad 2
print('\nZadanie 2')
p = 0.3
n = 100
mu = 2

bernoulli = scs.bernoulli.rvs(p, size=100)
print(bernoulli)
binom = scs.binom.rvs(n, p, size=100)
print(binom)
poisson = scs.poisson.rvs(mu, size=100)
print(poisson)

# zad 3
print('\nZadanie 3')
print('Rozkład Bernoulliego')
mean, var, skew, kurt = scs.bernoulli.stats(p, moments = 'mvsk')
print(mean)
print(var)
print(skew)
print(kurt)

mean, var, skew, kurt = scs.binom.stats(n, p, moments='mvsk')
print('\nRozkład Dwumianowy')
print(mean)
print(var)
print(skew)
print(kurt)

mean, var, skew, kurt = scs.poisson.stats(mu, p, moments='mvsk')
print('\nRozkład Poissona')
print(mean)
print(var)
print(skew)
print(kurt)

print('\nZadanie 4')

fig, (ax1, ax2, ax3) = plt.subplots(3)

# bernoulli
x = np.arange(scs.bernoulli.ppf(0.01, p), scs.bernoulli.ppf(0.99, p))
rv = scs.bernoulli(p)
ax1.vlines(x, 0, rv.pmf(x), colors='k', linestyles='-', lw=1, label='frozen pmf')
ax1.legend(loc='best', frameon=False)

# binom
x = np.arange(scs.binom.ppf(0.01, n, p), scs.binom.ppf(0.99, n, p))
rv = scs.binom(n, p)
ax2.vlines(x, 0, rv.pmf(x), colors='k', linestyles='-', lw=1, label='frozen pmf')
ax2.legend(loc='best', frameon=False)

# poisson
x = np.arange(scs.poisson.ppf(0.01, mu), scs.poisson.ppf(0.99, mu))
rv = scs.poisson(mu)
ax3.vlines(x, 0, rv.pmf(x), colors='b', linestyles='-', lw=1, label='frozen pmf')
ax3.legend(loc='best', frameon=False)
plt.show()


print('\nZadanie 5')
n = 20
p = 0.4
k = np.arange(0, 20)
binominal = scs.binom.pmf(k, n, p)
print(binominal)
print(sum(binominal))

print('\nZadanie 6')
norm_generated = scs.norm.rvs(loc=0, scale=2, size=100)
mean, var, skew, kurt = scs.norm.stats(loc=0, scale=2, moments = 'mvsk')
print(norm_generated)
print('Size = 100')
print('Średnia wygenerowana:', np.mean(norm_generated))
print('Średnia teoretyczna:', mean)
print('Odchylenie wygenerowane:', np.std(norm_generated))
print('Odchylenie teoretyczne:', np.sqrt(var))

print('Size = 100 000')
norm_generated = scs.norm.rvs(loc=0, scale=2, size=100000)
print('Średnia wygenerowana:', np.mean(norm_generated))
print('Odchylenie wygenerowane:', np.std(norm_generated))


print('\nZadanie 7')
norm_generated = scs.norm.rvs(loc=1, scale=2, size=100)
fig, ax = plt.subplots(1, 1)
x = np.linspace(scs.norm.ppf(0.01), scs.norm.ppf(0.99), 100)
ax.plot(x, scs.norm.pdf(x), 'r-', lw=6, alpha=0.5, label='Standardowy')
x = np.linspace(scs.norm.ppf(0.01, loc=-1, scale=0.5), scs.norm.ppf(0.99, loc=-1, scale=0.5), 100)
ax.plot(x, scs.norm.pdf(x, loc=-1, scale=0.5), 'k-', lw=3, label='Normalny – z próby')
ax.hist(norm_generated, density=True, histtype='bar', alpha=0.3)
ax.legend(loc='best')
plt.show()