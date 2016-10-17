#!/bin/env python3
from icalendar import Calendar, Event
import datetime
import pytz
import os
import time
from datetime import date, timedelta
import subprocess

file = open(os.path.join(os.path.expanduser('~'),'scripts/edt/finalSimple'),'r')


def lecturize(event):
    summary = str(event['SUMMARY'])
    return summary

def get_time(event):
    return (event['DTSTART'].dt, event['DTEND'].dt, event)

utc=pytz.timezone('Europe/Paris')

now = utc.localize(datetime.datetime.now())
nowTime = now.time()

start = file.readline()[:-2]
title = file.readline()[:-1]
duration = file.readline()[:-1]


startDate = utc.localize(datetime.datetime.now()).replace(
            hour=int(start.split(':')[0]),
                     minute=int(start.split(':')[1]),
                                second=0, microsecond=0
                     )
endDate = startDate + timedelta(hours=int(duration.split(':')[0]), minutes=int(duration.split(':')[1]))

durRemaning = endDate - now


d = divmod(durRemaning.total_seconds(),86400)  # days
h = divmod(d[1],3600)  # hours
m = divmod(h[1],60)  # minutes
s = m[1]  # seconds

if(m[0] < 0 or int(s) < 0 or h[0] < 0 or d[0] < 0):
    command1 = subprocess.Popen([os.path.join(os.path.expanduser('~'),'scripts/edt/createFile.sh')])
    print("  ")
    command1.wait()
else:
    strin='  ' + title+ " ("
    if (h[0] != 0):
        strin += str(int(h[0]))+'h'
    if (m[0] != 0):
        strin += str(int(m[0]))+'m'
    strin += str(int(s))+'s)  '
    print(strin)
