#!/usr/bin/perl
package Paquete;
use Moose;
use DateTime;
extends "Jorge::DBEntity";

has id=>(is=>"rw", isa=>"Num");
has num_paquete=>(is=>"rw",isa=>"Num");
has num_pedido=>(is=>"rw",isa=>"Num");
has estado=>(is=>"rw" , isa=>"Str" , default=>'despachado');
has ubicacion=>(is=>"rw",isa=>"Str");
has contenido=>(is=>"rw",isa=>"Str");
has fecha=>(is=>"rw",isa=>"DateTime");

#has itinerarios=>(is=>"rw",isa=>"Itinerarios",builder=>"_build_itinerarios");

sub _fields
{
	my $table_name="paquete";
	my @fields= qw(
				id
				num_paquete
				num_pedido
				estado
				ubicacion
				contenido
				fecha);
	my %fields= (
		id=>{pk=>1},
		fecha=>{datetime=>1}
		);
	return [\@fields,\%fields,$table_name];
}
sub get_itinerario
{
    my $self=shift;
	my $id= $self->id;
    my %param=(id_paquete=>$id);
    my $retorno=new PuntosdeControl();
    $retorno->get_all(%param);
	return $retorno;
}
sub add_punto_control
{
	my ($self,$ubicacion,$descripcion,$fecha)=@_;
	if ($self->estado eq "entregado")
	{
		print STDERR "El paquete " . $self->num_pedido . "-" . $self->num_paquete . " ya fue entregado\n";
		return 0;
	}
	$self->ubicacion($ubicacion);
	$self->update;
	my $punto_control= new PuntodeControl(id_paquete=>$self->id,
						ubicacion=>$ubicacion,descripcion=>$descripcion,fecha=>$fecha);
	$punto_control->insert;
	return 1;
}
sub marcar_recibido
{
	my ($self,$ubicacion,$descripcion,$fecha)=@_;
	$self->add_punto_control($ubicacion,$descripcion,$fecha);
	$self->estado('entregado');
	$self->update;
	return 1;
}

#sub before_delete
#{
#	my $self=shift;
#	my $itinerario= $self->get_itinerario;
#	while (my $punto = $itinerario->get_next)
#	{
#		$punto->delete;
#	}
#}
1;