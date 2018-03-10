#!/usr/bin/perl

print "Ingrese la cadena a parsear\n";
chomp(my $cadena = <STDIN>);
my $copia=$cadena;
print "Ingrese los patrones a reemplazar de la forma:\npatron reemplazo         presione control+D para finalizar\n";
my %reemplazos;

while ((my $linea=<STDIN>))
{
	chomp($linea);
	$linea =~ m/(\w+)\s+(\w+)/;
	$reemplazos{$1}=$2;

}

for $clave (keys %reemplazos)
{
	$cadena=~ s/$clave/$reemplazos{$clave}/g;
}
my $claves = join ("|", keys %reemplazos);
$copia =~ s/($claves)/$reemplazos{$1}/go;
print "cadena:$cadena\n";
print "copia=$copia\n";


