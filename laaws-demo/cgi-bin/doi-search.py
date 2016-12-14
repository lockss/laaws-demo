#!/usr/bin/env python3

import re
import requests
import json
import cgi
import cgitb
cgitb.enable()

# URL prefix for DOI query service
service = "http://laaws-mdq:8888/urls/doi"
# URL prefix for OpenWayback
wayback = "http://localhost:8080/wayback/*"
# Regex to match syntactically valid DOIs
doiRegex = '10\.[0-9]+\/'
err = "Error: "

# Return true if d is a syntactically valid DOI
def validate(d):
	regex = re.compile(doiRegex)
	ret = regex.match(d)
	return ret

# get data from web page form
input_data=cgi.FieldStorage()

if "DOI" in input_data:
	doi=input_data["DOI"].value
	if validate(doi):
		# query the service
		serviceUrl = "{0}/{1}".format(service, doi)
		doiResponse = requests.get(serviceUrl)
		status = doiResponse.status_code
		if(status == 200):
			# parse the JSON we got back
			doiData = doiResponse.json()
			if "urls" in doiData:
				urlList = doiData["urls"]
				if(len(urlList) == 1):
					url = urlList[0]
					redirectTo = "{0}/{1}".format(wayback,url)
					print("Location: {}".format(redirectTo))
					print()
				elif(len(urlList) == 0):
					message = "DOI query succeeded but no URL"
				else:
					err = ""
					message = "<ul>\n"
					for url in urlList:
						message = message + '<li><a href="{}">'.format(url) + "{}</a></li>\n".format(url)
					message = message + "</ul>\n"
			else:
				# JSON from DOI search lacked "urls"
				message = "DOI query result lacked urls: {}".format(doiData)
		else:
			# DOI search query unsuccessful
			message = "DOI service error: {}".format(status)
	else:
		# Got DOI but invalid
		message = "Invalid DOI: {}".format(doi)
else:
	# Missing DOI input
	message = "No DOI to search for"
print('Content-Type:text/html')
print()
print('<h1>DOI to URL</h1>')
print("{0}{1}".format(err,message))
print()
