cd /splunk/splunk/bin/splunk stop
rpm -e `rpm -qa | grep -i splunk`
rm -rf /splunk/splunk
