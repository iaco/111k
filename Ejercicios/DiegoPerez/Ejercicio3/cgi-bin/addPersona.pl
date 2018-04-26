#!/usr/bin/perl

use lib "./";
use lib "./../Controller/";
use Gestor;
use CGI;


my $gestor     = new Gestor();
my $cgi        = new CGI;
my $nombre     = $cgi->param('nombre');
my $apellido   = $cgi->param('apellido');
my $direccion  = $cgi->param('direccion');
my $nacimiento = $cgi->param('Nacimiento');
	

print  "Content-type: text/html", "\n\n";

my $inserto = $gestor->addPersona($nombre,$apellido,$direccion,$nacimiento);

print '<html>
    <body>';
    if ($inserto)
    {
        print "<h3> $nombre $apellido agregado </h3>";
    }
    else
    {
        print "<h3> $nombre $apellido NO agregado </h3>";
    }
    print '<a href="index.pl">Atras </a>
    </body>
    </html>';
