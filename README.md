# Xiangyu Li Personal Website

This repository contains the source for [Xiangyu Li's personal academic website](https://sheldonleelxy.github.io/). The site is built with Jekyll and the Academic Pages theme, and is published with GitHub Pages.

## Site Content

- **About**: research interests, background, and selected work.
- **Publications**: conference and journal publications with paper links.
- **Projects**: research project summaries, including PAVE Dataset and Pipebots Project.
- **CV**: education, publications, professional experience, skills, activities, and awards.

## Running Locally

The recommended local preview command uses the existing `academicpages-ruby` conda environment:

```bash
./scripts/serve_site.sh
```

The site will be available at <http://127.0.0.1:4000/>. Use a different port if needed:

```bash
PORT=4001 ./scripts/serve_site.sh
```

If you are running Jekyll manually, load both the production config and the local override config so local links stay on the local server:

```bash
bundle exec jekyll serve -l -H 127.0.0.1 --port 4000 --config _config.yml,_config_docker.yml
```

## Editing Content

- Site-wide metadata and sidebar links live in `_config.yml`.
- The home page lives in `_pages/about.md`.
- CV content lives in `_pages/cv.md` and `_data/cv.json`.
- Project pages live in `_portfolio/`.
- Publication pages live in `_publications/`.
- Images and favicons live in `images/`.

## Deployment

The repository is configured for the GitHub Pages site at `https://sheldonleelxy.github.io/`. Keep `url` in `_config.yml` set to the GitHub Pages URL for production builds, and use `_config_docker.yml` only as a local override.

## Maintenance Notes

Before pushing changes, run a local build when possible:

```bash
conda run --no-capture-output -n academicpages-ruby bundle exec jekyll build --config _config.yml,_config_docker.yml --destination /tmp/sheldon-jekyll-local-test
```

For production-style checks, build with the default config and `JEKYLL_ENV=production`:

```bash
conda run --no-capture-output -n academicpages-ruby env JEKYLL_ENV=production bundle exec jekyll build --destination /tmp/sheldon-jekyll-prod-test
```

This site is based on [Academic Pages](https://academicpages.github.io/), which is derived from the Minimal Mistakes Jekyll theme.
