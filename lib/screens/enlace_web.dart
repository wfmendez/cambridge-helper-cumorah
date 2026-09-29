/// Handing the address to the browser. See enlace.dart.
library;

import 'package:web/web.dart' as web;

/// `noopener` porque abrir con `_blank` sin él deja a la página abierta un
/// puntero a la nuestra por `window.opener`.
Future<bool> abrirEnlace(String url) async {
  web.window.open(url, '_blank', 'noopener,noreferrer');
  return true;
}
