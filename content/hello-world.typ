#import "/templates/post.typ": post

#show: post.with(
  title: "Hello World!",
  author: "Nixon",
  date: datetime(year: 2024, month: 1, day: 1),
  tags: ("Meta",),
  summary: "Welcome to the Voxell Blog.",
  reading-time: 1,
)

#lorem(80)

#lorem(120)
