#!/bin/sh

VALUE=$(rofi -sep "|" -dmenu -p 'Title' "" -lines 0  -width 50 -opacity 80 -bw 0 )

if [ -z "$VALUE" ]; then
    exit 0
fi
PRIORITY=$(echo "P4|P3|P2|P1" | rofi -sep "|" -dmenu -p 'Priority' "" -lines 4 -width 50 -opacity 80)

if [ -z "$PRIORITY" ]; then
    PRIORITY="P4"
fi

PROJECT_WITH_ID=$(todoist --csv projects)
PROJECT_LIST_FOR_ROFI=$(todoist --csv projects | cut -d , -f 2 | tr '\n' '|')

echo $PROJECT_WITH_ID
echo $PROJECT_LIST_FOR_ROFI


PROJECT=$(echo $PROJECT_LIST_FOR_ROFI | rofi -sep "|" -dmenu -p 'Project' "" -lines 9 -width 50 -opacity 80)

if [ -z "$PROJECT" ]; then
    PROJECT=$(echo $PROJECT_WITH_ID | grep Inbox | cut -d , -f 1)
else
    PROJECT=$(echo $PROJECT_WITH_ID | grep $PROJECT | cut -d , -f 1)
fi

DUE_DATE=$(echo "today|tomorow|next week|next month" | rofi -sep "|" -dmenu -p 'Project' "" -lines 4 -width 50 -opacity 80)

echo todoist a $VALUE -p $(echo $PRIORITY | cut -b 2) -P $PROJECT -d $DUE_DATE
todoist a $VALUE -p $(echo $PRIORITY | cut -b 2) -P $PROJECT -d $DUE_DATE


