use Lingua::EN::Words2Nums;

sub ascend_num{
	$a <=> $b;
}
open(IN,"number.txt") || die "El archivo no se puede abrir";
my $clave =0;
my %hash;
while (<IN>){
	$linea=$_;
	chomp($linea);
	$clave = words2nums($linea);
	$hash{$clave} = $linea;

}
close(IN);
foreach my $clave (sort ascend_num keys %hash){
	print "$clave => $hash{$clave}"."\n";
}