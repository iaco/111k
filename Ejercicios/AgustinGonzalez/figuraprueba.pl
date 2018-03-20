#!/usr/bin/perl
## Recive un path y crea un archivo png donde pone las figuras

use lib "./lib";
use Figura;
use Rectangulo;
use Circulo;
use Triangulo;
use Punto;
require Figura;
use GD;

my $path =shift;

open (FH, ">".$path);
my $img = new  GD::Image(800,600);
my $white = $img->colorAllocate(255,255,255);
my $black = $img->colorAllocate(0,0,0);       
my $red = $img->colorAllocate(255,0,0);      
my $blue = $img->colorAllocate(0,0,255);

my $rectangulo = new Rectangulo(10,10,10,50,50,10,50,50);
my $area = $rectangulo->area;

print	"El area del rectangulo es: $area\n";
$img =$rectangulo->draw($img);


my $triangulo = new Triangulo(100,10,200,10,150,96.60254038);

my $areaT = $triangulo->area;
print "El area del triangulo es: $areaT\n";
$img = $triangulo->draw($img);


##CREACION CIRCULO TEST
my $centro = new Punto(x=>300,y=>500);
my $puntoex = new Punto(x=>400,y=>300);
my $circulo = new Circulo($centro,$puntoex);

my $areaC = $circulo->area;

print "El area del circulo es: $areaC\n";

$img=$circulo->draw($img);
$centro->x(666);
my $centroget = $circulo->centro;
$puntoex = $circulo->puntoexterior;
my ($x,$y)=$centroget->puntos;
print	"el centro del circulo esta en ($x,$y)\n";
($x,$y)=$puntoex->puntos;
print	"el punto exterior del circulo esta en ($x,$y)\n";
my $punto_nuevo_centro = new Punto (x=>600,y=>0);
$circulo->centro($punto_nuevo_centro);
($x,$y) = ($circulo->centro)->puntos;
print	"el centro del circulo esta en ($x,$y)\n";
($x,$y)= $circulo->puntoexterior->puntos;

print	"el punto exterior del circulo esta en ($x,$y)\n";
$img = $circulo->draw($img);

print FH $img->png;
close FH;
