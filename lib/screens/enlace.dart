/// Opening an address, which only a browser can actually do here.
///
/// The app deliberately has no `url_launcher`: everywhere else it shows the
/// address and offers to copy it, which works offline and adds no dependency.
/// Web download buttons use the browser's own `window.open`. Native screens
/// offer a copyable address, without adding another dependency.
library;

export 'enlace_io.dart' if (dart.library.js_interop) 'enlace_web.dart';
