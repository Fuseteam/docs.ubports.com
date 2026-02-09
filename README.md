## UBports Documentation Website

This is the repository for the UBports documentation website served at [docs.ubports.com](https://docs.ubports.com).

The content is written in [reStructuredText (RST)](https://docutils.sourceforge.io/rst.html),
built with [Sphinx](https://www.sphinx-doc.org)
in the [Furo](https://pypi.org/project/furo) theme
and hosted on [Read the Docs](http://readthedocs.org).

### Contribution guidelines

You can find ways to contribute [here](https://docs.ubports.com/en/latest/contribute/documentation.html). Please follow all of the guidelines on that page.

### Build instructions

The documentation can be built by running `./build.sh` in the root of this repository. The script will also create a virtual build environment in `~/ubportsdocsenv` if none is present. After the build is complete, you can view the documentation by opening the html files in your favorite browser (eg. `firefox _build/html/index.html`).

#### Creating a PDF

```
uv venv
source .venv/bin/activate

git clone 'https://gitlab.com/ubports/docs/docs.ubports.com'
cd docs.ubports.com
# you will need LaTeX installed and available in your `PATH`

# For any errors (a few Unicode characters and `.svg` files you can press enter to continue generating the PDF anyway): note sometimes it may be necessary to clone the repo again (or somehow revert any changes made) to get the PDF to generate again
```

Errors related to `.svg` files can be bypassed by converting to `.png` with some basic scripting:

```
for i in $(find); do
sed -i 's/\.svg/\.png/g' $i
done
cd _static/
for i in $(fg \.svg$); do rsvg-convert $i > ${i%.*}.png; rm -rf $i; done
cd ..
```

Invisibile font in codeblocks can be fixed by replacing all instances of `\PYG{n` with `\PYG{b` (and, using regular expression replace, `\+n([a-z])\}` with `+b\1}`) inside `_build/latex/UBportsdocs.tex`: if you decide to make this fix, you'll need to run only `make latex` instead of the full `make latexpdfja`. You then replace the file to correct it before running `make` in the same directory.

### Translations

The documentation can be [translated via weblate](https://docs.ubports.com/en/latest/contribute/translations.html).

#### Update pot translations

Part of the translation workflow is the update of the `.pot` file. This is the input for the translation in weblate. This update can be done manually with the help of the `update-translations.sh` or automatically with the weekly gitlab CI task running the `ci-update-translations.sh` script.

### Project status

Build and translation status for all subprojects (languages) configured in ReadTheDocs.

|Language              |Build status |Translation status |
|----------------------|-------------|-------------------|
|Catalan               |[![Documentation Status](https://readthedocs.org/projects/docsubportscom-gitlab-ca/badge/?version=latest       )](https://docs.ubports.com/ca   ) | [![Translation status](https://hosted.weblate.org/widget/ubports/doc-ubports-com/ca/svg-badge.svg   )](https://hosted.weblate.org/projects/ubports/doc-ubports-com/ca    ) |
|Chinese - Simplified  |[![Documentation Status](https://readthedocs.org/projects/docsubportscom-gitlab-zh-cn/badge/?version=latest    )](https://docs.ubports.com/zh_CN) | [![Translation status](https://hosted.weblate.org/widget/ubports/doc-ubports-com/zh_CN/svg-badge.svg)](https://hosted.weblate.org/projects/ubports/doc-ubports-com/zh_CN ) |
|Chinese - Traditional |[![Documentation Status](https://readthedocs.org/projects/docsubportscom-gitlab-zh-hant/badge/?version=latest  )](https://docs.ubports.com/zh_TW) | [![Translation status](https://hosted.weblate.org/widget/ubports/doc-ubports-com/zh_TW/svg-badge.svg)](https://hosted.weblate.org/projects/ubports/doc-ubports-com/zh_TW ) |
|English               |[![Documentation Status](https://readthedocs.org/projects/docsubportscom-gitlab/badge/?version=latest          )](https://docs.ubports.com/en   ) | [![Translation status](https://hosted.weblate.org/widget/ubports/doc-ubports-com/en/svg-badge.svg   )](https://hosted.weblate.org/projects/ubports/doc-ubports-com/en    ) |
|French                |[![Documentation Status](https://readthedocs.org/projects/docsubportscom-gitlab-fr/badge/?version=latest       )](https://docs.ubports.com/fr   ) | [![Translation status](https://hosted.weblate.org/widget/ubports/doc-ubports-com/fr/svg-badge.svg   )](https://hosted.weblate.org/projects/ubports/doc-ubports-com/fr    ) |
|Galician              |[![Documentation Status](https://readthedocs.org/projects/docsubportscom-gitlab-gl/badge/?version=latest       )](https://docs.ubports.com/gl   ) | [![Translation status](https://hosted.weblate.org/widget/ubports/doc-ubports-com/gl/svg-badge.svg   )](https://hosted.weblate.org/projects/ubports/doc-ubports-com/gl    ) |
|German                |[![Documentation Status](https://readthedocs.org/projects/docsubportscom-gitlab-de/badge/?version=latest       )](https://docs.ubports.com/de   ) | [![Translation status](https://hosted.weblate.org/widget/ubports/doc-ubports-com/de/svg-badge.svg   )](https://hosted.weblate.org/projects/ubports/doc-ubports-com/de    ) |
|Italian               |[![Documentation Status](https://readthedocs.org/projects/docsubportscom-gitlab-it/badge/?version=latest       )](https://docs.ubports.com/it   ) | [![Translation status](https://hosted.weblate.org/widget/ubports/doc-ubports-com/it/svg-badge.svg   )](https://hosted.weblate.org/projects/ubports/doc-ubports-com/it    ) |
|Russian               |[![Documentation Status](https://readthedocs.org/projects/docsubportscom-gitlab-ru/badge/?version=latest       )](https://docs.ubports.com/ru   ) | [![Translation status](https://hosted.weblate.org/widget/ubports/doc-ubports-com/ru/svg-badge.svg   )](https://hosted.weblate.org/projects/ubports/doc-ubports-com/ru    ) |
|Spanish               |[![Documentation Status](https://readthedocs.org/projects/docsubportscom-gitlab-es/badge/?version=latest       )](https://docs.ubports.com/es   ) | [![Translation status](https://hosted.weblate.org/widget/ubports/doc-ubports-com/es/svg-badge.svg   )](https://hosted.weblate.org/projects/ubports/doc-ubports-com/es    ) |
|Tamil                 |[![Documentation Status](https://readthedocs.org/projects/docsubportscom-gitlab-ta/badge/?version=latest       )](https://docs.ubports.com/ta   ) | [![Translation status](https://hosted.weblate.org/widget/ubports/doc-ubports-com/ta/svg-badge.svg   )](https://hosted.weblate.org/projects/ubports/doc-ubports-com/ta    ) |
|Ukrainian             |[![Documentation Status](https://readthedocs.org/projects/docsubportscom-gitlab-uk/badge/?version=latest       )](https://docs.ubports.com/uk   ) | [![Translation status](https://hosted.weblate.org/widget/ubports/doc-ubports-com/uk/svg-badge.svg   )](https://hosted.weblate.org/projects/ubports/doc-ubports-com/uk    ) |

#### Weblate status

Translation status for all languages enabled in Weblate.

[![Translation status](https://hosted.weblate.org/widget/ubports/doc-ubports-com/multi-auto.svg)](https://hosted.weblate.org/engage/ubports/)


### Update libraries

The python dependencies (sphinx, furo, etc) are listed in `requirements.in.txt`. When there is a need to update any of these top level dependencies please specify it in this file. Afterwards, freeze the whole set of all low level python libraries via `pip3 freeze -r requirements.in.txt > requirements.txt`
