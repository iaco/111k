package Circulo;

use base qw(Figura);
use GD;
require Figura;


sub new {
	my $this = shift;
	my ($xcentro,$ycentro,$xpunto,$ypunto) = @_;
	my $class = ref ($this)  || $this;
	$class = ref $class if ref $class;
	my $self = my Figura();
	$self->{color}= "Yellow";
	$self->{centro}	 = {x=>$xcentro,y=>$ycentro};
	$self->{radio} =  &Figura::_distancia ($xcentro,$ycentro,$xpunto,$ypunto);
	bless $self, $class;
	return ($self);
}

sub centro
{	##Si recibe parametros cambia el centro del circulo
	#al finalizar nos devuelve el centro del circulo(lo haya cambiado o no)
	my $self = shift;
	my @params = @_;
	if (@params)
	{
		print "ENTRO A CAMBIAR\n";
		$self->{centro}{x}= $params[0];
		$self->{centro}{y}= $params[1];
	}
	my @centro = ($self->{centro}{x},$self->{centro}{y});
	return @centro;
}
sub punto
{
	#Devuelve un punto exterior, para poder guardar los parametros en la BD y reconstruirlo
	my $self = $_[0];
	my @punto = (${$self->{centro}}{x} +$self->{radio}, $self->{centro}{y} + 0);
	return @punto;
}
sub puntos
{
	my $self =$_[0];
	my @puntos = ($self->centro,$self->punto);
	return  @puntos;
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
	$img->filledArc($x,$y,$radio,$radio,0,360,$red);
	#$img->fill($x,$y,$red);

	return $img;
}

1;