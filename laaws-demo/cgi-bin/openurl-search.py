#!/usr/bin/env python3

import requests
import json
import cgi
import cgitb
cgitb.enable()

# URL prefix for OpenURL query service
service = "http://laaws-mdq:8889/urls/openurl"
# URL prefix for OpenWayback
wayback = "http://demo.laaws.lockss.org:8080/wayback/*"
err = "Error: "

# Return a Dictionary with the params for the OpenURL query
def parseOpenURL(s):
	# "rft.volume":"16","rft.spage":"222","rft.issn":"1434-4599"
	ret = {}
	for param in s:
		ret["rft." + param.lower()] = s[param].value
	return ret

# get data from web page form
input_data=cgi.FieldStorage()

params = parseOpenURL(input_data)
if params != None:
	# query the service
	openurlResponse = requests.post(service, json=params)
	status = openurlResponse.status_code
	if(status == 200):
		# parse the JSON we got back
		openurlData = openurlResponse.json()
		if "urls" in openurlData:
			urlList = openurlData["urls"]
			if(len(urlList) == 1):
				# 1 url - redirect to it
				url = urlList[0]
				redirectTo = "{0}/{1}".format(wayback,url)
				print("Location: {}".format(redirectTo))
				print()
			elif(len(urlList) > 1):
				# multiple urls, create page of links
				err = ""
				message = "<ol>\n"
				for url in urlList:
					message = message + '<li><a href="{0}/{1}">'.format(wayback,url) + "{}</a></li>\n".format(url)
				message = message + "</ol>\n"
			else:
				message = "OpenURL query succeeded but no URL"
		else:
			# JSON from OpenURL search lacked "urls"
			message = "OpenURL query result lacked urls: {}".format(openurlData)
	else:
		# OpenURL search query unsuccessful
		message = "OpenURL service error: {0}\n{1}".format(status,openurlResponse)
else:
	# Got OpenURL but invalid
	message = "Invalid OpenURL: {}".format(openurl)
print('Content-Type:text/html')
print()
print('<h1>OpenURL to URL</h1>')
print("{0}{1}".format(err,message))
print()
