#!/usr/bin/perl
package Compras;
use strict;
use warnings;
use base 'Jorge::DBEntity';
use Moose;
 
has 'id'            => (is => "rw", isa => "Num"); 
has "num_pedido"    => (is => "rw", isa => "Num");
has "despachados"   => (is => "rw", isa => "Int", default => 0);
has "recibidos"     => (is => "rw", isa => "Int", default => 0);
has "estado"        => (is => "rw", isa => "Str");
has "det_pedido"    => (is => "rw", isa => "Str");
has "cant_paquetes" => (is => "rw", isa => "Num");
has "usuarios"      => (is => "rw", isa => "Str");


sub _fields {
 
    my $table_name = 'Compras';
 
    my @fields = qw(
        id
        num_pedido
        despachados
        recibidos
        estado
        det_pedido
        cant_paquetes
        usuarios
    );
 
    my %fields = (
        id         => { pk => 1, read_only => 1 },   
        num_pedido => { uq => 1 },
    );
 
    return [ \@fields, \%fields, $table_name ];
}

no Moose;
1;