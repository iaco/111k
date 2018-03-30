#!/usr/bin/perl

use lib "./model/";
use lib "./controller/";
use lib "./view";
use Usuarios;
use Pedidos;
use Paquetes;
use PuntosdeControl;
use Interprete;
use Presentacion;

my $presentacion= new Presentacion;
my $interprete = new Interprete(presentacion=>$presentacion);

my $fh_instrucciones;
open($fh_instrucciones, "instrucciones.txt");

while (my $line= <$fh_instrucciones>)
{
    chomp($line);
    my @args= split (",", $line);
    my $codigo = shift @args;
    my $cant_params = $#args + 1;
    
    if ($codigo eq "A")
    {
        if ($cant_params != 3)
        {
            print STDERR "Numero incorrecto de parametros.. sintaxis esperada de agregar usuario:\n";
            print STDERR "Ejemplo:​ A,<usuario>,<apellido>,<nombre>\n";
            next;
        }
        $interprete->agregar_usuario(@args);
    }
    elsif ($codigo eq "E")
    {
        if ($cant_params != 1)
        {
            print STDERR "Numero incorrecto de parametros.. sintaxis esperada de eliminar usuario:\n";
            print STDERR "Ejemplo: E,<usuario>\n";
        }
        $interprete->eliminar_usuario(@args);
    }
    elsif ($codigo eq "C")
    {
        if ($cant_params != 4)
        {
            print STDERR "Numero incorrecto de parametros.. sintaxis esperada de registrar compra:\n";
            print STDERR "Ejemplo:​ C,<usuario>,<num_pedido>,<detalle_pedido>,<cantidad_paquetes>\n";
            next;
        }
        $interprete->registrar_compra(@args);
    }
    elsif ($codigo eq "D")
    {
        if ($cant_params != 4)
        {
            print STDERR "Numero incorrecto de parametros.. sintaxis esperada de registrar paquete:\n";
            print STDERR "Ejemplo:​ D,<num_pedido>,<num_paquete>,<contenido_paquete>,<ubicacion>\n";
            print STDERR "Nota: se utiliza la hora actual\n";
            next;
        }
        $interprete->despacho_paquete(@args);
    }
    elsif ($codigo eq "P")
    {
        if ($cant_params != 4)
        {
            print STDERR "Numero incorrecto de parametros.. sintaxis esperada de registrar posta de paquete:\n";
            print STDERR "Ejemplo:​ P,<num_pedido>,<num_paquete>,<ubicacion>,<descripcion>\n";
            print STDERR "Nota: se utiliza la hora actual\n";
            next;
        }
        $interprete->posta_paquete(@args);
    }
    elsif ($codigo eq "R")
    {
        if ($cant_params != 3)
        {
            print STDERR "Numero incorrecto de parametros.. sintaxis esperada de recepcion del  paquete:\n";
            print STDERR "Ejemplo:​ R,<num_pedido>,<num_paquete>,<ubicacion>\n";
            print STDERR "Nota: se utiliza la hora actual\n";
            next;
        }
        $interprete->recepcion_paquete(@args);
    }
    elsif ($codigo eq "Y")
    {
        if ($cant_params != 1)
        {
            print STDERR "Numero incorrecto de parametros.. sintaxis esperada de pedir info pedido:\n";
            print STDERR "Ejemplo:​ Y,<num_pedido>\n";
            next;
        }
        $interprete->estado_pedido(@args);
    }
    elsif ($codigo eq "Z")
    {
        if ($cant_params != 1)
        {
            print STDERR "Numero incorrecto de parametros.. sintaxis esperada de pedir info itinerario pedido:\n";
            print STDERR "Ejemplo:​ Z,<num_pedido>\n";
            next;
        }
        $interprete->itinerario_pedido(@args);
    }

}

close ($fh_instrucciones);

