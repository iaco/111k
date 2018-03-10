#!/usr/bin/perl

sub primo {
	 $x  = @_[0];
	 $pri  = 1;
	 $i  = 2;
	 $j;
	while (($i < $x) && $pri ) {
		$j = int($x / $i);
		$j = $x - ($j * $i);
		if ( $j == 0 ) {
			$pri = 0;
		} else {
			$i++;
		}
	}
	return $pri;
}

# programa principal
print "Ingrese un numero entero entre 2..1000000, se mostraran todos los numeros primos menores a el:\n";
$valor = <STDIN>;
chomp($valor);

while (($valor<2) || ($valor>1000000) || ($valor =~m/\D/)){
	print "Ingrese un valor dentro del rango:\n";
	$valor = <STDIN>;
	chomp($valor);
}

@arreglo=(2..$valor);
foreach $num (@arreglo){
	if (primo($num)) {
		print "$num";
		print " ";
	}
}	
print "\n";