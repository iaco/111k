#!/usr/bin/perl
package Itinerario;
use strict;
use warnings;
use base 'Jorge::DBEntity';
use Moose;
use DateTime;
 
has "id"             => (is => "rw", isa => "Num");
has "ubicacion"      => (is => "rw", isa => "Str");
has "fecha"          => (is => "rw", isa => "DateTime");
has "descripcion"    => (is => "rw", isa => "Str");
has "num_paq"        => (is => "rw", isa => "Num");

sub _fields {
 
    my $table_name = 'Itinerarios';
 
    my @fields = qw(
        id
        ubicacion
        fecha
        descripcion
        num_paq
    );
 
    my %fields = (
        id      => { pk => 1, read_only => 1 },
        fecha   => { datetime =>1 },
    );
 
    return [ \@fields, \%fields, $table_name ];
}

no Moose;
1;
