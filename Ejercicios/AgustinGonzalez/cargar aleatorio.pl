#!/usr/bin/perl 

$fichero= shift;
$name= shift;

my @nombres_varon = qw ( pablo ana jazmin valentina felicitas sara jhon beatriz jose camila marta juana diego martin agustin juan ignacio matias ezequiel guillermo carlos adrian);



print $#nombres_varon, "\n";
print $nombres_varon[$#nombres_varon],"\n";


open (FILEOUT,">".$fichero);

for (my $i=0; $i<100; $i++)
{
	my $rand = rand;
	my $indice = int $rand * ($#nombres_varon +1);
	print FILEOUT  $nombres_varon[$indice]."\n";
	

}
close FILEOUT;

open (FH_IN, "<".$fichero);

my $count=0;

while (my $line=<FH_IN>)
{
	chomp($line);
	print "linea= $line\n";
	if ($line eq $name)
	{
		$count++;
	}
	
}
close (FH_IN);
print "Se generaron $count $name\n";