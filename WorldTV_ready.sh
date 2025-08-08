#!/bin/sh
# Crée le projet Android complet avec workflow GitHub Actions

mkdir -p app/src/main/java/com/worldtv
mkdir -p app/src/main/res
mkdir -p .github/workflows

cat > app/src/main/java/com/worldtv/MainActivity.java <<EOF
package com.worldtv;

import android.os.Bundle;
import androidx.appcompat.app.AppCompatActivity;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle b) {
        super.onCreate(b);
        TextView tv = new TextView(this);
        tv.setText("Bienvenue sur World TV !");
        tv.setTextSize(24);
        setContentView(tv);
    }
}
EOF

cat > app/src/main/AndroidManifest.xml <<EOF
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.worldtv">

    <application android:label="World TV">
        <activity android:name=".MainActivity">
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
    </application>
</manifest>
EOF

cat > build.gradle <<EOF
buildscript {
  repositories { google(); mavenCentral(); }
  dependencies { classpath 'com.android.tools.build:gradle:8.0.2' }
}
allprojects { repositories { google(); mavenCentral(); } }
EOF

cat > app/build.gradle <<EOF
plugins { id 'com.android.application' }
android {
  compileSdk 33
  defaultConfig { applicationId "com.worldtv"; minSdk 21; targetSdk 33; versionCode 1; versionName "1.0" }
  buildTypes { release { minifyEnabled false } }
}
dependencies { implementation 'androidx.appcompat:appcompat:1.6.1' }
EOF

echo "include ':app'" > settings.gradle

cat > .github/workflows/android.yml <<EOF
name: Build Android APK
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-java@v4
        with: java-version: '17', distribution: 'temurin'
      - uses: gradle/actions/setup-gradle@v3
      - run: gradle assembleDebug
      - uses: actions/upload-artifact@v4
        with: name: WorldTV-debug-apk
              path: app/build/outputs/apk/debug/*.apk
EOF

# Script terminé
echo "Fichiers générés. Commit, puis va dans Actions et récupère ton APK."
