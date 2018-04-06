#!/usr/bin/perl
package Paquetes;
use strict;
use warnings;
use base 'Jorge::DBEntity';
use Moose;
use DateTime;

has "id"         => (is => "rw", isa => "Num");   
has "num_paq"    => (is => "rw", isa => "Num");
has "ubicacion"  => (is => "rw", isa => "Str");
has "estado"     => (is => "rw", isa => "Str");
has "cont_paq"   => (is => "rw", isa => "Str");
has "num_pedido" => (is => "rw", isa => "Num");
has "fecha"      => (is => "rw", isa => "DateTime");


sub _fields {
 
    my $table_name = 'Paquetes';
 
    my @fields = qw(
        id
        num_paq
        ubicacion
        estado
        cont_paq
        num_pedido
        fecha
    );
 
    my %fields = (
        id         => { pk => 1, read_only => 1 },
        fecha      => { DateTime => 1},
    );
 
    return [ \@fields, \%fields, $table_name ];
}

no Moose;
1;