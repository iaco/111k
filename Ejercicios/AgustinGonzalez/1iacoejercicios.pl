#!/usr/bin/perl


my ($a,$b,$c);
$a =shift;
if (!$a)
{
	$a=0;
}

my $b = shift;
if (!$b)
{
	$b=0;
}
my $c = shift;
if (!$c)
{
	$c=0;
}

if ( ($a!~ m/^+|-\d+$/)|| ($b !~ m/^+|-\d+$/) || ($c!~ m/^+|-\d+$/)|| (!$a && !$b))
{

	die "Ingrese  numeros para calcular una ecuacion\n";
}

print "A: $a, B:$b, C:$c\n";
if (!$c && !$b)
{
	print "Raices iguales x1,x2=0\n";
	exit;
}
my $discr = $b**2 - 4*$a*$c;

if ($discr<0)
{
	die "ERROR RAICES NO REALES\n";
}
else 
{
	$discr = sqrt($discr);
	if ($a!=0)
	{
		my $x1 = (-$b + $discr)/2*$a;
		my $x2 = (-$b - $discr)/2*$a;
		print "Raices: x1=$x1 , x2=$x2\n";
	}
	else
	{
		$x1 =$x2 = (-$c/$b);
		print "Raiz unica x1= $x1\n";
	}
	
	
}
exit(0);