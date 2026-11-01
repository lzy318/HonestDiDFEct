# Creates a standard basis vector.

Creates a basis vector of length `size` with a 1 in the `index`
position.

## Usage

``` r
# Create the index basis vector in R^size
basisVector(index, size)
```

## Arguments

- index:

  The index at which there should be a one. Default equals one.

- size:

  The length of the vector. Default equals one.

## Value

Returns a basis vector of length `size` with a 1 in the `index`
position.

## Examples

``` r
  # Create the first basis vector in R^2
  basisVector(index = 1, size = 2)
#>      [,1]
#> [1,]    1
#> [2,]    0
  # Create the third basis vector in R^6
  basisVector(index = 3, size = 6)
#>      [,1]
#> [1,]    0
#> [2,]    0
#> [3,]    1
#> [4,]    0
#> [5,]    0
#> [6,]    0
```
