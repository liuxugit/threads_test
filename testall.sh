#!/bin/bash
tmp_PingFile="/tmp/ping.tmp"
tmp_PingSortFile="/tmp/ping_OK.txt"
tmp_SSHFile="/tmp/SSH.tmp"
tmp_SSHSortFile="/tmp/SSH_OK.txt"

rm -rf $tmp_PingFile
rm -rf $tmp_PingSortFile
rm -rf $tmp_SSHFile
rm -rf $tmp_SSHSortFile

function a_sub {  
ping_OK_number=`ping 10.34.65.$i -c 4 | grep ttl -c`
if [ $ping_OK_number == 4 ]
then 
echo  10.34.65.$i >> $tmp_PingFile
fi
}


#function b_sub {  
#ping_SSH_number=`/usr/bin/expect -c "
#set timeout 5 
#spawn telnet 10.34.65.$i 22
#expect "SSH"
#send "exit"
#" | grep SSH -c`
#if [ $ping_SSH_number == 1 ]
#then 
#echo  10.34.65.$i  >> $tmp_SSHFile 
#fi
#}
 
tmp_fifofile="/tmp/$$.fifo" 
mkfifo $tmp_fifofile      
exec 6<>$tmp_fifofile      
rm $tmp_fifofile 
 
thread=50
for ((i=0;i<$thread;i++));do 
echo 
done >&6
 
for ((i=1;i<255;i++));do
    read -u6 
    { 
        a_sub 
#       b_sub 
        echo >&6
    } & 
done 
wait
exec 6>&- 
exit 0
