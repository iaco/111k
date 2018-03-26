#!/usr/bin/perl

package Triangulo;{

use GD;
use GD::Simple;
use strict;
use warnings;
use lib "/home/diego/Exercies/View/";
use lib "/home/diego/Exercies/Controller/";
use Moose;

extends 'Figura';
extends 'Jorge::DBEntity';

has 'x3', is => 'rw', isa => 'Int', default => 0;
has 'y3', is => 'rw', isa => 'Int', default => 0;

sub area{
	my ($self)=@_;
	my $base =  &Figura::distancia($self->{x1}, $self->{y1},$self->{x2}, $self->{y2});
	return ($base**2) * sqrt(3) / 4;
}

sub _fields {
 
    my $table_name = 'Triangulo';
 
    my @fields = qw(
        id_tria
        x1
        y1
        x2
        y2
        x3
        y3
    );
 
    my %fields = (
        id_tria => { pk => 1, read_only => 1 },
          );
 
    return [ \@fields, \%fields, $table_name ];
}

sub draw {
	
	my $self = shift;
	my $img  = shift;
	my $polig = new GD::Polygon;
	my $color = $img->colorAllocate(255,0,0);
	$polig -> addPt($self->{x1}, $self->{y1});
	$polig -> addPt($self->{x2}, $self->{y2});
	$polig -> addPt($self->{x3}, $self->{y3});
	$img ->filledPolygon($polig,$color);
	
}	
no Moose
}
1;
