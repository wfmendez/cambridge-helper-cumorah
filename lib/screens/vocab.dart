/// The word bank: read it, search it, then go and be tested on it.
///
/// Deliberately not a flashcard deck. Flashcards test recall of a word in
/// isolation, which is not what the exam asks; what it asks is whether the
/// word is the exact one for that sentence. So every entry carries a sentence
/// and the testing happens in Practice, where the marking already lives.
library;

import 'package:flutter/material.dart';

import '../disposicion.dart';

import '../brand.dart';
import '../cambridge_theme.dart';
import '../state.dart';
import '../vocab_data.dart';
import '../widgets.dart';

class VocabScreen extends StatefulWidget {
  const VocabScreen({super.key});

  @override
  State<VocabScreen> createState() => _VocabScreenState();
}

class _VocabScreenState extends State<VocabScreen> {
  final _busqueda = TextEditingController();
  String _filtro = '';

  @override
  void dispose() {
    _busqueda.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sets = vocabForGoal(AppScope.of(context).goal);
    final total = sets.fold<int>(0, (n, s) => n + s.entries.length);

    return Scaffold(
      appBar: AppBar(title: const Text('Word bank')),
      body: Column(
        children: [
          Centrado(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: TextField(
              controller: _busqueda,
              onChanged: (v) => setState(() => _filtro = v.trim()),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search_rounded),
                hintText: 'Search $total entries',
                border: const OutlineInputBorder(),
                isDense: true,
                suffixIcon: _filtro.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () {
                          _busqueda.clear();
                          setState(() => _filtro = '');
                        },
                      ),
              ),
            ),
          ),
          Expanded(
            child: _filtro.isEmpty
                ? _Listado(sets: sets)
                : _Resultados(sets: sets, filtro: _filtro),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Centrado(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
          child: Text(
            'Reading a list is not learning it. Come back to Practice and be '
            'tested on these.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.outline,
              height: 1.35,
            ),
          ),
        ),
      ),
    );
  }
}

class _Listado extends StatelessWidget {
  const _Listado({required this.sets});

  final List<VocabSet> sets;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Pagina(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        for (final s in sets)
          Seccion(
            titulo: TituloMarcado(
              s.name,
              color: cambridgeReadable(colourFor(s.level), theme.colorScheme),
            ),
            explicacion: Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 10, right: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      s.blurb,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        height: 1.45,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Pill('${s.entries.length}', color: theme.colorScheme.outline),
                ],
              ),
            ),
            maxColumnas: 1,
            rellenoCompacto: EdgeInsets.zero,
            children: [_Entradas(entries: s.entries)],
          ),
      ],
    );
  }
}

class _Resultados extends StatelessWidget {
  const _Resultados({required this.sets, required this.filtro});

  final List<VocabSet> sets;
  final String filtro;

  @override
  Widget build(BuildContext context) {
    final q = filtro.toLowerCase();
    // Busca en los tres campos: a veces recuerdas el significado y no la
    // palabra, que es justo cuando hace falta buscar.
    final hallados = [
      for (final s in sets)
        for (final e in s.entries)
          if (e.term.toLowerCase().contains(q) ||
              e.meaning.toLowerCase().contains(q) ||
              e.example.toLowerCase().contains(q))
            e,
    ];

    if (hallados.isEmpty) {
      return const EmptyState(
        icon: Icons.search_off_rounded,
        message: 'Nothing here matches that',
        detail: 'Try a shorter word, or part of one.',
      );
    }

    return Pagina(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
      children: [_Entradas(entries: hallados)],
    );
  }
}

/// En móvil conserva la tarjeta con divisores; en ancho cada entrada se puede
/// recorrer con la vista como una ficha completa, sin separar su ejemplo.
class _Entradas extends StatelessWidget {
  const _Entradas({required this.entries});
  final List<VocabEntry> entries;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      if (constraints.maxWidth < corteMedio) {
        return ContentCard(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          child: Column(
            children: [
              for (var i = 0; i < entries.length; i++) ...[
                if (i > 0) const Divider(height: 1),
                _Fila(entry: entries[i]),
              ],
            ],
          ),
        );
      }
      return Rejilla(
        maxColumnas: 2,
        children: [
          for (final e in entries)
            ContentCard(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              child: _Fila(entry: e),
            ),
        ],
      );
    },
  );
}

class _Fila extends StatelessWidget {
  const _Fila({required this.entry});

  final VocabEntry entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(entry.term, style: theme.textTheme.titleSmall),
          const SizedBox(height: 3),
          Text(
            entry.meaning,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 3,
                height: 16,
                margin: const EdgeInsets.only(top: 2, right: 9),
                color: cilGold,
              ),
              Expanded(
                child: Text(
                  entry.example,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
