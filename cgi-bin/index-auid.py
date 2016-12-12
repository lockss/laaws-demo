#!/usr/bin/env python3

import cgi
import cgitb
cgitb.enable()

input_data=cgi.FieldStorage()

print('Content-Type:text/html') #HTML is following
print()                         #Leave a blank line
print('<h1>Index AUID</h1>')
try:
	auid=input_data["AUID"].value
	print("Index AUID: {}".format(auid))
except:
	print('<p>No AUID?</p>')
