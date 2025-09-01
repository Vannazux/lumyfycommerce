#!/bin/sh
set -e

# Repositório e branch podem ser substituídos com variáveis de ambiente
: "${BAGISTO_REPO:=https://github.com/bagisto/bagisto}"
: "${BAGISTO_BRANCH:=master}"

if [ ! -f /var/www/html/.env.example ]; then
  echo "No .env.example in /var/www/html — cloning ${BAGISTO_REPO} (branch ${BAGISTO_BRANCH})..."
  tmpdir=$(mktemp -d)
  git clone --depth 1 --branch "${BAGISTO_BRANCH}" "${BAGISTO_REPO}" "${tmpdir}"
  cp -a "${tmpdir}/." /var/www/html/
  rm -rf "${tmpdir}"
  echo "Files copied to /var/www/html"
fi

if [ -x /usr/local/bin/init-bagisto.sh ]; then
  /usr/local/bin/init-bagisto.sh
fi

exec "$@"
