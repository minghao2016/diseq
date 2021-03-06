% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/disequilibrium_model.R
\name{get_normalized_shortages}
\alias{get_normalized_shortages}
\alias{get_normalized_shortages,disequilibrium_model-method}
\title{Normalized shortages.}
\usage{
get_normalized_shortages(object, parameters)

\S4method{get_normalized_shortages}{disequilibrium_model}(object, parameters)
}
\arguments{
\item{object}{A disequilibrium model object.}

\item{parameters}{A vector of parameters at which the shortages are evaluated.}
}
\value{
A vector with the estimated normalized shortages.
}
\description{
Returns the shortages normalized by the variance of the difference of the shocks at a
given point.
}
\examples{
\donttest{
simulated_data <- simulate_model_data(
  "diseq_basic", 500, 3, # model type, observed entities, observed time points
  -0.9, 8.9, c(0.3, -0.2), c(-0.03, -0.01), # demand coefficients
  0.9, 4.2, c(0.03), c(-0.05, 0.02) # supply coefficients
)

# initialize the model
model <- new(
  "diseq_basic", # model type
  c("id", "date"), "Q", "P", # keys, quantity, and price variables
  "P + Xd1 + Xd2 + X1 + X2", "P + Xs1 + X1 + X2", # equation specifications
  simulated_data, # data
  use_correlated_shocks = TRUE # allow shocks to be correlated
)

# estimate a model object
est <- estimate(model)

# get estimated normalized shortages
nshort <- get_normalized_shortages(model, est@coef)
}
}
