#!/usr/bin/perl

use GD;
use GD::Simple;
use strict;
use warnings;
use lib "/home/diego/Exercies/";

package Triangulo;{
use Moose;
extends 'Figura';

  has 'Vertice3x', is => 'rw', isa => 'Int', default => 0 , reader => 'getx3', writer => 'setx3';
  has 'Vertice3y', is => 'rw', isa => 'Int', default => 0 , reader => 'gety3', writer => 'sety3';

sub area
{
	my ($self)=@_;
	my $base =  &Figura::distancia($self->getx1(), $self->gety1(),$self->getx2(), $self->gety2());
	return ($base**2) * sqrt(3) / 4;
}

sub draw
{
	my ($self)=$_[0];
	my $path = "graficoTria.png";
	open (IMG, ">".$path);
	my $img = GD::Simple->new (800,600);
	my $polig = new GD::Polygon;
	my $color = $img->colorAllocate(255,0,0);
	$polig -> addPt($self->getx1(), $self->gety1());
	$polig -> addPt($self->getx2(), $self->gety2());
	$polig -> addPt($self->getx3(), $self->gety3());
	$img ->filledPolygon($polig,$color);
	print IMG $img->png;
	close (IMG);
	print "Se genero el archivo graficoTria.png conteniendo el dibujo\n";
}	

no Moose
}
1;
