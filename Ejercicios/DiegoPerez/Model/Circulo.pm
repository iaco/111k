#!/usr/bin/perl

package Circulo;
use GD;
use GD::Simple;
use Math::Vector::Real;
use strict;
#use lib "/home/diego/Exercies/View/";
#use lib "/home/diego/Exercies/Controller/";
use warnings;
use Moose;
use constant PI => 3.14159;
extends 'Figura','Jorge::DBEntity';

sub area 
{
	my $self = shift;
	return PI * ( Figura::distancia($self->{x1}, $self->{y1}, $self->{x2}, $self->{y2}) **2);
}

sub _fields {
 
    my $table_name = 'Circulo';
 
    my @fields = qw(
        id_circ
        x1
        y1
        x2
        y2
    );
 
    my %fields = (
        id_circ => { pk => 1, read_only => 1 },
          );
 
    return [ \@fields, \%fields, $table_name ];
}

sub draw
{
	
	my $self = shift;
	my $img  = shift;
	 	
	
	my $x = $self->{x1};#valor de x en el centro del circulo
	my $y = $self->{y1};#valor de y en el centro del circulo
	my $radio  = &Figura::distancia($self->{x1}, $self->{y1},$self->{x2}, $self->{y2});
	my $yellow = $img->colorAllocate(255,255,0);
	$img->arc($x,$y,$radio,$radio,0,360,$yellow);
	$img->fill($x,$y,$yellow);
}
no Moose;
1;
