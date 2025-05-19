#!/bin/bash
# Setup-Skript für iOS-Build von Infinity Circuit

echo "🚀 Starting iOS build setup for Infinity Circuit..."
echo "----------------------------------------------------"

# Gehe zurück zum Projektverzeichnis
cd ..

echo "🧹 Cleaning previous build artifacts..."
flutter clean

echo "📂 Navigating to iOS directory..."
cd ios

echo "🗑️ Removing previous Pod integration..."
pod deintegrate

echo "🧽 Cleaning Pod cache..."
pod cache clean --all

echo "🗑️ Removing Pod directories..."
rm -rf Pods/
rm -rf .symlinks/
rm -rf Podfile.lock

echo "📦 Installing dependencies..."
cd ..
flutter pub get

echo "📱 Installing iOS Pods..."
cd ios
pod install

echo "✅ Setup completed!"
echo "----------------------------------------------------"
echo "Now open the project in Xcode with the following command:"
echo "open Runner.xcworkspace"
echo ""
echo "In Xcode, make sure to:"
echo "1. Set your Team for signing"
echo "2. Check that Bundle Identifier is correct"
echo "3. Ensure iOS Deployment Target is 14.0 or higher"
echo "4. Select 'Any iOS Device (arm64)' as build target"
echo "5. Run Product > Archive to create a build for TestFlight"
echo ""
echo "If you encounter any issues, refer to README_FOR_IOS_BUILD.md" 