# Copyright (C) 2021-2025 by the FEM on Colab authors
#
# This file is part of FEM on Colab.
#
# SPDX-License-Identifier: MIT

set -e
set -x

# Expect one argument to set the scalar type
: ${1?"Usage: $0 scalar_type"}
SCALAR_TYPE="$1"
if [[ "$SCALAR_TYPE" != "complex" && "$SCALAR_TYPE" != "real" ]]; then
    echo "Expecting first input argument to be either real or complex, but got $SCALAR_TYPE"
    exit 1
fi

# Install petsc4py (and its dependencies)
SLEPC4PY_ARCHIVE_PATH="skip" source slepc4py/install.sh

# Install SLEPc
git clone https://gitlab.com/slepc/slepc.git /tmp/slepc-src
cd /tmp/slepc-src
./configure --prefix=$INSTALL_PREFIX
make SLEPC_DIR=$PWD PETSC_DIR=$INSTALL_PREFIX
make SLEPC_DIR=$PWD PETSC_DIR=$INSTALL_PREFIX install
rm -f $INSTALL_PREFIX/conf
ln -s $INSTALL_PREFIX/lib/slepc/conf $INSTALL_PREFIX/conf

# Install slepc4py
cd /tmp/slepc-src/src/binding/slepc4py/
PETSC_DIR=$INSTALL_PREFIX SLEPC_DIR=$INSTALL_PREFIX PYTHONUSERBASE=$INSTALL_PREFIX python3 -m pip install --check-build-dependencies --no-build-isolation --user .
cd && rm -rf /tmp/slepc-src
