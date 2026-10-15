# Fitness Music Recommender - Phone app

Play music for your workout and achieve your target exercise intensity.
The Fitness Music Recommender monitors your heart rate and selects a suitable song accordingly.
The app was developed as part of my bachelor's thesis at the
[University of Applied Sciences Düsseldorf](https://www.hs-duesseldorf.de/).

<img src="/Screenshot_20261006-175859.png" alt="app screenshot" width="250">

---

This repository contains the source code for the smartphone app. The app is written mostly in 
Dart / Flutter, but there is also some Android-specific Kotlin code for communication between the 
watch and the phone. At this time, only Android is supported, but the app could easily be adapted to 
work on iOS as well.

The app uses a git submodule called [FMRAndroidCore](https://github.com/simonldwg/fmr-android-core).
Cloning this repo should therefore be done recursively so that git also loads the submodule. The 
submodule contains a library which provides common code for the Wear OS (smartwatch) app and the 
Flutter app. The FMRAndroidCore module implements shared classes for message passing between the
watch and the phone.

---

## Getting Started

The app is built and installed using the Flutter SDK and the Android SDK command-line tools. 
The commands below are written for Unix-based systems (i.e. macOS / Linux). On Windows, the steps 
are the same, but environment variables have to be set with `setx` (or via the system settings) 
instead of `export`.

It is assumed that the developer options and USB debugging are already enabled on your phone.

### Setting up the toolchain
1. Install a JDK. **The Android Gradle plugin requires JDK 17 or newer.**
```shell
   # Linux (Debian / Ubuntu)
   sudo apt install openjdk-17-jdk
   # macOS with Homebrew
   brew install --cask temurin@17
```
You can check the installed version with `java -version`.

2. Install the Flutter SDK and add it to your `PATH`
```shell
   git clone https://github.com/flutter/flutter.git -b stable ~/development/flutter
   export PATH="$HOME/development/flutter/bin:$PATH"
```
To make the change permanent, add the `export` line to your `~/.bashrc` or `~/.zshrc`.

3. Install the Android SDK command-line tools. Download the "Command line tools only" package for 
   your OS from https://developer.android.com/studio#command-tools and unpack it into your SDK 
   folder:
```shell
   mkdir -p ~/Android/Sdk/cmdline-tools
   unzip commandlinetools-*_latest.zip -d ~/Android/Sdk/cmdline-tools
   mv ~/Android/Sdk/cmdline-tools/cmdline-tools ~/Android/Sdk/cmdline-tools/latest
   export ANDROID_HOME="$HOME/Android/Sdk"
   export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH"
```
Note: The folder **must be named `latest`**, otherwise `sdkmanager` cannot determine the SDK root. 
As in step 2, add the `export` lines to your shell profile.

4. Install the required SDK packages
```shell
   sdkmanager "platform-tools" "platforms;android-35" "build-tools;35.0.0"
```
You can list all available versions with `sdkmanager --list`. Any further components required by 
the project are downloaded automatically by Gradle during the first build.

5. Point Flutter to the Android SDK and accept the licenses
```shell
   flutter config --android-sdk "$ANDROID_HOME"
   flutter doctor --android-licenses
```
If you have multiple JDKs installed, specify the one to use with 
`flutter config --jdk-dir <path-to-jdk>`.

6. Verify the setup
```shell
   flutter doctor
```
The entries "Flutter" and "Android toolchain" should show a check mark. Warnings about Chrome, Xcode or
Android Studio can be ignored.

### Building and installing the app
1. Clone the repository **including the submodule**
```shell
   git clone --recurse-submodules https://github.com/simonldwg/fmr-phone
   cd fmr-phone
```
If you have already cloned the repository without the submodule, you can load it afterward:
```shell
   git submodule update --init --recursive
```

2. Install the Dart / Flutter dependencies
```shell
   flutter pub get
```

3. Connect your phone via USB and check that it is recognized
```shell
   adb devices
```
On the first connection, you have to confirm the "Allow USB debugging" dialog on your phone. The 
device should then be listed as `device`. If it is listed as `unauthorized`, the dialog has not 
been confirmed yet.
> Alternatively, you can connect wirelessly (Android 11+). Open 
> *Developer options → Wireless debugging → Pair device with pairing code* on your phone and run:  
> `adb pair <ip>:<pairing-port>`  
> `adb connect <ip>:<port>`

4. Build and run the app in debug mode
```shell
   flutter run
   # If multiple devices are connected, select one with -d <device-id> (see flutter devices)
```
This installs and starts the app with hot reload enabled. Note: The first build can take several 
minutes since Gradle needs to download the required dependencies first.

5. To build and install a proper release APK of the app that runs natively and without a Dart VM, run
```shell
   flutter build apk --release
   adb install -r build/app/outputs/flutter-apk/app-release.apk
```
