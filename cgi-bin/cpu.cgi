#!/bin/sh

echo "Content-type: text/plain";
echo "";
mpstat 1 2;
sar 1;
