#!/usr/bin/perl
package PuntodeControl;
use Moose;
use DateTime;
extends "Jorge::DBEntity";

has id=>(is=>"rw", isa=>"Num");
has id_paquete=>(is=>"rw",isa=>"Num");
has ubicacion=>(is=>"rw",isa=>"Str");
has fecha=>(is=>"rw",isa=>"DateTime");
has descripcion=>(is=>"rw",isa=>"Str");


sub _fields
{
	my $table_name="punto_de_control";
	my @fields= qw(
				id
                id_paquete
                ubicacion
				fecha
                descripcion
				);
	my %fields= (
		id=>{pk=>1,read_only=>1},
        fecha=>{datetime=>1}
		);
	return [\@fields,\%fields,$table_name];
}
1;