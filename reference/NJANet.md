# NJA network class

The container of an NJA network.

## Value

A new NJANet object.

## Public fields

- `image`:

  The original image used for processing.

- `skel`:

  A skeletonised version of the original image.

- `nodes`:

  The nodes of the network

- `edges`:

  The edges of the network

- `incorrect_1nodes`:

  Nodes with 1 junc and more than 1 connected edge

## Active bindings

- `bordermat`:

  skel but with a 1 column and 1 row border of 0s.

- `juncmat`:

  A map of the number of junctions that each cell has.

- `adj_stack`:

  A 3D array containing the stack of adjacencies for each pixel.

## Methods

### Public methods

- [`NJANet$new()`](#method-NJANet-new)

- [`NJANet$print()`](#method-NJANet-print)

- [`NJANet$clone()`](#method-NJANet-clone)

------------------------------------------------------------------------

### Method `new()`

Create a new NJANet object.

#### Usage

    NJANet$new(
      image = NULL,
      skel = NULL,
      nodes = NULL,
      edges = NULL,
      bordermat = NULL,
      juncmat = NULL,
      adj_stack = NULL
    )

#### Arguments

- `image`:

  The original image used for processing.

- `skel`:

  A skeletonised version of the original image.

- `nodes`:

  The nodes of the network

- `edges`:

  The edges of the network

- `bordermat`:

  skel but with a 1 column and 1 row border of 0s.

- `juncmat`:

  A map of the number of junctions that each cell has.

- `adj_stack`:

  A 3D array containing the stack of adjacencies for each pixel.

------------------------------------------------------------------------

### Method [`print()`](https://rdrr.io/r/base/print.html)

Print an NJANet object.

#### Usage

    NJANet$print(...)

#### Arguments

- `...`:

  Unused.

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    NJANet$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
