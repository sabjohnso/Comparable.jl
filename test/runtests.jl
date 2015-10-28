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

import Base.<, Base.<=, Base.==, Base.!=, Base.>=, Base.>

immutable SimpleWrapper{T} <: AbstractComparable
    value::T
end

<{T1,T2}( a::SimpleWrapper{T1}, b::SimpleWrapper{T2} ) = a.value < b.value
<{T}( a::SimpleWrapper{T}, b ) = a.value < b
<{T}( a, b::SimpleWrapper{T} ) = a < b.value

facts( "Abstract without alternate type" ) do

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

end


type OtherWrapper
    value
end

value( a::OtherWrapper ) = a.value

<( a::OtherWrapper, b::OtherWrapper ) = value( a ) < value( b )
<( a::OtherWrapper, b::Number ) = value( a ) < b
<( a::Number, b::OtherWrapper ) = a < value( b )

@make_comparable OtherWrapper Number


facts( "With alternate type" ) do
    context( "with a < b" ) do
        a = OtherWrapper( 1 )
        b = OtherWrapper( 2 )
        @fact a < b --> true
        @fact a <= b --> true
        @fact a == b --> false
        @fact a != b --> true
        @fact a >= b --> false
        @fact a > b --> false
    end

    context( "with a > b" ) do
        a = OtherWrapper( 2 )
        b = OtherWrapper( 1 )
        @fact a < b --> false
        @fact a <= b --> false
        @fact a == b --> false
        @fact a != b --> true
        @fact a >= b --> true
        @fact a > b --> true
    end

    context( "with a == b" ) do
        a = OtherWrapper( 1 )
        b = OtherWrapper( 1 )
        @fact a < b --> false
        @fact a <= b --> true
        @fact a == b --> true
        @fact a != b --> false
        @fact a >= b --> true
        @fact a > b --> false
    end

    context( "with a < b and only a is wrapped" ) do
        a = OtherWrapper( 1 )
        b = 2 
        @fact a < b --> true
        @fact a <= b --> true
        @fact a == b --> false
        @fact a != b --> true
        @fact a >= b --> false
        @fact a > b --> false    
    end

    context( "with a > b and only a is wrapped" ) do
        a = OtherWrapper( 2 )
        b = 1
        @fact a < b --> false
        @fact a <= b --> false
        @fact a == b --> false
        @fact a != b --> true
        @fact a >= b --> true
        @fact a > b --> true
    end

    context( "with a == b and only a is wrapped" ) do
        a = OtherWrapper( 1 )
        b = 1
        @fact a < b --> false
        @fact a <= b --> true
        @fact a == b --> true
        @fact a != b --> false
        @fact a >= b --> true
        @fact a > b --> false
    end


    
    context( "with a < b and only b is wrapped" ) do
        a = 1
        b = OtherWrapper( 2 )
        @fact a < b --> true
        @fact a <= b --> true
        @fact a == b --> false
        @fact a != b --> true
        @fact a >= b --> false
        @fact a > b --> false    
    end

    context( "with a > b and only b is wrapped" ) do
        a = 2
        b = OtherWrapper( 1 )
        @fact a < b --> false
        @fact a <= b --> false
        @fact a == b --> false
        @fact a != b --> true
        @fact a >= b --> true
        @fact a > b --> true
    end

    context( "with a == b and only b is wrapped" ) do
        a = 1
        b = OtherWrapper( 1 )
        @fact a < b --> false
        @fact a <= b --> true
        @fact a == b --> true
        @fact a != b --> false
        @fact a >= b --> true
        @fact a > b --> false
    end

end



type YAWrapper
    value
end

value( a::YAWrapper ) = a.value

<( a::YAWrapper, b::YAWrapper ) = value( a ) < value( b )
<( a::YAWrapper, b::Number ) = value( a ) < b
<( a::Number, b::YAWrapper ) = a < value( b )

@make_comparable_abstract YAWrapper Number

facts( "Abstract with alternate type" ) do
    context( "with a < b" ) do
        a = YAWrapper( 1 )
        b = YAWrapper( 2 )
        @fact a < b --> true
        @fact a <= b --> true
        @fact a == b --> false
        @fact a != b --> true
        @fact a >= b --> false
        @fact a > b --> false
    end

    context( "with a > b" ) do
        a = YAWrapper( 2 )
        b = YAWrapper( 1 )
        @fact a < b --> false
        @fact a <= b --> false
        @fact a == b --> false
        @fact a != b --> true
        @fact a >= b --> true
        @fact a > b --> true
    end

    context( "with a == b" ) do
        a = YAWrapper( 1 )
        b = YAWrapper( 1 )
        @fact a < b --> false
        @fact a <= b --> true
        @fact a == b --> true
        @fact a != b --> false
        @fact a >= b --> true
        @fact a > b --> false
    end

    context( "with a < b and only a is wrapped" ) do
        a = YAWrapper( 1 )
        b = 2 
        @fact a < b --> true
        @fact a <= b --> true
        @fact a == b --> false
        @fact a != b --> true
        @fact a >= b --> false
        @fact a > b --> false    
    end

    context( "with a > b and only a is wrapped" ) do
        a = YAWrapper( 2 )
        b = 1
        @fact a < b --> false
        @fact a <= b --> false
        @fact a == b --> false
        @fact a != b --> true
        @fact a >= b --> true
        @fact a > b --> true
    end

    context( "with a == b and only a is wrapped" ) do
        a = YAWrapper( 1 )
        b = 1
        @fact a < b --> false
        @fact a <= b --> true
        @fact a == b --> true
        @fact a != b --> false
        @fact a >= b --> true
        @fact a > b --> false
    end


    
    context( "with a < b and only b is wrapped" ) do
        a = 1
        b = YAWrapper( 2 )
        @fact a < b --> true
        @fact a <= b --> true
        @fact a == b --> false
        @fact a != b --> true
        @fact a >= b --> false
        @fact a > b --> false    
    end

    context( "with a > b and only b is wrapped" ) do
        a = 2
        b = YAWrapper( 1 )
        @fact a < b --> false
        @fact a <= b --> false
        @fact a == b --> false
        @fact a != b --> true
        @fact a >= b --> true
        @fact a > b --> true
    end

    context( "with a == b and only b is wrapped" ) do
        a = 1
        b = YAWrapper( 1 )
        @fact a < b --> false
        @fact a <= b --> true
        @fact a == b --> true
        @fact a != b --> false
        @fact a >= b --> true
        @fact a > b --> false
    end

end



type YAWrapper2
    value
end

value( a::YAWrapper2 ) = a.value
<( a::YAWrapper2, b::YAWrapper2 ) = value( a ) < value( b )

@make_comparable YAWrapper2

facts( "Without alternate type" ) do
    context( "with a < b" ) do
        a = YAWrapper2( 1 )
        b = YAWrapper2( 2 )
        @fact a < b --> true
        @fact a <= b --> true
        @fact a == b --> false
        @fact a != b --> true
        @fact a >= b --> false
        @fact a > b --> false
    end

    context( "with a > b" ) do
        a = YAWrapper2( 2 )
        b = YAWrapper2( 1 )
        @fact a < b --> false
        @fact a <= b --> false
        @fact a == b --> false
        @fact a != b --> true
        @fact a >= b --> true
        @fact a > b --> true
    end

    context( "with a == b" ) do
        a = YAWrapper2( 1 )
        b = YAWrapper2( 1 )
        @fact a < b --> false
        @fact a <= b --> true
        @fact a == b --> true
        @fact a != b --> false
        @fact a >= b --> true
        @fact a > b --> false
    end

end
