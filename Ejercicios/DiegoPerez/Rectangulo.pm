#!/usr/bin/perl

use GD;
use GD::Simple;
use strict;
use warnings;
use lib "/home/diego/Exercies/";


package Rectangulo;{
use Moose;

extends 'Figura';

    has 'Vertice3x', is => 'rw', isa => 'Int', default => 0 , reader => 'getx3', writer => 'setx3';

    has 'Vertice3y', is => 'rw', isa => 'Int', default => 0 , reader => 'gety3', writer => 'sety3';

    has 'Vertice4x', is => 'rw', isa => 'Int', default => 0 , reader => 'getx4', writer => 'setx4';

    has 'Vertice4y', is => 'rw', isa => 'Int', default => 0 , reader => 'gety4', writer => 'sety4';

	sub area
	{
	    my $self   = shift;
	    my $base   = &Figura::distancia($self->getx1(), $self->gety1(),$self->getx2(), $self->gety2());
	    my $altura = &Figura::distancia($self->getx1, $self->gety1,$self->getx3, $self->gety3);
	    print "Base= $base , altura=$altura\n";
	    return $base * $altura;
	}

	sub draw
	{
		my ($self)=$_[0];
		my $path = "graficoRect.png";
		open (IMG, ,">".$path);
		my $img = GD::Simple->new (800,600);
		$img ->bgcolor("black");
		$img -> fgcolor("black");
	#el metodo rectangle dibuja con el vertice 1 y 4 siempre lineal a las x`s
		$img ->rectangle($self->getx1(), $self->gety1(), $self->getx4(),$self->gety4());
		print IMG $img->png;
		close (IMG);
		print "Se genero el archivo graficoRect.png conteniendo el dibujo\n";
	}

no Moose;
}
1;

