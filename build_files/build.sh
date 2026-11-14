#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Branding
# Only NAME / PRETTY_NAME change. ID and VARIANT_ID stay as Bazzite ships them,
# because Bazzite's own tooling (ujust, updaters) depends on them.
sed -i 's/^NAME=.*/NAME="Sanad"/; s/^PRETTY_NAME=.*/PRETTY_NAME="Sanad"/' /usr/lib/os-release
echo "Sanad" > /etc/hostname

### Packages (each one best-effort so a renamed package never breaks the build)
install_optional() {
  for p in "$@"; do
    dnf5 install -y "$p" || echo "skipped package: $p"
  done
}

# Arabic fonts + common utilities
install_optional \
  amiri-fonts \
  google-noto-naskh-arabic-fonts \
  google-noto-sans-arabic-fonts \
  sil-scheherazade-new-fonts \
  liberation-fonts \
  btop \
  p7zip \
  p7zip-plugins

### First-login helper
chmod 0755 /usr/libexec/sanad-first-login

### Services
systemctl enable podman.socket || true
