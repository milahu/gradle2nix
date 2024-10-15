plugins {
    base
    alias(libs.plugins.kotlin.serialization) apply false
    id("com.github.ben-manes.versions") version "0.41.0"
    id("nl.littlerobots.version-catalog-update") version "0.8.4"
}

group = "org.nixos.gradle2nix"
version = property("VERSION") ?: "unspecified"

allprojects {
    repositories {
        mavenCentral()
        maven { url = uri("https://repo.gradle.org/gradle/libs-releases") }
        //maven { url = uri("https://plugins.gradle.org/m2/") }
    }
}

subprojects {
    group = rootProject.group
    version = rootProject.version
}

tasks {
    wrapper {
        gradleVersion = libs.versions.gradle.get()
        distributionType = Wrapper.DistributionType.ALL
    }
}
