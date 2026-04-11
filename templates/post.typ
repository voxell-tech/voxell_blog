#import "/templates/tola.typ": _parse-date, tola-page
#import "/templates/base.typ": base, colors
#import "/components/layout.typ" as layout
#import "/utils/tola.typ": cls, og-tags, set-tab-title, to-string
#import "@tola/site:0.0.0": info
#import "@tola/current:0.0.0": headings

#let post = (body, ..args) => {
  let m = args.named()

  // Parse dates
  if "date" in m { m.date = _parse-date(m.date) }
  if "update" in m { m.update = _parse-date(m.update) }

  // Auto-compute reading time from body word count
  let body-str = to-string(body)
  let word-count = if body-str == none { 0 } else {
    body-str.split(regex("\s+")).filter(w => w != "").len()
  }
  m.insert("reading-time", if word-count == 0 { 0 } else {
    calc.ceil(word-count / 200)
  })

  let head-content = [
    #html.elem("meta", attrs: (name: "viewport", content: "width=device-width, initial-scale=1"))
    #og-tags(
      title: m.title,
      description: m.at("summary", default: none),
      type: "article",
      site-name: info.title,
      author: m.at("author", default: none),
      published: m.at("date", default: none),
      tags: m.at("tags", default: ()),
    )
    #if m.title != none {
      html.title(m.title + " | " + info.title)
    }
  ]

  tola-page(..m, head: head-content)[
    #show: base

    #{
      let heading-id(text) = lower(to-string(text).replace("/", "-"))

      // Show rules
      show heading.where(level: 1): it => {
        let id = heading-id(it.body)
        html.h2(
          class: cls("text-2xl font-bold mt-8 mb-4", colors.accent),
          id: id,
        )[
          #html.a(
            class: "hover:underline underline-offset-4",
            href: "#" + id,
          )[#it.body]
        ]
      }
      show heading.where(level: 2): it => {
        let id = heading-id(it.body)
        html.h3(class: "text-xl font-semibold mt-6 mb-3", id: id)[
          #html.a(
            class: "hover:underline underline-offset-4",
            href: "#" + id,
          )[#it.body]
        ]
      }

      // Views
      let title-view = if m.title != none {
        html.h1(
          class: "text-3xl sm:text-4xl font-bold text-center my-6",
        )[#m.title]
      }

      let subtitle-view = {
        let parts = ()
        if m.at("date", default: none) != none {
          parts.push(m.date.display("[year]-[month]-[day]"))
        } else {
          parts.push("Coming soon")
        }
        if m.at("author", default: none) != none {
          parts.push("by " + m.author)
        }
        parts.push(str(m.at("reading-time")) + " min read")
        html.div(class: cls("text-center italic", colors.muted))[#parts.join(
          " · ",
        )]
      }

      let summary-view = if m.at("summary", default: none) != none {
        html.div(class: cls(
          "text-center italic my-4",
          colors.muted,
        ))[#m.summary]
      }

      let tags-view = if m.at("tags", default: ()).len() > 0 {
        html.div(class: "flex flex-wrap justify-center gap-2 my-4")[
          #for tag in m.tags {
            html.span(
              class: "px-2 py-1 text-sm bg-surface rounded text-cyan-400",
            )[#tag]
          }
        ]
      }

      // TOC using headings from @tola/current
      let toc-view = if headings.len() > 0 {
        html.nav(class: "my-6 p-4 border border-white/10 rounded-lg")[
          #html.div(class: "font-bold mb-3")[Contents]
          #html.div(class: "text-sm space-y-1")[
            #for h in headings {
              let id = heading-id(h.text)
              let indent = if h.level == 1 { "" } else { "pr-2" }
              let prefix = if h.level == 1 { "" } else { "→" }
              let prefix = html.span(class: cls(
                "text-white/75",
                indent,
              ))[#prefix]
              let text = html.a(
                class: "hover:text-sky-400 hover:underline underline-offset-4",
                href: "#" + id,
              )[#h.text]
              let item-class = if h.level == 1 { "mt-5 first:mt-0" } else { "" }
              html.div(class: item-class)[
                #prefix#text
              ]
            }
          ]
        ]
      }

      html.article(class: "space-y-6")[
        #title-view #subtitle-view #tags-view #summary-view #toc-view #layout.hr #body
      ]

      html.footer(class: "mt-12 pt-8 border-t border-white/10")[
        #html.a(
          class: cls(
            "text-sm hover:underline underline-offset-4",
            colors.muted,
          ),
          href: "/",
        )[← Back to blog]
      ]
    }
  ]
}
