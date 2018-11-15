#!/usr/bin/env python

import urllib.request

url = 'http://nginx:80'

req = urllib.request.Request(url)
with urllib.request.urlopen(req) as res:
    body = res.read()

print('Content-type: text/html; charset=UTF-8\r\n')

print("%s" % body)
