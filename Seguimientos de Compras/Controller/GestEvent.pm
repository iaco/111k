#!/usr/bin/perl
package GestEvent;
use lib "./";
use lib "./../Model/";
use UsuariosCollection;
use ComprasCollection;
use PaquetesCollection;
use ItinerarioCollection;
use Moose;
use DateTime;

sub itinerario_pedido #finalizar este
{
 my ($self,$num_pedido) = @_;
    my $pedido = _existe_pedido($num_pedido);
    if (not $pedido)
    {
        print STDERR "El pedido $num_pedido no fue encontrado\n";
        return 0;
    }
    my $usuario = _existe_usuario($pedido->{usuarios});
    
    print "==========\n";
    print "Pedido: $pedido->{num_pedido} \n";
    print "Usuario: $usuario->{usuarios}  \n";    
    print "Nombre:  $usuario->{Apellido}, $usuario->{Nombres} \n";
    print "Estado:  $pedido->{estado} \n";
    print "Itinerario: \n";
    my %param = (num_pedido => $num_pedido);
    my $paquetes = new PaquetesCollection();
    $paquetes->get_all(%param);

    while (my $paquete = $paquetes->get_next) {
        my $id          = $paquete->{num_paq};
        my %param       = (id=>$id);
        my $itinerarios = new ItinerarioCollection();
        $itinerarios->get_all(%param);
        while (my $recorrido = $itinerarios->get_next) {
            print "      $recorrido->descripcion - $recorrido->ubicacion ( $recorrido->fecha ), ";
        }
    }
    print "==========\n";
    return 1;
}    

sub estado_pedido
{
    my ($self,$num_pedido) = @_;
    my $pedido = _existe_pedido($num_pedido);
    if (not $pedido) {
        print STDERR "El pedido $num_pedido no fue encontrado\n";
        return 0;
    }
    my $usuario = _existe_usuario($pedido->{usuarios});
    
    print "==========\n";
    print "Pedido: $pedido->{num_pedido} \n";
    print "Usuario: $usuario->{usuarios}  \n";    
    print "Nombre:  $usuario->{Apellido}, $usuario->{Nombres} \n";
    print "Estado:  $pedido->{estado} \n";
    print "Paquetes: \n";
    my %param = (num_pedido => $num_pedido);
    my $paquetes = new PaquetesCollection();
    $paquetes->get_all(%param);

    while (my $paquete = $paquetes->get_next) {
        print "        $paquete->{num_paq} : $paquete->{cont_paq} - $paquete->{ubicacion} \n";
    }
    print "==========\n";
    return 1;
}


sub recepcion_paquete
{
    my ($self,$num_pedido,$num_paquete,$ubicacion) = @_;
    my $fecha   = DateTime->now();   
    my $paquete = _existe_paquete($num_pedido,$num_paquete);
    if (not $paquete) {
        print STDERR "El paquete $num_paquete no fue encontrado\n";
        return 0;
    }
    my $pedido = _existe_pedido($num_pedido);
    if (not($pedido->id)){
        print STDERR "El pedido $num_pedido no fue encontrado\n";
        return 0;
    }

    $pedido->recibidos(++$pedido->{recibidos}); 
    if ($pedido->cant_paquetes == $pedido->recibidos){
        $pedido->estado("entregado");
    }
    $paquete->ubicacion($ubicacion);
    $paquete->fecha($fecha);
    $paquete->estado("entregado");
    $paquete->update;

    $pedido ->update;

    print "Paquete $num_paquete del pedido $num_pedido recibido\n";
    return 1;
}

sub posta_paquete
{
    my ($self,$num_pedido,$num_paquete,$ubicacion,$descripcion) = @_;
    my $fecha   = DateTime->now();
    my $paquete = _existe_paquete($num_pedido,$num_paquete);
    if (not $paquete) {
        print STDERR "El paquete $num_paquete no fue encontrado\n";
        return 0;
    }

    my $pedido = _existe_pedido($num_pedido);
    if (not($pedido->id)){
        print STDERR "El pedido $num_pedido no fue encontrado\n";
        return 0;
    }
    $paquete->ubicacion($ubicacion);
    $paquete->update;

    my $itinerario = new Itinerario(num_paq=>$num_paquete,ubicacion=>$ubicacion,descripcion=>$descripcion,fecha=>$fecha);
    $itinerario->insert;
    print "Posta del paquete $num_paquete del pedido $num_pedido registrada\n";
    return 1;
}

sub despacho_paquete
{
    my ($self,$numero_pedido,$numero_paquete,$descripcion,$ubicacion) = @_;
    my $dateTime = DateTime->now();
    my $pedido   = _existe_pedido($numero_pedido);
    if (not($pedido)) {
        print STDERR "El pedido $numero_pedido no fue encontrado\n";
        return 0;
    }
    if ($pedido->estado eq ("enviado" || "entregado")){
        print STDERR "El pedido $numero_pedido ya posee todos los paquetes\n";
        return 0;
    } 

    my $paquete = new Paquetes(num_pedido=>$numero_pedido,num_paq=>$numero_paquete,
            ubicacion=>$ubicacion,cont_paq=>$descripcion,fecha=>$dateTime,estado=>"enviado");
    $paquete->get_by(qw(num_pedido num_paq));
    if ($paquete->id) {
        print STDERR "Ya hay un paquete con ese numero para ese pedido\n";
        return 0;
    }
    $paquete->insert;

    $pedido->despachados(++$pedido->{despachados});
    if ($pedido->despachados == $pedido->cant_paquetes){
        $pedido->estado("enviado");
    }
    if ($pedido->despachados < $pedido->cant_paquetes){
        $pedido->estado("despachando");
    }
        
    $pedido->update;
        
    print "Paquete $numero_paquete del pedido $numero_pedido despachado\n";
    return 1;
}

sub addPedido
{
    my($self, $usuario, $numero_pedido, $detalle_pedido, $cant_paquetes) = @_;
    my $usuario_existe = _existe_usuario($usuario);
    if (not($usuario_existe)) {
        print STDERR "El usuario $usuario no fue encontrado\n";
        return 0;
    }

    my $pedido = _existe_pedido($numero_pedido);
    if ($pedido) {
        print STDERR "EL pedido $numero_pedido ya fue ingresado al sistema\n";
        return 0;
    }
    $pedido = new Compras(num_pedido=>$numero_pedido,estado=>"pendiente", det_pedido=>$detalle_pedido,cant_paquetes=>$cant_paquetes, usuarios=>$usuario);
    $pedido->insert;
    print "Compra $numero_pedido registrada\n";
return 1;
}

sub addUsuario
{
    my ($self,$usuario, $apellido, $nombres) = @_;
    my $nuevo_usuario = new Usuarios(usuarios => $usuario, Apellido => $apellido, Nombres => $nombres);
    $nuevo_usuario->get_by("usuarios");
    
    if ($nuevo_usuario->id){ 
        print STDERR "El usuario existe";
        return 0;
    } else {
        $nuevo_usuario->insert;
        print "Usuario '$nuevo_usuario->{usuarios}' agregado\n";
        return 1;
    }
}


sub elimUsuario
{
    my ($self,$usuario) = @_;
    my $usuario_elim    = _existe_usuario($usuario);
    if (defined($usuario_elim->id)) {
        $usuario_elim->delete;
        print "Usuario $usuario eliminado\n";
        return 1;
    } else {
        print STDERR "El usuario $usuario no fue encontrado\n";
        return 0;
    }
}

sub _existe_usuario
{
    my $usuario       = shift;
    my $nuevo_usuario = new Usuarios(usuarios => $usuario);
    $nuevo_usuario->get_by("usuarios");
    if ($nuevo_usuario->id){
        return $nuevo_usuario; 
    } else {
        return 0;
    }
}   

sub _existe_pedido
{
    my $pedido        = shift;
    my $nuevo_pedido  = new Compras(num_pedido => $pedido);
    $nuevo_pedido = $nuevo_pedido->get_by("num_pedido");
    if ($nuevo_pedido->id) {
        return $nuevo_pedido;
    } else {
        return 0;
    }
} 

sub _existe_paquete
{
    my ($num_pedido,$num_paquete) = @_;
    my $nuevo = new Paquetes(num_pedido=>$num_pedido,num_paq=>$num_paquete);
    $nuevo->get_by(qw(num_pedido num_paq));
    if ($nuevo->id) {
        my $paquete= new Paquetes;
        $paquete->get_from_db($nuevo->id);
        return $paquete;
    } else {
        return 0;
    }
}

no Moose;
1;
