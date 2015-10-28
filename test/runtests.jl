### file: Comparable/test/runtests.jl

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
using Comparable
using FactCheck

import Base.<

immutable SimpleWrapper{T} <: AbstractComparable
    value::T
end

<{T1,T2}( a::SimpleWrapper{T1}, b::SimpleWrapper{T2} ) = a.value < b.value
<{T}( a::SimpleWrapper{T}, b ) = a.value < b
<{T}( a, b::SimpleWrapper{T} ) = a < b.value

facts( "Comparable" ) do

    context( "with a < b" ) do
        a = SimpleWrapper( 1 )
        b = SimpleWrapper( 2 )
        @fact a < b --> true
        @fact a <= b --> true
        @fact a == b --> false
        @fact a != b --> true
        @fact a >= b --> false
        @fact a > b --> false
    end

    context( "with a > b" ) do
        a = SimpleWrapper( 2 )
        b = SimpleWrapper( 1 )
        @fact a < b --> false
        @fact a <= b --> false
        @fact a == b --> false
        @fact a != b --> true
        @fact a >= b --> true
        @fact a > b --> true
    end

    context( "with a == b" ) do
        a = SimpleWrapper( 1 )
        b = SimpleWrapper( 1 )
        @fact a < b --> false
        @fact a <= b --> true
        @fact a == b --> true
        @fact a != b --> false
        @fact a >= b --> true
        @fact a > b --> false
    end

    context( "with a < b and only a is wrapped" ) do
        a = SimpleWrapper( 1 )
        b = 2 
        @fact a < b --> true
        @fact a <= b --> true
        @fact a == b --> false
        @fact a != b --> true
        @fact a >= b --> false
        @fact a > b --> false    
    end

    context( "with a > b and only a is wrapped" ) do
        a = SimpleWrapper( 2 )
        b = 1
        @fact a < b --> false
        @fact a <= b --> false
        @fact a == b --> false
        @fact a != b --> true
        @fact a >= b --> true
        @fact a > b --> true
    end

    context( "with a == b and only a is wrapped" ) do
        a = SimpleWrapper( 1 )
        b = 1
        @fact a < b --> false
        @fact a <= b --> true
        @fact a == b --> true
        @fact a != b --> false
        @fact a >= b --> true
        @fact a > b --> false
    end


    
end
