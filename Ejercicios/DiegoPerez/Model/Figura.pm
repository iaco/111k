#!/usr/bin/perl

use GD;
use GD::Simple;
use Math::Vector::Real;
use strict;
use warnings;

    
package Figura; 
use Moose;
	use constant PI => 3.14159;

    has 'x1', is => 'rw', isa => 'Num';
    has 'y1', is => 'rw', isa => 'Num';
    has 'x2', is => 'rw', isa => 'Num';
    has 'y2', is => 'rw', isa => 'Num';


sub distancia
{#dado dos puntos devuelve su distancia
    my $x1 = shift || 0;
    my $y1 = shift || 0;
    my $x2 = shift || 0;
    my $y2 = shift || 0;
   	my $difX = abs($x2 - $x1);
    my $difY = abs($y2 - $y1);
    $difX = $difX**2;
    $difY = $difY**2;
    return sqrt ($difX + $difY);
}

no Moose;
#_PACKAGE_->meta->make_immutable;
1;



