#!/usr/bin/perl

my $nombre = shift;
chomp($nombre);
my %documentos =
(
	"lucas" => 29310468,
	"dai" => 33361536,
	"mama" => 11756338,
	"papa" =>8707401,
	"valen" =>35829449,
	"tin" => 33800030,
	"belen" => 31584449,
	"teto" => 37344710,
	"matias" => 30864138
);
##use Data::Dumper qw(Dumper);
##print Dumper \%documentos;
foreach my $key (sort keys %documentos)
{
	print "$key = $documentos{$key}\n";
}
sub comparator
{
	$a<=>$b;
}
foreach my $numeros (sort comparator values %documentos)
{
	print "$numeros\n";
}
if ($documentos{$nombre})
{
	print "El documento de $nombre es $documentos{$nombre}\n";
}
else 
{
print "No se encuentra ningun documento cargado con $nombre\n";
}
