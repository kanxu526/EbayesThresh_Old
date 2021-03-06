"postmean.laplace" <-
function(x, s, w, a = 0.5)
{
#
# find the posterior mean for the double exponential prior for 
#   given x, s, w and a, assuming the error variance
#   is 1.
#
#  only allow a < 20 for input value.
  a <- min(a, 20)
  #  First find the odds of zero and the shrinkage factor
#
	wpost <- wpost.laplace(w, x, s, a)
	#  now find the posterior mean conditional on being non-zero
#
	sx <- sign(x)
	x <- abs(x)
	xpa <- x/s + s*a
	xma <- x/s - s*a
	xpa[xpa > 35] <- 35
	xma[xma < -35] <- -35
	
	cp1 <- pnorm(xma)
	cp2 <- pnorm( - xpa)
	ef <- exp(pmin(2 * a * x, 100))
	postmeancond <- x - a * s^2 * ( 2 * cp1/(cp1 + ef * cp2) - 1)	
#  calculate posterior mean and return
#
	mutilde <- sx * wpost * postmeancond
	return(mutilde)
}
