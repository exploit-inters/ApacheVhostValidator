dirchk=$1

_checkConf(){

conf=$1

echo -e "\n------------------------------------"
echo -e "\nConf File: $conf\n"
echo -e "\n------------------------------------"


#urls (assuming .com suffixed)

urls=(`egrep -i "\.com" $conf|egrep -iv "com\."| tr " " "\n"|grep -i com |tr "\n" " "`)

for url in "${urls[@]}"
do
echo -e "\n               ----              "
echo -e "\nURL: $url\n"
ping -c 1 $url

done

echo -e "\n------------------------------------"

#cert val

certs=(`grep SSLCertificateFile $conf|grep -v "#"|awk '{print $2}'|tr "\n" " "`)

for cert in "${certs[@]}"
do

if [ `echo $cert|grep "\"" |wc -l` != 0 ];then
cert=$(echo $cert|cut -d "\"" -f 2)
fi

echo -e "\n               ----              "
echo -e "\nCert: $cert\n"

openssl x509 -enddate -noout -in $cert|sed 's/notAfter=/Expiry: /g'

cn=`openssl x509 -in $cert -text|grep Subject.*CN|tr "=" "\n"|tr " " "\n"|grep "\.com" |grep -v "com\."`
alg=`openssl x509 -in $cert -text|grep "Signature Algorithm"|cut -d ":" -f 2|head -1|cut -d " " -f 2`

echo -e "\nCommon Name(URL): $cn\n"
echo -e "\nAlgorithm: $alg"

done




}



confs=(`ls ${dirchk}/*conf`)


for i in "${confs[@]}"
do

if [ -r $i ]
then

_checkConf ${i}

else

echo -e "\n------------------------------------"
echo no read rights on $i .. please use root
echo -e "\n------------------------------------"

fi
done

