#!/usr/bin/perl

package Paquetes;
use Moose;
extends "Jorge::ObjectCollection";

use Paquete;


sub create_object
{
    return new Paquete;
}

1;