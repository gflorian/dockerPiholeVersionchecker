#!/bin/bash
TEXT=`/usr/bin/docker exec -t pihole pihole -v`
VERSIONS=$(echo $TEXT | awk '{gsub(/v|)\r/,""); print "dpkg --compare-versions "$4" lt "$6}')
UPDATE=N

while IFS= read -r line
do
	if eval $line
		then
			UPDATE=Y
	fi
done < <(printf '%s\n' "$VERSIONS")

if [ "$UPDATE" == "Y" ]
	then
		CHATID="12346789dummy" #replace with your own
		KEY="123456:ABCDEFG123dummy" #replace with your own
		TIME="10"
		URL="https://api.telegram.org/bot$KEY/sendMessage"
		curl -s --max-time $TIME -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT" $URL >/dev/null
fi
