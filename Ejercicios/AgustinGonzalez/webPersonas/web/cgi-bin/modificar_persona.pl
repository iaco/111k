#!/usr/bin/perl
use lib "./../controller";
use Interprete;
use CGI;
my $servidor= new Interprete;
my $cgi= new CGI;

&parse_form_data(*simple_form);

print  "Content-type: text/html", "\n\n";

my $id= $cgi->param("id");
my $nombre= $cgi->param("nombre");
my $apellido= $cgi->param("apellido");
my $direccion= $cgi->param("direccion");
my $nacimiento= $cgi->param("nacimiento");

#$id =$simple_form{"id"};
#$nombre= $simple_form{"nombre"};
#$apellido= $simple_form{'apellido'};
#$direccion= $simple_form{'direccion'};
#$fecha_nacimiento=$simple_form{'nacimiento'};

my $funciono =$servidor->modificar_persona($id,$nombre,$apellido,$direccion,$nacimiento);

#print $cgi->header(-charset    => 'utf-8');
print '<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>..::Listado de personas:..</title>
        <link rel="stylesheet" type="text/css" href="../CSS/Styles.css">

    </head>
    <body>';
    if ($funciono)
    {
        print "<p> persona modificada correctamente </p>";
    }
    else
    {
        print "<p> Error desconocido </p>";
    }
    print '<a href="index.pl">VOLVER </a>
    </body>
    </html>';





sub parse_form_data
{
    local (*FORM_DATA) = @_;
    local ( $request_method, $query_string, @key_value_pairs,
                  $key_value, $key, $value);
    $request_method = $ENV{'REQUEST_METHOD'};
    if ($request_method eq "GET") {
        $query_string = $ENV{'QUERY_STRING'};
    } elsif ($request_method eq "POST") {
        read (STDIN, $query_string, $ENV{'CONTENT_LENGTH'});
    } else {
        &return_error (500, "Server Error",
                            "Server uses unsupported method");
    }
    @key_value_pairs = split (/&/, $query_string);
    foreach $key_value (@key_value_pairs) {
        ($key, $value) = split (/=/, $key_value);
        $value =~ tr/+/ /;
        $value =~ s/%([\dA-Fa-f][\dA-Fa-f])/pack ("C", hex ($1))/eg;
        if (defined($FORM_DATA{$key})) {
            $FORM_DATA{$key} = join ("\0", $FORM_DATA{$key}, $value);
        } else {
                    $FORM_DATA{$key} = $value;
        }
    }
}


sub return_error
{
    local ($status, $keyword, $message) = @_;
    print "Content-type: text/html", "\n";
    print "Status: ", $status, " ", $keyword, "\n\n";
    print "<<End_of_Error
    <HTML>
    <HEAD>
        <TITLE>CGI Program - Unexpected Error</TITLE>
    </HEAD>
    <BODY>
    <H1>$keyword</H1>
    <HR>$message<HR>
    Please contact $webmaster for more information.
    </BODY>
    </HTML>
    End_of_Error";
    exit(1);
}
