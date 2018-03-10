
use GD;
use GD::Simple;
 
package Figura;

use constant PI => 3.14159;

sub distancia
{##dado dos puntos devuelve su distancia
	my ($x1,$y1,$x2,$y2) =@_;

	my $difX = $x2 - $x1;
	my $difY = $y2 - $y1;

	$difX = $difX**2;
	$difY = $difY**2;
	return sqrt ($difX + $difY);
}

sub distancia_a_recta
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

sub new {
	my $class = shift;
	$class = ref $class if ref $class;
	my $self= {};
	$self->{color} =black; ##Color por defecto
	bless $self, $class;
	return $self;
}
sub area
{}

sub draw
{}

1;

package Rectangulo;
use base qw(Figura);


sub new
{
	my $this = shift;
	my $class= ref ($this) || $this;
	my ($x1,$y1,$x2,$y2,$x3,$y3,$x4,$y4,)=@_;
	my $self= new Figura();
	$self->{color} =  GD::Image->new()->colorAllocate(0,0,255); #color AZUL por defecto de los rectangulos
	$self->{vertice1} = {x=>$x1, y=> $y1};
	$self->{vertice2} = {x=>$x2, y=> $y2};
	$self->{vertice3} = {x=>$x3, y=> $y3};##Quizas seria mejor guardarlos como $x1,$y1,$x2,$y2,$x3,$y3,$x4,$y4
	$self->{vertice4} = {x=>$x4, y=> $y4};

	bless $self, "Rectangulo";
	return ($self);
}

sub area
{
	my ($self)=@_;
	
	my $base = %{$self->{vertice4}}{x} - %{$self->{vertice1}}{x};
	my $altura = %{$self->{vertice4}}{y} - %{$self->{vertice1}}{y};
	return $base * $altura;
}

sub draw
{
	my ($self)=$_[0];
	my $img = $_[1];
	#my $path = "dibujo.png";
	#open (IMG, ">".$path);
	#my $img = GD::Simple->new (800,600);
	#$img ->bgcolor($self->{color});
	#$img -> fgcolor("black");
	my $blue = $img->colorAllocate(0,0,255); #Esto deberia ir en la creacion del objeto pero no pude hacerlo andar
	my ($x1,$y1,$x2,$y2);
	$x1=${$self->{vertice1}}{x};
	$y1=${$self->{vertice1}}{y};
	$x4=${$self->{vertice4}}{x};
	$y4=${$self->{vertice4}}{y};
	$img ->rectangle($x1,$y1,$x4,$y4,$blue);
	my $xcentro = ($x1+$x4)/2;
	my $ycentro = ($y1+$y4)/2;
	$img->fill($xcentro,$ycentro, $blue);
	return $img;
}

1;
package Triangulo;

use base qw(Figura);
use GD::Polyline;

sub es_equilatero
{
	my ($x1,$y1,$x2,$y2,$x3,$y3)=@_;
	my $lado = Figura::distancia($x1,$y1,$x2,$y2);
	if (($lado != Figura::distancia($x1,$y1,$x3,$y3))|| ($lado!= Figura::distancia($x2,$y2,$x3,$y3)))
	{
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

	my $base = Figura::distancia($x1,$y1,$x2,$y2);
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

package Circulo;

use base qw(Figura);
require Figura;


sub new {
	my $this = shift;
	my ($xcentro,$ycentro,$xpunto,$ypunto) = @_;
	my $class = ref ($this)  || $this;
	$class = ref $class if ref $class;
	my $self = my Figura();
	$self->{color}= "Yellow";
	$self->{centro}	 = {x=>$xcentro,y=>$ycentro};
	$self->{radio} =  &Figura::distancia ($xcentro,$ycentro,$xpunto,$ypunto); 
	bless $self, $class;
	return ($self);
}

sub area 
{
	my ($self)=@_;
	return Figura::PI * ($self->{radio} **2);
}

sub draw
{
	my ($self)= $_[0];
	my $img = $_[1];
	$x=${$self->{centro}}{x};
	$y=${$self->{centro}}{y};
	$radio = $self->{radio};
	my $red = $img->colorAllocate(255,0,0);
	$img->arc($x,$y,$radio,$radio,0,360,$red);
	$img->fill($x,$y,$red);

	return $img;
}

1;



