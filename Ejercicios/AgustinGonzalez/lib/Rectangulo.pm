
package Rectangulo;
use base qw(Figura);
use GD;


sub new
{
	
	my $this = shift;
	my $class= ref ($this) || $this;
	my ($x1,$y1,$x2,$y2,$x3,$y3,$x4,$y4,)=@_;
	my $self= new Figura();
	$self->{color} =  GD::Image->new()->colorAllocate(0,0,255); #color AZUL por defecto de los rectangulos
	$self->{x1}= $x1;
	$self->{y1}= $y1;
	$self->{x2}= $x2;
	$self->{y2}= $y2;
	$self->{x3}= $x3;
	$self->{y3}= $y3;
	$self->{x4}= $x4;
	$self->{y4}= $y4;

	#$self->{vertice1} = {x=>$x1, y=> $y1};
	#$self->{vertice2} = {x=>$x2, y=> $y2};
	#$self->{vertice3} = {x=>$x3, y=> $y3};##Quizas seria mejor guardarlos como $x1,$y1,$x2,$y2,$x3,$y3,$x4,$y4
	#$self->{vertice4} = {x=>$x4, y=> $y4};

	bless $self, "Rectangulo";
	return ($self);
}
sub puntos
{
	my $self=shift;
	my @puntos= (	
		$self->{x1},
		$self->{y1},
		$self->{x2},
		$self->{y2},
		$self->{x3},
		$self->{y3},
		$self->{x4},
		$self->{y4});
	return @puntos;
}

sub area
{
	my ($self)=@_;
	
	#my $base = Figura::distancia($self->{vertice1}{x},$self->{vertice1}{y},$self->{vertice2}{x},$self->{vertice2}{y});
	#my $altura = Figura::distancia($self->{vertice1}{x},$self->{vertice1}{y},$self->{vertice3}{x},$self->{vertice3}{y});
	my $ base = Figura::_distancia($self->{x1},$self->{y1},$self->{x2},$self->{y2});
	my $ altura = Figura::_distancia($self->{x1},$self->{y1},$self->{x3},$self->{y3});
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
	my $black =$img ->colorAllocate(0,0,0);
	my $blue = $img->colorAllocate(0,0,255); #Esto deberia ir en la creacion del objeto pero no pude hacerlo andar
	my ($x1,$y1,$x2,$y2);
	$x1=$self->{x1};
	$y1=$self->{y1};
	$x4=$self->{x4};
	$y4=$self->{y4};

	$img ->filledRectangle($self->{x1},$self->{y1},$self->{x4},$self->{y4},$blue);
	$img-> rectangle($self->{x1},$self->{y1},$self->{x4},$self->{y4},$black); ##Para darle un borde negro al rectangulo
	return $img;
}

1;