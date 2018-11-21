temp=`cat /sys/bus/w1/devices/$1/w1_slave`
length=`echo -n $temp | wc -m`
startvalue=69
num=0
let "num = length - 71"
sign=${temp[0]:$startvalue:1}
checkminus=0

if [ $sign = '-' ]
then
checkminus=1
startvalue=70
let "num = length - 72"
fi

if [ $num -gt 0 ]
then
temp1=${temp[0]:$startvalue:$num}
let xa=$temp1/10 xb=$temp1%10
t_result=$xa'.'$xb
if [ $checkminus -eq 1 ]
then
t_result="-"$xa'.'$xb
fi

else
t_result=0
fi

echo $t_result
#echo 28-031654ab70ff
