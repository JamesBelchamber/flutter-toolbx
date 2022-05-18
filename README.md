# Flutter Toolbx
A customised [Toolbx](https://containertoolbx.org/) image that includes everything necessary to develop with Flutter.

## Why?

Like with many development environments, Flutter requires the installation of a bunch of components that quickly make a mess of your OS. Toolbx is a tool for spinning up containers to be used as interactive environments.

Stuffing all of Flutter's "stuff" in a container allows us to keep our computers clean and tidy 😁 and stops Flutter packages and dependencies causing havoc with everything else we have on our computers 👀.

## How to use

### Prerequisites
* libvirt must be installed on the host:
  * Silverblue: `rpm-ostree install libvirt` (then reboot)
  * Fedora: `dnf install libvirt`
* Owen Taylor's [Toolbox VS Code Integration](https://github.com/owtaylor/toolbox-vscode) is recommended..
* ..as is the [Visual Studio Code Flatpak](https://flathub.org/apps/details/com.visualstudio.code).


### Creating a new container

```
toolbox create -i docker.io/jamesbelchamber/flutter-toolbx
```

### Entering your new container

```
toolbox enter flutter-toolbx
```

### Creating an Android Virtual Device
(from within the the toolbox)

First, download the relevant system image (you can see all images by running `sdkmanager --list` and looking for the entries that start `system-images;`):

```
sdkmanager "system-images;android-32;google_apis;x86_64"
```

Then create an avd (Android Virtual Device):

```
avdmanager create avd -n Pixel_5_API_32 -k "system-images;android-32;google_apis;x86_64"
```

Finally, use the emulator to start the device:

```
/opt/android/emulator/emulator @Pixel_5_API_32
```

See the [sdkmanager](https://developer.android.com/studio/command-line/sdkmanager), [avdmanager](https://developer.android.com/studio/command-line/avdmanager) and [emulator](https://developer.android.com/studio/run/emulator-commandline) pages of the Android Studio User Guide for more details.

### Starting Visual Studio Code

Simply run `code .` from the directory that contains the Flutter project!
