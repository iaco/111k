#!/usr/bin/perl
use lib "./";
use Rectangulo;
use Triangulo;
use Punto;

my $punto_loco = new Punto(x=>0,y=>0);
my $rectangulo = new Rectangulo(
	vertice1=>$punto_loco,
	vertice2=>new Punto(x=>100,y=>0),
	vertice3=>new Punto(x=>0,y=>150),
	vertice4=>new Punto(x=>100,y=>150));
my $area = $rectangulo->area();
print "El area es $area\n";
$punto_loco->x(800);

$rectangulo->{vertice1};

$area = $rectangulo->area();

print "El area es $area\n";
open (my $fh_png,">", "rectangulomoose.png");

my $img =  new  GD::Image(800,600);
my $white = $img->colorAllocate(255,255,255);#El primer color guardado se convierte en el fondo de a imagen
my $black = $img->colorAllocate(0,0,0);       
my $red = $img->colorAllocate(255,0,0);      
my $blue = $img->colorAllocate(0,0,255);
$rectangulo->draw($img);


my $triangulo= new Triangulo(
	vertice1=>new Punto(x=>300,y=>100),
	vertice2=>new Punto(x=>600,y=>100),
	vertice3=>new Punto(x=>450,y=>100+150*sqrt(3)));
my $area_triangulo = $triangulo->area;
print "el area del triangulo es $area_triangulo\n";
$triangulo->draw($img);


print $fh_png $img->png;

close $fh_png;