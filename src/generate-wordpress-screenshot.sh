#!/usr/bin/env bash

FILE=screenshot.png

if [ -f $FILE ]; then
   echo "File $FILE exists... deleting."
   rm $FILE;
else
   echo "File $FILE does not exist... Generating"
fi

# Generate screenshot
webkit2png http://sjd.local:5757 --ignore-ssl-check -C --clipwidth=1200 --clipheight=900 --scale=0.75 --delay=2 -o screenshot

# Rename it to $FILE
mv screenshot-clipped.png $FILE

# Compress is with PNGQuant
echo "Compressing $FILE"

pngquant $FILE --ext -compressed.png

# Delete uncompressed version
rm $FILE

# Rename compressed version
mv screenshot-compressed.png $FILE