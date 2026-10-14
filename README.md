# WebTigerPython-Arbeitsblätter (Typst)

Vorlage für Arbeitsblätter zu WebTigerPython. Code sieht aus wie im Editor von WebTigerPython, `repeat` eingeschlossen.

## Dateien

| Datei | Inhalt |
|---|---|
| `wtp-arbeitsblatt.typ` | Die Vorlage |
| `wtp.tmTheme` | Farben des hellen Editor-Themes von WebTigerPython (`webtp/src/themes.ts`) |
| `wtp-links.mjs` | Erzeugt WebTigerPython-Links mit fertig geöffneten Dateien |
| `beispiel.typ` | Beispielblatt mit allen Bausteinen |

## Verwenden

`wtp-arbeitsblatt.typ` und `wtp.tmTheme` in den eigenen Ordner kopieren:

```typst
#import "wtp-arbeitsblatt.typ": *
#show: arbeitsblatt.with(kurs: "Python mit der Schildkröte")

#kopf("Wiederholen mit repeat", oben: "Tag 1 · Lektion 2")
#start-link("https://u.ethz.ch/dF62n")

#aufgabe[Quadrat][
  ```python
  repeat 4:
      forward(100)
      right(90)
  ```
]
#profi[Viele Ecken][Zeichne ein 7-Eck.]
#tipp[Alles, was *eingerückt* ist, wird wiederholt.]
```

```bash
typst compile beispiel.typ
```

Beim ersten Kompilieren lädt Typst das Paket `tiaoma` für die QR-Codes herunter.

## Bausteine

| Baustein | Was es macht |
|---|---|
| `arbeitsblatt.with(kurs: …)` | Seitenlayout, Fusszeile, Code-Farben |
| `kopf(titel, oben: …)` | Titel mit Namensfeld, `name: none` blendet es aus |
| `aufgabe(titel)[…]` | Aufgabe mit Kästchen zum Abhaken |
| `profi(titel)[…]` | Zusatzaufgabe mit ⭐ |
| `tipp[…]` | Gelber Hinweis-Kasten |
| `code(read("main.py"))` | Code direkt aus einer Datei |
| `start-link(url)` | QR-Code und Link nebeneinander |
| `link-box(url)` | Link zum Abtippen |
| `farben("red", "blue")` | Farbnamen mit Farbkästchen |

## Links mit Startdateien

Jeder Unterordner mit `.py`-Dateien ergibt einen Link. `main.py` wird zuerst geöffnet.

```bash
npm install
```

```bash
node wtp-links.mjs beispiel
```

Das schreibt `beispiel/links.json`. Im Arbeitsblatt:

```typst
#let links = json("beispiel/links.json")
#start-link(links.at("tag2"))
```

Lange Links zeigt `start-link` nur als QR-Code. Für gedruckte Blätter lohnt sich ein Kurzlink von [u.ethz.ch](https://u.ethz.ch). Der ist schnell abgetippt, und der QR-Code ist weniger dicht.
