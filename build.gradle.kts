
buildscript {
    dependencies {
        classpath("com.android.tools.build:gradle:8.5.0")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.24")
        classpath("com.google.dagger:hilt-android-gradle-plugin:2.51.1")
    }
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
