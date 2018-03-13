#!/usr/bin/perl
use v5.14;

print "Ingrese un numero entre 2..1000000 y le listare todos los primos menores que el\n";
my $limite = <STDIN>;
chomp($limite);
while (($limite<2)||($limite>1000000)|| ($limite=~ m/\D/))
{
	print "Ingrese un valor validos por favor\n";
	$limite = <STDIN>;
	chomp($limite);
}
my @primos;
push (@primos,2);

for (my $numero=2; $numero<= $limite;$numero++)
{
	my $esdivisible=0;
	for (my $i = 0;((!$esdivisible) &&($i <= $#primos)); $i++) {
		#print "indice: $i, cant: $#primos\n";
		if (!$primos[$i])
		{
			next;
		}
		#print "Probando si $numero es divisible por $primos[$i]\n";

		if ($numero % $primos[$i]  eq 0)
		{
			$esdivisible=1;
			last;
		}
	}
	if (!$esdivisible)
	{
		push(@primos,$numero);
	}
}

print "Listando los numeros primos: \n";
print join(" ",@primos)."\n";