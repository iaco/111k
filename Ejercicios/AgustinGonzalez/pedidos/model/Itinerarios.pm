#!/usr/bin/perl

package Itinerarios;
use Moose;
extends "Jorge::ObjectCollection";

use Itinerario;


sub create_object
{
    return new Itinerario;
}

1;