package Personas;
use base 'Jorge::ObjectCollection';
 
use Persona;
 
use strict;
 
sub create_object {
        return new Persona;
}
 
;1