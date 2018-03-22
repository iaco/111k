package Rectangulos;
use lib ("-/");
use Rectangulo;
use Moose;
extends "Jorge::ObjectCollection";

sub create_object
{
	return new Rectangulo;
}
1;