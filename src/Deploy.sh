#!/bin/bash
set -Ceuo pipefail

webdir=/var/www/html

cd $(dirname $0)


sudoflags=$(ruby -e "s=File.stat('${webdir}'); printf '-u #%s -g #%s', s.uid, s.gid")

test -d ${webdir}/wxsymbols || sudo $sudoflags mkdir --mode=0755 ${webdir}/wxsymbols

sudo $sudoflags cp -ruv ../img/* ${webdir}/wxsymbols
