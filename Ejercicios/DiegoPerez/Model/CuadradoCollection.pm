#!/usr/bin/perl

use lib "./";

package CuadradoCollection;
    use base 'Jorge::ObjectCollection';

    use Cuadrado;

    use strict;

    sub create_object{
            return new Cuadrado;
    }

    ;1