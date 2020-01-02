#!/bin/sh

cat $(pwd)/mail.template > .mail.tmp
cat log/$(ls -lah $(pwd)/log | tail -n 1 | awk '{print $9}') >> $(pwd)/.mail.tmp
echo "</pre>" >> $(pwd)/.mail.tmp
ssmtp YOUR_EMAIL@example.com < $(pwd)/.mail.tmp

#rm $(pwd)/.mail.tmp
