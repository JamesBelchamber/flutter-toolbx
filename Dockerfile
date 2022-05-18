FROM registry.fedoraproject.org/fedora-toolbox:36

# Install necessary packages
# (We install Chrome here to enable testing of Web builds)
RUN dnf -y install virt-install virt-manager clang cmake ninja-build gtk3-devel fedora-workstation-repositories java-11-openjdk-devel && dnf config-manager --set-enabled google-chrome && dnf -y install google-chrome-stable && dnf clean all

# Install the Android Command Line Tools
# (These need to be in a very specific place to work)
# Accept licences and install some starter SDKs
# Make Android files world-rw and directories world-rwx
RUN mkdir -p /opt/android/cmdline-tools && wget https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip && unzip commandlinetools-linux-8512546_latest.zip -d /opt/android/cmdline-tools && mv /opt/android/cmdline-tools/{cmdline-tools,tools} && rm commandlinetools-linux-8512546_latest.zip && yes | /opt/android/cmdline-tools/tools/bin/sdkmanager --licenses && yes | /opt/android/cmdline-tools/tools/bin/sdkmanager "emulator" "platform-tools" && yes | /opt/android/cmdline-tools/tools/bin/sdkmanager "cmdline-tools;latest" && chmod -R o+rw /opt/android && find /opt/android -type d -exec chmod o+x {} +

# Install Flutter under /opt
# Make Flutter files world-rw and directories world-rwx
RUN wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.0.0-stable.tar.xz && tar xf flutter_linux_3.0.0-stable.tar.xz --directory /opt && rm flutter_linux_3.0.0-stable.tar.xz && chmod -R o+rw /opt/flutter && chmod -R o+rw /opt/flutter

# Add Flutter and Android binaries to PATH
RUN echo export PATH="$PATH:/opt/flutter/bin:/opt/android/cmdline-tools/tools/bin" >> /etc/profile.d/sh.local