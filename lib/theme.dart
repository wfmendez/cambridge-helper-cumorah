/// The theme.
///
/// The colour schemes are written out by hand rather than generated from a
/// seed. `ColorScheme.fromSeed` is what makes most Flutter apps look like
/// each other: it produces a competent, interchangeable palette. Cíl uses
/// ink, paper and gold, and those three have to land where they were put.
///
/// Cambridge's own six colours live in `cambridge_theme.dart` and are used
/// only to tell the papers apart.
library;

import 'package:flutter/material.dart';

import 'brand.dart';

ThemeData lightTheme() => _build(_claro);
ThemeData darkTheme() => _build(_oscuro);

/// Light: ink on warm paper, gold for anything you act on.
const ColorScheme _claro = ColorScheme(
  brightness: Brightness.light,
  primary: cilInk,
  onPrimary: cilPaper,
  primaryContainer: Color(0xFFDCE3EE),
  onPrimaryContainer: cilInk,
  secondary: cilGold,
  onSecondary: cilInk,
  secondaryContainer: Color(0xFFF7E6C4),
  onSecondaryContainer: Color(0xFF4A3708),
  tertiary: Color(0xFF7A5C2E),
  onTertiary: cilPaper,
  error: Color(0xFFB3261E),
  onError: Colors.white,
  surface: cilPaper,
  onSurface: cilInk,
  surfaceContainerLowest: Color(0xFFFFFDF8),
  surfaceContainerLow: Color(0xFFF5F1E8),
  surfaceContainerHighest: Color(0xFFEDE8DC),
  onSurfaceVariant: Color(0xFF5A6377),
  outline: Color(0xFF8B93A3),
  outlineVariant: Color(0xFFDAD5C9),
);

/// Dark: the gold moves to primary so buttons carry the brand instead of
/// disappearing into a navy-on-navy screen.
const ColorScheme _oscuro = ColorScheme(
  brightness: Brightness.dark,
  primary: cilGold,
  onPrimary: cilInk,
  primaryContainer: Color(0xFF3D2F10),
  onPrimaryContainer: Color(0xFFF7E6C4),
  secondary: Color(0xFFEFC46B),
  onSecondary: cilInk,
  secondaryContainer: cilInkLift,
  onSecondaryContainer: cilPaper,
  tertiary: Color(0xFFD6B77E),
  onTertiary: cilInk,
  error: Color(0xFFF2B8B5),
  onError: Color(0xFF601410),
  surface: Color(0xFF0D1830),
  onSurface: Color(0xFFE8E4DA),
  surfaceContainerLowest: Color(0xFF0A1327),
  surfaceContainerLow: Color(0xFF13203A),
  surfaceContainerHighest: cilInkLift,
  onSurfaceVariant: Color(0xFFA9B2C4),
  outline: Color(0xFF6D7789),
  outlineVariant: Color(0xFF2A3A57),
);

ThemeData _build(ColorScheme esquema) {
  return ThemeData(
    colorScheme: esquema,
    useMaterial3: true,
    fontFamily: caraTexto,
    textTheme: _tipografia(esquema),
    scaffoldBackgroundColor: esquema.surface,
    // Una transición propia cambia la sensación de la app más que cualquier
    // otro ajuste suelto: es lo que se ve en cada toque.
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: _TransicionCil(),
        TargetPlatform.iOS: _TransicionCil(),
      },
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: EdgeInsets.zero,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: esquema.surface,
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontFamily: caraTitular,
        color: esquema.onSurface,
        fontSize: 21,
        fontVariations: peso(600),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
        textStyle: TextStyle(
          fontFamily: caraTexto,
          fontSize: 15,
          fontVariations: peso(650),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
        side: BorderSide(color: esquema.outlineVariant),
      ),
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: esquema.onSurface,
      unselectedLabelColor: esquema.onSurfaceVariant,
      indicatorColor: esquema.secondary,
      indicatorSize: TabBarIndicatorSize.label,
      dividerColor: esquema.outlineVariant,
      labelStyle: TextStyle(
        fontFamily: caraTexto,
        fontSize: 14,
        fontVariations: peso(650),
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: caraTexto,
        fontSize: 14,
        fontVariations: peso(500),
      ),
    ),
    dividerTheme: DividerThemeData(
      space: 1,
      thickness: 1,
      color: esquema.outlineVariant,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: esquema.secondary,
      thumbColor: esquema.secondary,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: esquema.secondary,
      linearTrackColor: esquema.outlineVariant,
    ),
  );
}

/// Entra deslizando desde abajo y con un desvanecido corto.
///
/// La transición por defecto de Android es una sacudida vertical larga; esta
/// es más corta y más plana, que es lo que pide una app donde se entra y se
/// sale de pantallas todo el rato.
class _TransicionCil extends PageTransitionsBuilder {
  const _TransicionCil();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curva = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
    return FadeTransition(
      opacity: curva,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.035),
          end: Offset.zero,
        ).animate(curva),
        child: child,
      ),
    );
  }
}

/// Elige entre la versión clara y la oscura de un color de acento.
Color byBrightness(
  ColorScheme esquema, {
  required Color light,
  required Color dark,
}) => esquema.brightness == Brightness.dark ? dark : light;

/// El verde de "esto está bien" y el ámbar de "ojo con esto".
///
/// Material 3 no trae color de éxito ni de aviso, así que hay que ponerlos a
/// mano. Se aclaran en modo oscuro: los que se leen bien sobre blanco quedan
/// apagados sobre una superficie oscura.
Color okGreen(ColorScheme esquema) => byBrightness(
  esquema,
  light: const Color(0xFF16A34A),
  dark: const Color(0xFF4ADE80),
);

Color warnAmber(ColorScheme esquema) => byBrightness(
  esquema,
  light: const Color(0xFFD97706),
  dark: const Color(0xFFFBBF24),
);

/// Fraunces anuncia, Inter explica.
///
/// El reparto es deliberado: lo que titula, nombra o es un número que hay que
/// notar va en la serif; lo que se lee sentado va en la sans. Los pesos se
/// piden por `fontVariations`, porque `fontWeight` a secas deja una fuente
/// variable en su instancia por defecto.
TextTheme _tipografia(ColorScheme esquema) {
  TextStyle titular(double tam, double w, {double alto = 1.15}) => TextStyle(
    fontFamily: caraTitular,
    fontSize: tam,
    height: alto,
    fontVariations: peso(w),
    color: esquema.onSurface,
  );
  TextStyle texto(double tam, double w, {double alto = 1.45}) => TextStyle(
    fontFamily: caraTexto,
    fontSize: tam,
    height: alto,
    fontVariations: peso(w),
    color: esquema.onSurface,
  );

  return TextTheme(
    displaySmall: titular(34, 800, alto: 1.05),
    headlineMedium: titular(29, 700),
    headlineSmall: titular(24, 700),
    titleLarge: titular(20, 600),
    titleMedium: titular(17, 600, alto: 1.3),
    titleSmall: titular(15, 600, alto: 1.3),
    bodyLarge: texto(16, 400),
    bodyMedium: texto(14.5, 400),
    bodySmall: texto(13, 400),
    labelLarge: texto(14, 600, alto: 1.2),
    labelMedium: texto(12.5, 600, alto: 1.2),
    labelSmall: texto(11.5, 600, alto: 1.2),
  );
}
