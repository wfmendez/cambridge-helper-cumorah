# -*- coding: utf-8 -*-
"""Draws the Cíl mark and writes every icon the app needs.

The mark is code rather than a drawing so it can be re-rendered at any size
without going soft, and so the logo and the one the app paints on screen
(`MarcaCil` in lib/brand.dart) stay the same shape — they are the same
geometry written twice.

    python marca.py

Writes assets/marca/logo.png, assets/marca/tamanos.png, the five
android/app/src/main/res/mipmap-*/ic_launcher.png, the iOS set in
ios/Runner/Assets.xcassets/AppIcon.appiconset/, the web set in web/ and the
multi-size .ico for the Windows runner.
"""
import io
import json
import math
import os

from PIL import Image, ImageDraw

SS = 8                                  # supersampling, for clean curves
TINTA = (18, 32, 58)                    # cilInk
PAPEL = (250, 247, 240)                 # cilPaper
ORO = (227, 167, 47)                    # cilGold

# Everything below is a fraction of the side, so one description serves
# every size. Keep these in step with _PintorMarca in lib/brand.dart.
R_FUERA, W_FUERA = 0.355, 0.085
R_DENTRO, W_DENTRO = 0.195, 0.075
W_TIRO, HUECO = 0.058, 0.028            # trajectory, and the gap it opens
PUNTA = 0.155
# The shot: in from the bottom-left, bowed upwards, into the middle. A
# quadratic Bézier; the control point is what bows it. It starts off the
# canvas on purpose, so the line enters the icon instead of beginning in it.
TIRO = ((-0.030, 0.880), (0.180, 0.400), (0.500, 0.500))

DENSIDADES = {'mdpi': 48, 'hdpi': 72, 'xhdpi': 96, 'xxhdpi': 144,
              'xxxhdpi': 192}


def bezier(p0, p1, p2, pasos):
    pts = []
    for i in range(pasos + 1):
        t = i / pasos
        u = 1 - t
        pts.append((u * u * p0[0] + 2 * u * t * p1[0] + t * t * p2[0],
                    u * u * p0[1] + 2 * u * t * p1[1] + t * t * p2[1]))
    return pts


class Marca:
    """The mark on a square canvas of `lado` pixels."""

    def __init__(self, lado, fondo=TINTA):
        self.lado = lado
        self.n = lado * SS
        self.img = Image.new('RGB', (self.n, self.n), fondo)
        self.d = ImageDraw.Draw(self.img)

    def _traza(self, pts, w, color, w0=None):
        """A stroked path, stamped as a run of overlapping discs.

        Pillow draws a wide line as a butt-ended rectangle, so a curve made
        of segments comes out with a serrated edge. Discs give a smooth edge
        and round caps at no extra effort."""
        w0 = w if w0 is None else w0
        ultimo = max(1, len(pts) - 1)
        for i, (x, y) in enumerate(pts):
            # Ancha al llegar, fina al salir: el trazo tiene sentido de
            # marcha, que es lo que lo aleja de una flecha de biblioteca.
            r = (w0 + (w - w0) * i / ultimo) * self.n / 2
            x, y = x * self.n, y * self.n
            self.d.ellipse([x - r, y - r, x + r, y + r], fill=color)

    def anillo(self, r, w, color):
        r, w = r * self.n, w * self.n
        c = self.n / 2
        self.d.ellipse([c - r, c - r, c + r, c + r], outline=color,
                       width=int(w))

    def tiro(self, fondo):
        """The trajectory, with a gap knocked out where it crosses a ring.

        Without the gap the gold just sits on top of the rings and the icon
        reads as two drawings stacked; with it, the arrow passes through."""
        pts = bezier(*TIRO, pasos=900)
        cuerpo = pts[:-70]
        self._traza(cuerpo, W_TIRO + HUECO * 2, fondo,
                    w0=W_TIRO * 0.45 + HUECO * 2)
        self._traza(cuerpo, W_TIRO, ORO, w0=W_TIRO * 0.45)

        fin, antes = pts[-1], pts[-40]
        ang = math.atan2(fin[1] - antes[1], fin[0] - antes[0])
        self.punta(fin, ang, fondo, PUNTA + HUECO * 1.4)
        self.punta(fin, ang, ORO, PUNTA)

    def punta(self, tip, ang, color, largo):
        x, y = tip[0] * self.n, tip[1] * self.n
        largo *= self.n
        alas = [(x + math.cos(ang + math.pi + math.radians(24 * s)) * largo,
                 y + math.sin(ang + math.pi + math.radians(24 * s)) * largo)
                for s in (1, -1)]
        hueco = (x + math.cos(ang + math.pi) * largo * 0.46,
                 y + math.sin(ang + math.pi) * largo * 0.46)
        self.d.polygon([(x, y), alas[0], hueco, alas[1]], fill=color)

    def dibuja(self, fondo=TINTA):
        self.anillo(R_FUERA, W_FUERA, PAPEL)
        self.anillo(R_DENTRO, W_DENTRO, PAPEL)
        self.tiro(fondo)
        return self

    def imagen(self):
        return self.img.resize((self.lado, self.lado), Image.LANCZOS)


def icono(lado):
    return Marca(lado).dibuja().imagen()


def tamanos(ruta):
    """A strip of the icon at the sizes Android actually shows it at.

    Worth looking at before shipping: a mark that works at 512 and dies at
    48 is not a launcher icon."""
    lados = [192, 96, 72, 48]
    hueco = 18
    ancho = sum(lados) + hueco * (len(lados) + 1)
    hoja = Image.new('RGB', (ancho, 192 + hueco * 2), (24, 24, 26))
    x = hueco
    for lado in lados:
        hoja.paste(icono(lado), (x, hueco + (192 - lado) // 2))
        x += lado + hueco
    hoja.save(ruta)


APPICONSET = os.path.join('ios', 'Runner', 'Assets.xcassets',
                          'AppIcon.appiconset')


def iconos_ios(raiz):
    """Every size the iOS asset catalogue asks for, taken from the catalogue.

    The list of sizes lives in Contents.json and not here: Xcode owns that
    file, so a size added or dropped there should not need a second edit in
    this script. One file often serves both iPhone and iPad, hence the
    dictionary — drawing it twice would only cost time.

    iOS rejects a launcher icon with an alpha channel; `icono` returns RGB,
    so there is nothing to flatten.
    """
    carpeta = os.path.join(raiz, APPICONSET)
    with io.open(os.path.join(carpeta, 'Contents.json'), encoding='utf-8') as f:
        catalogo = json.load(f)

    lados = {}
    for entrada in catalogo['images']:
        # 83.5x83.5 @2x sale a 167 px: de ahí el float y el redondeo.
        medida = float(entrada['size'].split('x')[0])
        lados[entrada['filename']] = round(medida * int(entrada['scale'][0]))

    for nombre, lado in sorted(lados.items(), key=lambda par: par[1]):
        destino = os.path.join(carpeta, nombre)
        icono(lado).save(destino)
        print('   %s (%d px)' % (destino, lado))


WEB_ICONOS = {
    'favicon.png': 32,
    os.path.join('icons', 'Icon-192.png'): 192,
    os.path.join('icons', 'Icon-512.png'): 512,
    os.path.join('icons', 'Icon-maskable-192.png'): 192,
    os.path.join('icons', 'Icon-maskable-512.png'): 512,
    # iOS no mira manifest.json para el icono de la pantalla de inicio: usa
    # el apple-touch-icon de index.html, y lo quiere a 180.
    os.path.join('icons', 'Icon-apple-180.png'): 180,
}


def iconos_web(raiz):
    """What a browser and an iPhone's home screen ask for.

    The maskable ones are the same drawing as the plain ones, on purpose. A
    maskable icon has to keep whatever matters inside a circle 80% of the
    side, in case the launcher crops it to a circle; the outer ring here sits
    at 71%, so it already does. Padding the mark down to make room would only
    render it smaller for nothing, and would cut the trajectory loose from the
    edge it is drawn entering from.
    """
    for nombre, lado in sorted(WEB_ICONOS.items(), key=lambda par: par[1]):
        destino = os.path.join(raiz, 'web', nombre)
        os.makedirs(os.path.dirname(destino), exist_ok=True)
        icono(lado).save(destino)
        print('   %s (%d px)' % (destino, lado))


def icono_windows(raiz):
    """The .ico the Windows runner compiles into the executable.

    One file holding several sizes: Windows picks from it by context — 16 for
    the title bar, 32 for the taskbar, 256 for the large view in Explorer —
    and picking is better than letting it scale one down.
    """
    destino = os.path.join(raiz, 'windows', 'runner', 'resources',
                           'app_icon.ico')
    lados = [16, 24, 32, 48, 64, 128, 256]
    # Pillow escribe las demás medidas del .ico reescalando la imagen que se
    # le da, así que se le da la mayor ya dibujada a su tamaño.
    icono(256).save(destino, sizes=[(l, l) for l in lados])
    print('   %s (%s px)' % (destino, ', '.join(str(l) for l in lados)))


def main():
    raiz = os.path.dirname(os.path.abspath(__file__))
    os.makedirs(os.path.join(raiz, 'assets', 'marca'), exist_ok=True)

    logo = os.path.join(raiz, 'assets', 'marca', 'logo.png')
    icono(512).save(logo)
    print('   %s' % logo)

    tam = os.path.join(raiz, 'assets', 'marca', 'tamanos.png')
    tamanos(tam)
    print('   %s' % tam)

    for densidad, lado in DENSIDADES.items():
        destino = os.path.join(raiz, 'android', 'app', 'src', 'main', 'res',
                               'mipmap-' + densidad, 'ic_launcher.png')
        icono(lado).save(destino)
        print('   %s (%d px)' % (destino, lado))

    iconos_ios(raiz)
    iconos_web(raiz)
    icono_windows(raiz)


if __name__ == '__main__':
    main()
