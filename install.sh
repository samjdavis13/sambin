#!/bin/bash

#-------------------------------------------------------------------------------
# Vars
#-------------------------------------------------------------------------------

bindir="/usr/local/bin"

# Coloured Text
textRed=`tput setaf 1`
textGreen=`tput setaf 2`
textReset=`tput sgr0`


#-------------------------------------------------------------------------------
# Functions
#-------------------------------------------------------------------------------
printNewLine() { echo "-------------------------------------------------------------"; }

installSingleScript() {

    # Get filename
    filename=$1

    # Get base file name
    filebasename=$(basename $filename .sh)

    # If file already exists in $bindir, delete it
    safetocontinue=1
    if [ -f $bindir/$filebasename ]; then

        safetocontinue=0

        if [ "$onlyNewScripts" != true ]; then

            if [ "$forceInstallEverything" != true ]; then
                echo "${textGreen}$filebasename${textReset} already exists in $bindir."
                read -p "Do you want to replace it? (y/n) " continue
            fi

            if [ "$forceInstallEverything" = true ] || [ "$continue" = "y" ]; then
                safetocontinue=1
                echo "Removing $bindir/$filebasename"
                rm $bindir/$filebasename
            fi
            
        fi

    fi

    if [ "$safetocontinue" = "1" ]; then
        # Make this file executable then move it to $bindir
        chmod +x $filename
        cp $filename $bindir/$filebasename

        echo -e "${textGreen}Succesully installed $filebasename to $bindir${textReset}"
    else
        echo "Skipping ${textGreen}$filebasename${textReset}"
    fi

    printNewLine
}


#-------------------------------------------------------------------------------
# Read Flags
#-------------------------------------------------------------------------------

while getopts ":fno" option; do
    case "${option}" in
        n)
            onlyNewScripts=true
            ;;
        o)
            onlyOneScript=true
            ;;
        f)
            forceInstallEverything=true
            ;;
    esac
done
shift $((OPTIND-1))


#-------------------------------------------------------------------------------
# Main Program
#-------------------------------------------------------------------------------

# Prompt the user with what we're about to do

echo

if [ "$onlyNewScripts" = true ]; then
    echo "Attempting to install new shell scripts to $bindir"
elif [ "$onlyOneScript" = true ]; then
    echo "Attempting to install a single shell script to $bindir"
elif [ "$forceInstallEverything" = true ]; then
    echo "Forcing install of all shell scripts to $bindir"
else
    echo "Attempting to install all shell scripts to $bindir"
fi

echo

printNewLine


# Run the one script installer
if [ "$onlyOneScript" = true ]; then

    select opt in $(basename ./src/*.sh) "Quit"; do

        filename=./src/$opt

        # Get base file name
        filebasename=$(basename $opt .sh)

        printNewLine

        case "$opt" in
            Quit)
                echo "${textRed}Quitting${textReset}"
                exit;
                ;;
        esac

        # echo "$filebasename"
        installSingleScript $filename

        break

    done

    exit;
fi

# Run the every scrip installer
# Loop over every file in ./src
for filename in ./src/*.sh; do

    installSingleScript $filename

done
