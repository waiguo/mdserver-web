#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

echo "welcome to mdserver-web panel"

startTime=`date +%s`

if [ ! -d /www/server/mdserver-web ];then
	echo "mdserver-web not exist!"
	exit 1
fi

# openresty
if [ ! -d /www/server/openresty ];then
	cd /www/server/mdserver-web/plugins/openresty && bash install.sh install 1.21.4.1
	cd /www/server/mdserver-web && python3 /www/server/mdserver-web/plugins/openresty/index.py start
else
	echo "openresty alreay exist!"
fi


# php
if [ ! -d /www/server/php/71 ];then
	cd /www/server/mdserver-web/plugins/php && bash install.sh install 71
	cd /www/server/mdserver-web && python3 /www/server/mdserver-web/plugins/php/index.py start 71
else
	echo "php71 alreay exist!"
fi

# mysql
if [ ! -d /www/server/mysql ];then
	cd /www/server/mdserver-web/plugins/mysql && bash install.sh install 5.5
	cd /www/server/mdserver-web && python3 /www/server/mdserver-web/plugins/mysql/index.py start 5.5
else
	echo "mysql alreay exist!"
fi

endTime=`date +%s`
((outTime=(${endTime}-${startTime})/60))
echo -e "Time consumed:\033[32m $outTime \033[0mMinute!"

