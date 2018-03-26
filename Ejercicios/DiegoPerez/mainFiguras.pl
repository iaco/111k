#!/usr/bin/perl
use strict;
use warnings;
use v5.14;
use lib "./";
use lib "./Model/";
use lib "./Controller/";
no if $] >= 5.018, warnings => "experimental::smartmatch";

use Circulo;
use Triangulo;
use Rectangulo;
use Cuadrado;
use GestEvent;

print "Ingrese el tipo de figura deseada, Cuadrado, Rectangulo, Circulo, Triangulo. Sale con <Ctrl + C>: \n";
my $gestor = new GestEvent;
while (chomp(my $entrada = <STDIN>)) {
    $entrada =~ tr/A-Z/a-z/;

 	given( $entrada) {
        
		when ("cuadrado")  {    print "Ingrese los 4 pares de vertices: \n";
								chomp(my $x1 = <STDIN>,my $y1 = <STDIN>,my $x2 = <STDIN>,my $y2 = <STDIN>,my $x3 = <STDIN>,my $y3 = <STDIN>,my $x4 = <STDIN>,my $y4 = <STDIN>);
								$gestor->add_cuadrado($x1,$y1,$x2,$y2,$x3,$y3,$x4,$y4);


                                print "Ingrese el tipo de figura: Cuadrado, Rectangulo, Circulo, Triangulo o Persistir si quiere guardar, listar para imprimir. Corte con <S>: \n";
							}
		when ("rectangulo") {   print "Ingrese los 4 pares de vertices:\n";
								
								chomp(my $x1 = <STDIN>,my $y1 = <STDIN>,my $x2 = <STDIN>,my $y2 = <STDIN>,my $x3 = <STDIN>,my $y3 = <STDIN>,my $x4 = <STDIN>,my $y4 = <STDIN>);
                                $gestor->add_rectangulo($x1,$y1,$x2,$y2,$x3,$y3,$x4,$y4);
								
								print "Ingrese el tipo de figura deseada, Cuadrado, Rectangulo, Circulo, Triangulo o Persistir si quiere guardar, listar para imprimir. Corte con <Ctrl + D>: \n";
								
							}
		when ("circulo")	{   print "Ingrese el centro y un punto: \n";
								chomp( my $x1 = <STDIN>, my $y1 = <STDIN>, my $x2 = <STDIN>, my $y2 = <STDIN>);
								$gestor->add_circulo($x1,$y1,$x2,$y2);


								print "Ingrese el tipo de figura deseada, Cuadrado, Rectangulo, Circulo, Triangulo o Persistir si quiere guardar, listar para imprimir. Corte con <Ctrl + D>: \n";

							}
		when ("triangulo")  {   print "Ingrese los 3 pares de vertices: \n";
								chomp(my $x1 = <STDIN>,my $y1 = <STDIN>,my $x2 = <STDIN>,my $y2 = <STDIN>,my $x3 = <STDIN>,my $y3 = <STDIN>);
                                $gestor->add_triangulo($x1,$y1,$x2,$y2,$x3,$y3);
								print "Ingrese el tipo de figura deseada, Cuadrado, Rectangulo, Circulo, Triangulo o Persistir si quiere guardar, listar para imprimir. Corte con <Ctrl + D>: \n";

							}
		when ("persistir")	{
								gestor->persistir();
							    print "Ingrese el tipo de figura deseada, Cuadrado, Rectangulo, Circulo, Triangulo o listar. Corte con <Ctrl + D>: \n";
							}	
		when ("listar")	{
								print "Ingrese la figura a listar: ";
								chomp(my $figura = <STDIN>);
                                $figura = lc($figura);
								&gestor->listar($figura);	
								print "Ingrese el tipo de figura deseada, Cuadrado, Rectangulo, Circulo, Triangulo o Persistir. Corte con <Ctrl + D>: \n";

							}		
		default				{   print "Ingrese una opcion valida por favor\n";
							}
						
		}
}
