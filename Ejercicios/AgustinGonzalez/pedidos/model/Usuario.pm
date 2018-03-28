#!/usr/bin/perl
package Usuario;
use Moose;
use Pedidos;
extends "Jorge::DBEntity";

has usuario=>(is=>"rw",isa=>"Str");
has nombre=>(is=>"rw",isa=>"Str");
has apellido=>(is=>"rw",isa=>"Str");
#has pedidos=>(is=>"rw",isa=>"Pedidos",builder=>"_build_pedidos");

sub add_pedido
{
	my ($self,$pedido)=@_;
	$pedido->usuario($self->usuario);
	$pedido->insert;
}

sub _fields
{
	my $table_name="usuario";
	my @fields= qw(
				usuario
				nombre
				apellido);
	my %fields= (
		usuario=>{pk=>1});
	return [\@fields,\%fields,$table_name];
}

sub get_pedidos
{
	my $self=shift;
	my %param = {usuario=> $self->usuario};
	
	my $retorno= new Pedidos();
	$retorno->get_all(%param);
	return $retorno;
}


1;
