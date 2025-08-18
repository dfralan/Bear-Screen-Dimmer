#!/bin/bash

# Script to convert PNG to ICNS format
echo "Converting PNG to ICNS format..."

# Check if icon.png exists
if [ ! -f "icon.png" ]; then
    echo "Error: icon.png not found in current directory"
    echo "Please place your PNG icon file as 'icon.png' in this directory"
    exit 1
fi

# Create iconset directory
mkdir -p bear-icon.iconset

# Generate all required icon sizes
echo "Generating icon sizes..."
for s in 16 32 64 128 256 512; do
    echo "Creating ${s}x${s} and ${s}x${s}@2x icons..."
    sips -z $s $s icon.png --out bear-icon.iconset/icon_${s}x${s}.png
    sips -z $(($s*2)) $(($s*2)) icon.png --out bear-icon.iconset/icon_${s}x${s}@2x.png
done

# Copy the original PNG as the largest @2x version
cp icon.png bear-icon.iconset/icon_512x512@2x.png

# Convert to ICNS
echo "Converting to ICNS format..."
iconutil -c icns bear-icon.iconset

# Clean up
echo "Cleaning up temporary files..."
rm -r bear-icon.iconset

echo "Icon conversion complete! bear-icon.icns created successfully."
