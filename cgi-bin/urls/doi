#!/usr/bin/env python3

import os
import cgi
import cgitb
cgitb.enable()

choices = {"/10.1080/15532739.2015.1081086":'{"params":{"rft_id":"info:doi/10.1080/15532739.2015.1081086"},"urls":["http://www.tandfonline.com/doi/pdf/10.1080/15532739.2015.1081086"]}',
	"/10.1234/foobar":'{"params":{"rft_id":"info:doi/10.1234/foobar"},"urls":[]}'}
if "PATH_INFO" in os.environ:
	doi = os.environ["PATH_INFO"]
	if doi in choices:
		json = choices[doi]
		print('Content-Type:application/json') #JSON is following
		print()                         #Leave a blank line
		print("{}".format(json))
	else:
		# XXX currently DOI service returns 500 on error
		# XXX service and this return need to be fixed
		print("Status:500")
