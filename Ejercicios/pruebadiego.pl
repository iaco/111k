#!/usr/bin/perl

sub hola
{
    $cadena = shift;
    
    if ($nombre eq "p"){
        print "Hola $cadena.\n";
        $nombre=$cadena;
    } else {
        print "Hola $cadena! $nombre ya esta aqui!\n";
    }
    
}
##use vars qw($nombre);

our $nombre = "p";
hola(Homero);
hola(bart);
hola("lisa");
hola("marge");