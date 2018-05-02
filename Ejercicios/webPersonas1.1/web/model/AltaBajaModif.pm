#!usr/bin/perl
package AltaBajaModif;
use Persona;
use Personas;
use DBHandler;
use Moose;

has "db"=>(is=>"ro", isa=>"DBHandler", default=> sub(){ new DBHandler});

sub agregar_persona
{
    my ($self, $nombre, $apellido, $direccion, $fecha)=@_;
    if ((_validar($nombre)) && (_validar($apellido))){
    
        if ($self->db->agregar_persona($nombre,$apellido,$direccion,$fecha))
        {
            return 1;
        }
     }   
    else
    {
        print STDERR "Error al agregar la nueva persona\n";
        return 0;
    }
}

sub eliminar_persona
{
    my ($self, $id)=@_;
    if ($self->db->delete($id))
    {
        return 1;
    }
    else
    {
        print STDERR "La persona a eliminar no existia";
        return 0;
    }

}

sub listar_personas
{
    my $self=shift;

    my $personas = $self->db->get_all;
    my @salida;
    while (my $persona= $personas->get_next)
    {
        push (@salida, $persona);
    }
    return @salida;
}

sub modificar_persona
{
    my ($self, $id, $nombre, $apellido,$direccion, $fecha)=@_;
    if (_validar($nombre) && _validar($apellido))
    {
        if ($self->db->modificar($id,$nombre,$apellido,$direccion,$fecha))
        {
            return 1;
        }
    }
    print STDERR "La persona a modificar no existia";
    return 0;
}

sub _validar
{

    my $dato  = shift;
    if ($dato =~ /^[a-z A-Z]+$/)
    { return 1;}
    return 0;

}
no Moose;
1;

