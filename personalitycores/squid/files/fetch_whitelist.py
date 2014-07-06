#!/usr/bin/python3
from subprocess import call
import urllib.request
import json

request = urllib.request.urlopen("http://api.proxmate.me/proxy/whitelist.json")
json_string = request.read()
whitelist_entries = json.loads(json_string.decode("utf-8"))

whitelist_file = open("/etc/squid/whitelist", encoding="utf-8", mode="w")
whitelist_file.write('\n'.join(whitelist_entries))
call(["service", "squid reload"])
