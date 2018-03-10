	#!/usr/bin/perl
	
	my $a = shift;
	if (!$a) { $a=0;}
	my $b = shift;
	if (!$b) { $b=0;}
	my $c = shift;
	if (!$c) { $c=0;}
	if (($a !~ m/^+|-\d+$/) || ($b !~ m/^+|-\d+$/) || ($c !~m/^+|-\d+$/)) {
         die "Ingrese solo numeros x parametros por favor\n";
    }
	if (($a==0) && (!$b)){
		die "Esta no es una funcion cuadratica\n";
	}	
	if (($a==0) && ($b)){
		die "Esta no es una funcion cuadratica, es lineal, y solo hay una raiz: ($c/$b)\n"
	}
	if ($a) {
		$cuad =($b**2)-(4*($a)*($c));
		if ($cuad<0){die "RAICES NO REALES"."\n";}
		else {
			$x1 = ((-$b) + sqrt($cuad))/(2*$a);
			$x2 = ((-$b) - sqrt($cuad))/(2*$a);
			print "Raices:x1 = $x1 x2 = $x2"."\n";
		}
	}	
	exit(0);
		

