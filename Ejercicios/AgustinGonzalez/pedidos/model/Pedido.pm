#!/usr/bin/perl
package Pedido;
use DateTime;
use Moose;
extends "Jorge::DBEntity";

has num_pedido=>(is=>"rw",isa=>"Num");
has descripcion=>(is=>"rw",isa=>"Str");
has usuario=>(is=>"rw",isa=>"Str");
has cant_paquetes=>(is=>"rw",isa=>"Num");
has fecha=>(is=>"rw",isa=>"DateTime");
has id=>(is=>"rw",isa=>"Num");
#has paquetes=>(is=>"rw",isa=>"Paquetes",builder=>"_build_paquetes");


sub _fields
{
	my $table_name="pedido";
	my @fields= qw(
				id
				num_pedido
				descripcion
				cant_paquetes
				usuario
				fecha);
	my %fields= (
		id=>{pk=>1},
		num_pedido=>{uq=>1},
		fecha=>{datetime=>1},
		);
	return [\@fields,\%fields,$table_name];
}

sub get_estado
{
	#El ​estado​ del pedido se calcula en base al estado de todos los paquetes que lo componen.
	#Los valores posibles de estado son:
	#‘Pendiente’: cuando ningún paquete fue despachado
	#‘Despachando’: cuando al menos un elemento fue despachado pero aún hay
	#elementos pendientes de ser enviados.
	#‘Enviado’: cuando todos los paquetes fueron despachados.
	#‘Entregado’: cuando todos los paquetes fueron recibidos.
	my $self=shift;
	my $paquetes= $self->get_paquetes;
	my $paquetes_despachados=0;
	my $paquetes_entregados=0;
	while (my $paquete = $paquetes->get_next)
	{
		#print "paquete " . $paquete->num_paquete . ", estado: " . $paquete->estado . "\n";
		if ($paquete->estado eq "despachado")
		{
			$paquetes_despachados++;
		}
		if ($paquete->estado eq "entregado")
		{
			$paquetes_entregados++;
			$paquetes_despachados++;
		}
	}
	#print "$paquetes_despachados despachados, $paquetes_entregados entregados\n";
	my $cant = $self->cant_paquetes;
	if ( $cant == $paquetes_entregados)
	{
		return "Entregado";
	}
	if ($cant == $paquetes_despachados)
	{
		return "Enviado";
	}
	if ($paquetes_despachados)
	{
		return "Despachando";
	}
	
	return "Pendiente";
}
sub get_paquetes
{
    my $self=shift;
    my %param = (num_pedido => $self->num_pedido);
	my $retorno= new Paquetes();
    $retorno->get_all(%param);
	return $retorno;
}

sub add_paquete
{
	my ($self,$num_paquete,$ubicacion,$descripcion,$dateTime)=@_;
	if ($num_paquete>$self->cant_paquetes())
	{
		print STDERR "El pedido " . $self->num_pedido . " llevaba " . $self->cant_paquetes . " paquetes\n";
		return 0;
	}
	my $paquete = new Paquete(num_pedido=>$self->num_pedido,estado=>'despachado',num_paquete=>$num_paquete,
			ubicacion=>$ubicacion,contenido=>$descripcion,fecha=>$dateTime);
	$paquete->get_by(qw(num_pedido num_paquete));
	if ($paquete->id)#EL PAQUETE YA EXISTIA
	{
		print STDERR "Ya hay un paquete con ese numero para ese pedido\n";
		return 0;
	}
	
	$paquete->insert;
	#añado la primer posta
	$paquete->add_punto_control($ubicacion,$descripcion,$dateTime);

	return 1;
}


sub before_delete
{
	my $self=shift;
	my $paquetes= $self->get_paquetes;
	while (my $paquete = $paquetes->get_next)
	{
		$paquete->delete;
	}
}
1;