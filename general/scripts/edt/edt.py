    #!/bin/env python3
from icalendar import Calendar, Event
import datetime
import pytz
import os
import time
from datetime import date

file = open(os.path.join(os.path.expanduser('~'),'scripts/edt/basic.ics'),'rb')
cal= Calendar.from_ical(file.read())

def lecturize(event):
    summary = str(event['SUMMARY'])
    return summary
    
def get_time(event):
    return (event['DTSTART'].dt, event['DTEND'].dt, event)
    
utc=pytz.timezone('Europe/Paris')
    

data = [(lecturize(e), get_time(e)) for e in cal.walk('vevent')]

now = utc.localize(datetime.datetime.now())
nowTime = now.time()

for name, eventData in data:
    
    #print(name + '\t\t' + str(eventData[0]))
    if(eventData[0].weekday() == now.weekday()):
        #print('helllooooooooooooooo')
        #print(name+str(eventData[1].time() - now.time()))
        startTime = eventData[0].time()
        endTime = eventData[1].time()
        #print(startTime)
        #print(endTime)
        if(startTime<= nowTime <= endTime):
            #print(nowTime.hour - endTime.hour)
            #print(nowTime.minute - endTime.minute)
            #print(nowTime.second - endTime.second)
            #print(endTime)
            test = eventData[1].replace(year=now.year, day=now.day, month=now.month)
            #print(test)
            #print(now)
            res = test - now
            #print('res')
            d = divmod(res.total_seconds(),86400)  # days
            h = divmod(d[1],3600)  # hours
            m = divmod(h[1],60)  # minutes
            s = m[1]  # seconds
            #print('test')
            #print(h[0])
            #print(m[0])
            #print(s)

#print '%d days, %d hours, %d minutes, %d seconds' % (d[0],h[0],m[0],s)
            
            #print(res )
            strin = '  ' + name + ' ('
            if (h[0] != 0):
                strin += str(int(h[0]))+'h'
            strin += str(int(m[0]))+'m'+str(int(s))+'s) '
            print(strin)
        
        