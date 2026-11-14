# Sanad = Bazzite (Universal Blue) + Sanad branding, Arabic support and gaming extras.
# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /
COPY system_files /system_files

# Base image.
#   ghcr.io/ublue-os/bazzite          KDE desktop, AMD/Intel GPUs (also fine in VMs)
#   ghcr.io/ublue-os/bazzite-nvidia   KDE desktop with NVIDIA drivers
#   ghcr.io/ublue-os/bazzite-gnome    GNOME instead of KDE
FROM ghcr.io/ublue-os/bazzite:stable

### MODIFICATIONS (see build_files/build.sh)
RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    bash /ctx/build.sh

### LINTING
RUN bootc container lint
