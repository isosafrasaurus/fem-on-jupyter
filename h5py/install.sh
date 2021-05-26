# Copyright (C) 2021 by the FEM on Colab authors
#
# This file is part of FEM on Colab.
#
# SPDX-License-Identifier: MIT

set -e
set -x

# Install mpi4py
MPI4PY_INSTALL_SCRIPT_PATH=${MPI4PY_INSTALL_SCRIPT_PATH:-"https://fem-on-colab.github.io/releases/mpi4py-install.sh"}
[[ $MPI4PY_INSTALL_SCRIPT_PATH == http* ]] && wget ${MPI4PY_INSTALL_SCRIPT_PATH} -O /tmp/mpi4py-install.sh && MPI4PY_INSTALL_SCRIPT_PATH=/tmp/mpi4py-install.sh
source $MPI4PY_INSTALL_SCRIPT_PATH

# Install zlib
apt install -y -qq zlib1g-dev

# Download and uncompress library archive
H5PY_ARCHIVE_PATH=${H5PY_ARCHIVE_PATH:-"H5PY_ARCHIVE_PATH_IN"}
[[ $H5PY_ARCHIVE_PATH == http* ]] && wget ${H5PY_ARCHIVE_PATH} -O /tmp/h5py-install.tar.gz && H5PY_ARCHIVE_PATH=/tmp/h5py-install.tar.gz
[[ $H5PY_ARCHIVE_PATH != skip ]] && tar -xzf $H5PY_ARCHIVE_PATH --strip-components=2 --directory=/usr/local || true
