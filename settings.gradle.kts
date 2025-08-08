
pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}
dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
    }
}
rootProject.name = "WorldTV"
include(":app", ":domain", ":data", ":feature-live", ":feature-vod", ":feature-series", ":feature-replay", ":feature-auth", ":feature-settings", ":ui-components")
