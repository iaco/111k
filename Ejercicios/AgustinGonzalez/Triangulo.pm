package Triangulo;

use base qw(Figura);
use GD;
use GD::Polyline;

sub es_equilatero
{
	my ($x1,$y1,$x2,$y2,$x3,$y3)=@_;
	my $lado = Figura::_distancia($x1,$y1,$x2,$y2);
	my $lado2=  Figura::_distancia($x1,$y1,$x3,$y3);
	my $lado3 = Figura::_distancia($x2,$y2,$x3,$y3);
	if (($lado !=$lado2)|| ($lado!= $lado3))
	{
		print "Lado1:$lado\nLado2:$lado2\nLado3:$lado3\n";
		return 0;
	}
	else 
	{
		return 1;
	}
}

sub new {
	my $this = shift;
	my $class= ref ($this) || $this;
	my ($x1,$y1,$x2,$y2,$x3,$y3) = @_;#Los 3 puntos de los vertices del triangulo
	#if (!&es_equilatero($x1,$y1,$x2,$y2,$x3,$y3))
	#{
	#	die "Los vertices no forman un triangulo equilatero";
	#}
	#LO comento porque no funciona por los redondeos
	my $self = new Figura();
	$self->{color} = "red";#Color por defecto de los triangulos
	$self->{vertice1} = {x=>$x1, y=> $y1};
	$self->{vertice2} = {x=>$x2, y=> $y2};
	$self->{vertice3} = {x=>$x3, y=> $y3};
	$self->{vertice4} = {x=>$x4, y=> $y4};
	bless $self, "Triangulo";
	return ($self);
}

sub puntos
{
	my $self = $_[0];
	my @puntos = (
			$self->{vertice1}{x},
			$self->{vertice1}{y},
			$self->{vertice2}{x},
			$self->{vertice2}{y},
			$self->{vertice3}{x},
			$self->{vertice3}{y}
		);
	return @puntos;
}

sub area
{
	#la altura de un triangulo equilatero es h= (lado)* (sqrt(3)/2)
	my ($self)=@_;
	my $x1 = %{$self->{vertice1}}{x};
	my $y1 = %{$self->{vertice1}}{y};
	my $x2 = %{$self->{vertice2}}{x};
	my $y2 = %{$self->{vertice2}}{y};
	my $x3 = %{$self->{vertice3}}{x};
	my $y3 = %{$self->{vertice3}}{y};

	my $base = Figura::_distancia($x1,$y1,$x2,$y2);
	my $altura = (sqrt(3)/2)*$base;
	return ($base * $altura)/2;
}

sub draw
{
	my ($self)= $_[0];
	my $img = $_[1];
	my $yellow= $img->colorAllocate(255,255,0);
	my $poligono = new GD::Polygon;
	my $x1 = %{$self->{vertice1}}{x};
	my $y1 = %{$self->{vertice1}}{y};
	my $x2 = %{$self->{vertice2}}{x};
	my $y2 = %{$self->{vertice2}}{y};
	my $x3 = %{$self->{vertice3}}{x};
	my $y3 = %{$self->{vertice3}}{y};
	$poligono->addPt($x1,$y1);
	$poligono->addPt($x2,$y2);
	$poligono->addPt($x3,$y3);
	$img->filledPolygon($poligono,$yellow);

	return $img;
}
1;