package Circulo;

#use base qw(Figura);
use GD;
use Punto;
use Moose;
require Figura;
use constant PI=>3.14159;
extends "Figura";
extends "Jorge::DBEntity";

has "x1"=>(is=>"rw",isa=>"Num");
has "y1"=>(is=>"rw",isa=>"Num");
has "x2"=>(is=>"rw",isa=>"Num");
has "y2"=>(is=>"rw",isa=>"Num");
#has "centro" =>(is =>"ro", isa=>"Punto");
#has "puntoexterior" => (is =>"ro", isa=>"Punto");



sub BUILD
{
	#Copia los puntos recibidos, asi no se guarda una referencia que luego puede comprometer la integridad
	my $self=shift;
	$self->{centro}= new Punto(x=>$self->{x1},y=>$self->{y1});
	$self->{puntoexterior}= new Punto(x=>$self->{x2},y=>$self->{y2});
	#Quizas aca podria hacer el calculo del radio, y guardarlo, de manera de solo hacerlo una vez
}
sub radio
{
	my $self=shift;
	return $self->centro->distancia($self->puntoexterior);
}
sub centro
 {	#Solamente devuelve el centro, no permite cambiarlo
  	my $self=shift;
  	if (!exists $self->{centro})
  	{
  		$self->{centro}= new Punto(x=>$self->{x1},y=>$self->{y1});
  	}

  	return new Punto(x=>$self->{centro}->x,y=>$self->{centro}->y);
  	#Devuelvo una copia para no comprometer la integridad del circulo
  }
sub puntoexterior
 {
 	#Solamente devuelve un punto exterior, no permite cambiarlo
  	my $self = shift;
  	if (!exists $self->{puntoexterior})
  	{
  		$self->{puntoexterior}= new Punto(x=>$self->{x2},y=>$self->{y2});
  	}
  	return new Punto(x=> $self->{puntoexterior}->x(),y=>$self->{puntoexterior}->y());
 }
sub puntos
{
	#Devuelve los puntos para poder persistirlo y volver a construirlo
	my $self =shift;
	my @puntos = ($self->centro->puntos,$self->punto->puntos);
	return  @puntos;
}
sub area 
{
	my $self=shift;
	return PI * ($self->radio() **2);
}

sub draw
{
	my ($self, $img)= @_;
	my ($x,$y)=  $self->centro->puntos;
	my $radio = $self->radio();
	my $red = $img->colorAllocate(255,0,0);
	$img->filledArc($x,$y,$radio,$radio,0,360,$red);
	return $img;
}

 sub _fields
 {
 	my $table_name="t_circulo";
 	 my @fields = qw(
         id_circulo
         x1
         y1
         x2
         y2
     );

     my %fields = (
         id_circulo => { pk => 1, read_only => 1 },
     );

     return [ \@fields, \%fields, $table_name ];
}
1;