// Erzeugt WebTigerPython-Links, in denen die Dateien eines Ordners schon geöffnet sind.
// Jeder Unterordner ergibt einen Link, main.py wird zuerst geöffnet.
//
//   npm install
//   node wtp-links.mjs beispiel            -> beispiel/links.json
//
// Im Arbeitsblatt: #let links = json("beispiel/links.json")
import { readdirSync, readFileSync, writeFileSync, statSync } from "fs";
import { join } from "path";
import LZString from "lz-string";

const ordner = process.argv[2] ?? ".";
const base = process.argv[3] ?? "https://webtigerpython.ethz.ch";

const links = {};
for (const set of readdirSync(ordner).sort()) {
  const pfad = join(ordner, set);
  if (!statSync(pfad).isDirectory()) continue;
  const namen = readdirSync(pfad)
    .filter((n) => n.endsWith(".py"))
    .sort((a, b) => (a === "main.py" ? -1 : b === "main.py" ? 1 : a.localeCompare(b)));
  if (namen.length === 0) continue;
  const dateien = namen.map((name) => ({ name, data: readFileSync(join(pfad, name), "utf8") }));
  const url = new URL(base);
  url.searchParams.append("code", LZString.compressToBase64(JSON.stringify(dateien)));
  links[set] = url.href;
  console.log(`${set} (${namen.join(", ")})\n${url.href}\n`);
}
writeFileSync(join(ordner, "links.json"), JSON.stringify(links, null, 2) + "\n");
