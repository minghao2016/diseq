# diseq 0.1.1

* Prepared CRAN submission. Small adjustments to README style. Updated CRAN comments.

# diseq 0.1.0.9004

* Adjusted file names so that they are consistent with the  API changes.

# diseq 0.1.0.9003

* Fixed `M1mac` issues. Adjusted README to API changes. Replaced `href` with `doi` whenever relevant. 

# diseq 0.1.0.9002

* Added macro checks for C++20 execution policies features in C++ sources. Removed calls to `std::ragnes::iota_view` and `std::reduce` to ensure C++11 compatibility.

# diseq 0.1.0.9001

* Adjusted vignettes to API changes. 

# diseq 0.1.0.9000

* Introduced the option maximizing the equilibrium model likelihood using `GSL` through `Rcpp`. Added linting and formatting configuration files for R and C++ code. Cleaned C++ code. Reorganized R back-end classes.

# diseq 0.0.14.9004

* Improved README file style.

# diseq 0.0.14.9003

* Corrected style attributes of README file.

# diseq 0.0.14.9002

* Corrected calculation of clustered standard errors by accounting for the number of used classes. 

# diseq 0.0.14.9001

* Changes to adjust for depreciating functionality of `dplyr` (as of 0.7.0)

# diseq 0.0.14

* Added option and documentation for estimating clustered standards errors.

# diseq 0.0.13.9002

* Added documentation for the function that return the scores.

# diseq 0.0.13.9001

* Added option for estimating heteroscedasticity-consistent (Huber-White) standard errors. 
* Added functionality for extracting the score matrices of the estimated models. 

# diseq 0.0.13.9000

* Corrected documentation typos.

# diseq 0.0.13

* Corrections of non-canonical web-links in README. Adjustments before CRAN submission.

# diseq 0.0.12.9002

* Added sections `A quick model tour`, `Alternative packages`, and `Planned extensions` in README.

# diseq 0.0.12.9001

* Added `noLD` in word exceptions list.

# diseq 0.0.12

* Fixed `noLD` issues.

# diseq 0.0.11.9002

* Renamed assessment vignette.

# diseq 0.0.11.9001

* Enabled BFGS-based estimation with numerical gradient. Added CRAN installation instructions in README.

# diseq 0.0.11.9000

* Corrected punctuation errors in documentation.

# diseq 0.0.11

* Removed "get_correlation_variable" from exported functions. Improved the documentation of "minus_log_likelihood". Reintroduced references in description.

# diseq 0.0.10

* Removed references from description to avoid CRAN notes.

# diseq 0.0.9

* Ignoring README.html from build. Removed links from description. Improved documentation examples.

# diseq 0.0.8

* Added examples to constructors, estimation, aggregation, and marginal effect functions.

# diseq 0.0.7.9002

* Skipping directional and stochastic adjustment tests on CRAN to reduce build time.

# diseq 0.0.7.9001

* Quoted all package names in DESCRIPTION. To reduce build time: 1. Removed direction model estimation from equilibrium assessment vignette, 2. Decreased estimation accuracy of basic usage vignette to six digits.

# diseq 0.0.7

* Fixed order of arguments in web-link of estimation documentation. Improved simulation documentation.

# diseq 0.0.6

* Corrected documentation typos. Fixed web-links.

# diseq 0.0.5.9009

* Improved documentation.

# diseq 0.0.5.9008

* Removed unused parameter from the constructor of the equilibrium two stage least square model.

# diseq 0.0.5.9007

* Removed dependence on `pastecs` package.

# diseq 0.0.5.9006

* Reformatted code using the `styler` package. Removed the `lintr` based test.

# diseq 0.0.5.9005

* Adjustments to address breaking changes of the `tibble` package.

# diseq 0.0.5.9004

* Added a vignette with an equilibrium assessment example.

# diseq 0.0.5.9003

* Added model-specific simulation functions.

# diseq 0.0.5.9002

* Refactored simulation code.

# diseq 0.0.5.9001

* Added simulation generating processes for all supported models. 

# diseq 0.0.4.9013

* Separated auto-generated derivative code to dedicated derivative files. 

# diseq 0.0.4.9012

* Allowed estimation of full information maximum likelihood, equilibrium, deterministic adjustment, and stochastic adjustment with one-sided inclusion of prices.
* Modified model titles' generation.

# diseq 0.0.4.9011

* Added basic_usage vignette.
* Added simulation function at model_base level. 
* Added a `NEWS.md` file to track changes to the package.
