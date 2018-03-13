use GD::Simple;
 
package Figura;
use constant PI =3.14159;


sub new {
	my $class = shift;
	$class = ref $class if ref $class;
	my $self = bless {}, $class;
	$self;
}




package Rectangulo;
use base qw(Figura);
our $color = "blue";

sub new
{
	my $this = shift;
	my $class= ref ($this) || $this;
	my $self={};
	$self ->{vertice1} = [10,10];
	$self ->{vertice2} = [50,10];
	$self ->{vertice3} = [10,50];
	$self ->{vertice4} = [50,50];

	bless $self, $class;
	return ($self);
}

sub area
{
	my $base = @{$self{vertice4}}[0] - @{$self{vertice1}}[0];
	my $altura = @{$self{vertice4}}[1] - @{$self{vertice1}}[1];
	return $base * $altura;
}

package Triangulo;

use base qw(Figura);
our $color = "red";
sub new {
	my $class = shift;
	$class = ref $class if ref $class;
	my $self = {
		vertice1->[80,50],
		vertice2->[120,50],
		vertice3->[100,10],
		};
		bless $self $class;
	return ($self);
}

sub area
{
	my $base =  @{$self{vertice2}}[0] - @{$self{vertice1}}[0];
	my $altura = @{$self{vertice2}}[1] - @{$self{vertice3}}[1];
	return ($base * $altura)/2;
}


package Circulo;

use base qw(Figura);
our $color="yellow";

sub new {
	my $class = shift;
	$class = ref $class if ref $class;
	my $self = {
		centro = [30,120];
		punto = [50,120];
	}
	bless $self, $class;
	return ($self);
}

sub area 
{
	my $radio = @{$self{punto}}[0] - @{$self{centro}}[0];
	return PI*($radio **2);
}