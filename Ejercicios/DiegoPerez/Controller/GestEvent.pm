#!/usr/bin/perl
package GestEvent;
use lib "./";
use lib "./../Model/";
use DB;
use Figura;
use RectanguloCollection;
use TrianguloCollection;
use CirculoCollection;
use CuadradoCollection;
use Moose;


has "collection" =>(is=>"rw", isa=>"ArrayRef[Figura]", default=> sub {[]},
					handles=>{push=>"push",});
#La collecion esta es para las figuras que estan en memoria dinamica y no han sido persistidas aun


sub add_cuadrado
{
	my ($self,$x1,$y1,$x2,$y2,$x3,$y3,$x4,$y4)=@_;
	my $nuevo_cuadrado = new Cuadrado (x1=>$x1, y1=>$y1, x2=>$x2, y2=>$y2,x3=>$x3, y3=>$y3,x4=>$x4, y4=>$y4);
	my $area = $nuevo_cuadrado->area;
	print "El Area es: $area\n";
	$self->push($nuevo_cuadrado);
	my $img =  new  GD::Image(800,600);
	my $white = $img->colorAllocate(255,255,255);
	$nuevo_cuadrado->draw($img);
	
	return $nuevo_cuadrado;

}
sub add_rectangulo
{
	my ($self,$x1,$y1,$x2,$y2,$x3,$y3,$x4,$y4)=@_;
	my $nuevo_rectangulo = new Rectangulo (x1=>$x1, y1=>$y1, x2=>$x2, y2=>$y2,x3=>$x3, y3=>$y3,x4=>$x4, y4=>$y4);
    my $area = $nuevo_rectangulo->area;
	print "El Area es: $area\n";
	$self->push($nuevo_rectangulo);
	my $img =  new  GD::Image(800,600);
	my $white = $img->colorAllocate(255,255,255);
	$nuevo_rectangulo->draw($img);
	open (my $grafico, ">"."grafico.png");
	print $grafico $img->png;
	close $grafico;
	return $nuevo_rectangulo;
}
sub add_triangulo
{
	my ($self,$x1,$y1,$x2,$y2,$x3,$y3)=@_;
	my $nuevo_triangulo = new Triangulo (x1=>$x1, y1=>$y1, x2=>$x2, y2=>$y2,x3=>$x3, y3=>$y3);
	my $area = $nuevo_triangulo->area;
	print "El Area es: $area\n";
	$self->push($nuevo_triangulo);
	my $img =  new  GD::Image(800,600);
	my $white = $img->colorAllocate(255,255,255);
	$nuevo_triangulo->draw($img);
	open (my $grafico, ">"."grafico.png");
	print $grafico $img->png;
	close $grafico;
	return $nuevo_triangulo;
}
sub add_circulo
{
	my ($self,$x1,$y1,$x2,$y2)=@_;
	my $nuevo_circulo = new Circulo (x1=>$x1, y1=>$y1, x2=>$x2, y2=>$y2);
	my $area = $nuevo_circulo->area;
	print "El Area es: $area\n";
	$self->push($nuevo_circulo);
	my $img =  new  GD::Image(800,600);
	my $white = $img->colorAllocate(255,255,255);
	$nuevo_circulo->draw($img);
	open (my $grafico, ">"."grafico.png");
	print $grafico $img->png;
	close $grafico;
	return $nuevo_circulo;
}
sub persistir
{
	my $self=shift;

	foreach my $figura (@{$self->{collection}})
	{
		$figura->insert;
	}
	$self->{collection}= [];
	return 1;
}

sub listar
{
	my ($self,$tipo)=@_;
	if ($tipo eq "cuadrado") {
	    my $coleccion= new CuadradoCollection();
		$coleccion->get_all();
		while (my $cuadrado = $coleccion->get_next){
            print "Cuadrado ".$cuadrado->id_cuad.": Vertice1: (".$cuadrado->x1.",".$cuadrado->{y1}.")\n";
            print "Vertice2: (".$cuadrado->x2.",".$cuadrado->y2.")\n";
            print "Vertice3: (".$cuadrado->x3.",".$cuadrado->y3.")\n";
            print "Vertice4: (".$cuadrado->x4.",".$cuadrado->y4.")\n";
        }
        $coleccion->get_all();
	
	}
	elsif ($tipo eq "rectangulo"){
		my $coleccion= new RectanguloCollection();
		$coleccion->get_all();
		while (my $rectangulo = $coleccion->get_next){
            print "Rectangulo ".$rectangulo->idRectangulo.": Vertice1: (".$rectangulo->x1.",".$rectangulo->{y1}.")\n";
            print "Vertice2: (".$rectangulo->x2.",".$rectangulo->y2.")\n";
            print "Vertice3: (".$rectangulo->x3.",".$rectangulo->y3.")\n";
            print "Vertice4: (".$rectangulo->x4.",".$rectangulo->y4.")\n";

        }
        $coleccion->get_all();
	
	}
	elsif ($tipo eq "triangulo"){
		my $coleccion= new TrianguloCollection();
		$coleccion->get_all();
		while (my $triangulo = $coleccion->get_next){
            print "Triangulo ".$triangulo->id_tria.": Vertice1: (".$triangulo->x1.",".$triangulo->{y1}.")\n";
            print "Vertice2: (".$triangulo->x2.",".$triangulo->y2.")\n";
            print "Vertice3: (".$triangulo->x3.",".$triangulo->y3.")\n";
        }
        $coleccion->get_all();
	}
	elsif ($tipo eq "circulo"){
		my $coleccion= new CirculoCollection();
		$coleccion->get_all();
		while (my $circulo = $coleccion->get_next){
            print "Circulo ".$circulo->id_circ.": Centro: (".$circulo->x1.",".$circulo->{y1}.")\n";
            print "Punto adyacente: (".$circulo->x2.",".$circulo->y2.")\n";
        }
        $coleccion->get_all();
	}
}

no Moose;
1;