#!/bin/bash

# Dieses Script vorbereitet das iOS-Projekt für den Build

echo "Vorbereitung des iOS-Projekts für TestFlight..."

# Ins Projektverzeichnis wechseln
cd "$(dirname "$0")/.."
PROJECT_ROOT="$(pwd)"

echo "Projektverzeichnis: $PROJECT_ROOT"

# Flutter-Umgebung bereinigen
echo "Flutter-Cache bereinigen..."
flutter clean

# Flutter-Abhängigkeiten aktualisieren
echo "Flutter-Abhängigkeiten installieren..."
flutter pub get

# iOS-Verzeichnis für CocoaPods vorbereiten
echo "CocoaPods installieren..."
cd ios
pod install

echo "iOS-Projekt ist jetzt für den Build in Xcode bereit!"
echo "Öffne das Projekt mit: open Runner.xcworkspace"
echo ""
echo "Bitte stelle sicher, dass im Xcode:"
echo "1. Das richtige Team für Signing & Capabilities ausgewählt ist"
echo "2. Bundle-ID korrekt ist"
echo "3. Archiv mit Product > Archive erstellt wird"
echo "4. Archive über Xcode Organizer validiert und hochgeladen wird" 