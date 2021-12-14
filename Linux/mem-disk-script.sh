#!/bin/bash

# checking the meminfo file for mem free, then awk-ing to get the printable version of what i want
cat /proc/meminfo | grep -i memfree | awk -F: '{print $1,$2}' > free-mem/free-mem.txt

# checking disk usage using df in human readable format
df -h / > free-disk/free-disk.txt

# using file space usage using du with options of only telling it to go one level deep (-d 1), and give me a grand total (-c), human readable (-h) and only checking one file system (-x) and checking only the / filesystem
du -d 1 -c -h -x / > disk-use/disk-use.txt

# listing all open files using lsof
lsof > open-list/open-list.txt

