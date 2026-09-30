/// Open a resource in a new web tab or the native device's default browser.
/// Callers retain a copyable address as a fallback.
library;

export 'enlace_io.dart' if (dart.library.js_interop) 'enlace_web.dart';
