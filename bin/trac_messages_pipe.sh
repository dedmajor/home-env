#!/bin/bash

# Copyright (c) 2009 by dedmajor@gmail.com
#
# Trac helper for instant messengers.
# Filters messages and replaces rNNNN and #NNNN with trac urls.
#
# Usage:
# $0 http://trac.example.com

TRAC="$1"

sed -e "

s~r\([0-9]\+\)~<a href=\"${TRAC}/changeset/\\1\">r\\1</a>~g

s~#\([0-9]\+\)~<a href=\"${TRAC}/ticket/\\1\">#\\1</a>~g

"
