#!/bin/sh -ex

test `cat "$1"` = "good"
echo ok > `basename "$1"`.res
