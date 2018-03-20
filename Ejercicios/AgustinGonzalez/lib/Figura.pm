package Figura;

use GD;
use GD::Simple;

use constant PI => 3.14159;



sub new {
	my $self= {};
	$self->{color} =black; ##Color por defecto
	bless $self, "Figura";
	return $self;
}
sub area
{}

sub draw
{}

sub _distancia
{##dado dos puntos devuelve su distancia
	my ($x1,$y1,$x2,$y2) =@_;

	my $difX = $x2 - $x1;
	my $difY = $y2 - $y1;

	$difX = $difX**2;
	$difY = $difY**2;
	return sqrt ($difX + $difY);
}

sub _distancia_a_recta
{
	#Distancia entre la recta dada por los primeros dos puntos y un tercer punto
	my ($x1,$y1,$x2,$y2,$x3,$y3)=@_;
	#Resolvemos la recta (x1,y1)->(x2,y2) en la forma y=ax+b
	my $a = ($y1 -$y2)/($x1-$x2);#pendiente
	my $b = $y1 - ($x1*$a);
	my $numerador = ($a *$x3) - ($y3 + $b);
	if ($numerador <0)
	{
		$numerador= -$numerador;#aplico modulo
	}
	my $denominador = sqrt (($a**2)+1);
	return ($numerador/$denominador);
}

1;







