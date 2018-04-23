#!/usr/bin/perl
package Persona;
use strict;
use warnings;
use base 'Jorge::DBEntity';
use Moose;
use Date::Tiny;

has "id"              => (is => "rw", isa => "Num");
has "nombre"          => (is => "rw", isa => "Str");
has "apellido"        => (is => "rw", isa => "Str");
has "direccion"       => (is => "rw", isa => "Str");
has "Nacimiento"      => (is => "rw", isa => "Date::Tiny");

sub _fields 
{
    my $table_name = 'Persona';
 
    my @fields = qw(
        id
        nombre
        apellido
        direccion
        Nacimiento
    );
 
    my %fields = (
        id         => { pk => 1, read_only => 1, uq =>1 },
        Nacimiento => {date => 1},   
        );
 
    return [ \@fields, \%fields, $table_name ];
}

sub calcEdad
{
	my $self           = shift; 
    my $ano_nacimiento = Date::Tiny->from_string($self->Nacimiento);
    my $ahora          = Date::Tiny->now;
    if ($ahora->month == $ano_nacimiento->month){
        if ($ahora->day > $ano_nacimiento->day){
            return $ahora->year - $ano_nacimiento->year - 1; 
        } else {
            return $ahora->year - $ano_nacimiento->year;
        }
    } else {
        if ($ahora->month < $ano_nacimiento->month){
            return $ahora->year - $ano_nacimiento->year - 1;
        } else {
            $ahora->year - $ano_nacimiento->year;
        }    
    }
}


no Moose;
1;