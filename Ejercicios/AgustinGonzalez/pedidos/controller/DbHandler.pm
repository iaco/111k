#!/usr/bin/perl

package DbHandler;

use lib "./../model";
use lib "./";
use Usuarios;
use Paquetes;
use Pedidos;
use PuntosdeControl;
use Moose;

sub get_usr
{
    my ($self,$usr)=@_;
    my $nuevo= new Usuario(usuario=>$usr);
    $nuevo->get_by("usuario");
    if (not $nuevo->id)
    {
        return 0;#El usuario no existe
    }
    else 
    {
        return $nuevo;
    }
}

sub get_pedido
{
    my ($self,$num_pedido)=@_;
    my $nuevo= new Pedido(num_pedido=>$num_pedido);
    $nuevo->get_by("num_pedido");
    if (not $nuevo->id)
    {
        return 0;#El PEDIDO no existe
    }
    else 
    {
        return $nuevo;
    }
}

sub get_paquete
{
    my ($self,$num_pedido,$num_paquete)=@_;
    my $nuevo= new Paquete(num_pedido=>$num_pedido,num_paquete=>$num_paquete);
    $nuevo->get_by(qw(num_pedido num_paquete));
    if (not $nuevo->id)
    {
        return 0;#El paquete no existe
    }
    else 
    {
        #Aca deberia alcanzar con retornar nuevo, pero encontre que a veces el get by no me rellenaba el resto de los campos
        #Solo me rellenaba e id, entonces tengo que hacer un get from db
        my $paquete= new Paquete;
        $paquete->get_from_db($nuevo->id);
        #print "paquete encontrado\n";
        #print "    " . $paquete->num_paquete . ": " . $paquete->contenido . " - " . $paquete->ubicacion . "\n";
        return $paquete;
    }
}



1;