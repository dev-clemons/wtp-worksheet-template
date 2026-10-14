// WebTigerPython-Arbeitsblätter
// Einbinden mit:  #import "wtp-arbeitsblatt.typ": *
//                 #show: arbeitsblatt.with(kurs: "Mein Kurs")

#import "@preview/tiaoma:0.3.0": qrcode

#let wtp-blau = rgb("#0033AA")

// Farben wie im Browser (CSS), damit Farbkästchen zur Zeichnung der Turtle passen
#let css-farben = (
  red: "#ff0000", blue: "#0000ff", green: "#008000", yellow: "#ffff00",
  orange: "#ffa500", purple: "#800080", black: "#000000", brown: "#a52a2a",
  pink: "#ffc0cb", gray: "#808080", white: "#ffffff", cyan: "#00ffff",
  magenta: "#ff00ff", lime: "#00ff00", navy: "#000080", gold: "#ffd700",
)

#let arbeitsblatt(
  kurs: none,
  fusszeile-rechts: "webtigerpython.ethz.ch",
  sprache: "de",
  region: "ch",
  schriftgroesse: 12pt,
  doc,
) = {
  set page(paper: "a4", margin: (x: 2cm, y: 1.8cm), footer: context [
    #set text(size: 8pt, fill: luma(120))
    #kurs #h(1fr) #fusszeile-rechts
  ])
  set text(lang: sprache, region: region, size: schriftgroesse)
  set par(spacing: 0.9em)
  show raw: set text(size: schriftgroesse - 1pt)
  // Farben wie das helle Editor-Theme von WebTigerPython
  set raw(theme: "wtp.tmTheme")
  // repeat ist TigerPython, der Python-Highlighter kennt es nicht
  show raw.where(lang: "python"): it => {
    show regex("\\brepeat\\b"): set text(fill: wtp-blau, weight: "bold")
    it
  }
  show raw.where(block: true): block.with(fill: luma(245), inset: 8pt, radius: 3pt, width: 100%)
  doc
}

// Kopf eines Blatts mit Titel und Namensfeld
#let kopf(titel, oben: none, symbol: "🐢", name: "Name:") = {
  block(width: 100%, inset: (bottom: 6pt), stroke: (bottom: 1pt))[
    #if oben != none [#text(size: 9pt, fill: luma(100), oben) \ ]
    #text(size: 20pt, weight: "bold")[#symbol #titel]
    #if name != none [#h(1fr) #name #box(width: 4.5cm, stroke: (bottom: 0.5pt))]
  ]
}

#let aufgabe(titel, body) = block(breakable: false, above: 1.2em)[
  #box(width: 0.9em, height: 0.9em, stroke: 1pt, radius: 2pt, baseline: 0.1em) #h(0.4em) *#titel* \
  #body
]

#let profi(titel, body, label: "⭐ Profi:") = aufgabe([#label #titel], body)

#let tipp(body, symbol: "💡") = block(fill: rgb("#fff6d5"), inset: 8pt, radius: 3pt, width: 100%)[#symbol #body]

// Python-Code aus einer Datei: #code(read("main.py"))
#let code(quelle, lang: "python") = raw(quelle.trim(at: end), lang: lang, block: true)

// Link zum Abtippen, z. B. ein Kurzlink von u.ethz.ch
#let link-box(url) = {
  let anzeige = url.replace(regex("^https?://"), "")
  box(fill: luma(235), inset: (x: 4pt, y: 2pt), radius: 2pt, text(weight: "bold", font: "DejaVu Sans Mono", anzeige))
}

#let qr(url, groesse: 2.2cm) = box(width: groesse, height: groesse, qrcode(url, width: groesse))

// QR-Code und Link nebeneinander. Lange Links kann niemand abtippen, die gibt es nur als QR-Code.
#let start-link(url, text-davor: [Öffne:], groesse: 2.2cm, max-laenge: 50) = grid(
  columns: (groesse, 1fr), gutter: 10pt, align: horizon,
  qr(url, groesse: groesse),
  if url.len() <= max-laenge [#text-davor \ #link-box(url)] else [#text-davor],
)

// Farbnamen mit Kästchen: #farben("red", "blue", "green")
#let farben(..namen) = namen.pos().map(name => box[
  #box(width: 0.8em, height: 0.8em, fill: rgb(css-farben.at(name)), stroke: 0.5pt + luma(120), radius: 1pt, baseline: 0.1em)
  #raw("\"" + name + "\"")
]).join([, ])
