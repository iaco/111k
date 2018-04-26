#!/usr/bin/perl
package Gestor;
use lib "./";
use lib "./../Model/";
use Personas;
use Persona;
use Moose;
use dbh;


has "dbh" => (is=>"rw", isa=>"dbh", default => sub(){new dbh;});


sub addPersona
{
    my ($self,$nombre, $apellido, $direccion, $fechanac) = @_;
    my $nacimiento = Date::Tiny->from_string( $fechanac );

    $self->dbh->agregar_persona($nombre, $apellido, $direccion, $nacimiento);
   
}

sub deletePersona
{
    my ($self,$id, $nombre, $apellido, $direccion, $fechanac) = @_;
    my $nacimiento = Date::Tiny->from_string( $fechanac );
    $self->dbh->eliminar_persona($id, $nombre, $apellido, $direccion, $nacimiento);
}

sub updatePersona
{
    my ($self,$id, $nombre, $apellido, $direccion, $fechanac) = @_;
    my $nacimiento = Date::Tiny->from_string( $fechanac );
    $self->dbh->actualizar_persona($id,$nombre, $apellido, $direccion, $nacimiento);
}

sub listPersonas
{
    my $self      = shift;
    my @resultado;
    my $personas  = Personas->new();
    $personas->get_all();
    
    while (my $persona = $personas->get_next){
        push(@resultado,{id        => $persona->id,
                        nombre     => $persona->nombre,
                        apellido   => $persona->apellido,
                        direccion  => $persona->direccion,
                        nacimiento => $persona->Nacimiento,
                        edad       => $persona->calcEdad()
                    }); 
    
        
    }
    return \@resultado;
}

no Moose;
1;