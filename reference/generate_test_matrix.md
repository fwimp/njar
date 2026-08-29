# Generate a random binary map

Generate a random binary map

## Usage

``` r
generate_test_matrix(n = 500)
```

## Arguments

- n:

  The size of the map

## Value

A random binary map (matrix)

## Examples

``` r
generate_test_matrix(5)
#>       [,1]  [,2]  [,3]  [,4]  [,5]
#> [1,]  TRUE  TRUE  TRUE FALSE  TRUE
#> [2,] FALSE  TRUE  TRUE  TRUE FALSE
#> [3,]  TRUE FALSE FALSE FALSE FALSE
#> [4,] FALSE FALSE  TRUE  TRUE  TRUE
#> [5,] FALSE FALSE  TRUE FALSE FALSE
```
