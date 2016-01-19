#!/bin/sh -ex

test `cat "$1"` = "good"
touch `basename "$1"`.result
