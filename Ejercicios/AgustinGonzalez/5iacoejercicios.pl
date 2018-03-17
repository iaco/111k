#!/usr/bin/perl
use v5.14;


my %hash;
my $path = shift;

open (FH, "<".$path)||die "no existe el archivo";

my $primeralinea = <FH>;
chomp ($primeralinea);

my $origen;
my $destino;

($origen,$destino) = &separarcamino($primeralinea);

print "Origen:$origen\nDestino:$destino\n";


while (my $line=<FH>)##Cargar el grafo de nodos
{
	chomp($line);
	($a,$b)= &separarcamino($line);
	if (!$hash{$a})
	{
		$hash{$a => []};
	}
	push (@{$hash{$a}},$b);
}



print &caminocorto($origen,$destino)."\n";



sub contiene
{
	my $valor = shift;
	my @arreglo = @_;

	my $encontrado =0;
	foreach my $valorcontenido (@arreglo)
	{
		if ($valorcontenido eq $valor)
		{
			$encontrado=1;
			last;
		}
	}
	return $encontrado;
}

{
	my @visitados;

	sub caminocorto
	{
		my $origen=shift;
		my $destino=shift;
		
		state $mejor=999999;
		state $encontrado=0;

		if (!(&contiene($origen,@visitados)))
		{
			push (@visitados,$origen);
			if (&contiene($destino,@{$hash{$origen}}))
			{
				$encontrado=1;
				return (($#visitados +1));
			}
			else
			{
				foreach my $alcanzable (@{$hash{$origen}})
				{
					my $caminoprueba = &caminocorto($alcanzable,$destino);
					if ($caminoprueba == -1)
					{
						next;
					}
					else
					{
						if ($caminoprueba < $mejor)
						{
							$mejor=$caminoprueba;
						}
					}
				}
			}
			pop(@visitados);
		}
		if (!$encontrado)
		{
			return -1;
		}
		else 
		{
			return $mejor;
		}
	}
}
sub separarcamino
{
	my $linea =shift;
	$linea =~ m/(\S+)\s+(\S+)/;
	#print "Separando linea:$linea en camino $1->$2\n";
	return ($1,$2);
}

