const esbuild = require("esbuild");
const path = require("path");

const watch = process.argv.includes("--watch");

esbuild.context({
  entryPoints: ["app/javascript/application.js"],
  bundle: true,
  platform: "browser",
  sourcemap: true,
  target: ["chrome58"],
  outdir: "app/assets/builds",
  publicPath: "/assets",
}).then((context) => {
  if (watch) {
    context.watch();
    console.log("👀 esbuild is watching...");
  } else {
    context.rebuild().then(() => context.dispose());
  }
}).catch((err) => {
  console.error("❌ esbuild build failed:", err);
  process.exit(1);
});
