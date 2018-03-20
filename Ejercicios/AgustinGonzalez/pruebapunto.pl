#!usr/bin/perl

use lib "./lib";
use Punto;


my $punto1 = new Punto(x=>2,y=>3);
my $punto2 = new Punto(x=>2,y=>7.20);
print "$punto1->get_x()\n";
print "$punto1\n";
my $x= $punto1->x();
print "$x\n";
my $distancia = $punto1->distancia($punto2);
print "Calculando Distancia: $distancia\n";