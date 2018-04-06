package UsuariosCollection;
use base 'Jorge::ObjectCollection';
 
use Usuarios;
 
use strict;
 
sub create_object {
        return new Usuarios;
}
 
;1