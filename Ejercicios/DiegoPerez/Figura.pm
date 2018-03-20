#!/usr/bin/perl

use GD;
use GD::Simple;
use Math::Vector::Real;
use strict;
use warnings;

    
package Figura; 
use Moose;
	use constant PI => 3.14159;

    has 'Vertice1x', is => 'rw', isa => 'Int', required => 1, reader => 'getx1', writer => 'setx1';

    has 'Vertice1y', is => 'rw', isa => 'Int', required => 1, reader => 'gety1', writer => 'sety1';

    has 'Vertice2x', is => 'rw', isa => 'Int', required => 1, reader => 'getx2', writer => 'setx2';

    has 'Vertice2y', is => 'rw', isa => 'Int', required => 1, reader => 'gety2', writer => 'sety2';


sub distancia
{#dado dos puntos devuelve su distancia
    my ($x1,$y1,$x2,$y2) =@_;
   	my $difX = $x2 - $x1;
    my $difY = $y2 - $y1;
    $difX = $difX**2;
    $difY = $difY**2;
    return sqrt ($difX + $difY);
}

no Moose;
#_PACKAGE_->meta->make_immutable;
1;



