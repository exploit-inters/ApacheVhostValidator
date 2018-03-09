# ApacheVhostValidator
scan and check the URLs and Certificate in all vhosts in a directory

Apache vhost component validator : 

Utility : apache_status.sh

User : [any user]

Features :
•	Parses readable .conf files in directory provided for urls and certificates
•	Pings Urls
•	Validates Certificates
•	Prints Certificate vital information

Conditions : Only the .conf files with read permissions will be read(so prefer root) 

Usage:
$ ./apache_status.sh [
e.g.
[[app1]@[host] ~]$ ./apache_status.sh /etc/httpd/conf.d/apps/

