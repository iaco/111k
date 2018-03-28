#!/usr/bin/perl

package Pedidos;
use Moose;
extends "Jorge::ObjectCollection";

use Pedido;


sub create_object
{
    return new Pedido;
}
1;