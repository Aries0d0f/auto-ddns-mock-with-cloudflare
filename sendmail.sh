#!/bin/sh

BASE=$(dirname "$0")
sleep 10;

cat $BASE/mail.template > $BASE/.mail.tmp;
cat $BASE/log/$(ls -lah "$BASE/log" | tail -n 1 | awk '{print $9}') >> $BASE/.mail.tmp;
echo "</pre>" >> $BASE/.mail.tmp;

ssmtp YOUR_EMAIL@example.com < $BASE/.mail.tmp;

rm $(pwd)/.mail.tmp;
