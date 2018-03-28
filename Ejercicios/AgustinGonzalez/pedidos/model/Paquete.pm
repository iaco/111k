#!/usr/bin/perl
package Paquete;
use Moose;
extends "Jorge::DBEntity";

has numero=>(is=>"rw",isa=>"Num");
has pedido=>(is=>"rw",isa=>"Num");
has entregado=>(is=>"rw",isa=>"Bool");
has ubicacion=>(is=>"rw",isa=>"Str");
has contenido=>(is=>"rw",isa=>"Str");
#has itinerarios=>(is=>"rw",isa=>"Itinerarios",builder=>"_build_itinerarios");

sub _fields
{
	my $table_name="paquete";
	my @fields= qw(
				numero
				pedido
				entregado
				ubicacion
				contenido);
	my %fields= (
		numero=>{pk=>1,read_only=>1},
		);
	return [\@fields,\%fields,$table_name];
}
sub get_itinerarios
{
    my $self=shift;
    my %param={num_paquete=>$self->numero};
    my $retorno=new Itinerarios();
    $retorno->get_all(%param);
	return $retorno;
}
sub add_itinerario
{
	my ($self,$itinerario)=@_;
	$itinerario->num_paquete($self->numero);
	$itinerario->insert;
}


1;