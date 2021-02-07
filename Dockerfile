FROM devkitpro/devkita64

# Add non-privileged build user
RUN useradd -m -s /bin/bash -G sudo build; passwd -d build

# Install fakeroot and updated git
RUN echo "deb http://deb.debian.org/debian stretch-backports main" >> /etc/apt/sources.list.d/stretch-backports.list &&\
    apt-get update &&\
    apt-get -t stretch-backports -y install git fakeroot

# Install devkitpro-pkgbuild-helpers
RUN dkp-pacman -S --noconfirm libnx

# Print installed pacman packages
RUN echo `dkp-pacman -Sl`

# Upgrade installed packages
RUN dkp-pacman -Suy --noconfirm

ENTRYPOINT ["/bin/bash"]
