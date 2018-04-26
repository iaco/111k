#!/usr/bin/perl
package dbh;
use lib "./";
use Personas;
use Moose;
use DateTime;

sub agregar_persona
{
	my ($self,$nombre, $apellido, $direccion, $fechanac) = @_;
  
    my $nuevo = new Persona(nombre => $nombre, apellido => $apellido, direccion => $direccion, Nacimiento=> $fechanac);
    $nuevo->get_by(qw(nombre apellido direccion Nacimiento));
    if ($nuevo->id){
        print STDERR "Esa persona ya existe";
        return 0; 
    } else {
        $nuevo->insert;
        return 1;
    }
    
}

sub eliminar_persona
{

	my ($self,$id, $nombre, $apellido, $direccion, $fechanac) = @_;
  
    my $nuevo = new Persona(id => $id, nombre => $nombre, apellido => $apellido, direccion => $direccion, Nacimiento=> $fechanac);
    $nuevo->get_by(qw(id nombre apellido direccion Nacimiento));
    if ($nuevo->id) {
        $nuevo->delete;
        return 1;
    } else {
        print STDERR "La persona $apellido, $nombre no fue encontrado\n";
        return 0;
    }

}

sub actualizar_persona
{
	my ($self,$id,$nombre, $apellido, $direccion, $fechanac) = @_;
  
    my $nuevo = new Persona(id=>$id, nombre => $nombre, apellido => $apellido, direccion => $direccion, Nacimiento=> $fechanac);
    $nuevo->update;
    return 1;  
}

no Moose;
1;