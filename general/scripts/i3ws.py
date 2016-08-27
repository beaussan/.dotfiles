# -*- coding: utf-8 -*-
import subprocess
import sys
import json

reload(sys)
sys.setdefaultencoding('utf-8')
command = ['i3-msg', '-t', 'get_workspaces']
p = subprocess.Popen(command, stdout=subprocess.PIPE)
text = p.stdout.read()

pjson = json.loads(text)

acnum = 0
string = ""

for objects in pjson:
	if objects["visible"] == True:
		acnum = objects["name"]

for objects in pjson:
	string += str(objects["name"])
	string += " "

print string
