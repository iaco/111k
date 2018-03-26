#!/usr/bin/perl

package Cuadrado;
use GD;
use GD::Simple;
use strict;
use warnings;
use lib "/home/diego/Exercies/View/";
use lib "/home/diego/Exercies/Controller/";


use Moose;
extends 'Figura';
extends 'Jorge::DBEntity';


has 'x3', is => 'rw', isa => 'Int', default => 0 , reader => 'getx3', writer => 'setx3';
has 'y3', is => 'rw', isa => 'Int', default => 0 , reader => 'gety3', writer => 'sety3';
has 'x4', is => 'rw', isa => 'Int', default => 0 , reader => 'getx4', writer => 'setx4';
has 'y4', is => 'rw', isa => 'Int', default => 0 , reader => 'gety4', writer => 'sety4';

sub area
{
	my ($self) = @_;
	my $base   = &Figura::distancia($self->{x1}, $self->{y1},$self->{x2}, $self->{y2});
	my $altura = &Figura::distancia($self->{x1}, $self->{y1},$self->{x3}, $self->{y3});
	print "Base=$base , altura=$altura\n";
	return $base * $altura;
}

sub _fields {
 
    my $table_name = 'Cuadrado';
 
    my @fields = qw(
        id_cuad
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
        id_cuad => { pk => 1, read_only => 1 },
          );
 
    return [ \@fields, \%fields, $table_name ];
}


sub draw
{
	my $self = shift;
	my $img  = shift;
	#my $polig = new GD;
	my $color = $img->colorAllocate(0,255,0);
	#$polig -> addPt($self->{x1}, $self->{y1});
	#$polig -> addPt($self->{x4}, $self->{y4});
	#$polig -> addPt($self->{x3}, $self->{y3});
	#$polig -> addPt($self->{x1}, $self->{y1});
	#$polig -> addPt($self->{x2}, $self->{y2});
#	$polig -> addPt($self->{x4}, $self->{y4});
	$img ->filledRectangle($self->{x1}, $self->{y1},$self->{x4}, $self->{y4},$color);

	
}	

no Moose;
1;
