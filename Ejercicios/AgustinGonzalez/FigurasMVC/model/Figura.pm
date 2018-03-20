package Figura;

use GD;
use GD::Simple;
use Moose;

use constant PI => 3.14159;

has "color" =>(is=>"rw",isa=>"Str", default=>"black");


sub area
{
	print "ENTRO A Area Figura\n";
}

sub draw
{}


no Moose;
1;







