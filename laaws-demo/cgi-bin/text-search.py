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

print('Content-Type:text/html')
print()
print('<h1>Text Search Results</h1>')

# return a Dictionary with the query params
def queryParams(s):
	if 'Search' in s:
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
	solrResponse = requests.get(service, params=params)
	status = solrResponse.status_code
	if(status == 200):
		# parse the JSON we got back
		solrData = solrResponse.json()
		# XXX response is paginated
		if "response" in solrData and "docs" in solrData["response"]:
			docs = solrData["response"]["docs"]
			for doc in docs:
				url = None
				if "response_url" in doc:
					url = doc["response_url"][0]
				elif "url" in doc:
					url = doc["url"]
				if url != None:
					urlArray.append(url)
					err = ""
		else:
			err = err + "No docs found"
	else:
		# SOLR search query unsuccessful
		err = err + "SOLR service response: {0}\n{1}".format(status,openurlResponse)
else:
	# No search data from form
	err = err + "No search string from form"
# Redirect implementation prevents cgitb traceback, so commented out
#if len(urlArray) == 1:
#	# 1 url - redirect to it
#	url = urlArray[0]
#	redirectTo = "{0}/{1}".format(wayback,url)
#	print("Location: {}".format(redirectTo))
#	print()
#elif len(urlArray) > 1:
#	# multiple urls, create page of links
#	print('Content-Type:text/html')
#	print()
#	print('<h1>Text Search Results</h1>')
#	print("<ol>")
#	for url in urlArray:
#		print('<li><a href="{0}/{1}">'.format(wayback,url) + "{}</a></li>".format(url))
#	print("</ol>")
#else:
#	print("{0}".format(err))
#	print()

if len(urlArray) > 0:
	# urls, create page of links
	print('Content-Type:text/html')
	print()
	print('<h1>Text Search Results</h1>')
	print("<ol>")
	for url in urlArray:
		print('<li><a href="{0}/{1}">'.format(wayback,url) + "{}</a></li>".format(url))
	print("</ol>")
else:
	print("{0}".format(err))
	print()
