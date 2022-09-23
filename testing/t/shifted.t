#!/usr/bin/perl

use strict;
use warnings;
use Test2::V0;
use shifted;

# =============== THESE ARRAYS ARE SET WITHIN lib/CalcCoordinates =====================================================================================
# @locationshifts = ([1933,1],[2531,0],[3037,-2],[3254,0],[3433,-2],[8334,-1],[13340,-2],[13848,-4],[19255,-5],[20107,-8]);
# @coordinates = ([250,560,0],[3767,4765,1],[5853,7502,1],[9124,11130,1],[12136,12705,1],[15087,17084,1],[18200,18949,1],[20013,21809,1],[22675,23388,1]);


# ================ VALUES I AM PASSING IN =============================================================================================================
# $locationShiftedFrame $value


# ================ TESTS ==============================================================================================================================
# Coordinate Prior to any indels 
is( shifted::locationShifted(0,0), 250 );

# Coordinate inside indels
is( shifted::locationShifted(3,0), 9123 );

# Coordinate Greater than last indel location
is( shifted::locationShifted(7,1), 21801 );

done_testing();
