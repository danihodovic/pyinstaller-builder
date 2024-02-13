# The executable that PyInstaller builds is not fully static, in that it still
# depends on the system libc. Under Linux, the ABI of GLIBC is backward
# compatible, but not forward compatible. So if you link against a newer GLIBC,
# you can't run the resulting executable on an older system. The supplied binary
# bootloader should work with older GLIBC. However, the libpython.so and other
# dynamic libraries still depends on the newer GLIBC. The solution is to compile
# the Python interpreter with its modules (and also probably bootloader) on the
# oldest system you have around, so that it gets linked with the oldest version
# of GLIBC.
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install --no-install-recommends -y \
  make build-essential libssl-dev \
  zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
  libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev \
  liblzma-dev ca-certificates git patchelf

ENV PYENV_ROOT="/root/.pyenv"
ENV PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"
ENV PYTHON_CONFIGURE_OPTS=--enable-shared
ENV POETRY_VIRTUALENVS_CREATE=false

RUN curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
