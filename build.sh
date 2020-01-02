#!/bin/sh

mkdir $(pwd)/log
touch $(pwd)/log/current_ip.log

crontab -l > .cron.tmp
echo "*/2 * * * * $(pwd)/cron_exec.sh" >> .cron.tmp
# echo "*/2 * * * * ssh $(whoami)@localhost 'cd $(pwd) && $(pwd)/cron_exec.sh'" >> .cron.tmp
crontab .cron.tmp
rm .cron.tmp

echo "#!/bin/sh\n\n$(pwd)/runtime.sh > $(pwd)/log/ddns_\$(date +"%Y-%m-%dT%H:%M:%S").log" > $(pwd)/cron_exec.sh
chmod a+x cron_exec.sh
