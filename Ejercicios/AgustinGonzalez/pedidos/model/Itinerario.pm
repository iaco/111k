#!/usr/bin/perl
package Itinerario;
use Moose;
extends "Jorge::DBEntity";

has id_itinerario=>(is=>"ro",isa=>"Num");
has num_paquete=>(is=>"ro",isa=>"Num");
has fecha=>(is=>"rw",isa=>"Date");
has ubicacion=>(is=>"rw",isa=>"Str");
has descripcion=>(is=>"ro",isa=>"Str");


sub _fields
{
	my $table_name="Itinerario";
	my @fields= qw(
				id_itinerario
                num_paquete
                fecha
                ubicacion
                descripcion
				);
	my %fields= (
		id_itinerario=>{pk=>1,read_only=>1},
        fecha=>{datetime=>1}
		);
	return [\@fields,\%fields,$table_name];
}
1;