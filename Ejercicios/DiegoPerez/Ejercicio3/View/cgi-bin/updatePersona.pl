#!/usr/bin/perl

use lib "./";
use lib "./../Controller/";
use Gestor;
use CGI;


my $gestor     = new Gestor();
my $cgi        = new CGI;
my $id         = $cgi->param('id');
my $nombre     = $cgi->param('nombre');
my $apellido   = $cgi->param('apellido');
my $direccion  = $cgi->param('direccion');
my $nacimiento = $cgi->param('Nacimiento');
my $update    = $gestor->updatePersona($id,$nombre, $apellido, $direccion, $nacimiento);
	
print $cgi->header;



print  "Content-type: text/html", "\n\n";

print '<html>
    <body>';
    if ($update)
    {
        print "<h3> $nombre $apellido actualizado </h3>";
    }
    else
    {
        print "<h3> $nombre $apellido NO aactualizado </h3>";
    }
    print '<a href="index.pl">Atras </a>
    </body>
    </html>';
