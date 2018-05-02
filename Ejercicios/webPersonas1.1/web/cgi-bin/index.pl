#!/usr/bin/perl

use lib "./../controller";
use Interprete;
use CGI;
use Template;
use CGI::Session;
use utf8;
use Date::Tiny;

my $cgi= new CGI;
        
my $session = new CGI::Session;

my $servidor= new Interprete;
$session->param('interprete',$servidor);
my $template = new Template({
    INCLUDE_PATH=>'../cgi-bin/',
    EVAL_PERL =>1,
}
);
my $input = "template.tmpl";

my @personas = $servidor->get_lista;
my $hoy = Date::Tiny->now;
my $fecha_max= $hoy->ymd;
my $patron_direccion = "^[a-zA-Z0-9\\u00F1\\u00D1&aacute&eacute&iacute&oacute&uacute][a-zA-Z0-9\\u00F1\\u00D1&aacute&eacute&iacute&oacute&uacute -,&#039(\.)]{4,254}\$";
my $vars ={
    patron_direccion => $patron_direccion,
    fecha_max => $fecha_max,
    personas => \@personas,
};
#Prueba de branch




#print "Content-type: text/html\n\n";
print $session->header;
print &encabezado;
$template->process ($input, $vars) || die $template->error();
print &cierre;





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