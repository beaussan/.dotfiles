#!/bin/bash

#use strict;
level=`xbacklight -get | cut -d "." -f 1`

echo  "$level"%

