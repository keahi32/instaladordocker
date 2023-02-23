#!/bin/bash
initCount=0
logs=/var/log/snort/alert

#Telegram temporary message
message=/tmp/message.txt

#Chat id and bot telegram token
echo "Dime tu chat ID"
read id
chat_id="$id"
token="6072331456:AAHndQClwpdyLXKnDIncbExw3NItXF6ZXk0"

#Send Alert Function
function sendAlert
{
        curl -s -F chat_id=$chat_id -F text="$text" https://api.telegram.org/bot$token/sendMessage
}

#Running the program
while true
do
    lastCount=$(wc -c $logs | awk '{print $1}') #getSizeFileLogs

    if(($(($lastCount)) > $initCount));
       then
        msg=$(tail -n 2 $logs) #GetLastLineLog
        echo -e "Para el Adminitrador\n Acabamos de recibir esta informacion del servidor\n\nServer Time : $(date +"%d %b %Y %T")\n\n"$msg > $message
        text=$(<$message)
        sendAlert
        echo " Alert sent!"
        initCount=$lastCount
        rm -f $message
        sleep 1
    fi
    sleep 2
done