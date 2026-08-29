# NJA node class

A node in the NJA graph. Make a new one with `NJANode$new()`

## Value

A new NJANode object.

## Public fields

- `pos`:

  The position of the node.

- `surround`:

  A 3x3 array indicating the pixel context of the node.

- `juncs`:

  The number of junctions the node has.

- `dirs`:

  The directions that junctions of the node emit.

- `uid`:

  A string of the position, acting as a unique identifier.

- `connected_edges`:

  A named list of all connected edges.

## Methods

### Public methods

- [`NJANode$new()`](#method-NJANode-new)

- [`NJANode$print()`](#method-NJANode-print)

- [`NJANode$clone()`](#method-NJANode-clone)

------------------------------------------------------------------------

### Method `new()`

Create a new NJANode object.

#### Usage

    NJANode$new(pos, surround = NULL, juncs = NULL, dirs = NULL, uid = NULL)

#### Arguments

- `pos`:

  The position of the node.

- `surround`:

  A 3x3 array indicating the pixel context of the node.

- `juncs`:

  The number of junctions the node has.

- `dirs`:

  The directions that junctions of the node emit.

- `uid`:

  A string of the position, acting as a unique identifier.

------------------------------------------------------------------------

### Method [`print()`](https://rdrr.io/r/base/print.html)

Print an NJANode object.

#### Usage

    NJANode$print(...)

#### Arguments

- `...`:

  Unused.

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    NJANode$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
