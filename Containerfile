FROM archlinux

RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm      \
           base-devel          \
           fish                \
           fd                  \
           git                 \
           helix               \
           jujutsu             \
           just                \
           llvm                \
           nodejs              \
           npm                 \
           ripgrep             \
           rustup
ARG uid
ARG gid
ARG user

RUN groupadd -g $gid $user
RUN useradd -m -s /usr/bin/fish -u $uid -g $gid $user
WORKDIR /home/$user
USER $user
