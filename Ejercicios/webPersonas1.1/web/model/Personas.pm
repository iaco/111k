#!/usr/bin/perl

package Personas;

use Persona;
use Moose;
extends "Jorge::ObjectCollection";

sub create_object
{
    return new Persona;
}

1;