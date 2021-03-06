context("Equilibrium FIML Model's Tests\n")

parameters <- list(
    nobs = 1000, tobs = 3,
    alpha_d = -0.9, beta_d0 = 14.9, beta_d = c(0.3, -0.2), eta_d = c(-0.03, -0.01),
    alpha_s = 0.9, beta_s0 = 3.2, beta_s = c(0.3), eta_s = c(0.5, 0.02),
    sigma_d = 1.0, sigma_s = 1.0, rho_ds = 0.0
)
# parameters <- list(
#    nobs = 1000, tobs = 9,
#    beta_d0 = 14.9, alpha_d = -0.9, beta_d = c(0.3, -0.2), eta_d = c(-0.03, -0.01),
#    beta_s0 = 3.2, alpha_s = 0.9, beta_s = c(0.3), eta_s = c(0.5, 0.02),
#    sigma_d = 1, sigma_s = 1, rho_ds = 0
# )

mdl <- load_or_simulate_model("equilibrium_model", parameters)

# Estimation setup
reltol <- 1e-12
optimization_method <- "BFGS"

# Estimate
optimization_controls <- list(REPORT = 10, maxit = 50000, reltol = reltol)
est <- estimate(mdl, control = optimization_controls, method = optimization_method)
reg <- estimate(mdl, method = "2SLS")
mll <- maximize_log_likelihood(mdl,
    start = NULL, step = 1e-5,
    objective_tolerance = 1e-4,
    gradient_tolerance = 1e-3
)

# Test
test_that(paste0(
    "Maximum likelihood estimates of '", get_model_description(mdl),
    "' are accurate"
), {
    test_estimation_accuracy(est@coef, unlist(parameters[-c(1, 2)]), 1e-0)
})

test_that(paste0(
    "Two-stage least squares estimates of '", get_model_description(mdl),
    "' are accurate"
), {
    order <- c(
        "beta_d0", "alpha_d", "beta_d", "eta_d",
        "beta_s0", "alpha_s", "beta_s", "eta_s"
    )
    test_estimation_accuracy(
        reg$system_model$coefficients, unlist(parameters[order]), 1e-0
    )
})

test_that(paste0("Aggregation can be calculated"), {
    test_aggregation(get_aggregate_demand, mdl, est@coef)
    test_aggregation(get_aggregate_supply, mdl, est@coef)
})

test_that(paste0("Scores can be calculated"), {
    test_scores(mdl, est@coef)
})

test_that(paste0("First stage of '", get_model_description(mdl), "' can be estimated"), {
    expect_is(reg$first_stage_model, "lm")
})

test_that(paste0("Second stage of '", get_model_description(mdl), "' can be estimated"), {
    expect_is(reg$system_model, "systemfit")
})

test_that(paste0("Optimization of '", get_model_description(mdl), "' using GSL succeeds"), {
    testthat::expect_length(mll, 8)
})


test_that(paste0(
    "Calculated gradient of '", get_model_description(mdl),
    "' matches the numerical approximation"
), {
    test_calculated_gradient(mdl, est@coef, 1e-1)
})
