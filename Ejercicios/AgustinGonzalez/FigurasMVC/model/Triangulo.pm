package Triangulo;

#use base qw(Figura);
use Moose;
use GD;
use GD::Polyline;

extends "Figura","Jorge::DBEntity";


#has "vertice1"=>(is=>"bare",isa=>"Punto");
#has "vertice2"=>(is=>"bare",isa=>"Punto");
#has "vertice3"=>(is=>"bare",isa=>"Punto");
has "x1"=>(is=>"rw",isa=>"Num");
has "y1"=>(is=>"rw",isa=>"Num");
has "x2"=>(is=>"rw",isa=>"Num");
has "y2"=>(is=>"rw",isa=>"Num");
has "x3"=>(is=>"rw",isa=>"Num");
has "y3"=>(is=>"rw",isa=>"Num");


sub _fields
{
	my $table_name="t_triangulo";
	 my @fields = qw(
     id
     x1
     y1
     x2
     y2
     x3
     y3
 );

 my %fields = (
     id => { pk => 1, read_only => 1 },
 );

 return [ \@fields, \%fields, $table_name ];
}
#sub BUILD {#EL BUILD NO FUNCIONA MAS CON JORGE
#	#Inicializa los puntos creando puntos nuevos, evitando que queden referencias a los puntos fuera de la figura
#    my $self=shift;
#    $self->{vertice1}= new Punto(x=>$self->{vertice1}->x,y=> $self->{vertice1}->y);
#    $self->{vertice2}= new Punto(x=>$self->{vertice2}->x,y=> $self->{vertice2}->y);
#    $self->{vertice3}= new Punto(x=>$self->{vertice3}->x,y=> $self->{vertice3}->y);
#    my $lado =$self->{vertice1}->distancia($self->{vertice2});
#    if (($lado != $self->{vertice1}->distancia($self->{vertice3})) || ($lado != $self->{vertice2}->distancia($self->{vertice3})))
#    {
#        die "Los puntos no forman un triangulo Equilatero\n";#Deshabilitada porque es imposible ingresar un triangulo equilatero por consola
#    }
#}


sub puntos
{
	my $self = shift;
	return ($self->{x1},$self->{y1},$self->{x2},$self->{y2},$self->{x3},$self->{y3});
}

sub area
{
	#la altura de un triangulo equilatero es h= (lado)* (sqrt(3)/2)
	my $self =shift;
	my $base = $self->vertice1->distancia($self->vertice2);
	my $altura = (sqrt(3)/2)*$base;
	return ($base * $altura)/2;
}

sub draw
{
	my ($self,$img)= @_;
	my $yellow= $img->colorAllocate(255,255,0);
	my $poligono = new GD::Polygon;
	$poligono->addPt($self->vertice1->puntos);
	$poligono->addPt($self->vertice2->puntos);
	$poligono->addPt($self->vertice3->puntos);
	$img->filledPolygon($poligono,$yellow);

	return $img;
}

sub vertice1
{
	my $self=shift;
	if (!exists $self->{vertice1})
	{
		$self->{vertice1}= new Punto(x=>$self->{x1},y=>$self->{y1});
	}
	return new Punto(x=>$self->{vertice1}->x, y=>$self->{vertice1}->y);
}
sub vertice2
{
	my $self=shift;
	if (!exists $self->{vertice2})
	{
		$self->{vertice2}= new Punto(x=>$self->{x2},y=>$self->{y2});
	}
	return new Punto(x=>$self->{vertice2}->x, y=>$self->{vertice2}->y);
}
sub vertice3
{
	my $self=shift;
	if (!exists $self->{vertice3})
	{
		$self->{vertice3}= new Punto(x=>$self->{x3},y=>$self->{y3});
	}
	return new Punto(x=>$self->{vertice3}->x, y=>$self->{vertice3}->y);
}
1;