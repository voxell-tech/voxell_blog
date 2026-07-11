#import "/templates/post.typ": post
#import "/monokai_pro.typ": *

// `html.frame()` bakes colors into a static SVG at compile time, so it can't
// read the site's CSS custom properties / `data-theme` toggle. We render one
// copy of each diagram per theme (palettes from monokai_pro.typ) and let
// `.frame-dark` / `.frame-light` (see tailwind.css) decide which is visible.
#let themed(diagram) = {
  html.elem("div", attrs: (class: "frame-dark"))[#diagram(dark)]
  html.elem("div", attrs: (class: "frame-light"))[#diagram(light)]
}

#show: post.with(
  title: "Why I created MotionGfx?",
  author: "Nixon",
  date: datetime(year: 2026, month: 7, day: 10),
  tags: ("MotionGfx", "Motion Graphics"),
  summary: "A tour of the motion graphics tooling landscape.",
)

= Prelude

For those who are unaware, #link("https://github.com/voxell-tech/motiongfx")[MotionGfx] is a backend-agnostic motion graphics creation framework. It uses a command-based workflow to generate animations (similar to Manim and Motion Canvas). We're working hard on an editor, and the LLM integration.

= The old guard: After Effects

For many years the industry has been stuck with #link("https://www.adobe.com/my_en/products/aftereffects.html")[After Effects]. It's amazing, even effective when it comes to motion graphics, but the main problem is that it sucks in performance and I have first hand experience with it. Another problem is that complex motion graphics always involves a lot of repetitive manual labor, adjusting keyframes, clicking things. One major thing that was missing from After Effects though, is the ability to integrate into real-time scenarios.

= Lottie and Rive

Then came Lottie. Lottie isn't an After Effects replacement. In fact, they knew it so well that they even made a feature that allows users to export Lottie into After Effects. Lottie also introduced state machines recently, making it even more seamless to plug into real-time applications. Lottie is this middle ground thing where it's small, efficient, real-time, but yet, not as powerful as After Effects. A major drawback is that they only focus on pure vector graphics, when in fact, they should be able to extend into 3D meshes too! (3D meshes are vector graphics too!)

On the other hand, we have Rive. Rive is arguably the closest to what an AE successor would look like. It has low level support (custom shaders / pipelines), 3D support, state machines for real-time applications, etc. The major downside, however, is its closed source policy. When a technology is behind pay walls, it tends to reduce confidence in developers, especially open source enthusiasts like me! We desperately need a version of Rive with some changes to how it handles keyframe animation (we'll talk about this later) that is open, and free. One where anyone can just depend on the file format and swap any renderer they want and with whatever custom workflow / pipeline they decide.

Both however, did not address the keyframe problem that #link("https://github.com/motion-canvas/motion-canvas")[Motion Canvas] and #link("https://www.manim.community")[Manim] resolves beautifully.

_Note: I'm intentionally leaving Blender out of this because it's another beast, I don't think we can match what Blender has in terms of 3D animation, but with time, we could?_

= Keyframes vs commands

== Keyframes

The keyframe problem goes like this. Say you created an animation sequence and you're proud of your result. You take it to your boss and show it to him. Your boss says that one section of your animation is lacking and asked you to add details. So you go back to edit your animation, but now you're greeted with a wall of keyframes.

#linebreak()
#{
  let diagram(c) = {
    set text(font: "0xProto Nerd Font Mono")
    let track-x0 = 6em
    let track-w = 24em
    let row-h = 2.6em

    // Drag-select marquee bounds, in row indices and x fractions.
    let sel-row0 = 0
    let sel-row1 = 2
    let sel-x0 = 0.22
    let sel-x1 = 0.68

    let in-selection(row, x) = (
      row >= sel-row0 and row <= sel-row1 and x >= sel-x0 and x <= sel-x1
    )

    let diamond(dx, dy, selected: false) = place(
      top + left,
      dx: dx - 0.35em,
      dy: dy - 0.35em,
    )[
      #if selected [
        #place(top + left, dx: -0.15em, dy: -0.15em)[
          #circle(radius: 0.5em, fill: c.select.transparentize(75%))
        ]
      ]
      #polygon(
        fill: if selected { c.select } else { c.accent },
        (0.35em, 0em),
        (0.7em, 0.35em),
        (0.35em, 0.7em),
        (0em, 0.35em),
      )
    ]

    let track(label, row, xs) = {
      let y = row * row-h
      place(top + left, dx: 0em, dy: y - 0.5em)[#text(
        size: 0.85em,
        fill: c.muted,
      )[#label]]
      place(top + left, dx: track-x0, dy: y)[
        #line(length: track-w, stroke: c.surface + 1.5pt)
      ]
      for x in xs {
        diamond(track-x0 + x * track-w, y, selected: in-selection(row, x))
      }
    }

    let tracks = (
      (label: "Position", xs: (0.08, 0.3, 0.55, 0.82)),
      (label: "Rotation", xs: (0.15, 0.4, 0.7)),
      (label: "Scale", xs: (0.1, 0.35, 0.6, 0.88)),
      (label: "Opacity", xs: (0.2, 0.6)),
    )

    html.frame(box(width: track-x0 + track-w + 2em, height: tracks.len() * row-h)[
      #for (i, t) in tracks.enumerate() [
        #track(t.label, i, t.xs)
      ]
      #place(top + left, dx: track-x0 + 0.35 * track-w, dy: -0.6em)[
        #line(
          start: (0em, 0em),
          end: (0em, (tracks.len() - 1) * row-h + 0.6em),
          stroke: (paint: c.text, thickness: 1.5pt, dash: "dashed"),
        )
      ]
      #place(top + left, dx: track-x0 + 0.35 * track-w - 1.5em, dy: -1.6em)[
        #text(size: 0.8em, fill: c.text, weight: "bold")[playhead]
      ]

      // Drag-select marquee, spanning the selected rows and x-range.
      #{
        let mx0 = track-x0 + sel-x0 * track-w
        let mx1 = track-x0 + sel-x1 * track-w
        let my0 = sel-row0 * row-h - 0.55em
        let my1 = sel-row1 * row-h + 0.55em
        place(top + left, dx: mx0, dy: my0)[
          #rect(
            width: mx1 - mx0,
            height: my1 - my0,
            fill: c.select.transparentize(88%),
            stroke: (paint: c.select, thickness: 1pt, dash: "dashed"),
          )
        ]
      }
    ])
  }

  themed(diagram)
}

The only way you can go through this new edit is by drag selecting chunks of keyframes away to make room for new ones!

== Commands

Commands treat animation in a different way. Instead of specifying each and every state in precise timing, you describe the motion as a sequence of actions.

#linebreak()
#{
  let diagram(c) = {
    set text(font: "0xProto Nerd Font Mono")
    let steps = ("move", "rotate", "wait", "scale", "move", "fade")
    let step-w = 5.2em
    let gap = 1.4em
    let cell = step-w + gap
    let box-h = 1.9em
    let playhead-i = 3

    let cmd-box(i, label, active: false) = {
      let x = i * cell
      place(top + left, dx: x, dy: 0em)[
        #rect(
          width: step-w,
          height: box-h,
          radius: 0.35em,
          fill: if active { c.accent.transparentize(80%) } else { c.surface },
          stroke: (
            paint: if active { c.accent } else { c.muted },
            thickness: 1pt,
          ),
        )[
          #align(center + horizon)[
            #text(
              size: 0.75em,
              fill: if active { c.accent } else { c.text },
            )[#label]
          ]
        ]
      ]
      if i < steps.len() - 1 {
        place(top + left, dx: x + step-w + 0.5em, dy: box-h / 2 - 0.35em)[
          #polygon(
            fill: c.muted,
            (0em, 0em),
            (0.6em, 0.35em),
            (0em, 0.7em),
          )
        ]
      }
    }

    html.frame(box(width: steps.len() * cell, height: box-h + 2.4em)[
      #for (i, s) in steps.enumerate() [
        #cmd-box(i, s, active: i <= playhead-i)
      ]
      #place(top + left, dx: playhead-i * cell + step-w / 2, dy: -0.5em)[
        #line(
          start: (0em, 0em),
          end: (0em, box-h + 0.5em),
          stroke: (paint: c.text, thickness: 1.5pt, dash: "dashed"),
        )
      ]
      #place(top + left, dx: playhead-i * cell + step-w / 2 - 1.5em, dy: -1.5em)[
        #text(size: 0.8em, fill: c.text, weight: "bold")[playhead]
      ]
    ])
  }

  themed(diagram)
}

This way, editing the animation can be as simple as adding a new action anywhere in between! Of course this is a simplified visualization of it, in practice commands can be very complex too, you can create a flow of actions, chain them, or have them played simultaneously. But the point is, the timing was never baked in, it's always a consequence of the actions that came before it!

#{
  let diagram(c) = {
    set text(font: "0xProto Nerd Font Mono")
    let step-w = 5.2em
    let gap = 1.8em
    let box-h = 1.9em
    let vgap = 0.7em

    let row-y = 2em // top padding reserved for the playhead label
    let bot-y = row-y + box-h + vgap
    let single-y = (row-y + bot-y) / 2 - box-h / 2

    let node(x, y, label, w: step-w, accent: none) = place(
      top + left,
      dx: x,
      dy: y,
    )[
      #rect(
        width: w,
        height: box-h,
        radius: 0.35em,
        fill: if accent != none {
          accent.transparentize(80%)
        } else { c.surface },
        stroke: (
          paint: if accent != none { accent } else { c.muted },
          thickness: 1pt,
        ),
      )[
        #align(center + horizon)[
          #text(size: 0.75em, fill: if accent != none { accent } else {
            c.text
          })[#label]
        ]
      ]
    ]

    let arrow(x, y) = place(top + left, dx: x + 0.5em, dy: y)[
      #polygon(fill: c.muted, (0em, 0em), (0.6em, 0.35em), (0em, 0.7em))
    ]

    // move starts first (top row), rotate starts a little after it and
    // runs below it, ending later than move does - same length, just offset.
    let flow-item-w = step-w * 0.75
    let stagger = step-w * 0.35
    let flow-w = stagger + flow-item-w

    let col0 = 0em
    let col1 = col0 + flow-w + gap * 1.6 // wait
    let col2 = col1 + step-w + gap * 1.3 // scale / fade
    let col3 = col2 + step-w + gap * 1.3 // wait
    let col4 = col3 + step-w + gap // final move

    html.frame(box(width: col4 + step-w, height: bot-y + box-h + 0.6em)[
      #place(top + left, dx: col0 - 0.4em, dy: row-y - 0.4em)[
        #rect(
          width: stagger + flow-item-w + 0.8em,
          height: bot-y + box-h - row-y + 0.8em,
          radius: 0.35em,
          fill: c.accent.transparentize(88%),
          stroke: (paint: c.accent, thickness: 1pt, dash: "dashed"),
        )
      ]
      #node(col0, row-y, "move", w: flow-item-w, accent: c.accent)
      #node(col0 + stagger, bot-y, "rotate", w: flow-item-w, accent: c.accent)

      #arrow((col0 + flow-w + col1) / 2 - 0.8em, single-y + box-h / 2 - 0.35em)
      #node(col1, single-y, "wait", accent: c.accent)

      #arrow((col1 + step-w + col2) / 2 - 0.8em, single-y + box-h / 2 - 0.35em)
      #place(top + left, dx: col2 - 0.4em, dy: row-y - 0.4em)[
        #rect(
          width: step-w + 0.8em,
          height: bot-y + box-h - row-y + 0.8em,
          radius: 0.35em,
          fill: c.accent.transparentize(88%),
          stroke: (paint: c.accent, thickness: 1pt, dash: "dashed"),
        )
      ]
      #node(col2, row-y, "scale", accent: c.accent)
      #node(col2, bot-y, "fade", accent: c.accent)
      #place(top + left, dx: col2 + step-w / 2, dy: row-y - 0.8em)[
        #line(
          start: (0em, 0em),
          end: (0em, bot-y + box-h - row-y + 1.2em),
          stroke: (paint: c.text, thickness: 1.5pt, dash: "dashed"),
        )
      ]
      #place(top + left, dx: col2 + step-w / 2 - 1.5em, dy: row-y - 1.9em)[
        #text(size: 0.8em, fill: c.text, weight: "bold")[playhead]
      ]

      #arrow((col2 + step-w + col3) / 2 - 0.8em, single-y + box-h / 2 - 0.35em)
      #node(col3, single-y, "wait")

      #arrow(col3 + step-w, single-y + box-h / 2 - 0.35em)
      #node(col4, single-y, "move")
    ])
  }

  themed(diagram)
}

This is how you create animations in Manim, Motion Canvas, or #link("https://github.com/voxell-tech/motiongfx")[MotionGfx] under the hood! Animations are created as a sequence of actions / commands and ordered on top of one another.

#html.elem("div", attrs: (class: "aspect-video w-full my-4"))[
  #html.elem("iframe", attrs: (
    width: "100%",
    height: "100%",
    src: "https://www.youtube.com/embed/WTUafAwrunE?si=kigwmYex-IgVj0xE&start=53",
    title: "Animating with code - Aarthificial",
    frameborder: "0",
    allow: "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share",
    referrerpolicy: "strict-origin-when-cross-origin",
    allowfullscreen: "true",
  ))
]

_30 seconds from #link("https://youtu.be/WTUafAwrunE?si=aeHiLO7sInq6Japx&t=53")[this timestamp] by the original Motion Canvas author sums it up well._

= The AI era

Then came the AI era, with YC backed companies like #link("https://hera.video")[Hera] and #link("https://midrender.com")[Midrender/Revideo].
I know there's also #link("https://www.palmier.io")[Palmier], but that's more like Premiere Pro than After Effects.

Midrender/Revideo in particular is pretty interesting to me. I have personally used Motion Canvas for a presentation before on "shaders" (#link("https://github.com/nixonyh/beauty-of-shaders")[repo]). It's beautiful, seriously. The workflow is very intuitive, and it's close to the web. And that might be one of its downfalls. I'm not against using web as a renderer, but you have a bunch of limitations when it comes to web technology, especially when it comes to what the GPU can do. I know WebGPU has done a great job to reduce that. But then again, the browser is not the first place where you get to use the most advanced features. What's even more pressing here, is that Typescript is simply not fast. There was a section in my slide where I was showcasing the many pixels you have on screen, but I was limited to how many squares I can animate due to performance issue. This also brings me to my next main topic: keyframes might not be the problem that Manim and Motion Canvas want to solve.

But before that, quick word about how these companies use AI.

== Midrender

Midrender still relies strongly on generating animation via code (Motion Canvas's way of doing things). It works but to a point. I've recently released #link("https://youtube.com/shorts/2-chU_NtCVQ?si=2ZGELcIWy9pRnIM0")[a few videos] using AI to create animations using MotionGfx. While it's usable and _very_ powerful, the audience for this kind of workflow is very niche, the everyday animators and designers simply *do not code*! Furthermore, it can sometimes get tricky to keep track of what the AI is generating, especially without something _(like a timeline)_ to visualize your animations.

== Hera

No, it's just not an editor. You need to have full control over your timeline structure to be able to make custom modifications. No serious animators would want a prompt only editor. In my eyes, it's set to fail. Not that it won't make money, but that it can't scale.

== How will MotionGfx use AI?

My plan with MotionGfx hasn't been consolidated yet. But it's heading somewhere that lets you edit animations via the editor itself, while also being able to create complex motion templates or low level shaders from scratch using code.

= What's wrong with just using commands?

The problem is twofold, first and foremost, this animation paradigm is still saturated with using code as the main workflow. The other is how command-based animations are being sampled.

The first problem, I think, in my humble opinion, is just a mere design problem. We just need someone to come up with an editor with amazing user experience!

The second problem is what causes Manim and Motion Canvas to be sluggish as an editor. Every time you scrub the timeline backwards (let's say from 10s to 5s), the engine has to recalculate all the state from the first frame until "now". This is the result of using "command" based animation as opposed to "keyframe" based. MotionGfx mitigates this by embracing both worlds. I know that command-based animations are nice in that you can easily articulate your animations and have an easy time editing it. But I also understand that it's only keyframes that allow you to scrub your animations in both directions with equal performance.

MotionGfx achieved this unification in a very simple way. Treat the animation creation method as commands, then, bake them into keyframes once before performing the animation!

= Closing thought

I have a very optimistic view of what MotionGfx can become in the future. Which is a unified motion engine with low level support, real-time integration, 2D and 3D native, video and audio support, and most importantly, fully open sourced and dual licensed under MIT and Apache 2.0!

I'll admit, creating a motion editor while trying to compete with these industry leading softwares is extremely challenging. But that's not a reason for us not to try! After all, _*we're born to create, and create we will!*_
