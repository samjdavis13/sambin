#!/bin/bash

# Fixes "compile error in hidden module:link"
echo "Attempting to fix word..."
sudo rm Library/Group\ Containers/UBF8T346G9.Office/User\ Content.localized/Startup.localized/Word/*
echo "Word Fixed."