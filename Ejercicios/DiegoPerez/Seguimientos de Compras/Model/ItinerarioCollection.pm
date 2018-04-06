package ItinerarioCollection;
use base 'Jorge::ObjectCollection';
 
use Itinerario;
 
use strict;
 
sub create_object {
        return new Itinerario;
}
 
;1