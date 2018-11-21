#!/bin/bash

t_kotelnaya=`/home/pi/prkotel/gett.sh 28-00000583d763`
t_ulica=`/home/pi/prkotel/gett.sh 28-031654ab70ff`
t_podval=`/home/pi/prkotel/gett.sh 28-031661fa25ff`
t_pod=`/home/pi/prkotel/gett.sh 28-000005b3ce1b`
#smoke1=`/home/pi/prkotel/getsmoke.py`
#smoke=${smoke1:0:3}
smoke=50

length=`echo -n $t_pod | wc -m`
if [ $length -eq 3 ]
    then
    temp1_pod=${t_pod:0:1}
fi

if [ $length -eq 4 ]
then
    temp1_pod=${t_pod:0:2}
fi

t_max=75
smoke_max=440

datealarm=`head -1 /home/pi/prkotel/alarmdate.txt`
datenow=`date +"%s"`
datediff=0
let "datediff = datenow - datealarm"
echo $datediff

if [ $temp1_pod -ge $t_max ] || [ $smoke -ge $smoke_max ]
then

    pumpstatus=`head -1 /home/pi/prkotel/pump/status`
    pumpstatuswas=$pumpstatus
    echo $pumpstatus
    if [ $pumpstatus -eq 0 ]
    then
        pumpstatuswas=0
        pstat =`/home/pi/prkotel/pump/pon.sh`
    fi

    pumpstatus=`head -1 /home/pi/prkotel/pump/status`


    if [ $datediff -ge 600 ]
    then

        echo "danger t!!!"
        echo $temp1
        curl -d "text=achtung! t_pod = $t_pod, t_kotelnaya = $t_kotelnaya, smoke = $smoke, pumpstatus was $pumpstatuswas, now $pumpstatus" http://sms.ru/sms/send\?api_id=885d1124-52f5-8fb4-3917-4950416a0bc9\&to=79214832174
        echo ""
        echo $datenow > /home/pi/prkotel/alarmdate.txt
    fi

fi

echo "podacha = $t_pod"
echo "kotelnaya = $t_kotelnaya"
echo "ulica = $t_ulica"
echo "podval = $t_podval"
echo "smoke = $smoke"

curl 194.67.211.50/add.php?id_sensor=1\&\value=$t_pod
curl 194.67.211.50/add.php?id_sensor=2\&\value=$t_kotelnaya
curl 194.67.211.50/add.php?id_sensor=3\&\value=$t_ulica
curl 194.67.211.50/add.php?id_sensor=4\&\value=$t_podval


raspistill -o /home/pi/prkotel/img.jpg -w 640 -h 480 -q 10

timestamp=`stat -c %y /home/pi/prkotel/img.jpg`
/usr/bin/convert /home/pi/prkotel/img.jpg -fill white -pointsize 15 -draw  "text 10,15 '${timestamp:0:19}'" /home/pi/prkotel/cam.jpg
