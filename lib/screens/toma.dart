/// Where a speaking take lives — the one thing this app cannot do the same
/// way on a phone and in a browser.
///
/// On a phone a take is a file in the cache directory, so it survives leaving
/// the screen and can be deleted by name. In a browser there is no file
/// system: `record` hands back a blob URL that lives in the tab's memory and
/// dies with it. The two are different enough that hiding the difference
/// behind `kIsWeb` checks scattered through the widget would be worse than
/// this — one small class, written twice, chosen at compile time.
///
/// The conditional import is on `dart.library.js_interop` rather than the old
/// `dart.library.html`, which does not exist in a wasm build.
library;

export 'toma_io.dart' if (dart.library.js_interop) 'toma_web.dart';
