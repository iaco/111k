#!/usr/bin/perl

use lib "./";
use lib "./../Controller/";
use lib "./../Model/";
use lib "./cgi-bin/";
use Gestor;
use CGI;
use Template;

$| = 1;
print "Content-type: text/html\n\n";


my $gestor   = new Gestor;
my $cgi      = new CGI;
my $template = new Template({
    INCLUDE_PATH => '/home/diego/Exercies/Ejercicio3/cgi-bin',
          
});

my $vars = {
	 personas => $gestor->listPersonas,
};

my $input = 'template.tmpl';
 
$template->process($input, $vars) || die $template->error();

