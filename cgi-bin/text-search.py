#!/usr/bin/env python3

import cgi
import cgitb
cgitb.enable()

input_data=cgi.FieldStorage()

print('Content-Type:text/html') #HTML is following
print()                         #Leave a blank line
print('<h1>Text search</h1>')
try:
	openurl=input_data["Search"].value
	print("Search string: {}".format(openurl))
except:
	print('<p>No Search string?</p>')
