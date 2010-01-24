#!/bin/bash

# One should enable direct downloads in account settings

wget --no-check-certificate --load-cookies=$HOME/rapidshare.cookie $*
