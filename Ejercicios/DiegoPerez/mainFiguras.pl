#!/usr/bin/perl
use GD;
use GD::Simple;
use strict;
use warnings;
use v5.14;
use DBI;
no if $] >= 5.018, warnings => "experimental::smartmatch";

use lib "/home/diego/Exercies/Figuras/";
use Circulo;
use Triangulo;
use Rectangulo;
use Cuadrado;

my @list = ();


sub persistir
{
	my $base_datos="Figuras"; #Nombre de las base de datos
	my $usuario="root"; #Usuario de la BD
	my $clave="diego"; #Password de la BD
	my $driver="mysql"; 

	#Conecta con la base_datos
	my $dbh = DBI->connect("dbi:$driver:$base_datos",$usuario,$clave) || die "\nError al abrir la base datos: $DBI::errstr\n";
	
	my @list = @_;
	my $tabla_cuadrado = "Cuadrado"; 
	my $tabla_triangulo = "Triangulo"; 
	my $tabla_rectangulo = "Rectangulo"; 
	my $tabla_circulo = "Circulo"; 

   	for(my $i=0; $i<=$#list; $i++){
   			
			if (${$list[$i]}[0] eq "cuadrado" ) {
				my $resultado = $dbh->do ("insert into $tabla_cuadrado values (0,${$list[$i]}[1],${$list[$i]}[2],${$list[$i]}[3],${$list[$i]}[4],${$list[$i]}[5],${$list[$i]}[6],${$list[$i]}[7],${$list[$i]}[8]);") || warn "Error en inserci¢n en $tabla_cuadrado: $DBI::errstr\n";
			}
			if (${$list[$i]}[0] eq "rectangulo" ){
				my $resultado = $dbh->do ("insert into $tabla_rectangulo values (0,$list[$i][1],$list[$i][2],$list[$i][3],$list[$i][4],$list[$i][5],$list[$i][6],$list[$i][7],$list[$i][8]);") || warn "Error en inserci¢n en $tabla_rectangulo: $DBI::errstr\n";
			}
			if (${$list[$i]}[0] eq "circulo" ){
				my $resultado = $dbh->do ("insert into $tabla_circulo values (0,$list[$i][1],$list[$i][2],$list[$i][3],$list[$i][4]);") || warn "Error en inserci¢n en $tabla_circulo: $DBI::errstr\n";
			}
			if (${$list[$i]}[0] eq "triangulo" ){
				my $resultado = $dbh->do ("insert into $tabla_triangulo values (0,$list[$i][1],$list[$i][2],$list[$i][3],$list[$i][4],$list[$i][5],$list[$i][6]);") || warn "Error en inserci¢n en $tabla_triangulo: $DBI::errstr\n";
			}
		}
	$dbh->disconnect || warn "\nFallo al desconectar.\nError: $DBI::errstr\n";		

}

sub listar
{
	my $figura = shift;
	my $base_datos="Figuras"; #Nombre de las base de datos
	my $usuario="root"; #Usuario de la BD
	my $clave="diego"; #Password de la BD
	my $driver="mysql"; 

	#Conecta con la base_datos
	my $dbh = DBI->connect("dbi:$driver:$base_datos",$usuario,$clave) || die "\nError al abrir la base datos: $DBI::errstr\n";
	
	my $tabla_cuadrado = "Cuadrado"; 
	my $tabla_triangulo = "Triangulo"; 
	my $tabla_rectangulo = "Rectangulo"; 
	my $tabla_circulo = "Circulo"; 
   	my @list = ();

   	$figura = "\U$figura\E";
	if ($figura eq "TRIANGULO"){
		my $consulta = ("select * from $tabla_triangulo"); 
		my @tria = $dbh->selectall_array($consulta);
    	print "Triangulo  -> puntos: ";
		for my $tria (@tria){
			print "@{$tria}, \n";
		}
		print "\n";
	}

	if ($figura eq "CUADRADO"){
	    my $consulta = ("select * from $tabla_cuadrado"); 
		my @cuad = $dbh->selectall_array($consulta);
		print "Cuadrado  -> puntos: ";
		for my $cuad (@cuad){
			print "@{$cuad}, \n";
		}
		print "\n";
	}

	if ($figura eq "RECTANGULO"){
	    my $consulta = ("select * from $tabla_rectangulo"); 
		my @rect = $dbh->selectall_array($consulta);
		print "Rectangulo  -> puntos: ";
		for my $rect (@rect){
			print "@{$rect}, \n";
		}
		print "\n";
	}	
	
	if ($figura eq "CIRCULO"){
		my $consulta = ("select * from $tabla_circulo"); 
		my @circ = $dbh->selectall_array($consulta);
		print "Circulo  -> puntos: ";
		for my  $circ (@circ){
			print "@{$circ}, \n";
		}
		print "\n";
	}	

	
	$dbh->disconnect || warn "\nFallo al desconectar.\nError: $DBI::errstr\n";		
}


print "Ingrese el tipo de figura deseada, Cuadrado, Rectangulo, Circulo, Triangulo. Sale con <Ctrl + C>: \n";

while (chomp(my $entrada = <STDIN>)) {
 $entrada =~ tr/A-Z/a-z/;

 	given( $entrada) {
		when ("cuadrado")  {    print "Ingrese los 4 pares de vertices: \n";
								chomp(my $x1 = <STDIN>,my $y1 = <STDIN>,my $x2 = <STDIN>,my $y2 = <STDIN>,my $x3 = <STDIN>,my $y3 = <STDIN>,my $x4 = <STDIN>,my $y4 = <STDIN>);
							    my $cuadrado = Cuadrado -> new(Vertice1x=>$x1,Vertice1y=>$y1,Vertice2x=>$x2,Vertice2y=>$y2,Vertice3x=>$x3,Vertice3y=>$y3,Vertice4x=>$x4,Vertice4y=>$y4);
							    
							    my $cuad = ["cuadrado",$x1,$y1,$x2,$y2,$x3,$y3,$x4,$y4];
							    push @list,$cuad;

							    my $area = $cuadrado->area;
							    print	"El area es: $area\n";
							    $cuadrado->draw;
								print "Ingrese el tipo de figura deseada, Cuadrado, Rectangulo, Circulo, Triangulo o Persistir si quiere guardar, listar para imprimir. Corte con <Ctrl + D>: \n";
							}
		when ("rectangulo") {   print "Ingrese los 4 pares de vertices:\n";
								chomp(my $x1 = <STDIN>,my $y1 = <STDIN>,my $x2 = <STDIN>,my $y2 = <STDIN>,my $x3 = <STDIN>,my $y3 = <STDIN>,my $x4 = <STDIN>,my $y4 = <STDIN>);
								
								my $rectangulo = Rectangulo -> new(Vertice1x=>$x1,Vertice1y=>$y1,Vertice2x=>$x2,Vertice2y=>$y2,Vertice3x=>$x3,Vertice3y=>$y3,Vertice4x=>$x4,Vertice4y=>$y4);

								my $rect = ["rectangulo",$x1,$y1,$x2,$y2,$x3,$y3,$x4,$y4];
							    push @list,$rect;
								my $area = $rectangulo->area;
								print	"El area es: $area\n";
								$rectangulo->draw;
								
								print "Ingrese el tipo de figura deseada, Cuadrado, Rectangulo, Circulo, Triangulo o Persistir si quiere guardar, listar para imprimir. Corte con <Ctrl + D>: \n";
								
							}
		when ("circulo")	{   print "Ingrese el centro y un punto: \n";
								chomp( my $x1 = <STDIN>, my $y1 = <STDIN>, my $x2 = <STDIN>, my $y2 = <STDIN>);
								my $circulo = Circulo -> new(Vertice1x=>$x1,Vertice1y=>$y1,Vertice2x=>$x2,Vertice2y=>$y2);

								my $circ = ["circulo",$x1,$y1,$x2,$y2,1,1,1,1];
							    push @list,$circ;
								
								my $area = $circulo->area;
								print	"El area es: $area\n";
								$circulo->draw;
								print "Ingrese el tipo de figura deseada, Cuadrado, Rectangulo, Circulo, Triangulo o Persistir si quiere guardar, listar para imprimir. Corte con <Ctrl + D>: \n";

							}
		when ("triangulo")  {   print "Ingrese los 3 pares de vertices: \n";
								chomp(my $x1 = <STDIN>,my $y1 = <STDIN>,my $x2 = <STDIN>,my $y2 = <STDIN>,my $x3 = <STDIN>,my $y3 = <STDIN>);
								my $triangulo = Triangulo -> new(Vertice1x=>$x1,Vertice1y=>$y1,Vertice2x=>$x2,Vertice2y=>$y2,Vertice3x=>$x3,Vertice3y=>$y3);
								
								my $tria = ["triangulo",$x1,$y1,$x2,$y2,$x3,$y3,1,1];
							    push @list,$tria;

								my $area = $triangulo->area;
						    	print	"El area es: $area\n";
							    $triangulo->draw;
								print "Ingrese el tipo de figura deseada, Cuadrado, Rectangulo, Circulo, Triangulo o Persistir si quiere guardar, listar para imprimir. Corte con <Ctrl + D>: \n";

							}
		when ("persistir")	{
								&persistir(@list);
								@list = ();
								 print "Ingrese el tipo de figura deseada, Cuadrado, Rectangulo, Circulo, Triangulo o listar. Corte con <Ctrl + D>: \n";

							}	
		when ("listar")	{
								print "Ingrese la figura a listar: ";
								chomp(my $figura = <STDIN>);

								&listar($figura);	
								print " estan persistidas\n";
								print "Ingrese el tipo de figura deseada, Cuadrado, Rectangulo, Circulo, Triangulo o Persistir. Corte con <Ctrl + D>: \n";

							}		
		default				{   print "Ingrese una opcion valida por favor\n";
							}
						
		}
}
