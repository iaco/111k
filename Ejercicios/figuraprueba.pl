#!/usr/bin/perl


use lib "/home/agustin/perl";
use Figura;
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

my $circulo = new Circulo(300,500,400,300);

my $areaC = $circulo->area;

print "El area del circulo es: $areaC\n";

$img=$circulo->draw($img);

my @test = ($circulo->centro);
my @puntoext = $circulo->punto;
print	"el centro del circulo esta en ($test[0],$test[1])\n";
print	"el punto exterior del circulo esta en ($puntoext[0],$puntoext[1])\n";
$circulo->centro(600,0);
@test = ($circulo->centro);
@puntoext = $circulo->punto;
print	"el centro del circulo esta en ($test[0],$test[1])\n";
print	"el punto exterior del circulo esta en ($puntoext[0],$puntoext[1])\n";
$img = $circulo->draw($img);

print FH $img->png;
close FH;
