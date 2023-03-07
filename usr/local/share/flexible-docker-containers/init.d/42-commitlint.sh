#!/bin/bash
# Copyright (c) 2022-2023, AllWorldIT.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.


# If we have no command line arguments, set it to commitlint
if [ "${#DOCKER_ARGS}" -eq 0 ]; then
    fdc_info "Setting up to run 'commitlint'"
    DOCKER_ARGS=(run-commitlint)
fi

# Check if we have a WORKDIR if not set it to /build
if [ -z "$CI_PROJECT_DIR" ]; then
    mkdir /build
    export CI_PROJECT_DIR=/build
fi
# shellcheck disable=SC2164
cd "$CI_PROJECT_DIR"

# Check if we have a commitlint configuration
commitlint_config=
for i in \
    .commitlintrc \
    .commitlintrc.json \
    .commitlintrc.yaml \
    .commitlintrc.yml \
    .commitlintrc.js \
    .commitlintrc.cjs \
    .commitlintrc.ts \
    .commitlintrc.cts \
    commitlint.config.js \
    commitlint.config.cjs \
    commitlint.config.ts \
    commitlint.config.cts
do
    if [ -e "$i" ]; then
        commitlint_config=$i
        break
    fi
done
# Perhapts the configuration is in package.json
if [ -e package.json ] && grep -q "commitlint" package.json; then
    commitlint_config=package.json
fi

# If no config was found add our own
if [ -z "$commitlint_config" ]; then
    fdc_notice "No commitlint configuration found, using defaults"
    cat <<EOF > .commitlintrc.yaml
extends:
  - '$(npm root -g)/@commitlint/config-conventional'
EOF
else
    fdc_notice "Using commitlint configuration '$commitlint_config'"
fi
