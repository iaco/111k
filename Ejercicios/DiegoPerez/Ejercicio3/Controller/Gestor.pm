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
    $self->dbh->agregar_persona($nombre, $apellido, $direccion, $fechanac);
   
}

sub deletePersona
{
    my ($self,$nombre, $apellido, $direccion, $fechanac) = @_;
    $self->dbh->eliminar_persona($nombre, $apellido, $direccion, $fechanac)
}

sub updatePersona
{
    my ($self,$id, $nombre, $apellido, $direccion, $fechanac) = @_;
    $self->dbh->actualizar_persona($id,$nombre, $apellido, $direccion, $fechanac)
}

sub listPersonas
{
    my $self      = shift;
    my @resultado = [];
    my %hash      = ();
    my $personas  = Personas->new();
    $personas->get_all();
    
    while (my $persona = $personas->get_next){
        %hash = (id        => $persona->id,
                nombre     => $persona->nombre,
                apellido   => $persona->apellido,
                direccion  => $persona->direccion,
                nacimiento => $persona->Nacimiento,
                edad       => $persona->calcEdad()
                ); 
        push(@resultado,%hash);
        
    }
    return @resultado;
}

no Moose;
1;