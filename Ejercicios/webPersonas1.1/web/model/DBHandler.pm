#!/usr/bin/perl

package DBHandler;
use lib "./";
use Moose;
use Persona;
use Date::Tiny;

sub get_all
{
    my $self=shift;
    my $personas= new Personas;
    $personas->get_all;
    return $personas;
    #Ahora tendria que crear las copias para devolver
}

sub delete
{
    my ($self,$idPersona)= @_;
    
    if (my $persona=$self->_get_by_id($idPersona))
    {
        $persona->delete;
        return 1;
    }
    else
    {
        return 0;
    }
}

sub _get_by_id
{
    my ($self,$idPersona)=@_;
    my $persona = new Persona;
    if ($persona->get_from_db($idPersona))
    {
        return $persona;
    }
    #si no lo encontro
    return 0;
    
}

sub modificar
{
    my ($self, $id, $nombre, $apellido,$direccion, $fecha)=@_;

    
    if (my $persona = $self->_get_by_id($id))
    {
        $persona->nombre($nombre);
        $persona->apellido($apellido);
        $persona->direccion($direccion);
        $persona->nacimiento($fecha);        
        $persona->update;
        return 1;
    }
    else 
    {
        return 0;
    }
}

sub agregar_persona
{
    my ($self, $nombre, $apellido, $direccion, $fecha)=@_;
    my $persona = new Persona(nombre=>$nombre, apellido=>$apellido, direccion=>$direccion, nacimiento=>$fecha);
    $persona->insert;
    if ($persona->id)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}
1;