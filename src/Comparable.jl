### file: Comparable/src/Comparable.jl

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
A module to facilitate the construction of type
that have binary comparison operators.
"
module Comparable

import Base.>, Base.>=, Base.<=, Base.==, Base.!=

export AbstractComparable, >, >=, <=, ==, !=, eq, neq
export make_comparable, make_comparable_abstract

"
@make_comparable
----------------
A macro to derive the remaining binary comparison operators from 
the `<` operator defined for the specified type.
"
macro make_comparable( T )
    esc( quote
         >=( a::$T, b::$T ) = !( a < b )
         >( a::$T, b::$T ) = b < a
         <=( a::$T, b::$T ) = !( b < a )
         ==( a::$T, b::$T ) = !(( a < b ) || ( b < a ))
         
         >=( a::$T, b ) = !( a < b )
         >( a::$T, b ) = b < a
         <=( a::$T, b ) = !( b < a )
         ==( a::$T, b ) = !(( a < b ) || ( b < a ))
         
         >=( a, b::$T ) = !( a < b )
         >( a, b::$T ) = b < a
        <=( a, b::$T ) = !( b < a )
        ==( a, b::$T ) = !(( a < b ) || ( b < a ))
    end )
end

"
@make_comparable_abstract
-------------------------
A macro to derive the remaining comparison operators from
the `<` operator defined for an abstract type.
"
macro make_comparable_abstract( C::Symbol )

    T = C != :T ? :T : Symbol( string( "T", randstring( 2 )))
    esc( quote

         >=( a::$C, b::$C ) = !( a < b )
         >( a::$C, b::$C ) = b < a
         <=( a::$C, b::$C ) = !( b < a )
         ==( a::$C, b::$C ) = !(( a < b ) || ( b < a ))
         
         >=( a::$C, b ) = !( a < b )
         >( a::$C, b ) = b < a
         <=( a::$C, b ) = !( b < a )
         =={ $T <: $C }( a::$T, b ) = !(( a < b ) || ( b < a ))
         
         >=( a, b::$C ) = !( a < b )
        >( a, b::$C ) = b < a
        <=( a, b::$C ) = !( b < a )
        =={ $T <: $C }( a, b::$T ) = !(( a < b ) || ( b < a ))
    end)
end

"
AbstractComparable
------------------
An abstract type facilitating the construction of comparable types
by deriving the binary comparison operators from `<`.
"
abstract AbstractComparable

#
# ... Derive the binary comparison operators
#

@make_comparable_abstract AbstractComparable


end # module
