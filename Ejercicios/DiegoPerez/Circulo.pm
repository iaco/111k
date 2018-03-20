#!/usr/bin/perl

use GD;
use GD::Simple;
use Math::Vector::Real;
use strict;
use lib "/home/diego/Exercies/";

use warnings;

package Circulo;{
use Moose;
use constant PI => 3.14159;
extends 'Figura';

sub area 
{
	my ($self)=@_;
	return PI * ( &Figura::distancia($self->getx1(), $self->gety1(),$self->getx2(), $self->gety2()) **2);
}

sub draw
{
	my ($self)= @_;
	my $img = GD::Simple -> new(800,600);
	$img->bgcolor("yellow");
	$img->fgcolor("yellow");
	my $x=$self->getx1();#valor de x en el centro del circulo
	my $y=$self->gety1();#valor de y en el centro del circulo
	my $radio =&Figura::distancia($self->getx1(), $self->gety1(),$self->getx2(), $self->gety2());
	my $yellow = $img->colorAllocate(255,255,0);
	$img->arc($x,$y,$radio,$radio,0,360,$yellow);
	$img->fill($x,$y,$yellow);
	open (IMG, ">"."graficoCirc.png");
	print IMG $img->png;
	close(IMG);
	print "Se genero el archivo graficoCirc.png conteniendo el dibujo\n";
}

no Moose;
}
1;
