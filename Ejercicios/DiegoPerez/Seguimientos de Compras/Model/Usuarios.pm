#!/usr/bin/perl
package Usuarios;
use strict;
use warnings;
use base 'Jorge::DBEntity';
use Moose;

has 'id'       => (is => "rw", isa => "Num");  
has 'usuarios' => (is => "rw", isa => "Str");
has 'Nombres'  => (is => "rw", isa => "Str");
has 'Apellido' => (is => "rw", isa => "Str");

sub _fields {
 
    my $table_name = 'Usuarios';
 
    my @fields = qw(
    				id
        			usuarios
        			Nombres
        			Apellido
    );
 
    my %fields = (
        id      => { pk => 1, read_only => 1 },
        usuarios => { uq => 1 },
    );
 
    return [ \@fields, \%fields, $table_name ];
}

no Moose;
1;