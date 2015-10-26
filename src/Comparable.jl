### file: Scalar/test/runtests.jl

## Copyright (c) 2015 Samuel B. Johnson

## Author: Samuel B. Johnson <sabjohnso@yahoo.com>

## This file is lincesed under a two license system. For commercial use
## that is not compatible with the GPLv3, please contact the author.
## Otherwise, continue reading below.

## This file is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3, or (at your option)
## any later version.

## You should have received a copy of the GNU General Public License
## along with this program. If not, see <http://www.gnu.org/licenses/>.

### Code:
"
module Comparable
-----------------
A module exporting an abstract type, AbstractComparable and a number
of methods overloaded for subtypes of that type to facilitate the
creation of types with binary comparison operators.
"
module Comparable

import Base.>, Base.>=, Base.<=, Base.==, Base.!=

export AbstractComparable, >, >=, <=, ==, !=




"
AbstractComparable
------------------
An abstract type facilitating the construction of comparable types
by deriving the binary comparison operators from `<`.
"
abstract AbstractComparable

#
# ... Derived binary comparison operators
#
>{ T <: AbstractComparable }( a::T, b::T ) = b < a
>={ T <: AbstractComparable }( a::T, b::T ) = !( a < b )
<={ T <: AbstractComparable }( a::T, b::T ) = !( b < a )
=={ T <: AbstractComparable }( a::T, b::T ) = !( a < b || b < a )
!={ T <: AbstractComparable }( a::T, b::T ) = a < b || b < a

end # module
