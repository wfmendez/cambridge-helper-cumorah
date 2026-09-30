/// Native apps open learning resources in the device's browser.
library;

import 'package:url_launcher/url_launcher.dart';

Future<bool> abrirEnlace(String url) async {
  final uri = Uri.tryParse(url);
  if (uri == null || uri.scheme != 'https' || uri.host.isEmpty) return false;
  try {
    return await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (_) {
    return false;
  }
}
