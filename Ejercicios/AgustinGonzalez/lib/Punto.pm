package Punto;


use Moose;

has "x" =>(is =>"rw", isa=>"Num", default=>0, reader=>"get_x");
has "y" =>(is =>'rw', isa=>"Num", default=>0);


sub distancia #Distancia a otro punto
{
	my ($self,$other)=@_;
	my $difx = $self->x() - $other->x();
	my $dify= $self->y() - $other->y();
	$difx= $difx **2;
	$dify=$dify **2;
	return sqrt ($difx+$dify);

}

sub set
{
	my ($self,$x,$y) =@_;
	$self->{x}=$x;
	$self->{y}=$y;
}
sub puntos
{
	my $self=shift;
	return ($self->{x},$self->{y});
}
1;