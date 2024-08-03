## To become root to install splunk on ec2
#sudo su - 

## Download Splunk rpm from splunk portal, you need to update this link for latest splunk software, refer slide 3 and 4

wget -O splunk-9.3.0-51ccf43db5bd.x86_64.rpm "https://download.splunk.com/products/splunk/releases/9.3.0/linux/splunk-9.3.0-51ccf43db5bd.x86_64.rpm"
##Create dedicated mount point/folder for splunk installation
mkdir /splunk

##Install splunk
rpm -ivh --prefix /splunk splunk-9.3.0-51ccf43db5bd.x86_64.rpm

## Start splunk service, and feed password along with command, you can change password once you login to splunk portal 
/splunk/splunk/bin/splunk start --accept-license --answer-yes --no-prompt --seed-passwd Admeensd@7658

## Enable autostart of splunk service
/splunk/splunk/bin enable boot-start
## Fix minimum free diskspace issue - only for lab environment not for production
echo "[diskUsage]" >> /splunk/splunk/etc/system/local/server.conf
echo "minFreeSpace = 50" >> /splunk/splunk/etc/system/local/server.conf
cp -pr ./SA-Eventgen /splunk/splunk/etc/apps
cp -pr ./TA-Eventgen-Learning /splunk/splunk/etc/apps
cp -pr ./TA-squid_proxy_eventgen /splunk/splunk/etc/apps
chown -R splunk:splunk /splunk/splunk/etc/apps
chmod 755 /splunk/splunk/etc/apps/SA-Eventgen/linux_x86_64/bin/modinput_eventgen
/splunk/splunk/bin/splunk restart
## Check splunk status
/splunk/splunk/bin/splunk status
/splunk/splunk/bin/splunk add oneshot ./hrdata.csv -index hrdata -sourcetype csv -auth admin:Admeensd@7658
/splunk/splunk/bin/splunk add oneshot ./zomato.csv -index zomato -sourcetype csv -auth admin:Admeensd@7658
echo "installation completed"
echo ""
echo ""
echo ""
echo "#########################################################################################################"
echo ""
echo "Login UserName admin password Admeensd@7658"
