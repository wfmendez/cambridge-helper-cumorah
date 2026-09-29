/// Opening an address, which only a browser can actually do here.
///
/// The app deliberately has no `url_launcher`: everywhere else it shows the
/// address and offers to copy it, which works offline and adds no dependency.
/// The downloads page is the one place that needs a real link, and it only
/// exists on the web, so the browser's own `window.open` is enough and
/// nothing new gets pulled in.
library;

export 'enlace_io.dart' if (dart.library.js_interop) 'enlace_web.dart';
