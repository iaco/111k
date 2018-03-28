#!/usr/bin/perl
package Pedido;
use Moose;
extends "Jorge::DBEntity";



use Moose;
extends "Jorge::DBEntity";

has num_pedido=>(is=>"rw",isa=>"Num");
has descripcion=>(is=>"rw",isa=>"Str");
has usuario=>(is=>"rw",isa=>"Str");
has cant_paquetes=>(is=>"rw",isa=>"Num");
has fecha=>(is=>"rw",isa=>"Date");
#has paquetes=>(is=>"rw",isa=>"Paquetes",builder=>"_build_paquetes");


sub _fields
{
	my $table_name="pedido";
	my @fields= qw(
				num_pedido
				descripcion
				cant_paquetes
				usuario
				fecha);
	my %fields= (
		num_pedido=>{pk=>1,read_only=>1},
		fecha=>{datetime=>1},
		);
	return [\@fields,\%fields,$table_name];
}

sub get_paquetes
{
    my $self=shift;
    my %param={pedido=>$self->num_pedido};
	my $retorno= new Paquetes();
    $retorno->get_all(%param);
	return $retorno;
}

sub add_paquete
{
	my ($self,$paquete)=@_;
	$paquete->pedido($self->num_pedido);
	$paquete->insert;
}
1;