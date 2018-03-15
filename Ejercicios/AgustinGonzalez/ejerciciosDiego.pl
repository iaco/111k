#!/usr/bin/perl
use constant PI => 3.14159;


use v5.14;
use warnings;
no if $] >= 5.018, warnings => "experimental::smartmatch";#para que no vuelvan loco las advertencias al usar given


sub Circunferencia
{
	my $radio=shift;
	if ($radio<0)
	{
		return (0);
	}
	my $circunferencia=2*$radio*$PI;
	return ($circunferencia);
}

sub Ejercicio1
{
	print "Ingrese el radio para calcular la circunferencia\n";
	my $radio= <STDIN>;

	#si hago todo en el print no me lo imprime que onda, sabes??
	#print "La circunferencia es &Circunferencia($radio)\n";
	#entonces tengo que hacerlo en varios pasos

	my $circunferencia = &Circunferencia($radio);
	print "la circunferencia es $circunferencia\n";
}


sub Ejercicio5
{
	#5. Escriba un programa que solicite una cadena y un número de la entrada estándar (en líneas
	#	separadas) e imprima en la salida la cadena original repetida según el número de veces indicado

	print "Ingrese la cadena a repetir: ";
	my $cadena = <STDIN>;
	chop($cadena);
	print "\n¿Cuantas veces queres repetirla? ";
	my $veces = <STDIN>;
	my $resultado = ($cadena) x ($veces);
	print $resultado."\n";

}


sub Ejercicio6
{
	#6. Escriba un programa que lea una lista de cadenas separados por
	#líneas e imprima esta lista en modo inverso. (Si la entrada proviene del
	#teclado, la secuencia para finalizar es CTRL-D en *NIX).

	print "Ingrese varias palabras y se las dire en orden inverso\npresione control+d para terminar\n";

	my $linea;
	my @lista;
	while (chomp ($linea = <STDIN>))
	{
		push(@lista,$linea);
	}
	@lista= 	reverse(@lista);
	$,="-";#Defino el guion como separador
	print @lista;
}

sub Ejercicio7
{
	#7. Escriba un programa que lea una lista de números separados por líneas
	#y por cada número imprima el nombre correspondiente a la siguiente lista:
	#bart, lisa, homero, marge, maggie, ned, nelson, barney
	#Por ejemplo, si la entrada es 1, 2, 4, la salida debe mostrar lo siguiente:
	#bart, lisa, marge
	my @nombres= qw(cero bart lisa homero marge maggie ned nelson barney);
	my @entrada;
	print "Ingrese una lista de numeros para listar los personajes\n$#nombres es el valor maximo y control+d para terminar\n";
	my $linea;
	while(chomp ($linea=<STDIN>))
	{
		push(@entrada,$linea);
	}
	while (@entrada)
	{
		my $indice=shift(@entrada);
		print $nombres[$indice]."\n";
	}
}

sub Ejercicio8
{
	#8. Escriba un programa que lea una lista de cadenas (separadas por
	#líneas) e imprima esta lista en orden alfabético (tenga en cuenta que la entrada podría
	#contener caracteres Unicode)
	package ejercicio8;
	
	use utf8;
	use Unicode::Collate;
	
	my @entrada;
	print "Ingrese cadenas separadas por enter para ser ordenadas\n";
	print "control+d para terminar\n";
	my $linea;
	while ( ($linea=<STDIN>))
	{
		push(@entrada,$linea);
	}
	@entrada = Unicode::Collate->new->sort(@entrada);
	print @entrada;
}

sub total
{
	my @numeros =@_;
	my $total;
	print "La lista recibida es: @numeros\n";
	while (@numeros)
	{
		my $valor = shift(@numeros);
		$total = $total + $valor;
	}
	return $total;
}
sub Ejercicio9
{
	#9. Escriba una función llamada "total" que retorne la suma de una lista
	#de números proporcionados como parámetros, y úsela en un programa para calcular
	#la suma de los primeros 100 números enteros positivos (el resultado debería ser 5050),
	#y también para calcular una lista de números proporcionados desde la entrada estándar:

    print "Ingrese algunos números separados por líneas..\nControl+D para terminar\n";
    my @entrada;
    my $linea;
    while (chomp ($linea=<STDIN>))
    {
    	push (@entrada,$linea);
    }
    my $total_numeros = &total(@entrada);
    print "El total para los números ingresados es: $total_numeros.\n";

    my @primeros100 = (1..100);
    my $total_primeros_100 = &total(@primeros100);
    print "El total para los primeros 100 es; $total_primeros_100\n";

}
sub promedio
{
	my @entrada=@_;
	my $total;
	my $cantidad;
	while (@entrada) {
		my $valor = shift(@entrada);
		$total += $valor;
		$cantidad++;
	}
	return ($total/$cantidad);
}
sub sobre_promedio
{
	my @entrada =@_;
	my @salida;
	my $prom = &promedio(@entrada);
	while (@entrada) {
		my $valor= shift(@entrada);
		if ($valor>$prom)
		{
			push(@salida,$valor);
		}
	}
	return @salida;


}

sub Ejercicio10
{
	#10. Escriba una función llamada “sobre_promedio” que tome una lista de
	#números y retorne aquellos números que estén por encima del promedio
	#(puede escribir otra función para calcular este promedio). Pruébelo con:

	my @arr1 = sobre_promedio(1..10);
	print "\@arr1 es: @arr1 \n"; # deberían mostrarse del 6 al 10
	my @arr2 = sobre_promedio(100,1..10);
	print "\@arr2 es: @arr2 \n"; # debería mostrarse solo el 100
}


{
	#Declarando las funciones asi, ellas pueden acceder a esta variable buffer, ya que fueron declaradas en este scope
	#Pero si quiero acceder a @BUffer manualmente sin la funcion, no puedo
	#Para esto necesitamos que este bloque se encuentre antes para que se ejecute la declaracion de buffer
	#Para ello, o nos aseguramos que este antes del bloque "main" del programa, o lo encerramos en una declaracion BEGIN
	my @buffer;
	sub hola
	{
		my $personaje = shift;
		if (@buffer)
		{
			print "Hola $personaje! He visto a: @buffer tambien aqui!\n";
			push (@buffer,$personaje);
		}
		else 
		{
			print "Hola $personaje! Eres el primero aqui\n";
			push (@buffer,$personaje);
		}
	}
}
sub Ejercicio11
{
	#11. Escriba una función llamada "hola", que de la bienvenida a una
	#persona por su nombre y diga el nombre de la última persona saludada:
	sub hola11
	{
		my $personaje = shift;
		state $anterior;
		if ($anterior)
		{
			print "Hola $personaje! $anterior ya esta aqui\n";
			$anterior=$personaje;

		}
		else
		{
			print "Hola $personaje! Eres el primero aqui\n";
			$anterior=$personaje;
		}
	}

	&hola11("Homero");
	&hola11("Bart");

}
sub Ejercicio12
{
	#Modifique el programa anterior para que imprima los nombres de todas
	#las personas que han sido previamente saludadas.

	#hola("Homero");
	#hola("Bart");
	#hola("Lisa");
	#hola("Marge");

	#La salida debe ser como lo siguiente:

	#Hola Homero! Eres el primero aquí!
	#Hola Bart! He visto a: Homero
	#Hola Lisa! He visto a: Homero Bart
	#Hola Marge! He visto a: Homero Bart Lisa
	sub hola12
	{
		my $personaje= shift;
		state @anteriores;
		if (@anteriores)
		{
			print "Hola $personaje! He visto a: @anteriores\n";
			push(@anteriores,$personaje);
		}
		else
		{
			print "Hola $personaje! Eres el primero en llegar\n";
			push(@anteriores,$personaje);
		}
		

	}
	
	&hola12("Homero");
	&hola12("bart");
	&hola12("lisa");
	&hola12("marge");
}

sub Ejercicio13
{
	#13. Escriba un programa que lea una serie de palabras (puede haber varias palabras
	#por línea) hasta el final de la entrada (End-Of-Input o Ctrl+D), e imprima un resumen de
	#cuántas veces fue vista cada letra.
	my @entrada;
	print "Ingrese cadenas separadas por enter\n";
	print "control+d para terminar\n";
	my $linea;
	while ( ($linea=<STDIN>))
	{
		push(@entrada,$linea);
	}
	my %vocales =
	(
		"a" => 0,
		"e" => 0,
		"i" => 0,
		"o" => 0,
		"u" => 0,
	);
	
	foreach $linea (@entrada)
	{
		foreach my $vocal (keys %vocales)
		{
			print "buscando $vocal en $linea\n";
			my @lista_encontradas = $linea=~ m/$vocal/gi; #Lista todas las ocurrencias
			my $encontradas= @lista_encontradas; #Obtengo la cantidad de ocurrencias
			print "se encontraron $encontradas\n";
			$vocales{$vocal}+= $encontradas;	
		}
	}
	print "Apariciones:\n";
	foreach my $vocal (keys %vocales)
	{
		print "$vocal= $vocales{$vocal}\n";
	}
}

sub Ejercicio14
{
	#14. Escriba un programa que imprima cada línea que tenga dos caracteres
	#iguales juntos el uno al otro (exceptuando espacios en blanco). Debe hacer
	#match de lineas que contengan cosas como “Mississippi”, “Bamm”, o “llama”.

	my @entrada;
	print "Ingrese cadenas separadas por enter\n";
	print "control+d para terminar\n";
	my $linea;
	while ( ($linea=<STDIN>))
	{
		push(@entrada,$linea);
	}

	foreach $linea (@entrada)
	{
		if ($linea=~ m/(\w)\1/)
		{
			print $linea;
		}
	}

}

sub Ejercicio15
{
	#15. Escriba un programa que lea una serie de palabras (puede haber varias palabras
	#por línea) e imprima las palabras terminadas en la letra “a”.
	my @entrada;
	print "Ingrese cadenas separadas por enter\n";
	print "control+d para terminar\n";
	my $linea;
	while ( ($linea=<STDIN>))
	{
		push(@entrada,$linea);
	}
	print "Buscando palabras que terminen con a.....\n";
	foreach $linea (@entrada)
	{
		my @palabras = $linea =~ m/\w+/g;
		foreach my $palabra (@palabras)
		{
			if ($palabra =~ m/a$/)
			{
				print "$palabra\n";
			}
			
		}
	}
}

sub Ejercicio16
{
	#16. Escriba una función que permita identificar si una cadena de texto es una dirección IPv4.

	print "ingrese una cadena y le dire si es una direccion IPv4\n";
	my $texto = <STDIN>;
	if ($texto =~ m/^(\d+)\.(\d+)\.(\d+)\.(\d+)$/)
	{
		if (((0<$1)&&($1<256))&&((0<$2)&&($2<256))&&((0<=$3)&&($3<256))&&((0<$4)&&($4<256)))
		{
			print "$texto es una direccion de Ipv4 valida\n";
		}
		else
		{
			print "Los valores ingresados no corresponden a una direccion IPv4\n";
		}
		
	}
	else 
	{
		print "$texto no tiene el formato de  una direccion de IPv4\n";
	}
}

sub Ejercicio17
{
	#17. Un archivo de texto contiene una lista de direcciones de correo electrónico. Escriba un programa
	#para ordenar la lista según el dominio, y dentro de un mismo dominio, ordene las direcciones
	#alfabéticamente por el nombre de buzón/usuario.
	my $path = shift;
	open (FILE, $path);


}


#PROGRAMA MAIN
my $seleccion = shift;

given ($seleccion)
{
	when (1) {&Ejercicio1}
	when (5) {&Ejercicio5}
	when (6) {&Ejercicio6}
	when (7) {&Ejercicio7}
	when (8) {&Ejercicio8}
	when (9) {&Ejercicio9}
	when (10) {&Ejercicio10}
	when (11) {&Ejercicio11}
	when (12) {&Ejercicio12}
	when (13) {&Ejercicio13}
	when (14) {&Ejercicio14}
	when (15) {&Ejercicio15}
	when (16) {&Ejercicio16}
	when (17) {&Ejercicio17}
	when (18) {&Ejercicio18}
	when (19) {&Ejercicio19}

	default {print "Ingrese un numero de ejercicio valido"}
}