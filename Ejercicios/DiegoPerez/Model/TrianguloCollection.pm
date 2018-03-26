#!/usr/bin/perl

use lib "./";

package TrianguloCollection;
    use base 'Jorge::ObjectCollection';

    use Triangulo;

    use strict;

    sub create_object{
            return new Triangulo;
    }

    ;1