#!/usr/bin/env python

# Original version is here: http://shove-it.de/open/jcm/muttquery.py
# See http://wiki.mutt.org/?QueryCommand

###############################################
# answer queries for mutt from kabc file
###############################################
import sys
import os
import re

KDE_ADDRESSBOOK=os.environ['HOME'] + '/.kde/share/apps/kabc/std.vcf'

# String to identify Mail address entrys in vcards
MAIL_INIT_STRING = r'EMAIL:'
# String to identify Name entrys in vcards
NAME_INIT_STRING = r'N:'

class vcard:
    def __init__(self, email, name):
        self.email = str(email)
        self.name = str(name)

def parseFile(file_name):
    if not os.access(file_name, os.F_OK|os.R_OK):
        print 'Cannot open file ' , file_name
        sys.exit(1)
    try:
        cf = open(file_name)
        cards = cf.read()
    finally:
        cf.close()
    re_vcard = re.compile(r'BEGIN:VCARD.*?END:VCARD', re.DOTALL)
    vcards = re_vcard.findall(cards)
    return vcards

def getMatches(vcards, search_string):
    lines = []
    search_re = re.compile(search_string, re.I)
    mail_re = re.compile(r'^' + MAIL_INIT_STRING + r'(.*)$', re.MULTILINE)
    name_re = re.compile(r'^' + NAME_INIT_STRING + r'(.*)$', re.MULTILINE)
    for loop_vcard in vcards:
        if search_re.search(loop_vcard):
            if mail_re.search(loop_vcard) != None:
                tmp_mail = mail_re.search(loop_vcard).group(1).strip()
                if name_re.search(loop_vcard) != None:
                    tmp_name = name_re.search(
                        loop_vcard).group(1).replace(';', ' ').strip()
                else:
                    tmp_name = ''
                my_vcard = vcard(tmp_mail, tmp_name)
                lines.append(my_vcard)
    return lines



# main program starts here
vcards = parseFile(KDE_ADDRESSBOOK)
try:
    search_string = sys.argv[1]
except IndexError:
    print 'Use only with an argument'
    sys.exit(1)

lines = getMatches(vcards, search_string)
print 'Searched ' + str(vcards.__len__()) + ' vcards, found ' + str(
    lines.__len__())+ ' matches.'
for line in lines:
    #tmp_fill = (40 - line.email.__len__() ) * ' '
    print '%s\t%s' % (line.email, line.name)
    #print '%s' % line.email,

if lines.__len__() > 0:
    sys.exit(0)
else:
    sys.exit(1)
