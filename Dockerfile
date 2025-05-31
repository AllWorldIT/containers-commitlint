# Copyright (c) 2022-2025, AllWorldIT.
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


FROM registry.conarx.tech/containers/alpine/3.22


ARG VERSION_INFO=
LABEL org.opencontainers.image.authors   = "Nigel Kukard <nkukard@conarx.tech>"
LABEL org.opencontainers.image.version   = "3.22"
LABEL org.opencontainers.image.base.name = "registry.conarx.tech/containers/alpine/3.22"


ENV FDC_DISABLE_SUPERVISORD=true
ENV FDC_QUIET=true


RUN set -eux; \
	true "Node"; \
	apk add --no-cache \
		git \
		npm \
		sqlite-libs; \
	true "Cleanup"; \
	rm -f /var/cache/apk/*

# Install commitlint
RUN set -eux; \
	npm install -g @commitlint/cli @commitlint/config-conventional; \
	# Remove things we dont need
	rm -f /usr/local/share/flexible-docker-containers/tests.d/40-crond.sh; \
	rm -f /usr/local/share/flexible-docker-containers/tests.d/90-healthcheck.sh

# Commitlint
COPY usr/local/bin/run-commitlint /usr/local/bin
COPY usr/local/share/flexible-docker-containers/pre-init-tests.d/42-commitlint.sh /usr/local/share/flexible-docker-containers/pre-init-tests.d
COPY usr/local/share/flexible-docker-containers/init.d/42-commitlint.sh /usr/local/share/flexible-docker-containers/init.d
COPY usr/local/share/flexible-docker-containers/tests.d/42-commitlint.sh /usr/local/share/flexible-docker-containers/tests.d
RUN set -eux; \
	true "Flexible Docker Containers"; \
	if [ -n "$VERSION_INFO" ]; then echo "$VERSION_INFO" >> /.VERSION_INFO; fi; \
	true "Permissions"; \
	chown root:root \
		/usr/local/bin/run-commitlint; \
	chmod 0755 \
		/usr/local/bin/run-commitlint; \
	fdc set-perms
