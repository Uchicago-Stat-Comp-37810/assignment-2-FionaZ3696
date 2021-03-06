######### Calculate the likelihood ###############
likelihood <- function(param){
  #assign input parameters to a
  a = param[1]
  #assign input parameters to b
  b = param[2]
  #assign input parameters to sd
  sd = param[3]
  
  #the mean value of y under the input parametres
  pred = a*x + b
  #calculate the density function and set it to single likelihood values. l(a,b,sd|yi) = log(f(yi|a,b,sd)).Notice here we set log=T, which takes log of the density function, this is because simple likelihoods, where a lot of small probabilities are multiplied, can get ridiculously small pretty fast, and computer programs are getting into numerical rounding or underflow problems. So we prefer to use log-likelihood
  singlelikelihoods = dnorm(y, mean = pred, sd = sd, log = T)
  #Calculate total log-likelihood values: l(a,b,sd|y) = sum of log(f(yi|a,b,sd)) for all i.
  sumll = sum(singlelikelihoods)
  #return the loglikelihood values
  return(sumll)   
}




#########Define prior distribution################
prior <- function(param){
  # assign the values of input parameters to a
  a = param[1]
  # assign the values of input parameters to b
  b = param[2]
  # assign the values of input parameters to sd
  sd = param[3]
  #specify prior distribution for each parameter. For "a", set it a uniform distribution, calculate its density, also take log transformation to its density
  aprior = dunif(a, min=0, max=10, log = T)
  # set normal distribution to b, and assign its density to bprior
  bprior = dnorm(b, sd = 5, log = T)
  # set another normal distribution to sd.
  sdprior = dunif(sd, min=0, max=30, log = T)
  # return the sum of three log values
  return(aprior+bprior+sdprior)
}





######### Define posterior ################
posterior <- function(param){
  # Calculate the product of prior and likelihood to provide the qunatity for MCMC algorithm, we use sum because we take log when calculating both likelihood and prior
  return (likelihood(param) + prior(param))
}







######## define proposal function ################
proposalfunction <- function(param){
  # choose normal distribution as the proposal distribution centered at the input parameters, and return a generated candidate x* for the next sample by picking from distribution g(x*|params)
  return(rnorm(3,mean = param, sd= c(0.1,0.5,0.3)))
}






####### Metropolis algorithm ################
run_metropolis_MCMC <- function(startvalue, iterations){ # initialize an arbitrary point to be the staring values, and set the number of iterations
  #create a chain to store all the element generated in each iterations
  chain = array(dim = c(iterations+1,3))
  #assign the first element in the chain to be the staring value we picked
  chain[1,] = startvalue
  for (i in 1:iterations){
    # generate a candidate x* (here named proposal) using the jumping distribution centered at last value in the chain
    proposal = proposalfunction(chain[i,])
    # calculate the acceptance ratio, which will be used to decide whether to accept or reject the candidate
    probab = exp(posterior(proposal) - posterior(chain[i,]))
    #generate a uniform random number u on [0,1]
    if (runif(1) < probab){
      # if u<= acceptance ratio, accept the candidate by setiing next element in the chain to the proposal
      chain[i+1,] = proposal
    }else{
      # if u<= acceptance ratio, reject the candidate proposal and set next element the same value as last element
      chain[i+1,] = chain[i,]
    }
  }
  return(chain)
}





########### summary plot #################
plotting<-function(startvalue,iterations){
  burnIn = 0.5*iterations
  chain = run_metropolis_MCMC(startvalue, iterations = iterations)
  # set 2 rows and 3 columns subgragh
  par(mfrow = c(2,3))
  # plot the histogram of the after burnIn values in chain (posterior of a)
  hist(chain[-(1:burnIn),1],nclass=30, , main="Posterior of a", xlab="True value = red line" )
  # draw the mean of after burnIn values in chain for a
  abline(v = mean(chain[-(1:burnIn),1]))
  # draw the true value of a
  abline(v = trueA, col="red" )
  # plot the histogram of the after burnIn values in chain (posterior of b)
  hist(chain[-(1:burnIn),2],nclass=30, main="Posterior of b", xlab="True value = red line")
  # draw the mean of after burnIn values in chain for b
  abline(v = mean(chain[-(1:burnIn),2]))
  # draw the true value of a
  abline(v = trueB, col="red" )
  # plot the histogram of the after burnIn values in chain (posterior of sd)
  hist(chain[-(1:burnIn),3],nclass=30, main="Posterior of sd", xlab="True value = red line")
  # draw the mean of after burnIn values in chain for sd
  abline(v = mean(chain[-(1:burnIn),3]) )
  # draw the true value of a
  abline(v = trueSd, col="red" )
  #plot the values in chain for a (except burnIn values)
  plot(chain[-(1:burnIn),1], type = "l", xlab="True value = red line" , main = "Chain values of a",)
  #draw the true value of a
  abline(h = trueA, col="red" )
  #plot the values in chain for b (except burnIn values)
  plot(chain[-(1:burnIn),2], type = "l", xlab="True value = red line" , main = "Chain values of b", )
  #draw the true value of b
  abline(h = trueB, col="red" )
  #plot the values in chain for sd (except burnIn values)
  plot(chain[-(1:burnIn),3], type = "l", xlab="True value = red line" , main = "Chain values of sd", )
  #draw the true value of sd
  abline(h = trueSd, col="red" )
}










