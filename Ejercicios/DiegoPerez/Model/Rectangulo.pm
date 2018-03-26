#!/usr/bin/perl
package Rectangulo;

use GD;
use GD::Simple;
use strict;
use warnings;
use lib "/home/diego/Exercies/View/";
use lib "/home/diego/Exercies/Controller/";
use Moose;

extends 'Figura','Jorge::DBEntity';


has 'x3', is => 'rw', isa => 'Num', default => 0;
has 'y3', is => 'rw', isa => 'Num', default => 0;
has 'x4', is => 'rw', isa => 'Num', default => 0;
has 'y4', is => 'rw', isa => 'Num', default => 0;

sub area
{
    my $self   = shift;
    my $base   = Figura::distancia($self->{x1}, $self->{y1},$self->{x2}, $self->{y2});
    my $altura = Figura::distancia($self->{x1}, $self->{y1},$self->{x3}, $self->{y3});
    print "Base= $base , altura= $altura\n";
    return $base * $altura;
}

sub _fields {#ORM Jorge
 
    my $table_name = 'Rectangulo';
 
    my @fields = qw(
        idRectangulo
        x1
        y1
        x2
        y2
        x3
        y3
        x4
        y4
    );
 
    my %fields = (
        idRectangulo => { pk => 1, read_only => 1 },
          );
 
    return [ \@fields, \%fields, $table_name ];
}

sub draw
{
	my $self = shift;
	my $img  = shift;
	my $polig = new GD::Polygon;
	my $color = $img->colorAllocate(255,120,0);
	$polig -> addPt($self->{x1}, $self->{y1});
	$polig -> addPt($self->{x2}, $self->{y2});
	$polig -> addPt($self->{x4}, $self->{y4});
	$polig -> addPt($self->{x3}, $self->{y3});
	$img ->filledPolygon($polig,$color);
	
}	

no Moose;
1;

