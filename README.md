# Infinity Circuit

## Projekteinrichtung

### Voraussetzungen
- Flutter SDK installiert
- Xcode (für iOS-Entwicklung) - nur auf macOS verfügbar
- Android Studio oder VS Code

### Installation

1. **Clone das Repository:**
   ```
   git clone https://github.com/soufianeben56/MVP.V.0.1.git
   cd MVP.V.0.1
   ```

2. **Flutter-Abhängigkeiten installieren:**
   ```
   flutter pub get
   ```

3. **Für iOS-Entwicklung (nur auf macOS):**
   ```
   cd ios
   pod install
   ```
   
   **WICHTIGER HINWEIS:** Nach dem Klonen fehlen möglicherweise einige iOS-spezifische Dateien und Verzeichnisse, die nicht im Repository gespeichert sind. Der Befehl `pod install` generiert diese Dateien automatisch.

4. **Projekt öffnen:**
   - Für iOS: Öffne `ios/Runner.xcworkspace` in Xcode (nicht `Runner.xcodeproj`!)
   - Für Android: Öffne den Ordner `android` in Android Studio

### Fehlerbehandlung

- **Fehlende iOS-Dateien:** Wenn du das Projekt klonst und feststellst, dass Ordner wie `Pods`, `.symlinks`, `Runner.xcworkspace` usw. fehlen, ist das normal. Diese werden durch `pod install` generiert und sind im `.gitignore` ausgeklammert.

- **CocoaPods-Installation (falls benötigt):**
  ```
  sudo gem install cocoapods
  ```

- **Flutter Clean (bei Problemen):**
  ```
  flutter clean
  flutter pub get
  ```
  
- **Beim Wechsel von Branches oder nach einem Pull:**
  Es ist empfehlenswert, nach dem Wechseln von Branches oder nach einem Pull immer `flutter pub get` und bei iOS auch `pod install` auszuführen.

## Entwicklung

- Der Ordner `lib` enthält den Hauptquellcode der App.
- Assets befinden sich im Ordner `assets`.
- Platform-spezifischer Code ist in den Ordnern `android` und `ios`.

## Kontakt

Bei Fragen wende dich an das Entwicklungsteam.
