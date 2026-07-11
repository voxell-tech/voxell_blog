#let red = rgb("#FF6188")
#let orange = rgb("#FC9867")
#let yellow = rgb("#FFD866")
#let green = rgb("#A9DC76")
#let blue = rgb("#78DCE8")
#let purple = rgb("#AB9DF2")
#let base0 = rgb("#19181A")
#let base1 = rgb("#221F22")
#let base2 = rgb("#2D2A2E")
#let base3 = rgb("#403E41")
#let base4 = rgb("#5B595C")
#let base5 = rgb("#727072")
#let base6 = rgb("#939293")
#let base7 = rgb("#C1C0C0")
#let base8 = rgb("#FCFCFA")

// Semantic palettes for `html.frame()` diagrams, which bake colors into a
// static SVG at compile time and can't read the site's CSS custom
// properties / `data-theme` toggle. Render one copy per theme and toggle
// visibility with `.frame-dark` / `.frame-light` (see tailwind.css) instead.
#let dark = (
  accent: blue,
  select: orange,
  surface: base3,
  muted: base6,
  text: base8,
)
#let light = (
  accent: rgb("#0d7a8a"),
  select: rgb("#c2660d"),
  surface: rgb("#e4e1e2"),
  muted: rgb("#727072"),
  text: rgb("#2d2a2e"),
)
