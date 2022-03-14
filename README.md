# Online Textbook Quick Template

Use GitHub and mdBook to create textbooks.

Read the [mdBook Format Guide](https://rust-lang.github.io/mdBook/format/index.html) to get started.

- [Configure book.toml](https://rust-lang.github.io/mdBook/format/configuration/general.html)
- [Enable MathJax](https://rust-lang.github.io/mdBook/format/mathjax.html)
- [Write Markdown](https://rust-lang.github.io/mdBook/format/markdown.html)

For the purposes of getting the book working, you don't have to read the entire guide.

## Generate Table of Contents

The GitHub Actions will automatically generate one.

Otherwise, if you want to control the page placement manually, create a file in `src/SUMMARY.md` (case sensitive) and see [SUMMARY.md guidelines](https://rust-lang.github.io/mdBook/format/summary.html) for details.

If you use Mac or Linux, you can generate one locally by using this command:

```bash
./toc.sh > src/SUMMARY.md
```