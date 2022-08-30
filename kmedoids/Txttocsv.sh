#!/usr/bin/bash
for dir in */; do cd "$dir"; awk '{print $1","$2}' *Txt>new.csv; cd ..; done
