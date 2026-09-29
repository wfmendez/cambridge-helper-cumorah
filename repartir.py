# -*- coding: utf-8 -*-
"""Hands out the APK over the classroom wifi, using a QR code.

Starts a server on this laptop and shows a QR. Students scan it, their phone
downloads the file and opens it. No cable, no account, no developer mode, and
nothing uploaded anywhere: the file never leaves the local network.

    python repartir.py

Ctrl+C to stop. While it runs, the laptop has to stay on and on the same wifi
as the phones.
"""
import http.server
import io
import os
import socket
import socketserver
import sys
import threading
import webbrowser

PUERTO = 8000
APK = 'build/app/outputs/flutter-apk/app-release.apk'
NOMBRE = 'Cil.apk'


def ip_local():
    """This machine's address on the local network.

    Opens a socket outwards without actually sending anything: it is the
    reliable way to learn which interface the system would use, rather than
    trusting the host name, which on Windows tends to return 127.0.0.1.
    """
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    try:
        s.connect(('10.255.255.255', 1))
        return s.getsockname()[0]
    except OSError:
        return '127.0.0.1'
    finally:
        s.close()


PAGINA = """<!doctype html>
<html lang="en"><head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Cíl</title>
<style>
  body {{ font-family: system-ui, sans-serif; background:#12203A;
         color:#FAF7F0; margin:0; min-height:100vh; display:flex;
         align-items:center; justify-content:center; text-align:center; }}
  .caja {{ padding: 32px 24px; max-width: 420px; }}
  .marca {{ margin-bottom: 14px; }}
  h1 {{ font-size: 46px; margin: 0 0 4px; letter-spacing:-.01em; }}
  .nombre {{ font-size:19px; margin-bottom:10px; opacity:.92; }}
  .glosa {{ opacity:.55; font-style:italic; margin-bottom:28px;
            font-size:14px; letter-spacing:.06em; text-transform:uppercase; }}
  a.boton {{ display:block; background:#E3A72F; color:#12203A; padding:18px;
             border-radius:14px; text-decoration:none; font-weight:700;
             font-size:18px; margin-bottom:24px; }}
  ol b {{ color:#E3A72F; }}
  ol {{ text-align:left; line-height:1.6; opacity:.9; font-size:15px; }}
  .pie {{ margin-top:24px; font-size:13px; opacity:.6; line-height:1.5; }}
</style></head>
<body><div class="caja">
  <svg class="marca" width="88" height="88" viewBox="0 0 100 100">
    <circle cx="50" cy="50" r="50" fill="#12203A"/>
    <g fill="none" stroke="#FAF7F0">
      <circle cx="50" cy="50" r="35.5" stroke-width="8.5"/>
      <circle cx="50" cy="50" r="19.5" stroke-width="7.5"/>
    </g>
    <path d="M -3 88 Q 18 40 50 50" fill="none" stroke="#12203A"
          stroke-width="11.4" stroke-linecap="round"/>
    <polygon points="50,50 34.6,51.8 43.2,47.9 38.4,39.8" fill="#12203A"
             stroke="#12203A" stroke-width="5.6" stroke-linejoin="round"/>
    <path d="M -3 88 Q 18 40 50 50" fill="none" stroke="#E3A72F"
          stroke-width="5.8" stroke-linecap="round"/>
    <polygon points="50,50 34.6,51.8 43.2,47.9 38.4,39.8" fill="#E3A72F"/>
  </svg>
  <h1>Cíl</h1>
  <div class="nombre">My English Goal</div>
  <div class="glosa">Cambridge practice · B1 · B2 · C1</div>
  <a class="boton" href="/{nombre}">Download ({tam} MB)</a>
  <ol>
    <li>Tap <b>Download</b> and wait for it to finish.</li>
    <li>Open the file from the download notification.</li>
    <li>Android will ask for permission to <b>install unknown apps</b>.
        Allow it — that permission belongs to your browser, not to this app.</li>
    <li>Tap <b>Install</b>.</li>
  </ol>
  <p class="pie">Free. No account, no ads, works offline. Everything you
  practise stays on your phone.</p>
</div></body></html>
"""


class Servidor(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/':
            cuerpo = PAGINA.format(
                nombre=NOMBRE,
                tam=round(os.path.getsize(APK) / 1024 / 1024),
            ).encode('utf-8')
            self.send_response(200)
            self.send_header('Content-Type', 'text/html; charset=utf-8')
            self.send_header('Content-Length', str(len(cuerpo)))
            self.end_headers()
            self.wfile.write(cuerpo)
            return
        if self.path == '/' + NOMBRE:
            with open(APK, 'rb') as f:
                datos = f.read()
            self.send_response(200)
            # The right MIME type is what makes Android offer to install it
            # when the file is opened, instead of leaving it as a stray file.
            self.send_header('Content-Type',
                             'application/vnd.android.package-archive')
            self.send_header('Content-Disposition',
                             'attachment; filename="%s"' % NOMBRE)
            self.send_header('Content-Length', str(len(datos)))
            self.end_headers()
            self.wfile.write(datos)
            return
        self.send_error(404)

    def log_message(self, formato, *args):
        # One line per download, so you can see how many have it.
        if 'GET /%s' % NOMBRE in (formato % args):
            print('   downloading -> %s' % self.client_address[0])


def hacer_qr(url):
    """Saves the QR as an image, and tries to draw it in the terminal too.

    The image is what actually works in a classroom: put it on screen or
    project it and everyone scans at once. The text version is a bonus, and on
    Windows it fails when the console cannot render block characters, hence
    the try."""
    import qrcode

    qr = qrcode.QRCode(border=2, box_size=12)
    qr.add_data(url)
    qr.make(fit=True)
    try:
        qr.make_image(fill_color='#12203A', back_color='white').save('qr.png')
    except OSError:
        # On Windows the image viewer locks the file while it is open. The
        # address has not changed, so the QR already on disk is still valid.
        print('   (qr.png is open elsewhere; keeping the existing one)')

    try:
        salida = io.StringIO()
        qrcode.QRCode(border=1).add_data(url)
        chico = qrcode.QRCode(border=1)
        chico.add_data(url)
        chico.make(fit=True)
        chico.print_ascii(out=salida, invert=True)
        print(salida.getvalue())
    except (UnicodeEncodeError, LookupError):
        pass  # The console cannot; the image is still there.


def main():
    if not os.path.exists(APK):
        print('APK not found. Build it first:')
        print('   flutter build apk --release')
        sys.exit(1)

    url = 'http://%s:%d/' % (ip_local(), PUERTO)
    hacer_qr(url)
    print('   QR saved to qr.png — open it and let them scan.')
    print('   Or they can type it:  %s' % url)
    print('   APK: %.1f MB' % (os.path.getsize(APK) / 1024 / 1024))
    print('   Ctrl+C to stop.')

    socketserver.TCPServer.allow_reuse_address = True
    with socketserver.TCPServer(('', PUERTO), Servidor) as httpd:
        threading.Timer(1, lambda: webbrowser.open('qr.png')).start()
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print('\n   Parado.')


if __name__ == '__main__':
    main()
