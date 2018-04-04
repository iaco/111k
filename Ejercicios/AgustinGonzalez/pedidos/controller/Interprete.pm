#!/usr/bin/perl

package Interprete;
use lib "./../model";
use lib "./../view";
use Usuarios;
use Paquetes;
use Pedidos;
use PuntosdeControl;
use Moose;
use DateTime;
use Presentacion;
use DbHandler;

has "presentacion"=>(is=>"rw",isa=>"Presentacion");
has "db" =>(is=>"ro", isa=>"DbHandler", default=> sub {new DbHandler});

sub _get_usr
{
    my ($self,$usr)=@_;
    return $self->{db}->get_usr($usr);
}

sub get_pedido
{
    my ($self,$num_pedido)=@_;
    return $self->{db}->get_pedido($num_pedido);
}
sub _get_paquete
{
    my ($self,$num_pedido,$num_paquete)=@_;
    return $self->{db}->get_paquete($num_pedido,$num_paquete);
}

sub agregar_usuario
#CODIGO A
{
    my ($self,$usr,$apellido,$nombre)=@_;
    my $nuevo= new Usuario(usuario=>$usr,apellido=>$apellido,nombre=>$nombre);
    $nuevo->get_by("usuario");
    if ($nuevo->id)
    {
        print STDERR "El usuario ".$nuevo->usuario." ya existe: ".$nuevo->apellido.", ".$nuevo->nombre."\n";
        return 0;
    }
    else
    {
        $nuevo->insert;
        print "Usuario $usr agregado\n" ;
        return 1;
    }
    
}

sub eliminar_usuario
#CODIGO E
{
    my ($self,$usr)=@_;
    my $usuario = $self->_get_usr($usr);
    if (not($usuario))
    {
        print STDERR "El Usuario $usr no estaba registrado\n";
        return 0;
    }
    $usuario->delete;
    print "Usuario $usr eliminado\n";
    return 1;
}

sub registrar_compra
#CODIGO C
{
    my ($self,$usr,$num_pedido,$detalle,$cant_paquetes)=@_;
    #Primero, ver que el usuario exista
    my $usuario = $self->_get_usr($usr);
    if (not($usuario))
    {
        print STDERR "El Usuario $usr no estaba registrado";
        return 0;
    }
    
    my $datetime= DateTime->now();
    my $pedido= $self->get_pedido($num_pedido);
    if ($pedido)
    {
        print STDERR "EL pedido $num_pedido ya existe\n";
        return 0;
    }
    $pedido = new Pedido(num_pedido=>$num_pedido,descripcion=>$detalle,cant_paquetes=>$cant_paquetes,fecha=>$datetime);
    $usuario->add_pedido($pedido);
    print "Compra $num_pedido registrada\n";
    return 1;
}

sub despacho_paquete
{
    #4. Despacho de Paquete:​
    #Registra un nuevo paquete a un pedido dado. Informa de la
    #ubicación inicial del paquete y el número del paquete dentro del pedido para utilizar
    #como referencia. La descripción no es necesaria para esta operación ya que se
    #asume el valor de ‘Enviado’
    #CODIGO D
    my ($self,$num_pedido,$num_paquete,$descripcion,$ubicacion)=@_;
    my $pedido= $self->get_pedido($num_pedido);
    if (not($pedido))
    {
        print STDERR "El pedido $num_pedido no esta cargado\n";
        return 0;
    }
    my $dateTime= DateTime->now();
    $pedido->add_paquete($num_paquete,$ubicacion,$descripcion,$dateTime);
    print "Paquete $num_paquete del pedido $num_pedido despachado\n";
    return 1;
}

sub posta_paquete
{
    #Registra un nuevo punto de control al itinerario del paquete.
    #Código: ​P

    my ($self,$num_pedido,$num_paquete,$ubicacion,$descripcion)=@_;
    my $fecha= DateTime->now();
    my $paquete= $self->_get_paquete($num_pedido,$num_paquete);
    if (not $paquete)
    {
        print STDERR "El paquete " . $num_pedido . "/" .$num_paquete . "no esta cargado\n";
        return 0;
    }
    my $paquetecompleto = new Paquete();
    $paquetecompleto->get_from_db($paquete->id);
    $paquetecompleto->add_punto_control($ubicacion,$descripcion,$fecha);
    print "Posta del paquete $num_paquete del pedido $num_pedido registrada\n";
    return 1;

}

sub recepcion_paquete
{
    #: Registra la recepción del paquete por parte del usuario. La
    #descripción no es necesaria para esta operación ya que se asume el valor de‘Recibido’.
    #CODIGO R

    my ($self,$num_pedido,$num_paquete,$ubicacion)=@_;
    
    my $fecha= DateTime->now();
    my $paquete= $self->_get_paquete($num_pedido,$num_paquete);
    if (not $paquete)
    {
        print STDERR "El paquete " . $num_pedido . "/" .$num_paquete . "no esta cargado\n";
        return 0;
    }
    #print "Marcando recepcion del paquete\n";
    #print "    " . $paquete->num_paquete . ": " . $paquete->contenido . " - " . $paquete->ubicacion . "\n";
    $paquete->marcar_recibido($ubicacion,"Entregado",$fecha);
    print "Paquete $num_paquete del pedido $num_pedido recibido\n";
    return 1;

}

sub estado_pedido
{
    #​Debe retornar el estado actual de un pedido dado.
    #Codigo Y
    my ($self,$num_pedido)=@_;
    my $pedido = $self->get_pedido($num_pedido);
    if (not $pedido)
    {
        print STDERR "No hay un pedido con el numero $num_pedido\n";
        return 0;
    }
    print "==========\n";
    my $usuario = $self->_get_usr($pedido->usuario);
    my $presentacion=$self->presentacion;
    $presentacion->imprimir_pedido($pedido,$usuario);
    
    my $paquetes= $pedido->get_paquetes;
    while (my $paquete = $paquetes->get_next)
    {
        $presentacion->imprimir_info_paquete($paquete);
    }
    print "==========\n";


}

sub itinerario_pedido
{
    #Retorna el itinerario de un pedido dado.
    #Código:​Z

    my ($self, $num_pedido)=@_;
    my $pedido = $self->get_pedido($num_pedido);
    if (not $pedido)
    {
        print STDERR "No hay un pedido con el numero $num_pedido\n";
        return 0;
    }
    my $usuario = $self->_get_usr($pedido->usuario);
    print "==========\n";
    my $presentacion =$self->presentacion;
    $presentacion->imprimir_pedido($pedido,$usuario);

    my $paquetes= $pedido->get_paquetes;
    while (my $paquete = $paquetes->get_next)
    {
        $presentacion->imprimir_info_paquete($paquete);
        $presentacion->imprimir_itinerario_paquete($paquete);
    }
    print "==========\n";
}




1;
