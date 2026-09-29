/// Anchos por contenido: leer necesita renglones cortos; elegir admite rejillas.
library;

import 'dart:math' as math;

import 'package:flutter/material.dart';

const double corteMedio = 600;
const double corteAmplio = 840;
const double anchoLectura = 720;
const double anchoMenu = 1200;

/// La lista conserva todo el viewport: rueda y scrollbar funcionan incluso
/// sobre los márgenes. En móvil el relleno es exactamente el de cada pantalla.
class Pagina extends StatelessWidget {
  const Pagina({
    super.key,
    required this.children,
    required this.padding,
    this.ancho = anchoMenu,
  });

  final List<Widget> children;
  final EdgeInsets padding;
  final double ancho;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final margen = (constraints.maxWidth - ancho) / 2;
      return ListView(
        padding: padding.copyWith(
          left: math.max(padding.left, margen),
          right: math.max(padding.right, margen),
        ),
        children: children,
      );
    },
  );
}

/// Para cabeceras y controles que no tienen su propio scroll. El límite mide
/// el contenido, igual que en Pagina, y deja intacto el relleno compacto.
class Centrado extends StatelessWidget {
  const Centrado({
    super.key,
    required this.child,
    this.ancho = anchoMenu,
    this.padding = EdgeInsets.zero,
  });

  final Widget child;
  final double ancho;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.topCenter,
    heightFactor: 1,
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: ancho + padding.horizontal),
      child: Padding(padding: padding, child: child),
    ),
  );
}

/// Filas de igual altura sin imponer una altura fija al texto. Las claves
/// conservan temporizadores, campos y tarjetas abiertas al cambiar de columnas.
class Rejilla extends StatefulWidget {
  const Rejilla({
    super.key,
    required this.children,
    this.anchoMinimo = 300,
    this.maxColumnas = 3,
    this.separacion = 16,
    this.rellenoCompacto = const EdgeInsets.only(bottom: 10),
  });

  final List<Widget> children;
  final double anchoMinimo;
  final int maxColumnas;
  final double separacion;
  final EdgeInsets rellenoCompacto;

  @override
  State<Rejilla> createState() => _RejillaState();
}

class _RejillaState extends State<Rejilla> {
  final _claves = <Object, GlobalKey>{};

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final columnas = constraints.maxWidth < corteMedio
          ? 1
          : ((constraints.maxWidth + widget.separacion) /
                    (widget.anchoMinimo + widget.separacion))
                .floor()
                .clamp(1, widget.maxColumnas);
      final ids = [
        for (var i = 0; i < widget.children.length; i++)
          widget.children[i].key ?? i,
      ];
      _claves.removeWhere((id, _) => !ids.contains(id));
      final hijos = [
        for (var i = 0; i < widget.children.length; i++)
          KeyedSubtree(
            key: _claves.putIfAbsent(ids[i], () => GlobalKey()),
            child: widget.children[i],
          ),
      ];
      if (columnas == 1) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final hijo in hijos)
              Padding(padding: widget.rellenoCompacto, child: hijo),
          ],
        );
      }
      return Column(
        children: [
          for (var i = 0; i < hijos.length; i += columnas)
            Padding(
              padding: EdgeInsets.only(bottom: widget.separacion),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (var j = 0; j < columnas; j++) ...[
                      if (j > 0) SizedBox(width: widget.separacion),
                      Expanded(
                        child: i + j < hijos.length
                            ? hijos[i + j]
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ],
                ),
              ),
            ),
        ],
      );
    },
  );
}

/// En ancho, la explicación acompaña a las opciones desde un aparte. Sin
/// explicación, el título encabeza la rejilla. En compacto no cambia el orden,
/// ni el espaciado que cada pantalla tenía entre explicación y tarjetas.
class Seccion extends StatelessWidget {
  const Seccion({
    super.key,
    this.titulo,
    this.explicacion,
    this.children = const [],
    this.maxColumnas = 3,
    this.anchoMinimo = 300,
    this.separacionIntro = 0,
    this.rellenoCompacto = const EdgeInsets.only(bottom: 10),
  });

  final Widget? titulo;
  final Widget? explicacion;
  final List<Widget> children;
  final int maxColumnas;
  final double anchoMinimo;
  final double separacionIntro;
  final EdgeInsets rellenoCompacto;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final aparte =
          constraints.maxWidth >= corteAmplio &&
          explicacion != null &&
          children.isNotEmpty;
      final intro = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [?titulo, ?explicacion],
      );
      final rejilla = Rejilla(
        maxColumnas: maxColumnas,
        anchoMinimo: anchoMinimo,
        rellenoCompacto: rellenoCompacto,
        children: children,
      );
      if (aparte) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 280, child: intro),
              const SizedBox(width: 32),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: titulo == null ? 0 : 24),
                  child: rejilla,
                ),
              ),
            ],
          ),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (children.isEmpty)
            Centrado(ancho: anchoLectura, child: intro)
          else
            intro,
          if (separacionIntro > 0) SizedBox(height: separacionIntro),
          if (children.isNotEmpty) rejilla,
        ],
      );
    },
  );
}
