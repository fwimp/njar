#' Generate a random binary map
#'
#' @param n The size of the map
#'
#' @returns A random binary map (matrix)
#' @export
#'
#' @examples
#' generate_test_matrix(5)
generate_test_matrix <- function(n=500) {
  matrix(sample(c(TRUE, FALSE), n*n, replace = TRUE), nrow=n, ncol=n)
}
