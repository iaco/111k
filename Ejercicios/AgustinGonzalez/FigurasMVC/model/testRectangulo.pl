#!/usr/bin/perl
use lib "./";
use Rectangulo;
use Triangulo;
use Circulo;
use Punto;

my $punto_loco = new Punto(x=>0,y=>0);
my $rectangulo = new Rectangulo(x1=>0,y1=>0,x2=>100,y2=>0,x3=>0,y3=>150,x4=>100,y4=>150);
my $area = $rectangulo->area();
print "El area es $area\n";
$rectangulo->insert;
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


my $triangulo= new Triangulo(x1=>300,y1=>100,x2=>600,y2=>100,x3=>450,y3=>100+150*sqrt(3));

my $area_triangulo = $triangulo->area;
print "el area del triangulo es $area_triangulo\n";
$triangulo->draw($img);
$triangulo->insert;

my $circulo = new Circulo(x1=>300,y1=>300,x2=>600,y2=>300) ||die "no se creo el circulo";
my $area_circulo = $circulo->area;
print "el area del circulo es $area_circulo\n";
$circulo->draw($img);
$circulo->insert;


print $fh_png $img->png;

close $fh_png;