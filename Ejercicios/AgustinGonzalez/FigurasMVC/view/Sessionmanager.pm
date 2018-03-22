package Sessionmanager;

use lib "./../controller";
use lib "./../model/";
use DB;
use Rectangulos;
use Triangulos;
use Circulos;
use Figura;
use Moose;
use DBhandler;


has "db" =>(is=>"ro", isa=>"DBhandler", default=> sub {new DBhandler});
has "coleccion" =>(is=>"ro", isa=>"ArrayRef[Figura]", default=> sub {[]});

#La collecion esta es para las figuras que estan en memoria dinamica y no han sido persistidas aun


sub dibujar_todas
{
	my ($self,$path)=@_;
	my $img =  new  GD::Image(800,600);
	my $white = $img->colorAllocate(255,255,255);#El primer color guardado se convierte en el fondo de a imagen
	foreach my $figura (@{$self->{coleccion}})
	{
		$figura->draw($img);
	}
	open (my $fh_img, ">".$path);
	print $fh_img $img->png;
	close $fh_img;
	return 1;

}

sub persistir
{
	my $self=shift;
	$self->{db}->persistir(@{$self->{coleccion}});
	return 1;
}
sub reset
{
	my $self=shift;
	$self->{coleccion} =[];
}

sub add_rectangulo
{
	my ($self,$x1,$y1,$x2,$y2,$x3,$y3,$x4,$y4)=@_;
	my $nuevo_rectangulo = new Rectangulo (x1=>$x1, y1=>$y1, x2=>$x2, y2=>$y2,x3=>$x3, y3=>$y3,x4=>$x4, y4=>$y4);
	push @{$self->coleccion}, $nuevo_rectangulo;
	return $nuevo_rectangulo;
}
sub add_triangulo
{
	my ($self,$x1,$y1,$x2,$y2,$x3,$y3)=@_;
	my $nuevo = new Triangulo (x1=>$x1, y1=>$y1, x2=>$x2, y2=>$y2,x3=>$x3, y3=>$y3);
	push @{$self->coleccion}, $nuevo;
	return $nuevo;
}
sub add_circulo
{
	my ($self,$x1,$y1,$x2,$y2)=@_;
	my $nuevo = new Circulo (x1=>$x1, y1=>$y1, x2=>$x2, y2=>$y2);
	push @{$self->coleccion}, $nuevo;	
	return $nuevo;
}
sub recuperar
{
	#trae las figuras de un tipo guardadas en la base de datos y las agrega en la coleccion de la sesion
	my ($self,$tipo)=@_;
	my $objetos_recuperados= $self->{db}->recuperar($tipo);
	while (my $figura = $objetos_recuperados->get_next)
	{
		push @{$self->coleccion}, $figura;
	}
	
}

sub listar
{	#Lista las figuras activas de la sesion
	my $self=shift;
	print "listando las figuras activas\n";
	foreach my $figura (@{$self->{coleccion}})
	{
		print ref($figura)." ".$figura->id.": ". join("-",$figura->puntos)."\n";
	}
}




1;