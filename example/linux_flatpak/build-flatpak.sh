#!/bin/bash


# Convert the archive of the Flutter app to a Flatpak.


# Exit if any command fails
set -e

# Echo all commands for debug purposes
set -x

# No spaces in project name.
projectName=example
projectId=com.llfbandit.example
executableName=example
archiveName=$projectName-Linux.tar.gz

# ------------------------------- Build Flatpak ----------------------------- #

# Extract portable Flutter build.
mkdir -p $projectName
tar -xf $archiveName -C $projectName

# Copy the portable app to the Flatpak-based location.
pwd
cp -r $projectName /app/
chmod +x /app/$projectName/$executableName
mkdir -p /app/bin
ln -s /app/$projectName/$executableName /app/bin/$executableName

# Install the desktop file.
desktopFileDir=/app/share/applications
mkdir -p $desktopFileDir
cp -r $projectId.desktop $desktopFileDir/

