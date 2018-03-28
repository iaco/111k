#!/usr/bin/perl

use lib "./model/";
use Usuarios;
use Pedidos;
use Paquetes;
use Itinerarios;

my $usuarioagustin= new Usuario(usuario=>"agustin14",nombre=>"agustin",apellido=>"gonzalez");
my $usuariodiego= new Usuario(usuario=>"diegoperez",nombre=>"diego",apellido=>"perez");
print $usuarioagustin->usuario;
$usuarioagustin->insert;



my $pedido_prueba= new Pedido(num_pedido=>1,usuario=>$id,cant_paquetes=>0);
$usuarioagustin->add_pedido($pedido_prueba);