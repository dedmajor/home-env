#!/bin/bash

wget -O /tmp/premiumzone.html --save-cookies=$HOME/rapidshare.cookie --post-data="login=$1&password=$2" "https://ssl.rapidshare.com/cgi-bin/premiumzone.cgi"

if grep 'Account has not been found' /tmp/premiumzone.html; then
	echo Account not found
	exit 1
fi

if grep 'password is incorrect' /tmp/premiumzone.html; then
	echo Password is incorrect
	exit 1
fi

if grep 'account is expired' /tmp/premiumzone.html; then
	echo Account is expired
	exit 1
fi

echo OK
