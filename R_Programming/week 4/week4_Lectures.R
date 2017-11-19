## simulating random numbers

# rnorm: generate random Normal varialbles with given mean and standard deviation
# dnorm: evaulate the Normal probabilyt density
# d for density
# r for random number generation
# p for cumulative distribution
# q for quantile function
rnorm(n, mean = 0, sd = 1)
dnorm(x, mean = 0, sd = 1, log=FALSE)
pnorm(q, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
qnorm(p, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)

x <- rnorm(10, mean = 0, sd = 1)
x
x <- rnorm(10, 20, 2)
x

set.seed(1) # random number generator seed
rnorm(5)
rnorm(5)
set.seed(1) # sets once, need to reset for reproducing results
rnorm(5)

rpois(10, 1)
rpois(10, 2)
rpois(10, 20)

ppois(2, 2) # cumulative distribution
ppois(4, 2) # probability that a variable is <= 4 when the rate is 2 in the poisson distribution

# simulating a linear model
set.seed(20)
x <- rnorm(100)
e <- rnorm(100, 0, 2)
y <- 0.5 + 2 * x + e
summary(y)
plot(x, y)

set.seed(10)
x <- rbinom(100, 1, 0.5)
e <- rnorm(100, 0, 2)
y <- 0.5 + 2 * x + e
summary(y)
plot(x, y)

set.seed(1)
x <- rnorm(100)
log.mu <- 0.5 + 0.3 * x
y <- rpois(100, exp(log.mu))
summary(y)
plot(x, y)

# simulation random sampling
set.seed(1)
sample(1:10, 4)
sample(1:10, 4)
sample(letters, 5)
sample(1:10) ## permutation
sample(1:10)
sample(1:10, replace = TRUE) # sample with replacement

# R Profiler
# profiling is a systematic way to examine how much time is spent in parts of a program
# useful when optimizing code
# design first, then optimize

system.time({expression})
# if error, gives time until error
# returns proc_time - user time, elapsed time

Rprof()
summaryRprof() # summarizes output from Rprof() to read
  
