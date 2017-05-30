#!/bin/bash

sitesAvailable='/etc/apache2/sites-available/'
sitesDir='/var/www/'

# Get domain name
echo "Please enter the domain of the new VirtualHost: "
read domain

siteDir=$sitesDir$domain
sitesAvailableDomain=$sitesAvailable$domain.conf

# Create directory for virtualhost
echo "Creating site directory in $siteDIR"
mkdir $siteDir

# Set appropriate permission
echo "Setting permissions for $siteDir"
chown www-data:www-data -R $siteDir
chmod 775 -R $siteDir

# Create virutal host entry
echo "Creating virtual host file"
cat > $sitesAvailableDomain <<EOF
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    ServerName $domain
    ServerAlias www.$domain
    DocumentRoot $siteDir
    ErrorLog \${APACHE_LOG_DIR}/$domain-error.log
    CustomLog \${APACHE_LOG_DIR}/$domain-access.log combined
</VirtualHost>
EOF

# Activate virtual host
echo "Activating virtual host"
a2ensite $domain

# Reload apache
echo "Reloading Apache"
service apache2 reload