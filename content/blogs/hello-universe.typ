#import "/templates/post.typ": post

#show: post.with(
  title: "Hello Universe!",
  author: "Nixon",
  date: datetime(year: 2026, month: 4, day: 11),
  tags: ("Meta",),
  summary: "Who we are, what we build, and what to expect.",
)

= What is Voxell?

Voxell is an open-source organization building tools that solve *real*, *hard* problems.
We care about pushing technology forward in ways that actually matter (e.g. empowering individuals to create, lowering the barrier to entry, knowledge sharing, and many more).

= But first, who the hell are you?

Hi, my name is Nixon.
I'm a software engineer who is deeply passionate about open-source technology.
On my free time, I like writing software, reading up new research, and tinker with hardware.
I love the idea of having the freedom to express one's creativity freely and easily and I have many big and small projects in mind that I want to work on.
Some examples include a smart home assistant, a toy vehicle (boat/car/submarine/drone), etc.
This is also partly the reason why I started all these!
Empowering people to create!

= What we are building #underline[*now*]?

Right now, our short-term mission is to build an open-source ecosystem for makers.
We're naming this whole suite of tools "*Forge*".
If you have ever juggled between OnShape, KiCad, Cura, and Arduino IDE all at once just to build one thing, you know the pain we're solving.
Our first few initiatives include the creation of #link("https://github.com/voxell-tech/xad")[Xad] - a precision modeling CAD engine, and #link("https://github.com/voxell-tech/fynix")[Fynix] - our answer to building user interfaces (_in Rust for now_).

Voxell also houses a few other more mature projects:

- #link("https://github.com/voxell-tech/motiongfx")[Motiongfx]: A backend-agnostic motion graphics framework.
- #link("https://github.com/voxell-tech/velyst")[Velyst]: An interactive Typst content creator.

Under the hood, these are supported by a set of foundational libraries we maintain.
Things like #link("https://github.com/voxell-tech/sparse_map")[`sparse_map`], #link("https://github.com/voxell-tech/rectree")[`rectree`], #link("https://github.com/voxell-tech/field_path")[`field_path`], and #link("https://github.com/voxell-tech/typeslot")[`typeslot`].
Small pieces, but they matter.

= What to expect here?

This blog is where we share the thinking behind our work. Expect a mix of:

- *Devlogs*: progress updates and behind-the-scenes looks at what we are building
- *Deep dives*: technical write-ups on problems we have encountered and how we solved them
- *Release notes*: announcements when something ships
- *Tutorials*: guides for getting the most out of our tools

... and many more!

= Come build with us!

We are a small team with big ideas, and we would love for you to be part of it.
Whether you want to contribute code, report issues, share feedback, or just follow along - you are welcome here.

Check out our projects on #link("https://github.com/voxell-tech")[GitHub] and feel free to open an issue or send a pull request.
Every contribution, big or small, helps move things forward.
We also have a #link("https://discord.gg/Mhnyp6VYEQ")[Discord] server where we hold most of our discussions at.
Finally, we host a bi-monthly #link("https://calendar.google.com/calendar?cid=NWJmNTUxODcwMWQyMzA4N2YzZmFhN2Q2YjAzMTBmMzEwMTNiNTA2MDVlMmU5NDhmM2JmYzU1MjQ1OTQ5ZGU3OUBncm91cC5jYWxlbmRhci5nb29nbGUuY29t")["office hours"] on the Discord server as well anyone is more than welcomed to join us!

Welcome to Voxell!
