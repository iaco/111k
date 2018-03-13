#!/usr/bin/perl

use lib "/home/agustin/perl";
use DBI;
use Figura;
use Rectangulo;
use Circulo;
use Triangulo;
require Figura;
use strict;
our $dbh;#data base handler
our %tablas={};
#our ($t_cuadrado,$t_triangulo,$t_circulo);#tablas de la base


sub crear_tablas
{

	
	my $t_cuadrado= "t_cuadrado";
	$tablas{cuadrado}= $t_cuadrado;
	$tablas{rectangulo}=$t_cuadrado;
	my $campos_t_cuadrado=  "id_cuadrado int auto_increment PRIMARY KEY,x1 FLOAT,y1 FLOAT,x2 FLOAT,y2 FLOAT,x3 FLOAT,y3 FLOAT,x4 FLOAT,y4 FLOAT";
	$dbh->do("create table if not exists $t_cuadrado ($campos_t_cuadrado);") || die "no se pudo crear la tabla";

	my $t_triangulo ="t_triangulo";
	$tablas{triangulo}= $t_triangulo;
	my $campos_t_triangulo= "id_triangulo INT auto_increment PRIMARY KEY, x1 FLOAT,y1 FLOAT,x2 FLOAT,y2 FLOAT,x3 FLOAT,y3 FLOAT";
	$dbh->do("create table if not exists $t_triangulo ($campos_t_triangulo);")|| die "no se pudo crear la tabla de triangulos";

	my $t_circulo = "t_circulo";
	$tablas{circulo}=$t_circulo;
	my $campos_t_circulo = "id_circulo INT auto_increment PRIMARY KEY,x1 FLOAT, y1 FLOAT, x2 FLOAT, y2 FLOAT";
	$dbh->do ("create table if not exists $t_circulo ($campos_t_circulo);")|| die "no se pudo crear la tabla de circulos";

}
sub insert
{
	my $figura = shift;
	my $class = lc(ref $figura);
	if ($class eq "rectangulo")
	{
		$class= "cuadrado";
	}
	my $t_figura= $tablas{$class};
	my @values = $figura->puntos;
	my $string = "insert into $t_figura values(0,".join (",",@values).")";
	print "string: $string\n";
	$dbh->do($string);#Poner un 0 para el autoincrement
}

sub persistir
{
	my @figuras =@_;

	foreach my  $figura (@figuras)
	{
		my $class = ref $figura;
		print "Guardando un $class\n";
		insert($figura);
	}
}

sub recuperar_todo
{
	my $figura = lc (shift);
	my $t_figura= $tablas{$figura};
	my $consulta = "select * from $t_figura;";
	my @listado = $dbh->selectall_array($consulta);
	foreach my $row (@listado)
	{
		@{$row}[0]=$figura;
	}
	return (@listado);
}



######################################################################################################################
$dbh =  DBI->connect("DBI:mysql:figuras:localhost", "root", "root") || die "No se pudo conectar a la base de datos\n";

my $img =  new  GD::Image(800,600);
my $white = $img->colorAllocate(255,255,255);#El primer color guardado se convierte en el fondo de a imagen
my $black = $img->colorAllocate(0,0,0);       
my $red = $img->colorAllocate(255,0,0);      
my $blue = $img->colorAllocate(0,0,255);

&crear_tablas;

#my @lista = (new Rectangulo(10,20,10,40,50,20,50,40),
#			new Triangulo(100,10,200,10,150,96.60254038), 
#			new Circulo(300,500,400,300), 
#			new Rectangulo(100,200,100,400,500,200,500,400), 
#			new Rectangulo(10,25,10,40,50,25,50,40), 
#			new Rectangulo(30,20,30,40,50,20,50,40));
#persistir (@lista);
my $tipo_figura="cuadrado";
my (@cuadrados) = (&recuperar_todo($tipo_figura));
print "Se encontraron los siguientes $tipo_figura"."s\n";


my @lista_recuperados;
foreach my $figura (@cuadrados)
{
	my $tipo = shift @{$figura};
	if (($tipo eq "cuadrado")||($tipo eq "Rectangulo"))
	{
		push (@lista_recuperados, new Rectangulo(@{$figura}));
		next;
	}
	if ($tipo eq "triangulo")
	{
		push(@lista_recuperados, new Triangulo(@{$figura}));
		next;
	}
	if ($tipo eq "circulo")
	{
		push(@lista_recuperados, new Circulo(@{$figura}));
		next;
	}
}

foreach my $figura (@lista_recuperados)
{
	my @puntos = $figura->puntos;
	my $area = $figura->area;
	print "Calculando area del $tipo_figura con puntos @puntos\nArea: $area}\n";
}

open (FH, ">"."DBIprueba.png");
print FH $img->png;
close FH;



$dbh->disconnect;