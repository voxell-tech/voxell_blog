#import "monokai_pro.typ": *

#set document(
  title: [Voxell Blog],
)

#html.elem("body", attrs: (
  style: "min-height: 100vh;
    padding: 0pt 20pt;
    margin: 0;
    background-color: "
    + base0.to-hex()
    + "; color: "
    + base7.to-hex(),
))[

  #html.elem("style")[
    #".hover-box {
      transition: background-color 0.2s ease;
      padding: 1pt 20pt;
      margin: 8pt;
      background-color: "
    #base1.to-hex()
    #"; border-radius: 10pt;
    }

    .hover-box:hover {
      cursor: pointer;
      background-color: "
    #base2.to-hex()
    #";}"
  ]

  #html.elem("div", attrs: (
    style: "display: flex;
      flex-direction: row;
      align-items: center;
      justify-content: space-between",
  ))[
    #link("https://voxell.dev")[#image(
      "assets/icons/voxell.svg",
      height: 30pt,
    )]

    = Voxell Blog

  ]

  #html.elem("hr")

  #set heading(numbering: "1.")
  #show heading: it => html.elem("div", attrs: (
    class: "hover-box",
  ))[#it]

  #html.elem("div", attrs: (style: "display: flex; flex-direction: column"))[
    = Hello World!
    = Type-erasure in Rust
    = Creation of MotionGfx
  ]
]
