#!/bin/sh -ex

if echo "$1" | grep -qE '\.gz$'; then
    test `zcat "$1"` = "good"
else
    test `cat "$1"` = "good"
fi
touch `basename "$1"`.result
