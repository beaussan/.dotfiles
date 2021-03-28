#!/bin/sh

todoist sync

TODOS=$(todoist --csv cl ${1:--f today})
PROJECTS=$(todoist --csv projects)
IFS=$'\n'
cd ~/brain
cd *'journal'


BODY="\n## What I have done today\n\n### Todo items from todoist done today :\n"

for line in $TODOS 
do
    TIME=$(echo $line | cut -d , -f 2 | cut -d ' ' -f 2)
    DATE=$(echo $line | cut -d , -f 2 | cut -d ' ' -f 1)
    PROJECT=$(echo $line | cut -d , -f 3 | cut -b 2-)
    TEXT=$(echo $line | cut -d , -f 4)
    PROJECTS_ID=$(echo $PROJECTS | grep $PROJECT | cut -d , -f 1)
    URL="https://todoist.com/app/project/$PROJECTS_ID"
    PROJECT_LINK="[$PROJECT]($URL)"
    BODY="$BODY\n- $DATE $PROJECT_LINK $TEXT @$TIME"
done

#BODY="$BODY\n\n### New Zettel :\n"
#for file in $(ls brain/Zettelkasten/items | grep $(date -u +"%Y%m%d"))
#do
#    file=$(echo $file | rev | cut -d '.' -f 2- | rev)
#    BODY="$BODY\n- [[${file}|$(echo $file | cut -d ' ' -f 2-)]]"
#done

FILENAME=$(ls | grep $(date -u +"%Y-%m-%d"))

printf $BODY >> $(pwd)/$FILENAME
