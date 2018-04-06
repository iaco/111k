package PaquetesCollection;
use base 'Jorge::ObjectCollection';
 
use Paquetes;
 
use strict;
 
sub create_object {
        return new Paquetes;
}
1; 
