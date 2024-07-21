## To become root to install splunk on ec2
#sudo su - 

## Download Splunk rpm from splunk portal, you need to update this link for latest splunk software, refer slide 3 and 4

wget -O wget -O splunk-9.2.1-78803f08aabb.x86_64.rpm "https://download.splunk.com/products/splunk/releases/9.2.1/linux/splunk-9.2.1-78803f08aabb.x86_64.rpm"

##Create dedicated mount point/folder for splunk installation
mkdir /splunk

##Install splunk
rpm -ivh --prefix /splunk splunk-9.2.1-78803f08aabb.x86_64.rpm
## Go to splunk binary path
cd /splunk/splunk/bin

## Start splunk service, and feed password along with command, you can change password once you login to splunk portal 
./splunk start --accept-license --answer-yes --no-prompt --seed-passwd Admeensd@7658

## Enable autostart of splunk service
./splunk enable boot-start
## Fix minimum free diskspace issue - only for lab environment not for production
echo "[diskUsage]" >> /splunk/splunk/etc/system/local/server.conf
echo "minFreeSpace = 50" >> /splunk/splunk/etc/system/local/server.conf
cp -pr ./SA-Eventgen /splunk/splunk/etc/apps
cp -pr ./TA-Eventgen-Learning /splunk/splunk/etc/apps
cp -pr ./TA-squid_proxy_eventgen /splunk/splunk/etc/apps
/splunk/splunk/bin/splunk restart
## Check splunk status
./splunk status
echo "installation completed"
