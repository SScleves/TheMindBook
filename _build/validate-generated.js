const crypto = require("crypto");
const fs = require("fs");
const vm = require("vm");

const html = fs.readFileSync("libros.html", "utf8");
const dataMatch = html.match(/<script id="data" type="application\/json">([\s\S]*?)<\/script>\s*<script>/);
const appMatch = html.match(/<\/script>\s*<script>([\s\S]*)<\/script>\s*<\/body>/);
if (!dataMatch || !appMatch) throw new Error("Generated data or app script was not found");
const appScript = appMatch[1];
new vm.Script(appScript, { filename: "libros-inline.js" });

const data = JSON.parse(dataMatch[1]);
const docs = data.books.flatMap((book) => book.docs);
const atlasIds = new Set(data.atlas.map((hub) => hub.id));
const bookIds = new Set(data.books.map((book) => book.id));
const debates = data.debates || [];
const bridges = data.bridges || [];
const appendix = data.appendix || [];
const onDisk = (p) => fs.existsSync(p.replace(/\\/g, "/"));
const debatesOk = debates.every((d) => atlasIds.has(d.hub) && d.positions.length > 0 && d.positions.every((p) => bookIds.has(p.book)));
const bridgesOk = bridges.every((b) =>
  atlasIds.has(b.fromHub) && atlasIds.has(b.toHub) &&
  (b.disclosure || "").trim().length > 0 && b.sourceDocs.length > 0 && b.sourceDocs.every(onDisk));
const appendixOk = appendix.every((a) => a.id && a.title && (a.summary || "").trim().length > 0 && a.body && (!a.hub || atlasIds.has(a.hub)));
const markers = data.dossiers.flatMap((dossier) =>
  [...dossier.body.matchAll(/<!--\s*visual:([a-z0-9-]+)/g)].map((match) => match[1]));
const builderSection = appScript.slice(appScript.indexOf("const visualBuilders"));
const builders = markers.filter((marker) => builderSection.includes(`"${marker}"`));
const hash = (path) => crypto.createHash("sha256").update(fs.readFileSync(path)).digest("hex");

const result = {
  books: data.books.length,
  docs: docs.length,
  atlas: data.atlas.length,
  dossiers: data.dossiers.length,
  debates: debates.length,
  bridges: bridges.length,
  appendix: appendix.length,
  debatesOk,
  bridgesOk,
  appendixOk,
  nullConcepts: docs.filter((doc) => doc.concepts.includes(null)).length,
  nullPeople: docs.filter((doc) => doc.people.includes(null)).length,
  markers,
  builders,
  missingBuilders: markers.filter((marker) => !builders.includes(marker)),
  identical: hash("index.html") === hash("libros.html")
};

console.log(JSON.stringify(result, null, 2));
if (result.books !== 9 || result.docs !== 259 || result.atlas !== 10 || result.dossiers !== 3 ||
    result.debates !== 5 || result.bridges !== 3 || result.appendix !== 1 ||
    !result.debatesOk || !result.bridgesOk || !result.appendixOk ||
    result.nullConcepts || result.nullPeople || result.missingBuilders.length || !result.identical) {
  process.exitCode = 1;
}