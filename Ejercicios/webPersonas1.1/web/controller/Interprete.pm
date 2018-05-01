#!/usr/bin/perl
package Interprete;
use lib "./../model";
use Persona;
use Personas;
use AltaBajaModif;
use Moose;
use Date::Tiny;
use utf8;

has "abm"=>(is=>"ro", isa=>"AltaBajaModif", default=> sub() { new AltaBajaModif});
has "diccionario"=>(is=>"ro",isa=>"HashRef");

sub agregar_persona
{
    my ($self,$nombre,$apellido,$direccion, $fecha)=@_;
    my $fecha_tiny = Date::Tiny->from_string($fecha);
    $self->abm->agregar_persona($nombre,$apellido, $direccion,$fecha_tiny);
}

sub get_lista
{
    my $self=shift;
    $self->{diccionario}={};
    my @personas = $self->abm->listar_personas;
    my @salida;
    for my $persona (@personas)
    {
        my $id= $persona->id;
        my $md5= $persona->encodeMd5("id");
        $self->{diccionario}->{$md5}=$id;
        push (@salida, {id=>$md5,                        #MD5
                        nombre=>$persona->nombre,
                        apellido=>$persona->apellido,
                        direccion=>$persona->direccion,
                        nacimiento=>$persona->nacimiento,
                        edad=>$persona->edad});
    }
    return @salida;
}

sub eliminar_persona
{
    my ($self, $md5)=@_;
    my $id = $self->{diccionario}->{$md5};            
    $self->abm->eliminar_persona($id);
    
}
sub modificar_persona
{
    my ($self, $md5, $nombre, $apellido, $direccion,$fecha)=@_;
    my $id=$self->{diccionario}->{$md5};                   
    my $fecha_tiny = Date::Tiny->from_string($fecha);
    
    $self->abm->modificar_persona($id,$nombre,$apellido,$direccion,$fecha_tiny);
}
1;