// UI components
// Import: #import "/components/ui.typ" as ui

#import "/utils/tola.typ": cls
#import "/components/layout.typ" as layout

/// Navigation link
#let nav-link(href, label) = html.a(
  class: "text-muted hover:text-accent transition-colors",
  href: href,
)[#label]

/// Tag badge
#let tag(name) = html.span(
  class: "px-2 py-1 text-xs bg-surface rounded text-accent",
)[#name]

/// Card container
#let card(title: none, body) = html.div(class: "p-4 bg-surface rounded-lg")[
  #if title != none { html.h3(class: "font-semibold text-accent mb-2")[#title] }
  #body
]

/// Post card for blog listings
#let post-card(post) = {
  let date = post.at("date", default: none)
  let tags = post.at("tags", default: ())
  let reading-time = post.at("reading-time", default: none)
  html.elem("a", attrs: (
    class: "block mb-6 p-4 border border-border hover:border-accent/50 rounded-lg bg-surface/50 hover:bg-surface transition-colors no-underline group",
    href: post.permalink,
    "data-title": lower(post.title),
    "data-tags": lower(tags.join(" ")),
  ))[
    #html.h3(
      class: "text-xl font-semibold mb-2 group-hover:text-accent transition-colors",
    )[
      #post.title
    ]

    #{
      let parts = ()
      if date != none {
        parts.push(date)
      } else {
        parts.push(html.span(
          class: "text-sm italic text-muted",
        )[Coming soon...])
      }
      if reading-time != none {
        parts.push(html.span(
          class: "text-sm text-muted",
        )[#str(reading-time) min read])
      }
      layout.flex-row(gap: 4, ..parts, ..tags.map(t => tag(t)))
    }

    #if post.at("summary", default: none) != none {
      html.p(class: "mt-2 text-muted")[#post.at("summary")]
    }
  ]
}

/// Project card with name, shields.io badges, and description
#let project-card(name, url, repo, description, crate: none) = html.div(
  class: "flex flex-col p-4 bg-surface rounded-lg border border-border hover:border-accent/30 transition-colors",
)[
  #html.a(
    class: "font-bold text-lg hover:text-accent transition-colors mb-2",
    href: url,
    target: "_blank",
    rel: ("noopener", "noreferrer"),
  )[#name ↗]
  #html.p(class: "text-muted text-sm mb-3 grow")[#description]
  #let c = if crate != none { crate } else { name }
  #let crates-url = "https://crates.io/crates/" + c
  #html.div(class: "flex flex-wrap mt-auto")[
    #html.a(href: url, target: "_blank", rel: ("noopener", "noreferrer"))[
      #html.elem("img", attrs: (
        src: "https://img.shields.io/github/stars/"
          + repo
          + "?style=flat&logo=github&label=",
        alt: "GitHub stars",
        height: "20",
      ))
    ]
    #html.a(href: crates-url, target: "_blank", rel: (
      "noopener",
      "noreferrer",
    ))[
      #html.elem("img", attrs: (
        src: "https://img.shields.io/crates/v/"
          + c
          + "?style=flat&logo=rust&label=",
        alt: "crates.io version",
        height: "20",
      ))
    ]
  ]
]

/// Side-by-side showcase card: source code + rendered output.
#let showcase-demo(
  title: none,
  description: none,
  code: none,
  preview: none,
  code-label: "Typst Code",
  preview-label: "Rendered Output",
) = {
  assert(title != none, message: "showcase-demo: `title` is required")
  assert(code != none, message: "showcase-demo: `code` is required")
  assert(preview != none, message: "showcase-demo: `preview` is required")

  html.section(
    class: "my-8 rounded-lg border border-border bg-surface/50 p-4 sm:p-6",
  )[
    #html.div(class: "mb-4")[
      #html.h3(class: "text-lg sm:text-xl font-semibold text-accent")[
        #title
      ]
      #if description != none {
        html.p(class: "mt-1 text-sm text-subtle")[
          #description
        ]
      }
    ]

    #html.div(class: "grid gap-4")[
      #html.div(
        class: "rounded-lg border border-border bg-bg/70 overflow-hidden",
      )[
        #html.div(
          class: "border-b border-border px-3 py-2 text-xs uppercase tracking-wide text-muted",
        )[
          #code-label
        ]
        #html.div(class: "p-3 text-sm")[
          #code
        ]
      ]

      #html.div(
        class: "rounded-lg border border-accent/30 bg-surface/40 overflow-hidden",
      )[
        #html.div(
          class: "border-b border-accent/20 px-3 py-2 text-xs uppercase tracking-wide text-accent",
        )[
          #preview-label
        ]
        #html.div(class: "p-3 text-sm")[
          #preview
        ]
      ]
    ]
  ]
}
