#!/usr/bin/perl

use lib "./model";
use lib "./controller";
use lib "./view";

use Personas;
use Persona;
use Interprete;

my $manager = new Interprete();
&cargar;
&listar;









sub cargar
{
    for(my $i=1; $i<=10; $i++)
    {
        $manager->agregar_persona("nombre$i", "apellido$i" ,"direccion$i" ,"1988-12-23");
    }
}

sub listar
{
    my @personas = $manager->get_lista;
    foreach my $persona(@personas)
    {
        print $persona->{"direccion"} . "\n";
        
    }
}