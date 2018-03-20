
package Rectangulo;
#use base qw(Figura);
use GD;
use Moose;
use Punto;

extends 'Figura',"Jorge::DBEntity";

#has "vertice1"=>(is=>"bare",isa=>"Punto");
#has "vertice2"=>(is=>"bare",isa=>"Punto");
#has "vertice3"=>(is=>"bare",isa=>"Punto");
#has "vertice4"=>(is=>"bare",isa=>"Punto");
has "x1"=>(is=>"rw",isa=>"Num",default=>0);
has "y1"=>(is=>"rw",isa=>"Num",default=>0);
has "x2"=>(is=>"rw",isa=>"Num",default=>0);
has "y2"=>(is=>"rw",isa=>"Num",default=>0);
has "x3"=>(is=>"rw",isa=>"Num",default=>0);
has "y3"=>(is=>"rw",isa=>"Num",default=>0);
has "x4"=>(is=>"rw",isa=>"Num",default=>0);
has "y4"=>(is=>"rw",isa=>"Num",default=>0);



sub _fields
{
	my $table_name="t_cuadrado";
	 my @fields = qw(
     id_cuadrado
     x1
     y1
     x2
     y2
     x3
     y3
     x4
     y4
 );

 my %fields = (
     id_cuadrado => { pk => 1, read_only => 1 },
 );

 return [ \@fields, \%fields, $table_name ];
}

#sub BUILD {
#    #Inicializa los puntos creando puntos nuevos, evitando que queden referencias a los puntos fuera de la figura
#    my $self=shift;
#    $self->vertice1= new Punto(x=>$self->vertice1->x,y=> $self->vertice1->y);
#    $self->vertice2= new Punto(x=>$self->vertice2->x,y=> $self->vertice2->y);
#    $self->vertice3= new Punto(x=>$self->vertice3->x,y=> $self->vertice3->y);
#    $self->{vertice4}= new Punto(x=>$self->{vertice4}->x,y=> $self->{vertice4}->y);
#    if (($self->vertice1->distancia($self->vertice2) != $self->vertice3->distancia($self->{vertice4})) ||
#        ($self->vertice1->distancia($self->vertice3) != $self->vertice2->distancia($self->{vertice4})))
#    {
#        die "Los puntos no forman un cuadrado|rectangulo\n";
#    }
#}

sub puntos
{
    #Otorga los puntos que componen el rectangulo para poder persistirlo
	my $self=shift;
	my @puntos= (
		new Punto(x=>$self->vertice1->x, y=> $self->vertice1->y),
		new Punto(x=>$self->vertice2->x, y=> $self->vertice2->y),
		new Punto(x=>$self->vertice3->x, y=> $self->vertice3->y),
		new Punto(x=>$self->vertice4->x, y=> $self->vertice4->y)
				);
	return @puntos;
}

sub area
{
	my $self=shift;
	my $ base = $self->vertice1->distancia($self->vertice2);
	my $ altura = $self->vertice1->distancia($self->vertice3);
	return $base * $altura;

}

sub draw
{
	my ($self,$img)= @_;
	my $black =$img ->colorAllocate(0,0,0);
	my $blue = $img->colorAllocate(0,0,255); #Esto deberia ir en la creacion del objeto pero no pude hacerlo andar


	$img ->filledRectangle($self->vertice1->puntos(), $self->vertice4->puntos(),$blue);
	#$img-> rectangle($self->{x1},$self->{y1},$self->{x4},$self->{y4},$black); ##Para darle un borde negro al rectangulo
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
sub vertice4
{
	my $self=shift;
	if (!exists $self->{vertice4})
	{
		$self->{vertice4}= new Punto(x=>$self->{x4},y=>$self->{y4});
	}
	return new Punto(x=>$self->{vertice4}->x, y=>$self->{vertice4}->y);
}
no Moose;
1;