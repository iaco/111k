#!/usr/bin/perl

package Usuarios;
use Moose;
extends "Jorge::ObjectCollection";

use Usuario;


sub create_object
{
    return new Usuario;
}
1;