#!/usr/bin/perl
use lib "./../controller";
use Interprete;
use CGI;
use HTML::Template;
use CGI::Session;

my $cgi= new CGI;

my $session = new CGI::Session;
my $template = new HTML::Template(filename=>"form.tmpl");


my $servidor= new Interprete;

$session->param('interprete',$servidor);
my @personas = $servidor->get_lista;

$template->param(ROWS => \@personas);

#print "Content-type: text/html\n\n";
print $session->header;
#print &encabezado;

print $template->output;
#print &cierre;





sub encabezado
{
    my $encabezado = '<!DOCTYPE  html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width", initial-scale=1.0">
        <title>..::Listado de personas:..</title>
        <link rel="stylesheet" type="text/css" href="/CSS/Styles.css">
    </head>

    <body>
    <div class="container" align=center width=100%>';
    return $encabezado;
}

sub cierre
{
    my $cierre = ' </div>   </body>
            </html>';
            return $cierrre;
}