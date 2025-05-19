import java.util.Properties
import java.io.FileInputStream
import java.io.File

// Define hardcoded keystore values as fallback
val storePassword = "Infinitysolutions4500B"
val keyPassword = "Infinitysolutions4500B"
val keyAlias = "infinityrelease"
val storeFilePath = "../new-release-key.jks"

println("🔍 Using hardcoded keystore values")
println("🔐 Keystore path: $storeFilePath")

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.dev.infinitycircuit.infinity_circuit_temp"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.dev.infinitycircuit.infinity_circuit_temp"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            keyAlias = "infinityrelease"
            keyPassword = "Infinitysolutions4500B"
            storeFile = file("../../new-release-key.jks")
            storePassword = "Infinitysolutions4500B"
        }
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            isShrinkResources = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

flutter {
    source = "../.."
}
