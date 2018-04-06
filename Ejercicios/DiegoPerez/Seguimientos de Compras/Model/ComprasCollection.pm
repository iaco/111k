package ComprasCollection;
use base 'Jorge::ObjectCollection';
 
use Compras;
 
use strict;
 
sub create_object {
        return new Compras;
}
 
;1