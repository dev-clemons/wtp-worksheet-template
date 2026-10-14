#import "wtp-arbeitsblatt.typ": *
#show: arbeitsblatt.with(kurs: "Python mit der Schildkröte · Beispielkurs")

// Erzeugt mit: node wtp-links.mjs beispiel
#let links = json("beispiel/links.json")

#kopf("Wiederholen mit repeat", oben: "Tag 1 · Lektion 2")

#start-link("https://u.ethz.ch/dF62n", text-davor: [Scanne den Code oder öffne:])

#aufgabe[Quadrat][
  ```python
  repeat 4:
      forward(100)
      right(90)
  ```
  Ändere die Zahlen. Was passiert?
]

#tipp[Alles, was *eingerückt* ist, wird wiederholt.]

#aufgabe[Farben][
  Wähle eine Farbe mit `setPenColor`: #farben("red", "blue", "green", "orange", "purple")
]

#profi[Viele Ecken][
  Zeichne ein 7-Eck. Tipp: `right(360 / 7)`
]

#pagebreak()
#kopf("Code aus Dateien", oben: "Tag 2 · Lektion 4")

Der Code kommt direkt aus den Dateien in `beispiel/tag2`. So bleiben Arbeitsblatt und Startdateien gleich.

#grid(columns: (1fr, 1fr), gutter: 12pt,
  [`main.py` #code(read("beispiel/tag2/main.py"))],
  [`befehle.py` #code(read("beispiel/tag2/befehle.py"))],
)

#start-link(links.at("tag2"), text-davor: [Scanne den Code, um beide Dateien zu öffnen.])

```python
# Alle Farben des WebTigerPython-Editors
def test(n):
    if n > 0 and True:
        print("Text", None)
```
