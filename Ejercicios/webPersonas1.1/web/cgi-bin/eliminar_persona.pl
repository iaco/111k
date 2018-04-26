#!/usr/bin/perl
use lib "./../controller";
use Interprete;
use CGI;
use CGI::Session;

my $cgi = new CGI;
my $session = new CGI::Session;

my $servidor = $session->param('interprete');


my $id = $cgi->param("id");

my $funciono=$servidor->eliminar_persona($id);

print $cgi->redirect( 'http://personas.com/cgi-bin/index.pl');

#print  "Content-type: text/html", "\n\n";
#print '<html>
#    <head>
#        <meta charset="utf-8">
#        <meta name="viewport" content="width=device-width, initial-scale=1.0">
#        <link rel="stylesheet" type="text/css" href="../CSS/Styles.css">
#
#    </head>
#    <body>';
#    if ($funciono)
#    {
#        print "<p> persona eliminada correctamente </p>";
#    }
#    else
#    {
#        print "<p> Error desconocido </p>";
#    }
#    print '<a href="index.pl">VOLVER </a>
#    </body>
#    </html>';
#