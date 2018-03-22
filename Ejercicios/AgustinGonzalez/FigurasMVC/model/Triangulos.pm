package Triangulos;
use lib ("-/");
use Triangulo;
use Moose;
extends "Jorge::ObjectCollection";

sub create_object
{
	return new Triangulo;
}
1;