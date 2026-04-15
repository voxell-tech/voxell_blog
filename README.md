# Voxell Blog

Source for the [blog.voxell.dev](blog.voxell.dev), built with [tola](https://github.com/tola-ssg/tola) SSG and [Tailwind CSS v4](https://tailwindcss.com).

## Prerequisites

Install **tola** (the static site generator):

```sh
cargo install --locked tola
```

Install **Tailwind CSS** (`package.json` is already set up):

```sh
npm install
npm install -g @tailwindcss/cli
```

## Development

Start a local dev server with live reload at <http://127.0.0.1:5277>:

```sh
tola serve
```

## Building

Produce a production build in `public/`:

```sh
tola build --clean
```

## Deployment

Pushing to `main` triggers the GitHub Actions workflow (`.github/workflows/deploy.yml`), which builds the site and deploys `public/` to GitHub Pages automatically.

## Project structure

```
content/          # Pages (Typst files, one per route)
  index.typ       # Homepage
  blogs/          # Blog posts
templates/        # Base HTML shell and page wrapper
components/       # Reusable UI components (ui.typ, layout.typ)
utils/            # Helper utilities
assets/
  icons/          # SVG icons and favicon
  styles/         # Tailwind CSS entry point
  fonts/          # Web fonts
```
