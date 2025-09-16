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

### Translations

To update translation templates, run `./update-translations.sh` in the root of this repository.

Strings can be translated on [Hosted Weblate](https://hosted.weblate.org/projects/ubports/doc-ubports-com/). The localization platform of this project is sponsored by Hosted Weblate via their free hosting plan for Libre and Open Source Projects.

We welcome translators from all different languages. Thank you for your contribution!
You can easily contribute to the localization of this project (i.e. the translation into your language) by visiting (and signing up with) the Hosted Weblate service as linked above and start translating by using the webinterface. To add a new language, log into weblate, goto tools --> start new translation.

### Project status

|Language              |Build status |Translation status |
|----------------------|-------------|-------------------|
|English               |[![Documentation Status](https://readthedocs.org/projects/docsubportscom-gitlab/badge/?version=latest          )](https://docs.ubports.com/en   ) | |
|Catalan               |[![Documentation Status](https://readthedocs.org/projects/docsubportscom-gitlab-ca/badge/?version=latest       )](https://docs.ubports.com/ca   ) | [![Translation status](https://hosted.weblate.org/widget/ubports/doc-ubports-com/ca/svg-badge.svg   )](https://hosted.weblate.org/engage/ubports/-/ca   ) |
|Chinese - Simplified  |[![Documentation Status](https://readthedocs.org/projects/docsubportscom-gitlab-zh-cn/badge/?version=latest    )](https://docs.ubports.com/zh_CN) | [![Translation status](https://hosted.weblate.org/widget/ubports/doc-ubports-com/zh_CN/svg-badge.svg)](https://hosted.weblate.org/engage/ubports/-/zh_CN   ) |
|Chinese - Traditional |[![Documentation Status](https://readthedocs.org/projects/docsubportscom-gitlab-zh-hant/badge/?version=latest  )](https://docs.ubports.com/zh_TW) | [![Translation status](https://hosted.weblate.org/widget/ubports/doc-ubports-com/zh_TW/svg-badge.svg)](https://hosted.weblate.org/engage/ubports/-/zh_TW ) |
|French                |[![Documentation Status](https://readthedocs.org/projects/docsubportscom-gitlab-fr/badge/?version=latest       )](https://docs.ubports.com/fr   ) | [![Translation status](https://hosted.weblate.org/widget/ubports/doc-ubports-com/fr/svg-badge.svg   )](https://hosted.weblate.org/engage/ubports/-/fr   ) |
|Galician              |[![Documentation Status](https://readthedocs.org/projects/docsubportscom-gitlab-gl/badge/?version=latest       )](https://docs.ubports.com/gl   ) | [![Translation status](https://hosted.weblate.org/widget/ubports/doc-ubports-com/gl/svg-badge.svg   )](https://hosted.weblate.org/engage/ubports/-/gl   ) |
|German                |[![Documentation Status](https://readthedocs.org/projects/docsubportscom-gitlab-de/badge/?version=latest       )](https://docs.ubports.com/de   ) | [![Translation status](https://hosted.weblate.org/widget/ubports/doc-ubports-com/de/svg-badge.svg   )](https://hosted.weblate.org/engage/ubports/-/de   ) |
|Italian               |[![Documentation Status](https://readthedocs.org/projects/docsubportscom-gitlab-it/badge/?version=latest       )](https://docs.ubports.com/it   ) | [![Translation status](https://hosted.weblate.org/widget/ubports/doc-ubports-com/it/svg-badge.svg   )](https://hosted.weblate.org/engage/ubports/-/it   ) |
|Russian               |[![Documentation Status](https://readthedocs.org/projects/docsubportscom-gitlab-ru/badge/?version=latest       )](https://docs.ubports.com/ru   ) | [![Translation status](https://hosted.weblate.org/widget/ubports/doc-ubports-com/ru/svg-badge.svg   )](https://hosted.weblate.org/engage/ubports/-/ru   ) |
|Spanish               |[![Documentation Status](https://readthedocs.org/projects/docsubportscom-gitlab-es/badge/?version=latest       )](https://docs.ubports.com/es   ) | [![Translation status](https://hosted.weblate.org/widget/ubports/doc-ubports-com/es/svg-badge.svg   )](https://hosted.weblate.org/engage/ubports/-/es   ) |
|Tamil                 |[![Documentation Status](https://readthedocs.org/projects/docsubportscom-gitlab-ta/badge/?version=latest       )](https://docs.ubports.com/ta   ) | [![Translation status](https://hosted.weblate.org/widget/ubports/doc-ubports-com/ta/svg-badge.svg   )](https://hosted.weblate.org/engage/ubports/-/ta   ) |
|Ukrainian             |[![Documentation Status](https://readthedocs.org/projects/docsubportscom-gitlab-uk/badge/?version=latest       )](https://docs.ubports.com/uk   ) | [![Translation status](https://hosted.weblate.org/widget/ubports/doc-ubports-com/uk/svg-badge.svg   )](https://hosted.weblate.org/engage/ubports/-/uk   ) |

### Update libraries

The python dependencies (sphinx, furo, etc) are listed in `requirements.in.txt`. When there is a need to update any of these top level dependencies please specify it in this file. Afterwards, freeze the whole set of all low level python libraries via `pip3 freeze -r requirements.in.txt > requirements.txt`
