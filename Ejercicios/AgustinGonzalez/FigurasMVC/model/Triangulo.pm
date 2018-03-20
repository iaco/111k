package Triangulo;

#use base qw(Figura);
use Moose;
use GD;
use GD::Polyline;
extends "Figura";


has "vertice1"=>(is=>"bare",isa=>"Punto");
has "vertice2"=>(is=>"bare",isa=>"Punto");
has "vertice3"=>(is=>"bare",isa=>"Punto");


sub BUILD {
	#Inicializa los puntos creando puntos nuevos, evitando que queden referencias a los puntos fuera de la figura
    my $self=shift;
    $self->{vertice1}= new Punto(x=>$self->{vertice1}->x,y=> $self->{vertice1}->y);
    $self->{vertice2}= new Punto(x=>$self->{vertice2}->x,y=> $self->{vertice2}->y);
    $self->{vertice3}= new Punto(x=>$self->{vertice3}->x,y=> $self->{vertice3}->y);
    my $lado =$self->{vertice1}->distancia($self->{vertice2});
    if (($lado != $self->{vertice1}->distancia($self->{vertice3})) || ($lado != $self->{vertice2}->distancia($self->{vertice3})))
    {
        die "Los puntos no forman un triangulo Equilatero\n";#Deshabilitada porque es imposible ingresar un triangulo equilatero por consola
    }
}


sub puntos
{
	my $self = shift;
	my @puntos = (
			new Punto ( x=> $self->{vertice1}->x, y=> $self->{vertice1}->y),
			new Punto ( x=> $self->{vertice2}->x, y=> $self->{vertice2}->y),
			new Punto ( x=> $self->{vertice3}->x, y=> $self->{vertice3}->y)
		);
	return @puntos;
}

sub area
{
	#la altura de un triangulo equilatero es h= (lado)* (sqrt(3)/2)
	my $self =shift;
	my $base = $self->{vertice1}->distancia($self->{vertice2});
	my $altura = (sqrt(3)/2)*$base;
	return ($base * $altura)/2;
}

sub draw
{
	my ($self,$img)= @_;
	my $yellow= $img->colorAllocate(255,255,0);
	my $poligono = new GD::Polygon;
	$poligono->addPt($self->{vertice1}->puntos);
	$poligono->addPt($self->{vertice2}->puntos);
	$poligono->addPt($self->{vertice3}->puntos);
	$img->filledPolygon($poligono,$yellow);

	return $img;
}
1;