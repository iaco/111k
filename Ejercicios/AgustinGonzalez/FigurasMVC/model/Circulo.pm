package Circulo;

use base qw(Figura);
use GD;
use Punto;
require Figura;
use constant PI=>3.14159;

#has "centro","puntoexterior" =>(is =>"rw", isa=>"Punto");


sub new {
	my ($this,$puntocentro,$puntofuera) = @_;
	my $self = my Figura();
	$self->{color}= "Yellow";
	$self->{centro}	 = new Punto(x=>$puntocentro->x,y=>$puntocentro->y);
	$self->{radio} =  $puntocentro->distancia($puntofuera);
	bless $self, "Circulo";
	return ($self);
}

sub centro
{	##Si recibe parametros cambia el centro del circulo
	#al finalizar nos devuelve el centro del circulo(lo haya cambiado o no)
	my ($self,$nuevocentro) = @_;
	if (defined $nuevocentro)
	{
		print "ENTRO A CAMBIAR\n";
		$self->{centro}->set($nuevocentro->x,$nuevocentro->y);
	}

	return new Punto(x=>$self->{centro}->x,y=>$self->{centro}->y);
}
sub puntoexterior
{
	#Devuelve un punto exterior, para poder guardar los parametros en la BD y reconstruirlo
	my $self = shift;
	#Aca habria que hacer calculos a ver si se esta llendo fuera del lienzo al sumarle el radio a x, pero la idea es esa
	return new Punto(x=> $self->{centro}->x+$self->{radio},y=>$self->{centro}->y);
}
sub puntos
{
	my $self =shift;
	my @puntos = ($self->{centro}->puntos,$self->{punto}->puntos);
	return  @puntos;
}
sub area 
{
	my $self=shift;
	return PI * ($self->{radio} **2);
}

sub draw
{
	my ($self, $img)= @_;
	my $x=$self->{centro}->x;
	my $y=$self->{centro}->y;
	my $radio = $self->{radio};
	my $red = $img->colorAllocate(255,0,0);
	$img->filledArc($x,$y,$radio,$radio,0,360,$red);
	return $img;
}

1;