#!/bin/bash

###########################
# Download Wordpress Core #
###########################

echo "Downloading WordPress Core"
wp core download;


########################
# Create wp-config.php #
########################

# Ask for DB Name
echo "Please enter new db name: "
read database_name

echo "Configuring WP"
wp core config --dbname=$database_name --dbuser=root --dbpass='admin' --dbprefix=wp_forge_;

# Create the database
echo "Creating the Database"
mysql -uroot -padmin -e "create database $database_name"


##########################
# Install Wordpress Core #
##########################

# Get url for this site
echo "Please enter the URL for this site: "
read site_url

echo "Please enter the title for this site: "
read site_title

echo "Please enter the admin user password: "
read admin_password

echo "Installing WordPress"
wp core install --skip-themes --skip-plugins --url="$site_url" --title="$site_title" --admin_user="Forge" --admin_password="$admin_password" --admin_email="development@weareforge.com.au" --skip-email


###############################
# Set some default WP Options #
###############################

# Remove site tagline
echo "Setting blog description to nothing"
wp option set blogdescription ""

# Set Permalink Structure
echo "Setting WP Permalink Structure"
wp rewrite structure '/%year%/%monthnum%/%postname%/'

# Remove the default 'post'
echo "Deleting the default post"
wp post delete 1

# Rename the default page to "Home"
echo "Renaming default page to Home"
wp post update 2 --post_title="Home" --post_name="home"

# Set static home page
echo "Setting a static home page"
wp option update show_on_front page
wp option update page_on_front 2

###########
# Plugins #
###########

# Delete unwanted plugins
echo "Deleting unwanted plugins"
wp plugin delete akismet hello

# Download and install my list of frequently used plugins
echo "Insalling frequently used plugins"
wp plugin install --activate "https://github.com/weareforge/forge-tweaks/archive/master.zip" "https://github.com/wp-sync-db/wp-sync-db/archive/master.zip" "https://connect.advancedcustomfields.com/index.php?p=pro&a=download&k=b3JkZXJfaWQ9ODExNTV8dHlwZT1wZXJzb25hbHxkYXRlPTIwMTYtMDUtMDkgMDI6NDA6MjU=" aryo-activity-log wp-nested-pages backupwordpress reveal-ids-for-wp-admin-25


##########
# Themes #
##########

# Ask for theme name
echo "Please enter a name for the theme slug: "
read theme_name
git clone https://github.com/weareforge/sam-bedrock.git wp-content/themes/$theme_name

# Create style.css with all necessary comment fields
echo "Enter client name to be used in Stylesheet comments"
read client_name
cat > wp-content/themes/$theme_name/style.css <<EOF
/*!
Theme Name: $client_name
Theme URI: http://weareforge.co
Description: Custom WordPress theme made for $client_name by Forge
Version: 1.0.0
Author: Forge <hello@weareforge.co>
*/
EOF

# Activate it
echo "Activating $theme_name"
wp theme activate $theme_name

# Remove unwanted themes
echo "Removing unwanted themes"
wp theme delete twentyseventeen twentysixteen twentyfifteen


############
# Complete #
############

# Open MAMP
open /Applications/MAMP\ PRO/MAMP\ PRO.app/;

# Alert the user on a job well done.
echo "Wordpress Installed and Themes Downlaoded. All that's left is to create a virtual host in MAMP"