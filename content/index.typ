#import "/templates/page.typ": page
#import "/components/ui.typ" as ui
#import "@tola/pages:0.0.0": pages

#show: page.with(title: none)

#html.div(class: "text-center py-12")[
  #html.h1(class: "text-4xl font-bold mb-2")[Voxell Blog]
  #html.p(class: "text-muted text-lg")[
    Thoughts and updates from the Voxell open-source organization.
  ]
]

#html.elem("input", attrs: (
  id: "search-input",
  type: "text",
  placeholder: "Search posts...",
  class: "w-full mb-8 px-4 py-2 bg-surface border border-white/10 rounded-lg text-sm focus:outline-none focus:border-accent/50",
))
#html.elem("script", attrs: (src: "/js/search.js"))[]

#html.elem("p", attrs: (id: "search-empty", style: "display:none", class: "text-muted text-center"))[No posts match your search.]

#let posts = pages().filter(p => p.permalink != "/")
#if posts.len() == 0 {
  html.p(class: "text-muted text-center")[No posts yet.]
} else {
  html.div(id: "post-list")[
    #for post in posts { ui.post-card(post) }
  ]
}
