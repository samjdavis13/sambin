#!/usr/bin/env bash

FILE=screenshot.png

if [ -f $FILE ]; then
   echo "File $FILE exists... deleting."
   rm $FILE;
else
   echo "File $FILE does not exist... Generating"
fi

# Generate screenshot
echo "Generating screenshot"
webkit2png http://localhost:5757 --ignore-ssl-check -F  --delay=1 -o screenshot --width=1440 --height=1080

# Crop it to just the top 2880x2160
echo "Cropping screenshot"
convert screenshot-full.png -crop 2880x2160+0+0 +repage screenshot-full.png

# Rename it to $FILE
mv screenshot-full.png $FILE

# Resize it to 1440x900
convert $FILE -resize 1440x900 $FILE

# Compress is with PNGQuant
echo "Compressing $FILE"

pngquant $FILE --ext -compressed.png

# Delete uncompressed version
rm $FILE

# Rename compressed version
mv screenshot-compressed.png $FILE