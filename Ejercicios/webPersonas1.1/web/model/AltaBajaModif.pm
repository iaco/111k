#!usr/bin/perl
package AltaBajaModif;
use Persona;
use Personas;
use DBHandler;
use Moose;
use Date::Tiny;
use DateTime;
use v5.14;

has "db"=>(is=>"ro", isa=>"DBHandler", default=> sub(){ new DBHandler});

sub agregar_persona
{
    my ($self, $nombre, $apellido, $direccion, $fecha)=@_;

    if ((_validar($nombre)) && (_validar($apellido))){

        if (!_validar_direccion($direccion))
        {
            print STDERR "Caracteres no permitidos en el campo direccion: valor=$direccion\n";
            return 0;
        }
        if (!_validar_fecha($fecha))
        {
            print STDERR "Fecha invalida\n";
            return 0;
        }
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

    if (_validar($nombre) && _validar($apellido)){

        if (!_validar_direccion($direccion))
        {
            print STDERR "Caracteres no permitidos en el campo direccion: valor=$direccion\n";
            return 0;
        }
        if (!_validar_fecha($fecha))
        {
            print STDERR "Fecha invalida\n";
            return 0;
        }
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

sub _validar_direccion
{
    my $direccion=shift;

    if ($direccion =~ /^[\p{Letter}\d\s\-\,\'\.]+$/)
    #Permito -  . para quien quiera expresar un numero de departamento o numero de torre o lo que corresponda
    #Quedan vetadas ; "" , etc
    {
        return 1; #cadena valida
    }
    return 0;#La cadena contiene caracteres no validos

}

sub _validar_fecha
{
    my $fecha= shift;
    my $hoy = DateTime->now;
    my $dt_fecha= $fecha->DateTime;
    my $comparacion = DateTime->compare($dt_fecha, $hoy);
                    #-1 if dt_fecha<hoy 
                    #0 if dt_fecha=hoy
                    #1 if dt_fecha > hoy
    if ($comparacion == 1)
    {
        return 0;#Fecha invalida
    }
    else 
    {
        return 1; #fecha valida
    }
}

no Moose;
1;

