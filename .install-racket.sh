
set -e

URL="https://mirror.racket-lang.org/installers/6.7/racket-6.7-x86_64-linux.sh"

INSTALLER="./racket-6.7-x86_64-linux.sh"

echo "Downloading $URL to $INSTALLER:"
curl -L -o $INSTALLER $URL

chmod u+rx "$INSTALLER"

RUN_INSTALLER="${INSTALLER}"


$RUN_INSTALLER <<EOF
no
"$RACKET_DIR"

EOF

exit 0
