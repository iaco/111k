#!/usr/bin/perl

package DB;
use DBI;
my $fh_config;
open ($fh_config,"dbconfig");
my $line = <$fh_config>;
chomp($line);
$line=~ m/^driver:(.+)\|database:(.+)\|ipserver:(.+)\|user:(.+)\|pass:(.+)\|/;
close($fh_config);
my ($driver,$database,$server,$user,$pass)=($1,$2,$3,$4,$5);

my $singleton;

sub new
{
	$singleton ||= bless {},"DB";
}

sub connect
{
	my $self = shift;
	if (exists $self->{dbh})
	{
		return $self->{dbh};
	}
	else 
	{
		$self->{dbh}= DBI->connect("DBI:$driver:$database:$server", $user, $pass) || die "No se pudo conectar a la base de datos\n";
		return $self->{dbh};
	}
}

sub disconnect
{
	my $self=shift;
	$self->{dbh}->disconnect;
}

1;