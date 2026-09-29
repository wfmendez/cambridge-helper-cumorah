/// Getting the app off the website and onto a device.
///
/// Only reachable on the web, because on a phone you are already holding the
/// installed thing. The binaries live in GitHub releases and not next to the
/// site: a 50 MB APK served from the host is bandwidth paid for nothing, and
/// a release is versioned, which a file in a folder is not.
library;

import 'package:flutter/material.dart';

import '../disposicion.dart';

import '../brand.dart';
import '../cambridge_theme.dart';
import '../widgets.dart';
import 'enlace.dart';

const _repo = 'https://github.com/wfmendez/cambridge-helper-cumorah';

/// `releases/latest/download/<name>` always resolves to the newest release,
/// so publishing a new one does not mean rebuilding the site to repoint it.
const _apk = '$_repo/releases/latest/download/cil-android.apk';
const _windows = '$_repo/releases/latest/download/cil-windows.zip';
const _releases = '$_repo/releases/latest';

/// Set by the build (`--dart-define=APP_VERSION=...`), so it cannot drift from
/// what was actually shipped. Empty in a local build, and then not shown.
const _version = String.fromEnvironment('APP_VERSION');

class DescargasScreen extends StatelessWidget {
  const DescargasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Install it'),
        actions: [
          if (_version.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: Pill(
                  _version,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
        ],
      ),
      body: Pagina(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        children: [
          Centrado(
            ancho: anchoLectura,
            child: ContentCard(
              color: theme.colorScheme.surfaceContainerLowest,
              child: Text(
                'This page already is the app — everything works in the browser, '
                'offline included, once it has loaded the first time. Installing '
                'only buys you an icon, no address bar, and not having to '
                'remember the address.',
                style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
              ),
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              final estirar = Rejilla.columnasPara(constraints.maxWidth) > 1;
              Widget tarjeta(Widget child) =>
                  estirar ? Expanded(child: child) : child;
              return Rejilla(
                rellenoCompacto: EdgeInsets.zero,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TituloMarcado(
                        'iPhone and iPad',
                        color: cambridgeReadable(
                          cambridgeBlue,
                          theme.colorScheme,
                        ),
                      ),
                      tarjeta(
                        ContentCard(
                          color: cambridgeBlue.withValues(alpha: 0.06),
                          border: cambridgeBlue.withValues(alpha: 0.3),
                          child: Text(
                            'There is nothing to download. Open this page in Safari, press '
                            'Share, then Add to Home Screen. It gets its own icon and opens '
                            'without the browser around it.\n\n'
                            'It has to be Safari — on iPhone, Chrome cannot add to the home '
                            'screen.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TituloMarcado(
                        'Android',
                        color: cambridgeReadable(
                          cambridgeGreen,
                          theme.colorScheme,
                        ),
                      ),
                      tarjeta(
                        _Descarga(
                          icono: Icons.android_rounded,
                          color: cambridgeGreen,
                          titulo: 'Download the APK',
                          detalle:
                              'Android will ask you to allow installing from your browser: '
                              'that is normal for an app that is not from the Play Store.\n\n'
                              'If you already have it installed, this installs over the top '
                              'and keeps your progress — you do not need to uninstall first.',
                          url: _apk,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TituloMarcado(
                        'Windows',
                        color: cambridgeReadable(
                          cambridgePurple,
                          theme.colorScheme,
                        ),
                      ),
                      tarjeta(
                        _Descarga(
                          icono: Icons.desktop_windows_rounded,
                          color: cambridgePurple,
                          titulo: 'Download the zip',
                          detalle:
                              'Unzip it anywhere and run Cíl.exe. Windows will warn you that '
                              'it does not recognise the publisher — the app is not signed '
                              'with a paid certificate. Choose More info, then Run anyway.',
                          url: _windows,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 26),
          Center(
            child: TextButton.icon(
              onPressed: () => _abrir(context, _releases),
              icon: const Icon(Icons.history_rounded, size: 18),
              label: const Text('All versions and what changed'),
            ),
          ),
        ],
      ),
    );
  }
}

/// Opens the address, or copies it if there is no browser to open it with.
Future<void> _abrir(BuildContext context, String url) async {
  if (await abrirEnlace(url)) return;
  if (context.mounted) copyToClipboard(context, url, 'Address copied');
}

class _Descarga extends StatelessWidget {
  const _Descarga({
    required this.icono,
    required this.color,
    required this.titulo,
    required this.detalle,
    required this.url,
  });

  final IconData icono;
  final Color color;
  final String titulo;
  final String detalle;
  final String url;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final c = cambridgeReadable(color, theme.colorScheme);

    return ContentCard(
      color: color.withValues(alpha: 0.06),
      border: color.withValues(alpha: 0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icono, color: c),
              const SizedBox(width: 10),
              Expanded(child: Text(titulo, style: theme.textTheme.titleSmall)),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            detalle,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () => _abrir(context, url),
            style: FilledButton.styleFrom(
              backgroundColor: c,
              foregroundColor: theme.colorScheme.surface,
            ),
            icon: const Icon(Icons.download_rounded, size: 18),
            label: const Text('Download'),
          ),
        ],
      ),
    );
  }
}
