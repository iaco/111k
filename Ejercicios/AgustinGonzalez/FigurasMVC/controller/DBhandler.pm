package DBhandler;
use lib "./";
use lib "./../model/";
use DB;
use Rectangulos;
use Triangulos;
use Circulos;
use Moose;


sub persistir
{
	my ($self,@figuras)=@_;

	foreach my $figura (@figuras)
	{
		$figura->insert;
	}
	return 1;
}

sub recuperar
{
	my ($self,$tipo)=@_;
	$tipo=lc($tipo);
	my $coleccion;
	if (($tipo eq "cuadrado")||($tipo eq "rectangulo"))
	{
		$coleccion= new Rectangulos();
	}
	elsif ($tipo eq "triangulo")
	{
		$coleccion= new Triangulos();
	}
	elsif ($tipo eq "circulo")
	{
		$coleccion= new Circulos();
	}
	$coleccion->get_all();
	return $coleccion;
}
1;