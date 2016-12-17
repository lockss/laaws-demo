#!/usr/bin/env python3

import requests
import json
import cgi
import cgitb
cgitb.enable()

# URL prefix for SOLR query service
# XXX should work with both EDINA and BL
service = "http://laaws-indexer/XXX"
# URL prefix for OpenWayback
wayback = "http://localhost:8080/wayback/*"
err = "Error: "
urlArray = []
count = 0

# return a Dictionary with the query params
def queryParams(s):
	if 'Search' in input-data:
		ret = {}
		ret['q'] = s["Search"].value
		ret['indent'] = "on"
		ret['wt'] = "json"
	else:
		ret = None
	return ret

# get data from web page form
input_data=cgi.FieldStorage()
params = None
# convert to SOLR query params
params = queryParams(input_data)

if params != None:
	# query the service
	solrResponse = requests.post(service, json=params)
	status = solrResponse.status_code
	if(status == 200):
		# parse the JSON we got back
		solrData = solrResponse.json()
		# XXX response is paginated
		if "docs" in solrData:
			docs = solrData["docs"]
			for doc in docs:
				url = None
				if "response_url" in doc:
					urls = doc["response_url"]
					url = urls[0]
				elif "url" in doc:
					url = doc["url"]
				if url != None
					urlArray[count++] = url
					err = ""
		else:
			err = err + "No docs found"
	else:
		# SOLR search query unsuccessful
		err = err + "SOLR service response: {0}\n{1}".format(status,openurlResponse)
else:
	# No search data from form
	err = err + "No search string from form"
if count == 1:
	# 1 url - redirect to it
	url = urlArray[0]
	redirectTo = "{0}/{1}".format(wayback,url)
	print("Location: {}".format(redirectTo))
	print()
elif count > 1:
	# multiple urls, create page of links
	print('Content-Type:text/html')
	print()
	print('<h1>Text Search Results</h1>')
	print("<ol>")
	for url in urlArray:
		print('<li><a href="{0}/{1}">'.format(wayback,url) + "{}</a></li>".format(url))
	print("</ol>")
else:
	print('Content-Type:text/html')
	print()
	print('<h1>OpenURL to URL</h1>')
	print("{0}{1}".format(err,message))
	print()

