#!/usr/bin/env bash
# Builds the web app inside Vercel's build container.
#
# Vercel has no Flutter SDK and no way to install one, so the build fetches it
# itself. That is why this is a script and not a line in vercel.json: it needs
# explaining, and a one-liner in JSON cannot carry a comment.
#
# The alternative is building elsewhere and handing Vercel the finished folder,
# which is faster but needs an API token. This way the only thing Vercel needs
# is the connection to the repository that is already there.
set -euo pipefail

# La misma versión que usa el CI. Sin fijarla, una versión nueva de Flutter
# puede romper el despliegue sin que nadie haya tocado el proyecto.
VERSION_FLUTTER=3.47.1
SDK="$HOME/flutter"

echo "==> Fetching the Flutter SDK ($VERSION_FLUTTER)"
# --depth 1 sobre la etiqueta: el historial completo son cientos de megas que
# no se usan para nada.
git clone https://github.com/flutter/flutter.git \
  --depth 1 --branch "$VERSION_FLUTTER" "$SDK"
export PATH="$SDK/bin:$PATH"

# Sin esto la primera orden se para a preguntar por la telemetría.
export FLUTTER_SUPPRESS_ANALYTICS=true
flutter --version

echo "==> Resolving packages"
flutter pub get

# El número que se muestra en la página de descargas: el de pubspec con el
# commit detrás, para que se vea exactamente qué está publicado.
DECLARADA=$(grep -m1 '^version:' pubspec.yaml | sed 's/version:[[:space:]]*//')
VERSION="${DECLARADA%%+*}+${VERCEL_GIT_COMMIT_SHA:0:7}"
echo "==> Building $VERSION"

# --no-web-resources-cdn: sin esto el motor se descarga CanvasKit y la
# tipografía de respaldo desde gstatic.com en cada carga fría, lo que rompe el
# arranque sin conexión y manda una petición a Google que esta app no hace en
# ningún otro sitio.
flutter build web --release --no-web-resources-cdn \
  --dart-define=APP_VERSION="$VERSION"

echo "==> Built build/web"
