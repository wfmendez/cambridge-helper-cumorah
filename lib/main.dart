/// Cíl — “goal” in Czech; My English Goal in full. Cambridge practice
/// for B1 Preliminary, B2 First and C1 Advanced.
///
/// This is the English section of Píle, pulled out so it can be handed to
/// classmates without dragging along a schedule, a to-do list or anything
/// personal. Practice and drafts stay local. Optional Writing reviews send
/// the chosen answer and task to the server only when requested.
library;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'state.dart';
import 'screens/english.dart';
import 'screens/tutorial.dart';
import 'theme.dart';
import 'reminders.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final state = await AppState.open();
  runApp(CilApp(state: state));
  unawaited(restoreLocalReminder(state.profile, state.goal.cefr));
}

class CilApp extends StatelessWidget {
  const CilApp({super.key, required this.state});

  final AppState state;

  @override
  Widget build(BuildContext context) {
    // El MaterialApp se reconstruye con el estado para que el cambio de tema
    // se aplique sin reiniciar la app.
    return AppScope(
      state: state,
      child: ListenableBuilder(
        listenable: state,
        builder: (context, _) => MaterialApp(
          title: 'Cíl · My English Goal',
          debugShowCheckedModeBanner: false,
          theme: lightTheme(),
          darkTheme: darkTheme(),
          themeMode: state.themeMode,
          shortcuts: {
            ...WidgetsApp.defaultShortcuts,
            // Match web scrolling on laptops running the native app too.
            // EditableText and controls keep their more local key bindings.
            const SingleActivator(LogicalKeyboardKey.arrowUp):
                const ScrollIntent(direction: AxisDirection.up),
            const SingleActivator(LogicalKeyboardKey.arrowDown):
                const ScrollIntent(direction: AxisDirection.down),
          },
          home: const _Inicio(),
        ),
      ),
    );
  }
}

/// La pantalla principal, que al primer arranque abre la bienvenida encima.
///
/// Se lanza tras el primer fotograma y no antes: si se abre durante el
/// arranque, el usuario ve un destello de la app debajo y parece un fallo.
class _Inicio extends StatefulWidget {
  const _Inicio();

  @override
  State<_Inicio> createState() => _InicioState();
}

class _InicioState extends State<_Inicio> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (AppScope.of(context).tutorialSeen) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => const PantallaTutorial(primeraVez: true),
        ),
      );
    });
  }

  // EnglishScreen trae su propio Scaffold: necesita la barra de navegación
  // inferior, y anidar dos Scaffold solo serviría para descuadrarla.
  @override
  Widget build(BuildContext context) => const EnglishScreen();
}
