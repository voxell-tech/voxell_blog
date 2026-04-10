#import "/templates/post.typ": post

#show: post.with(
  title: "Hello World!",
  author: "Nixon",
  date: datetime(year: 2024, month: 1, day: 1),
  tags: ("Meta",),
  summary: "Introducing the Voxell Blog. Who we are, what we build, and what to expect.",
  reading-time: 2,
)

= What is Voxell?

Voxell is an open-source organization building tools that solve real, hard problems. We care about pushing technology forward in ways that actually matter — not reinventing wheels, not chasing trends. Just good software, built in the open.

Most of our work lives in the Rust and Bevy ecosystem. We believe this space has enormous potential, but still lacks the mature tooling it deserves. That is the gap we are trying to fill.

= What we are building?

Our most ambitious project is *Forge* - an end-to-end product creation platform that unifies CAD, electronics design, 3D printing, embedded development, and simulation into one seamless environment. If you have ever juggled Fusion 360, KiCad, Cura, and Arduino IDE all at once just to build one thing, Forge is our answer to that chaos.

Forge is built on top of several of our own projects:

- #link("https://github.com/voxell-tech/velyst")[*velyst*]: an interactive Typst content creator using Vello and Bevy
- #link("https://github.com/voxell-tech/xad")[*xad*]: a precision 2D/3D modeling tool with constraint-based and SDF-based modeling
- #link("https://github.com/voxell-tech/motiongfx")[*motiongfx*]: a backend-agnostic motion graphics framework for expressive, composable animations
- #link("https://github.com/voxell-tech/fynix")[*fynix*]: a composable declarative UI framework

Under the hood, these are supported by a set of foundational libraries we maintain - things like #link("https://github.com/voxell-tech/sparse_map")[sparse_map], #link("https://github.com/voxell-tech/rectree")[rectree], #link("https://github.com/voxell-tech/field_path")[field_path], and #link("https://github.com/voxell-tech/typeslot")[typeslot]. Small pieces, but they matter.

= This blog

This is where we share the thinking behind our work. Expect a mix of:

- *Devlogs*: progress updates and behind-the-scenes looks at what we are building
- *Deep dives*: technical write-ups on problems we have encountered and how we solved them
- *Release notes*: announcements when something ships
- *Tutorials*: guides for getting the most out of our tools

= Come build with us!

We are a small team with big ideas, and we would love for you to be part of it. Whether you want to contribute code, report issues, share feedback, or just follow along - you are welcome here.

Check out our projects on #link("https://github.com/voxell-tech")[GitHub] and feel free to open an issue, start a discussion, or send a pull request. Every contribution, big or small, helps move things forward.

Welcome to Voxell.
