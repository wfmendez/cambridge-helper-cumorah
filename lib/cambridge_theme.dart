/// The official Cambridge English palette.
///
/// One deliberate exception: **the mock test is black and white**. When you
/// are sitting a paper you do not want brand colours, you want paper.
library;

import 'package:flutter/material.dart';

import 'cambridge.dart';

/// The six brand colours, as Cambridge publishes them.
const Color cambridgeRed = Color(0xFFD6083B);
const Color cambridgeBlue = Color(0xFF0072CF);
const Color cambridgeOrange = Color(0xFFEA7125);
const Color cambridgeGreen = Color(0xFF55A51C);
const Color cambridgePurple = Color(0xFF8F2BBC);
const Color cambridgeCyan = Color(0xFF00B1C1);

const List<Color> cambridgePalette = [
  cambridgeRed,
  cambridgeBlue,
  cambridgeOrange,
  cambridgeGreen,
  cambridgePurple,
  cambridgeCyan,
];

/// A fixed colour per paper, so each is recognisable at a glance.
/// El color de un nivel. Verde sube a azul y azul a morado, que es el orden
/// en que se suben los tres exámenes.
Color colourFor(ExamLevel level) => switch (level) {
  ExamLevel.b1 => cambridgeGreen,
  ExamLevel.b2 => cambridgeBlue,
  ExamLevel.c1 => cambridgePurple,
};

Color paperColour(String paperId) {
  if (paperId.contains('reading')) return cambridgeBlue;
  if (paperId.contains('writing')) return cambridgePurple;
  if (paperId.contains('listening')) return cambridgeCyan;
  if (paperId.contains('speaking')) return cambridgeOrange;
  return cambridgeBlue;
}

/// Spreads the palette across practice topics deterministically: the same
/// topic always comes out the same colour, with nothing stored anywhere.
Color topicColour(String temaId) =>
    cambridgePalette[temaId.hashCode.abs() % cambridgePalette.length];

/// The brand colours are vivid and were designed for a white background. On a
/// dark surface they have to be lightened or they lose contrast.
Color cambridgeReadable(Color base, ColorScheme esquema) {
  if (esquema.brightness != Brightness.dark) return base;
  return Color.lerp(base, Colors.white, 0.35)!;
}

// ── The paper ────────────────────────────────────────────────────────────────

/// Ink and paper for the mock. Fixed, not drawn from the theme: the sheet has
/// to look the same whether the phone is in light or dark mode, because it is
/// imitating something printed.
const Color paperBg = Color(0xFFFDFDFB);
const Color paperInk = Color(0xFF1A1A1A);
const Color paperGrey = Color(0xFF6B6B6B);
const Color paperRule = Color(0xFFCFCFCF);

/// Monochrome theme for the answer sheet.
///
/// No brand colour, no Material blue: black on off-white, like the booklet.
/// The only colour that appears is the marking, and it appears after you have
/// finished.
ThemeData paperTheme() {
  const esquema = ColorScheme.light(
    primary: paperInk,
    onPrimary: paperBg,
    secondary: paperGrey,
    surface: paperBg,
    onSurface: paperInk,
    onSurfaceVariant: paperGrey,
    outline: paperGrey,
    outlineVariant: paperRule,
    error: cambridgeRed,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: esquema,
    scaffoldBackgroundColor: paperBg,
    appBarTheme: const AppBarTheme(
      backgroundColor: paperBg,
      foregroundColor: paperInk,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: paperInk,
        fontSize: 19,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(color: paperInk, fontWeight: FontWeight.w600),
      titleSmall: TextStyle(color: paperInk, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(color: paperInk, height: 1.5),
      bodyMedium: TextStyle(color: paperInk, height: 1.5),
      bodySmall: TextStyle(color: paperGrey, height: 1.45),
      labelMedium: TextStyle(color: paperGrey, letterSpacing: 1.1),
      labelSmall: TextStyle(color: paperGrey),
      displaySmall: TextStyle(color: paperInk, fontWeight: FontWeight.w800),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      isDense: true,
      filled: false,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: paperRule),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: paperRule),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: paperInk, width: 1.4),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: paperRule),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: paperInk,
        foregroundColor: paperBg,
        shape: const RoundedRectangleBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: paperRule,
      space: 1,
      thickness: 1,
    ),
  );
}
