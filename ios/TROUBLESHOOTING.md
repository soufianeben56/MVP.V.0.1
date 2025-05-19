# Fehlerbehebung für iOS-Builds

Wenn du Probleme beim Bauen der App für iOS hast, überprüfe folgende häufige Fehlerquellen:

## "PhaseScription failed with a nonzero exit code" Fehler

Dieser Fehler kann verschiedene Ursachen haben:

### 1. Fehlende Berechtigungen in Info.plist

Überprüfe, ob die Info.plist alle benötigten Einträge enthält:
- Bluetooth-Berechtigungen
- Standort-Berechtigungen
- App-Transport-Security-Einstellungen

### 2. Probleme mit Cocoapods

```bash
# Cocoapods-Version überprüfen
pod --version

# Cocoapods aktualisieren
sudo gem install cocoapods

# Cocoapods-Repo aktualisieren
pod repo update
```

### 3. Inkompatible iOS-Zielversion

Stelle sicher, dass die iOS-Zielversion in Xcode auf 14.0 oder höher eingestellt ist:
- Runner > General > Deployment Info > iOS 14.0

### 4. Fehlende Signierungs-Berechtigungen

- Überprüfe, ob du das richtige Team ausgewählt hast
- Stelle sicher, dass dein Zertifikat und Provisioning-Profil gültig sind
- Prüfe, ob der Bundle-Identifier mit dem in deinem Apple Developer Account registrierten übereinstimmt

### 5. Bundle-Identifier-Probleme

Dies ist eine häufige Fehlerquelle:

- Der aktuelle Bundle-Identifier im Projekt ist `com.dev.infinitycircuit.infinityCircuit`
- Im funktionierenden Projekt war er `com.dev.devcircuitinfinity`
- Stelle sicher, dass der verwendete Bundle-Identifier in deinem Apple Developer-Konto registriert ist
- So änderst du den Bundle-Identifier in Xcode:
  1. Öffne Runner.xcworkspace
  2. Wähle links das Runner-Projekt
  3. Wähle den "Runner"-Target
  4. Gehe zum "Signing & Capabilities"-Tab
  5. Ändere den Bundle-Identifier unter "Bundle Identifier"
  6. Wiederhole dies für alle Build-Konfigurationen (Debug, Release, Profile)

### 6. Architektur-Probleme

Stelle sicher, dass du für die arm64-Architektur baust:
- Editor > New Build Configuration > Duplicate "Release" Configuration
- Benenne diese in "Release-prod"
- Wähle für alle Schemata "Release-prod" als Build-Konfiguration

### 7. Cache-Probleme

Manchmal helfen diese Schritte:
```bash
# Xcode-Cache leeren
rm -rf ~/Library/Developer/Xcode/DerivedData
rm -rf ~/Library/Caches/CocoaPods

# Neustarten von Xcode und Mac
```

### 8. Zugriff auf Ordner oder spezifische Dateien

Wenn Fehlermeldungen anzeigen, dass Xcode auf bestimmte Dateien nicht zugreifen kann:
- Überprüfe die Datei-Berechtigungen im Finder (Rechtsklick > Informationen > Freigabe & Berechtigungen)
- Stelle sicher, dass du Lese- und Schreibzugriff auf alle Projektdateien hast

### 9. Veraltete iOS-SDK-Version

- Überprüfe, ob die neueste Xcode-Version installiert ist
- Führe ein Software-Update für macOS durch

### 10. Konflikt-Auflösung

Falls Konflikte zwischen Bibliotheken auftreten:
```bash
cd ios
pod update --repo-update
```

## Wenn alle Lösungen fehlschlagen

Bitte teile folgende Informationen mit:
1. Vollständige Fehlermeldung aus Xcode
2. Liste der Schritte, die du bereits versucht hast
3. Xcode-Version und macOS-Version
4. Ergebnis des Befehls `flutter doctor -v` 