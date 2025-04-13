# tholmes-jsonresume

This repository contains a multilingual CV for Tobias Holmes, utilizing the JSON Resume format and deployed via GitHub Pages.

## Edit Resume

To update the resume, edit the respective JSON files:

- `resume-en.json` for the English version
- `resume-de.json` for the German version

## Preview

### To preview a single resume page locally:

1. test a single resume with
   ```sh
   resume serve -r <resume-file.json> -t <theme-name>
   ```
2. Open your browser and navigate to `http://localhost:4000` to view the resume.

### To preview the complete resume page with language switcher:

1. Run the `resume2html.sh` script to generate the HTML files for both versions:
   ```sh
   sh ./resume2html.sh
   ```
2. Start a local web server (e.g., using Python):
   ```sh
   python3 -m http.server 8080
   ```
3. Open your browser and navigate to `http://localhost:8080` to view the resume.

## Deploy Changes

To deploy changes:

1. Run the `resume2html.sh` script to generate the HTML files:
   ```sh
   ./resume2html.sh
   ```
2. Commit and push the changes to the repository. Deployment is handled via GitHub Actions.

## Directory Structure

- `resume-de.json`: German version of the resume.
- `resume-en.json`: English version of the resume.
- `resume2html.sh`: Script to convert JSON resumes to HTML.
- `index.html`: Redirects to the appropriate language version based on browser settings.
- `de/index.html`: Generated HTML for the German resume.
- `en/index.html`: Generated HTML for the English resume.
- `CNAME`: Custom domain for GitHub Pages.
- `.gitignore`: Specifies files to be ignored by Git.
- `package.json`: Required npm modules, i.e. custom themes

## JSON Resume

This project uses the [JSON Resume](https://jsonresume.org/) format, which is a community-driven open-source initiative to create a JSON-based standard for resumes. For more information, visit the [JSON Resume website](https://jsonresume.org/).

## Required Installations

To work with JSON Resume, you need to have the following installed:

- [Node.js](https://nodejs.org/): JavaScript runtime built on Chrome's V8 JavaScript engine.
- [resumed](https://github.com/rbardini/resumed) / [resume-cli](https://github.com/jsonresume/resume-cli): Command line tool to generate HTML and PDF resumes from JSON Resume files.

You can install `resumed-cli` globally using npm:

```sh
npm install -g resume-cli
```

To use the customised themes install them using npm:

```sh
npm install
```

## License [![License: CC BY-NC-SA 4.0](https://licensebuttons.net/l/by-nc-sa/4.0/80x15.png)](https://creativecommons.org/licenses/by-nc-sa/4.0/)

This project is licensed under the CC BY-NC-SA 4.0 license. See `LICENSE.md`for the legal code.
