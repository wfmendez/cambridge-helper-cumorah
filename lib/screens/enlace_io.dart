/// On a phone there is no browser to hand the address to. See enlace.dart.
library;

/// Always false: the caller falls back to copying the address, which is what
/// the rest of the app does anyway.
Future<bool> abrirEnlace(String url) async => false;
