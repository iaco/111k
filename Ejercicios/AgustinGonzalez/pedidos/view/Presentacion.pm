#!/usr/bin/perl

package Presentacion;
use lib "./../model";
use lib "./../controller";
use Usuarios;
use Paquetes;
use Pedidos;
use PuntosdeControl;
use Moose;
use DateTime;



sub imprimir_pedido
{
    #se encarga de imprimir por pantalla los datos de un pedido
    my ($self,$pedido,$usuario)=@_;
    my $estado=$pedido->get_estado;
    
    print "Pedido: " . $pedido->num_pedido . "\n";
    print "Usuario: " . $usuario->usuario . "\n";    
    print "Nombre: " . $usuario->apellido . ", " . $usuario->nombre . "\n";
    print "Estado: " . $estado . "\n";
    print "Paquetes: \n";
    return 1;

}

sub imprimir_info_paquete
{
    my ($self,$paquete)=@_;
    my $fecha = $paquete->fecha;
    print "    " . $paquete->num_paquete . ": " . $paquete->contenido . " - " . $paquete->ubicacion . "(" . $fecha . ")\n";
    return 1;
}

sub imprimir_itinerario_paquete
{
    my ($self,$paquete)=@_;
    
    my $ruta= $paquete->get_itinerario;
    while (my $posta =$ruta->get_next)
    {
        print $posta->descripcion . " - " . $posta->ubicacion . "(" . $posta->fecha . "), ";
    }
    print "\n";

}
1;