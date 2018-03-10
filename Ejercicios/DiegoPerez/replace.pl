print "Ingrese el texto a analizar\n";
$cadena = <STDIN>;
chomp($cadena);
my @cadena = split(/\s+/, $cadena);
print "Ingrese separado por espacio el texto a reemplazar y su reemplazo\n presione enter y siga escribiendo patrones y su reemplazo\n";
print "Corte con <Ctrl + D>";

my % hash;

while (chomp($entrada=<STDIN>)){
	$entrada =~ m/(\w+)\s+(\w+)/;
	$hash{$1}=$2;
}

my $linea = join("|",keys %hash);
$cadena =~ s/($linea)/$hash{$1}/g;
print $cadena."\n";

