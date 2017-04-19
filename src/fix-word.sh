#!/bin/bash

# Fixes "compile error in hidden module:link"
echo "Attempting to fix word..."
sudo rm -rf ~/Library/Group\ Containers/UBF8T346G9.Office/User\ Content.localized/Startup.localized/Word/*
echo "Removed all files from ~/Library/Group Containers/UBF8T346G9.Office/User Content.localized/Startup.localized/Word/"
echo "Word Fixed."