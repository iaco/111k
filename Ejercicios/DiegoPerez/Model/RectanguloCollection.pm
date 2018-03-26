#!/usr/bin/perl

use lib "./";

package RectanguloCollection;
    use base 'Jorge::ObjectCollection';

    use Rectangulo;

    use strict;

    sub create_object{
            return new Rectangulo;
    }

    ;1