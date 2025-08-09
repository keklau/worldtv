// Root build.gradle.kts

plugins {
    // Android plugin déclaré ici mais pas appliqué à la racine
    id("com.android.application") version "8.5.2" apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Tâche de nettoyage
tasks.register("clean", Delete::class) {
    delete(layout.buildDirectory)
}
