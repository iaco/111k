#!/usr/bin/perl
use lib "./view";
use lib "./model";
use lib "./controller";

use Sessionmanager;

my $session= new Sessionmanager;
my $eleccion;

while (($eleccion=&menu) != "salir")
{
	if ($eleccion eq 1)
	{
		my @puntos = &pedir_rectangulo();
		my $rectangulo_nuevo = $session->add_rectangulo(@puntos);
		print "El area de la figura ingresada es ".$rectangulo_nuevo->area."\n";		
	}
	elsif ($eleccion eq 2)
	{
		my @puntos = &pedir_circulo();
		my $nuevo = $session->add_circulo(@puntos);
		print "El area de la figura ingresada es ".$nuevo->area."\n";
	}
	elsif ($eleccion eq 3)
	{
		my @puntos = &pedir_triangulo();
		my $nuevo = $session->add_triangulo(@puntos);
		print "El area de la figura ingresada es ".$nuevo->area."\n";
	}
	elsif ($eleccion eq 4)
	{
		print "Ingrese el nombre del archivo donde quiere dibujar: ";
		my $path = <STDIN>;
		chomp $path;
		$session->dibujar_todas($path);
	}
	elsif ($eleccion eq 5)
	{
		$session->persistir;
	}
	elsif ($eleccion eq 6)
	{
		print "Ingrese que tipo de figuras quiere recuperar\nLas opciones son cuadrado|rectangulo, triangulo, circulo\n";
		my $tipo =<STDIN>;
		chomp $tipo;
		$session->recuperar($tipo);
	}
	elsif ($eleccion eq 7)
	{
		$session->listar;
	}
	elsif ($eleccion eq 8)
	{
		$session->reset;
	}
}











sub menu
{
	print "Elija que accion quiere realizar, escriba salir para terminar\n
	1-Crear Rectangulo|cuadrado\n
	2-Crear Circulo\n
	3-Crear Triangulo\n
	4-Dibujar las figuras creadas\n
	5-Guardar en la base de datos las figuras creadas\n
	6-Recuperar de la base de datos todas las figuras en un tipo\n
	7-Listar las figuras creadas\n
	8-Reset(No elimina Figuras persistidas)\n
	salir\n";
	my $entrada =<STDIN>;
	chomp ($entrada);
	return $entrada;
}


sub pedir_rectangulo
{
	print "Ingrese los puntos que conformaran el rectangulo de la siguiente manera\nx1 y1 x2 y2 x3 y3 x4 y4\n";
	my $entrada= <STDIN>;
	chomp $entrada;
	my @puntos = split(/ /,$entrada);
	return @puntos;
}


sub pedir_triangulo
{
	print "Ingrese los puntos que conformaran el triangulo de la siguiente manera\nx1 y1 x2 y2 x3 y3\n";
	my $entrada= <STDIN>;
	chomp $entrada;
	my @puntos = split(/ /,$entrada);
	return @puntos;
}

sub pedir_circulo
{
	print "Ingrese las coordenadas que componen el centro del circulo y un punto exterior de la siguiente manera\nxcentro ycentro xpuntoext ypuntoex\n";
	my $entrada= <STDIN>;
	chomp $entrada;
	my @puntos = split(/ /,$entrada);
	return @puntos;
}

