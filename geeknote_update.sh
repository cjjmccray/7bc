#!/bin/sh

## Outputs some stuff to a file
## Uploads file to Evernote

echo > ~/geeknote/7bc-rome-status

echo Date/Time >> ~/geeknote/7bc-rome-status
date >> ~/geeknote/7bc-rome-status
echo >> ~/geeknote/7bc-rome-status

echo uname -a >> ~/geeknote/7bc-rome-status
uname -a >> ~/geeknote/7bc-rome-status
echo >> ~/geeknote/7bc-rome-status

echo slackware-version >> ~/geeknote/7bc-rome-status
cat /etc/slackware-version >> ~/geeknote/7bc-rome-status
echo >> ~/geeknote/7bc-rome-status

echo uptime >> ~/geeknote/7bc-rome-status
uptime >> ~/geeknote/7bc-rome-status
echo >> ~/geeknote/7bc-rome-status

echo df >> ~/geeknote/7bc-rome-status
df >> ~/geeknote/7bc-rome-status
echo >> ~/geeknote/7bc-rome-status

echo ntpq -pn >> ~/geeknote/7bc-rome-status
ntpq -pn >> ~/geeknote/7bc-rome-status
echo >> ~/geeknote/7bc-rome-status

echo geeknote_update.log file size >> ~/geeknote/7bc-rome-status
ls -l ~/geeknote_update.log >> ~/geeknote/7bc-rome-status
echo >> ~/geeknote/7bc-rome-status

## geeknote edit --title "7bc-rome-status"  --notebook "Newport" --content < ~/geeknote/7bc-rome-status
gnsync --path /root/geeknote --mask "*" --logpath /root/geeknote_update.log --notebook "Newport"
