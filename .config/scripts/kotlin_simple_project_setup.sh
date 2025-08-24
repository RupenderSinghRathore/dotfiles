#!/bin/bash

echo 'plugins { id "org.jetbrains.kotlin.jvm" version "2.2.0" }' > build.gradle.kts && mkdir -p src/main/kotlin && touch src/main/kotlin/Main.kt
