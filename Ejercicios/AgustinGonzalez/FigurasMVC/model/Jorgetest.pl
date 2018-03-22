use lib "./";
use Rectangulos;


my $objetos = new Rectangulos();
my %params = ();
$objetos->get_all(%params);
my $img =  new  GD::Image(800,600);
my $white = $img->colorAllocate(255,255,255);#El primer color guardado se convierte en el fondo de a imagen
open (IMG,">","imagen.png");
while (my $rectangulo = $objetos->get_next)
{
	print ref($rectangulo)." ".$rectangulo->id.": ";
	print join("-",$rectangulo->puntos)."\n";
	#$rectangulo->draw($img);
}
print IMG $img->png;
close IMG;