# Add an external border to a matrix

Add an external border to a matrix

## Usage

``` r
border_matrix(m)
```

## Arguments

- m:

  The matrix to border

## Value

The matrix m with a 1 column and 1 row border of 0s

## Examples

``` r
m <- matrix(1, 3, 3)
border_matrix(m)
#>      [,1] [,2] [,3] [,4] [,5]
#> [1,]    0    0    0    0    0
#> [2,]    0    1    1    1    0
#> [3,]    0    1    1    1    0
#> [4,]    0    1    1    1    0
#> [5,]    0    0    0    0    0
```
