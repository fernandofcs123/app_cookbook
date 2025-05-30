// android/app/build.gradle.kts

plugins {
  id("com.android.application")
  id("kotlin-android")
  id("dev.flutter.flutter-gradle-plugin")
  // <-- **NÃO** coloque id("com.google.gms.google-services") aqui
}

android {
  namespace   = "com.example.app_cookbook"
  compileSdk  = 35
  ndkVersion  = "27.0.12077973"

  defaultConfig {
    applicationId = "com.example.app_cookbook"
    minSdk        = 23
    targetSdk     = 35
    versionCode   = flutter.versionCode
    versionName   = flutter.versionName
  }

  compileOptions {
    sourceCompatibility = JavaVersion.VERSION_11
    targetCompatibility = JavaVersion.VERSION_11
  }
  kotlinOptions {
    jvmTarget = JavaVersion.VERSION_11.toString()
  }
  buildTypes {
    release {
      signingConfig = signingConfigs.getByName("debug")
    }
  }
}

flutter {
  source = "../.."
}

dependencies {
  implementation("com.google.firebase:firebase-storage-ktx:20.3.0")
  // outras suas dependências...
}

// **Aplique** o plugin **após** o bloco de configuração:
apply(plugin = "com.google.gms.google-services")
