#' @include market_model.R

#' @title Equilibrium model base class
setClass(
    "disequilibrium_model",
    contains = "market_model",
    representation(),
    prototype()
)

setMethod(
    "initialize", "disequilibrium_model",
    function(
             .Object,
             model_type_string, verbose,
             key_columns, time_column,
             quantity_column, price_column,
             demand_specification, supply_specification, price_specification,
             use_correlated_shocks,
             data,
             system_initializer) {
        .Object <- callNextMethod(
            .Object,
            model_type_string, verbose,
            key_columns, time_column,
            quantity_column, price_column,
            demand_specification, supply_specification, price_specification,
            use_correlated_shocks,
            data,
            system_initializer
        )
    }
)

setGeneric("calculate_h", function(object, equation) {
  standardGeneric("calculate_h")
})

setGeneric("calculate_z", function(object, equation_i, equation_j) {
  standardGeneric("calculate_z")
})

setGeneric("get_shortage_variance", function(object) {
  standardGeneric("get_shortage_variance")
})

#' Normalized shortages.
#'
#' Returns the shortages normalized by the variance of the difference of the shocks at a
#' given point.
#' @param object A disequilibrium model object.
#' @param parameters A vector of parameters at which the shortages are evaluated.
#' @return A vector with the estimated normalized shortages.
#' @rdname get_normalized_shortages
#' @examples
#' \donttest{
#' simulated_data <- simulate_model_data(
#'   "diseq_basic", 500, 3, # model type, observed entities, observed time points
#'   -0.9, 8.9, c(0.3, -0.2), c(-0.03, -0.01), # demand coefficients
#'   0.9, 4.2, c(0.03), c(-0.05, 0.02) # supply coefficients
#' )
#'
#' # initialize the model
#' model <- new(
#'   "diseq_basic", # model type
#'   c("id", "date"), "Q", "P", # keys, quantity, and price variables
#'   "P + Xd1 + Xd2 + X1 + X2", "P + Xs1 + X1 + X2", # equation specifications
#'   simulated_data, # data
#'   use_correlated_shocks = TRUE # allow shocks to be correlated
#' )
#'
#' # estimate a model object
#' est <- estimate(model)
#'
#' # get estimated normalized shortages
#' nshort <- get_normalized_shortages(model, est@coef)
#' }
#' @export
setGeneric("get_normalized_shortages", function(object, parameters) {
  standardGeneric("get_normalized_shortages")
})

#' Relative shortages.
#'
#' Returns the shortages normalized by the supplied quantity at a given point.
#' @param object A disequilibrium model object.
#' @param parameters A vector of parameters at which the shortages are evaluated.
#' @return A vector with the estimated normalized shortages.
#' @rdname get_relative_shortages
#' @examples
#' \donttest{
#' simulated_data <- simulate_model_data(
#'   "diseq_basic", 500, 3, # model type, observed entities, observed time points
#'   -0.9, 8.9, c(0.3, -0.2), c(-0.03, -0.01), # demand coefficients
#'   0.9, 4.2, c(0.03), c(-0.05, 0.02) # supply coefficients
#' )
#'
#' # initialize the model
#' model <- new(
#'   "diseq_basic", # model type
#'   c("id", "date"), "Q", "P", # keys, quantity, and price variables
#'   "P + Xd1 + Xd2 + X1 + X2", "P + Xs1 + X1 + X2", # equation specifications
#'   simulated_data, # data
#'   use_correlated_shocks = TRUE # allow shocks to be correlated
#' )
#'
#' # estimate a model object
#' est <- estimate(model)
#'
#' # get estimated relative shortages
#' rshort <- get_relative_shortages(model, est@coef)
#' }
#' @export
setGeneric("get_relative_shortages", function(object, parameters) {
  standardGeneric("get_relative_shortages")
})

#' Shortage probabilities.
#'
#' Returns the shortage probabilities, i.e. the probabilities of an
#' observation coming from an excess demand regime, at the given point.
#' @param object A disequilibrium model object.
#' @param parameters A vector of parameters at which the shortage probabilities are evaluated.
#' @return A vector with the estimated shortage probabilities.
#' @rdname get_shortage_probabilities
#' @examples
#' \donttest{
#' simulated_data <- simulate_model_data(
#'   "diseq_basic", 500, 3, # model type, observed entities, observed time points
#'   -0.9, 8.9, c(0.3, -0.2), c(-0.03, -0.01), # demand coefficients
#'   0.9, 4.2, c(0.03), c(-0.05, 0.02) # supply coefficients
#' )
#'
#' # initialize the model
#' model <- new(
#'   "diseq_basic", # model type
#'   c("id", "date"), "Q", "P", # keys, quantity, and price variables
#'   "P + Xd1 + Xd2 + X1 + X2", "P + Xs1 + X1 + X2", # equation specifications
#'   simulated_data, # data
#'   use_correlated_shocks = TRUE # allow shocks to be correlated
#' )
#'
#' # estimate a model object
#' est <- estimate(model)
#'
#' # get the estimated shortage probabilities
#' probs <- get_shortage_probabilities(model, est@coef)
#' }
#' @export
setGeneric("get_shortage_probabilities", function(object, parameters) {
  standardGeneric("get_shortage_probabilities")
})

setGeneric("get_scaled_effect", function(object, estimation, variable, scale_function) {
  standardGeneric("get_scaled_effect")
})

#' Mean marginal effects
#'
#' Returns the average estimated marginal effect a variable.
#' @param object A disequilibrium model object.
#' @param estimation A model estimation object (i.e. a \code{\link[bbmle]{mle2}} object).
#' @param variable Variable name for which the effect is calculated.
#' @return The mean of the estimated marginal effects of the passed variable.
#' @rdname get_mean_marginal_effect
#' @examples
#' \donttest{
#' simulated_data <- simulate_model_data(
#'   "diseq_basic", 500, 3, # model type, observed entities, observed time points
#'   -0.9, 8.9, c(0.3, -0.2), c(-0.03, -0.01), # demand coefficients
#'   0.9, 4.2, c(0.03), c(-0.05, 0.02) # supply coefficients
#' )
#'
#' # initialize the model
#' model <- new(
#'   "diseq_basic", # model type
#'   c("id", "date"), "Q", "P", # keys, quantity, and price variables
#'   "P + Xd1 + Xd2 + X1 + X2", "P + Xs1 + X1 + X2", # equation specifications
#'   simulated_data, # data
#'   use_correlated_shocks = TRUE # allow shocks to be correlated
#' )
#'
#' # estimate a model object
#' est <- estimate(model)
#'
#' # get the mean marginal effects of variable "X1"
#' get_mean_marginal_effect(model, est, "X1")
#' }
#' @export
setGeneric("get_mean_marginal_effect", function(object, estimation, variable) {
  standardGeneric("get_mean_marginal_effect")
})

#' Marginal effects at the mean.
#'
#' Returns the estimated marginal effects evaluated at the mean of a variable.
#' @param object A disequilibrium model object.
#' @param estimation A model estimation object (i.e. a \code{\link[bbmle]{mle2}} object).
#' @param variable Variable name for which the effect is calculated.
#' @return The marginal effect of the passed variable evaluated at the estimated mean.
#' @rdname get_marginal_effect_at_mean
#' @examples
#' \donttest{
#' simulated_data <- simulate_model_data(
#'   "diseq_basic", 500, 3, # model type, observed entities, observed time points
#'   -0.9, 8.9, c(0.3, -0.2), c(-0.03, -0.01), # demand coefficients
#'   0.9, 4.2, c(0.03), c(-0.05, 0.02) # supply coefficients
#' )
#'
#' # initialize the model
#' model <- new(
#'   "diseq_basic", # model type
#'   c("id", "date"), "Q", "P", # keys, quantity, and price variables
#'   "P + Xd1 + Xd2 + X1 + X2", "P + Xs1 + X1 + X2", # equation specifications
#'   simulated_data, # data
#'   use_correlated_shocks = TRUE # allow shocks to be correlated
#' )
#'
#' # estimate a model object
#' est <- estimate(model)
#'
#' # get the marginal effects at the mean of variable "X1"
#' get_marginal_effect_at_mean(model, est, "X1")
#' }
#' @export
setGeneric("get_marginal_effect_at_mean", function(object, estimation, variable) {
  standardGeneric("get_marginal_effect_at_mean")
})

#' Checks if an observation is in a shortage stage.
#'
#' Returns TRUE for the indices at which the shortages of the market are non-negative, i.e. the
#' market is in an excess demand state. Returns FALSE for the remaining indices. The evaluation
#' of the shortages is performed using the passed parameter vector.
#' @param object A disequilibrium model object.
#' @param parameters A vector of parameters at which the shortage probabilities are evaluated.
#' @return A vector of Boolean values indicating observations with shortages.
#' @rdname has_shortage
#' @examples
#' \donttest{
#' simulated_data <- simulate_model_data(
#'   "diseq_basic", 500, 3, # model type, observed entities, observed time points
#'   -0.9, 8.9, c(0.3, -0.2), c(-0.03, -0.01), # demand coefficients
#'   0.9, 4.2, c(0.03), c(-0.05, 0.02) # supply coefficients
#' )
#'
#' # initialize the model
#' model <- new(
#'   "diseq_basic", # model type
#'   c("id", "date"), "Q", "P", # keys, quantity, and price variables
#'   "P + Xd1 + Xd2 + X1 + X2", "P + Xs1 + X1 + X2", # equation specifications
#'   simulated_data, # data
#'   use_correlated_shocks = TRUE # allow shocks to be correlated
#' )
#'
#' # estimate a model object
#' est <- estimate(model)
#'
#' # get the indices of  estimated shortages
#' has_short <- has_shortage(model, est@coef)
#' }
#' @export
setGeneric("has_shortage", function(object, parameters) {
  standardGeneric("has_shortage")
})

setMethod(
  "calculate_h", signature(object = "system_base", equation = "equation_base"),
  function(object, equation) {
    (object@quantity_vector - equation@independent_matrix %*% equation@alpha_beta) / equation@sigma
  }
)

setMethod(
  "calculate_z",
  signature(object = "system_base", equation_i = "equation_base", equation_j = "equation_base"),
  function(object, equation_i, equation_j) {
    (equation_i@h - equation_j@h * object@rho) * object@rho1
  }
)

setMethod("get_shortage_variance", signature(object = "disequilibrium_model"), function(object) {
    sqrt(object@system@demand@var + object@system@supply@var - 2 * object@system@demand@sigma *
        object@system@supply@sigma * object@system@rho)
})

#' @rdname get_normalized_shortages
setMethod(
    "get_normalized_shortages", signature(object = "disequilibrium_model"),
    function(object, parameters) {
        object@system <- set_parameters(object@system, parameters)
        (
            object@system@demand@independent_matrix %*% object@system@demand@alpha_beta -
                object@system@supply@independent_matrix %*% object@system@supply@alpha_beta
        ) / get_shortage_variance(object)
    }
)

#' @rdname get_relative_shortages
setMethod("get_relative_shortages", signature(object = "disequilibrium_model"), function(object, parameters) {
    object@system <- set_parameters(object@system, parameters)
    (
        object@system@demand@independent_matrix %*% object@system@demand@alpha_beta -
            object@system@supply@independent_matrix %*% object@system@supply@alpha_beta
    ) / object@system@supply@independent_matrix %*% object@system@supply@alpha_beta
})

#' @rdname get_shortage_probabilities
setMethod(
    "get_shortage_probabilities", signature(object = "disequilibrium_model"),
    function(object, parameters) {
        pnorm(get_normalized_shortages(object, parameters))
    }
)

setMethod(
    "get_scaled_effect", signature(object = "disequilibrium_model"),
    function(object, estimation, variable, scale_function) {
        object@system <- set_parameters(object@system, estimation@coef)
        dvar <- paste0(object@system@demand@variable_prefix, variable)
        svar <- paste0(object@system@supply@variable_prefix, variable)
        in_demand <- dvar %in% get_prefixed_independent_variables(object@system@demand)
        in_supply <- svar %in% get_prefixed_independent_variables(object@system@supply)
        scale <- scale_function(estimation@coef)
        if (in_demand && in_supply) {
            effect <- scale * (
                estimation@coef[dvar] - estimation@coef[svar]
            ) / get_shortage_variance(object)
            names(effect) <- paste0("B_", variable)
        }
        else if (in_demand) {
            effect <- scale * estimation@coef[dvar] / get_shortage_variance(object)
            names(effect) <- dvar
        }
        else {
            effect <- -scale * estimation@coef[svar] / get_shortage_variance(object)
            names(effect) <- svar
        }
        effect
    }
)

#' @rdname get_mean_marginal_effect
setMethod(
    "get_mean_marginal_effect", signature(object = "disequilibrium_model"),
    function(object, estimation, variable) {
        get_scaled_effect(
            object, estimation, variable,
            function(x) mean(dnorm(get_normalized_shortages(object, x)))
        )
    }
)

#' @rdname get_marginal_effect_at_mean
setMethod(
    "get_marginal_effect_at_mean", signature(object = "disequilibrium_model"),
    function(object, estimation, variable) {
        get_scaled_effect(
            object, estimation, variable,
            function(x) dnorm(mean(get_normalized_shortages(object, x)))
        )
    }
)

#' @rdname has_shortage
setMethod(
    "has_shortage", signature(object = "disequilibrium_model"),
    function(object, parameters) {
        get_normalized_shortages(object, parameters) >= 0
    }
)
