#!/bin/bash

# Build script for BearScreenDimmer
echo "Building BearScreenDimmer.app..."

# Set variables
APP_NAME="BearScreenDimmer"
BUNDLE_ID="com.bearscreendimmer.app"
VERSION="1.0"
BUILD_DIR="build"
APP_BUNDLE="$BUILD_DIR/$APP_NAME.app"
CONTENTS_DIR="$APP_BUNDLE/Contents"
MACOS_DIR="$CONTENTS_DIR/MacOS"
RESOURCES_DIR="$CONTENTS_DIR/Resources"

# Create build directory structure
mkdir -p "$MACOS_DIR"
mkdir -p "$RESOURCES_DIR"

# Compile the Swift files
echo "Compiling Swift files..."
swiftc -target x86_64-apple-macos13.0 \
       -framework AppKit \
       -framework SwiftUI \
       -framework Foundation \
       -o "$MACOS_DIR/$APP_NAME" \
       BearScreenDimmerApp.swift \
       AppDelegate.swift \
       OverlayContentView.swift

# Copy resources
echo "Copying resources..."
cp bear-icon.icns "$RESOURCES_DIR/"

# Create the Info.plist
cat > "$CONTENTS_DIR/Info.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleDevelopmentRegion</key>
    <string>en</string>
    <key>CFBundleExecutable</key>
    <string>$APP_NAME</string>
    <key>CFBundleIconFile</key>
    <string>bear-icon.icns</string>
    <key>CFBundleIdentifier</key>
    <string>$BUNDLE_ID</string>
    <key>CFBundleInfoDictionaryVersion</key>
    <string>6.0</string>
    <key>CFBundleName</key>
    <string>$APP_NAME</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>$VERSION</string>
    <key>CFBundleVersion</key>
    <string>1</string>
    <key>LSMinimumSystemVersion</key>
    <string>13.0</string>
    <key>LSUIElement</key>
    <true/>
    <key>NSHighResolutionCapable</key>
    <true/>
    <key>NSPrincipalClass</key>
    <string>NSApplication</string>
</dict>
</plist>
EOF

# Make the app executable
chmod +x "$MACOS_DIR/$APP_NAME"

echo "Build complete! App bundle created at: $APP_BUNDLE"
echo "You can now test the app by opening: $APP_BUNDLE"
