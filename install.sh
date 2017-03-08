bindir="/usr/local/bin"

echo "Attempting to install all shell scripts to $bindir"

# Loop over every file in ./src
for filename in ./src/*.sh; do

    echo

    # Get base file name
    filebasename=$(basename $filename .sh)

    # If file already exists in $bindir, delete it
    safetocontinue=1
    if [ -f $bindir/$filebasename ]; then
        safetocontinue=0
        echo "$filebasename already exists in $bindir."
        read -p "Do you want to replace it? (y/n) " continue

        if [ "$continue" = "y" ]; then
            safetocontinue=1
            echo "Removing $bindir/$filebasename"
            rm $bindir/$filebasename
        fi

    fi

    if [ "$safetocontinue" = "1" ]; then
        # Make this file executable then move it to $bindir
        chmod +x $filename
        cp $filename $bindir/$filebasename

        echo "Succesully installed $filebasename to $bindir"
    else
        echo "Skipping $filebasename"
    fi

    echo

done