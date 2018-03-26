#!/usr/bin/perl

use lib "./";

package CirculoCollection;
    use base 'Jorge::ObjectCollection';

    use Circulo;

    use strict;

    sub create_object{
            return new Circulo;
    }

    ;1