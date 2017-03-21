#!/bin/bash

###########################
# Download Wordpress Core #
###########################

wp core download --locale=en_AU;


########################
# Create wp-config.php #
########################

# Ask for DB Name
echo "Please enter new db name: "
read database_name
wp core config --dbname=$database_name --dbuser=root --dbpass='admin' --dbprefix=wp_forge_;

# Create the database
mysql -uroot -padmin -e "create database $database_name"


##########################
# Install Wordpress Core #
##########################

echo "Attempting to install wordpress..."
wp core install --prompt --skip-themes --skip-plugins


#######################
# Remove site tagline #
#######################

wp option set blogdescription ""


###########
# Plugins #
###########

# Delete unwanted plugins
wp plugin delete akismet hello

# Download and activate Forge Tweaks Plugin
git clone https://sd-forge@bitbucket.org/forgecollective/forge-tweaks.git wp-content/plugins/forge-tweaks
wp plugin activate forge-tweaks

# Download and install my list of frequently used plugins
wp plugin install --activate "https://github.com/wp-sync-db/wp-sync-db/archive/master.zip" "https://connect.advancedcustomfields.com/index.php?p=pro&a=download&k=b3JkZXJfaWQ9ODExNTV8dHlwZT1wZXJzb25hbHxkYXRlPTIwMTYtMDUtMDkgMDI6NDA6MjU=" aryo-activity-log swifty-page-manager backupwordpress reveal-ids-for-wp-admin-25


##########
# Themes #
##########

# Ask for theme name
echo "Please enter a name for the theme: "
read theme_name
git clone https://github.com/weareforge/sam-bedrock.git wp-content/themes/$theme_name

# Activate it
wp theme activate $theme_name

# Remove unwanted themes
wp theme delete twentyseventeen twentysixteen twentyfifteen


############
# Complete #
############

# Open MAMP
open /Applications/MAMP\ PRO/MAMP\ PRO.app/;

# Alert the user on a job well done.
echo "Wordpress Installed and Themes Downlaoded. All that's left is to create a virtual host in MAMP"