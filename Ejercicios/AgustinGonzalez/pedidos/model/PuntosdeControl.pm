#!/usr/bin/perl

package PuntosdeControl;
use Moose;
extends "Jorge::ObjectCollection";

use PuntodeControl;


sub create_object
{
    return new PuntodeControl;
}

1;