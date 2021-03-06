% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tune_proposals.R
\name{tune_proposals}
\alias{tune_proposals}
\title{Tune proposal densities}
\usage{
tune_proposals(data, tune_iterations, K = NULL, thetas = NULL,
  alphas = NULL, deltas = NULL, taus = NULL,
  theta_prior_params = c(0, 1), alpha_prior_params = c(1.5, 1.5, 0.25,
  4), delta_prior_params = c(2, 2, -5, 5), tau_prior_params = c(2, 2,
  -6, 6))
}
\arguments{
\item{data}{An integer matrix giving the response by each
respondent to each item}

\item{tune_iterations}{An integer vector of length one;
the number of iterations to complete}

\item{K}{(Optional) A numeric vector with an element for each item giving
the number of options for the item; if not provided, it is generated by
taking the number of unique options observed in the data}

\item{thetas}{(Optional) A numeric vector giving an initial value
for each respondent's theta parameter;
if not given, the initial values are drawn from the prior distribution}

\item{alphas}{(Optional) A numeric vector giving an initial value
for each item's alpha parameter;
if not given, the initial values are drawn from the prior distribution}

\item{deltas}{(Optional) A numeric vector giving an initial value
for each item's delta parameter;
if not given, the initial values are drawn from the prior distribution}

\item{taus}{(Optional) A list giving an initial value
for each item's tau vector;
if not given, the initial values are drawn from the prior distribution}

\item{theta_prior_params}{A numeric vector of length two;
the mean and standard deviation of theta parameters' prior distribution
(where the theta parameters have a normal prior; the default is 0 and 1)}

\item{alpha_prior_params}{A numeric vector of length four;
the two shape parameters and a and b values for alpha parameters' prior
distribution (where the alpha parameters have a four parameter beta prior;
the default is 1.5, 1.5, 0.25, and 4)}

\item{delta_prior_params}{A numeric vector of length four;
the two shape parameters and a and b values for delta parameters' prior
distribution (where the delta parameters have a four parameter beta prior;
the default is 2, 2, -5, and 5)}

\item{tau_prior_params}{A numeric vector of length four;
the two shape parameters and a and b values for tau parameters' prior
distribution (where the tau parameters have a four parameter beta prior;
the default is 2, 2, -6, and 6)}
}
\value{
A list, where each element is a numeric vector;
  the first element is a numeric vector of standard deviations for the
  theta parameters' proposals, the second for the alpha parameters, the
  third for the delta parameters, and the fourth for the tau parameters
}
\description{
Tunes the standard deviation for the parameters' proposal densities
}
\details{
This function runs the MCMC algorithm for the number of iterations
specified in \code{tune_iterations}, updating parameter values at each
iteration. Every 100 iterations, the function determines how many
of the previous 100 iterations resulted in an accepted proposal for
each parameter. If the number of acceptances was less than 20,
the standard deviation of the proposal for that parameter is
decreased by (20 - N) * 0.01, where N is the number of acceptances in
the previous 100 iterations. If N is greater than 25, the proposal
standard deviation is increased by (N - 25) * 0.01.

Please see the vignette (via \code{vignette("bggum")}) for a full in-depth
practical guide to Bayesian estimation of GGUM parameters.
}
\section{Warning}{

The parameters are updated in place;
that is, if you supply objects for the \code{theta}, \code{alpha},
\code{delta}, and \code{tau} arguments, the objects will not hold the
same values after the function is run
(in the underlying C++ function, these objects are passed by reference).
}

\examples{
## NOTE: This is a toy example just to demonstrate the function, which uses
## a small dataset and an unreasonably low number of tuning interations.
## For a longer practical guide on Bayesian estimation of GGUM parameters,
## please see the vignette ( via vignette("bggum") ).
## We'll simulate data to use for this example
set.seed(123)
sim_data <- ggum_simulation(100, 10, 2)
## Now we can tune the proposal densities
## (for the purposes of example, we use 100 iterations,
## though in practice you would use much more)
proposal_sds <- tune_proposals(data = sim_data$response_matrix,
                               tune_iterations = 100)

}
