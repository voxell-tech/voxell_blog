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

#let posts = pages().filter(p => p.permalink != "/")
#if posts.len() == 0 {
  html.p(class: "text-muted text-center")[No posts yet.]
} else {
  html.div[
    #for post in posts { ui.post-card(post) }
  ]
}
