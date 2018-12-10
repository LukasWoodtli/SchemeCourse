
set -e

URL="https://mirror.racket-lang.org/installers/7.1/racket-7.1-x86_64-linux.sh"

INSTALLER="./racket-7.1-x86_64-linux.sh"

echo "Downloading $URL to $INSTALLER:"
curl -L -o $INSTALLER $URL

chmod u+rx "$INSTALLER"

RUN_INSTALLER="${INSTALLER}"


$RUN_INSTALLER <<EOF
no
"$RACKET_DIR"

EOF

exit 0
