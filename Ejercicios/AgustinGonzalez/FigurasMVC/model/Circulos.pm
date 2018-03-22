package Circulos;
use lib ("-/");
use Circulo;
use Moose;
extends "Jorge::ObjectCollection";

sub create_object
{
	return new Circulo;
}
1;