
set -e

VERSION=7.2

INSTALLER="./racket-${VERSION}-x86_64-linux.sh"

URL="http://mirror.informatik.uni-tuebingen.de/mirror/racket/${VERSION}/${INSTALLER}"


echo "Downloading $URL to $INSTALLER:"
curl -L -o $INSTALLER $URL

chmod u+rx "$INSTALLER"

RUN_INSTALLER="${INSTALLER}"


$RUN_INSTALLER <<EOF
no
"$RACKET_DIR"

EOF

exit 0
