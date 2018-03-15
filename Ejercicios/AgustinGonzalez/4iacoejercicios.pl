#!/usr/bin/perl

use Lingua::EN::Words2Nums;

my $path = shift;

my $fh_entrada;
open($fh_entrada,"<",$path);

my %palabras= {};
while (chomp (my $line = <$fh_entrada>))
{
	my $numero = words2nums($line);
	$palabras{$numero} =$line;
}


foreach	my $key (sort compareNums keys %palabras)
{
	print "$palabras{$key}\n";
}
close ($fh_entrada);
exit;





sub compareNums
{
	my ($a,$b) = @_;
	return ($b<=>$a);#Al reves para que ordene descendientemente
}