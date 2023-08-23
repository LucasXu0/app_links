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
baseDir=$(pwd)

# ----------------------------- Build Flutter app ---------------------------- #

flutter pub get
flutter build linux

cd build/linux/x64/release/bundle || exit
tar -czaf $archiveName ./*
mv $archiveName "$baseDir"/linux_flatpak/

