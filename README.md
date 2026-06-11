# Xiangyu Li Personal Homepage

This repository hosts Xiangyu Li's personal homepage at:

https://SheldonLeeLXY.github.io/

The site is built with Jekyll and the al-folio starter. It keeps the standard al-folio sections for publications, projects, repositories, CV, teaching, people, and blog posts, while personal information is currently represented with TODO placeholders until real content is added.

## Local Development

Install Ruby dependencies:

```bash
bundle install
```

Build the site for the GitHub Pages root path:

```bash
bundle exec jekyll build --baseurl ""
```

Serve locally:

```bash
bundle exec jekyll serve --baseurl ""
```

Then open `http://127.0.0.1:4000/`.

## Content To Fill

- `_pages/about.md`: homepage biography, affiliation, and tagline.
- `_data/cv.yml`: CV content.
- `_data/socials.yml`: email, CV PDF, and public social links.
- `_bibliography/papers.bib`: publications.
- `_projects/`: real project pages.
- `_news/`: personal updates and announcements.

## Notes

This repository should only customize site-owned content and configuration. Runtime behavior, layouts, includes, Sass, and feature JavaScript are provided by al-folio gems and should not be modified locally unless a deliberate override is required.
