#!/usr/bin/env python3

import sys
import os
import cgi
import json
import cgitb
cgitb.enable()

#input_data=cgi.FieldStorage()
input_data=json.load(sys.stdin)
print("{}".format(input_data))

issn = None
volume = None
issue = None
spage = None
author = None

ret = None
if "rft.issn" in input_data:
	issn = input_data["rft.issn"]
if "rft.volume" in input_data:
	volume = input_data["rft.volume"]
if "rft.issue" in input_data:
	issue = input_data["rft.issue"]
if "rft.spage" in input_data:
	spage = input_data["rft.spage"]
if "rft.author" in input_data:
	author = input_data["rft.author"]
if issn == "1434-4599" and volume == "16" and spage == "222":
	# Single URL test case
	ret = '{"params":{"rft.volume":"16","rft.spage":"222","rft.issn":"1434-4599"},"urls":["http://www.tandfonline.com/doi/pdf/10.1080/15532739.2015.1081086"]}'
elif issn == "1234-5678" and volume == "77" and author == "Arthur Dent":
	# No URL test case
	ret = '{"params":{"rft.volume":"77","rft.author":"Arthur Dent","rft.issn":"1234-5678"},"urls":[]}'
elif issn == "8765-4321" and volume == "99" and author == "Tricia McMillan":
	# Multiple URL test case
	ret = '{"params":{"rft.volume":"99","rft.author":"Tricia McMillan","rft.issn":"8765-4321"},"urls":["http://www.example.com/one","http://www.null.com/two","http://www.badguys.com/three"]}'
if ret != None:
	print('Content-Type:text/html') #HTML follows
	#print('Content-Type:application/json') #JSON is following
	print()                         #Leave a blank line
	print(ret)
	print()
else:
	# XXX currently DOI service returns 500 on error
	# XXX service and this return need to be fixed
	#print("Status:500")

	print('Content-Type:text/html') #HTML follows
	print()                         #Leave a blank line
	if(issn != None):
		print("ISSN: {0}".format(issn))
	if(volume != None):
		print("Volume: {0}".format(volume))
	if(issue != None):
		print("Issue: {0}".format(issue))
	if(spage != None):
		print("Spage: {0}".format(spage))
	if(author != None):
		print("Author: {0}".format(author))
