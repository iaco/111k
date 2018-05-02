#!/usr/bin/perl
package Persona;
use Moose;
use Date::Tiny;
extends  "Jorge::DBEntity";
use Jorge::Plugin::Md5;

#Jorge::Config::$CONFIG_FILE = "/home/agustin/git/111k/Ejercicios/AgustinGonzalez/webPersonas/web/model/config/jorge.yml";
has "id"=> (is=>"ro", isa=>"Num");
has "nombre"=>(is=>"rw", isa=>"Str");
has "apellido"=>(is=>"rw", isa=>"Str");
has "direccion"=>(is=>"rw", isa=>"Str");
has "nacimiento"=>(is=>"rw", isa=>"Date::Tiny");



sub edad
{
    my $self=shift;
    my $hoy = Date::Tiny->now;
    my $nac = Date::Tiny->from_string($self->nacimiento);
    my $edad = $hoy->year - $nac->year;

    if ($hoy->month > $nac->month)#Ya tuvo su cumpleanos
    {
        return $edad;
    }
    elsif ($hoy->month < $nac->month) #Falta para cumplir los anos
    {
        return $edad -1 ;
    }
    else #Estoy en el mes del cumpleanos
    {
        if ($hoy->day >= $nac->day)
        {
            return $edad;
        }
        else 
        {
            return $edad -1;
        }
    }
    
}

sub _fields
{
    my $table_name = 'persona';
    
    my @fields = qw(
            id
            nombre
            apellido
            nacimiento
            direccion
            
    );

    my %fields = (
            id => { pk => 1, read_only => 1 },
            nacimiento => { date => 1},
    );

    return [ \@fields, \%fields, $table_name ];
}

1;