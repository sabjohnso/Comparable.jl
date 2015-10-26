# Comparable

### Derived Binary Comparison Operators

[![Build Status](http://travis-ci.org/sabjohnso/Comparable.jl.svg?branch=master)](https://travis-ci.org/sabjohnso/Comparable.jl)
[![codecov.io](http://codecov.io/github/sabjohnso/Comparable.jl/coverage.svg?branch=master)](http://codecov.io/github/sabjohnso/Comparable.jl?branch=master)

`Comparable.jl` is a [Julia](http://julialang.org) package to facilitate the generation of types with binary comparison operator by using a user defined `<` operator to derive the remaining binary comparison operators: `<=`, `>`, `>=`, `==` and  `!=`.

Dual licensing (GPLv3, alternate commercial) - See LICENSE.md


### Getting Started

To define a new comparable type, inherit from AbstractComparable and define a method for `<`:

```julia
using Comparable

import Base.<

type SimpleWrapper{T} <: AbstractScalar
    value::T
end

<{T}( a::SimpleWrapper{T}, b::SimpleWrapper{T} ) = a.value < b.value


a = SimpleWrapper( 3 )
b = SimpleWrapper( 4 )

println( a <  b )
println( a <= b )
println( a == b )
println( a != b )
println( a >= b )
println( a >  b )

```

```julia
true
true
false
true
false
false
```
