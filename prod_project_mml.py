#!/usr/bin/python
# -*- coding: utf8 -*-
#
# modification de la conf du projet présente dans le dépôt pour docker
#

import json
import sys

project = json.loads(sys.stdin.read())

files_ref = {
	'10m_land':'/usr/share/shapefile/naturalearth/ne_10m_land.shp',
	'processed_p': '/srv/coastline/coastline-good.shp',
	'shoreline_300': '/usr/share/shapefile/naturalearth/ne_10m_coastline.shp',
	'10m_rivers': '/usr/share/shapefile/naturalearth/ne_10m_rivers_europe.shp',
	'10m_lakes': '/usr/share/shapefile/naturalearth/ne_10m_lakes_europe.shp',
	'10m_populated_places': '/usr/share/shapefile/naturalearth/ne_10m_populated_places.shp'
}

for l in project['Layer']:
	if l['Datasource'].has_key('file'):
		l['Datasource']['file'] = files_ref[l['name']]
		l['Datasource']['type'] = 'shape'
	elif l['Datasource'].has_key('dbname'):
		l['Datasource']['dbname'] = 'osm'
		l['Datasource']['user'] = 'osm'
		l['Datasource']['password'] = 'osm'
		l['Datasource']['host'] = '192.168.0.179'
		l['Datasource']['port'] = '54320'
	else:
		print "ooops:",l['name'],l['Datasource'].keys()
		sys.exit(1)

print json.dumps(project)
