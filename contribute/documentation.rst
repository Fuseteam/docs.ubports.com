Documentation
=============

.. tip::
    Documentation on this site is written in ReStructuredText, or RST for short. Please check the `RST Primer <http://www.sphinx-doc.org/en/stable/rest.html>`_ if you are not familiar with RST.

This page will guide you through writing great documentation for the UBports project that can be featured on this site.

Documentation guidelines
------------------------

These rules govern how you should write documentation to avoid problems with style, format or linking.

Title
^^^^^

All pages must have a document title that will be shown in the table of contents (left sidebar) and at the top of the page.

Titles should be "sentence cased" rather than "Title Cased". For example::

    Incorrect casing:
        Writing A Good Bug Report
    Correct casing:
        Writing a good bug report
    Correct casing when proper nouns are involved:
        Installing Ubuntu Touch on your phone

There isn't a single definition of title casing that everyone follows, but sentence casing is easy. This helps keep capitalization in the table of contents consistent.

Page titles are underlined with equals signs. For example, the markup for :doc:`./bugreporting` includes the following title:

.. code-block:: rst

    Bug reporting
    =============

Note that:

#. The title is sentence cased
#. The title is underlined with equals signs
#. The underline spans the title completely without going over

Incorrect examples of titles include:

* Incorrect casing

    .. code-block:: rst

        Bug Reporting
        =============

* Underline too short

    .. code-block:: rst

        Bug reporting
        =====

* Underline too long

    .. code-block:: rst

        Bug reporting
        ================


Headings
^^^^^^^^

There are several levels of headings that you may place on a page. These levels are shown here in order:

.. code-block:: rst

    Page title
    ==========

    Level one
    ---------

    Level two
    ^^^^^^^^^

    Level three
    """""""""""

Please refrain from using more than four levels. If you think you need more levels, it is a good sign that the document should be split up into multiple pages. Furthermore the web version of the documentation only shows four levels in it's table of contents.

Table of contents
^^^^^^^^^^^^^^^^^

If you add a new page you also have to add it to the table of contents. You can do this by adding the page to the ``index.rst`` file in the same directory where you created it. For example, if you create a file called "newpage.rst", you would add the line marked with a chevron (>) in the nearest index:

.. code-block:: rst

    .. toctree::
        :maxdepth: 1
        :name: example-toc

        oldpage
        anotheroldpage
    >   newpage

The order matters. If you would like your page to appear in a certain position in the table of contents, place it there. In the previous example, newpage would be added to the end of this table of contents.

Moving pages
^^^^^^^^^^^^

Sometimes it becomes necessary to move a page from one place in the documentation to another. Generally this is to improve document flow: For example, it makes more sense for the page to come after a page you've just added in a different section.

However, people link to our documentation from many sources that we do not control.
Blogs, websites, and other documentation sites can direct people here using links that they may never update.
It is a terrible experience to follow a link from a different site and land on a 404 page, being forced to search manually in our documentation.

We use a tool called Rediraffe to avoid such a bad experience. Rediraffe creates redirect pages, which can send a user from an old, invalid link to a new, useful link. Please create a redirect link when changing a page's name or moving a page within the documentation's directory structure. Redirect links are created by placing the filename of the old document and the filename of the new document, relative to the documentation's root, in the `redirects.txt file <https://gitlab.com/ubports/docs/docs.ubports.com/-/blob/master/redirects.txt>`_.

We use Rediraffe's ``checkdiff`` builder to ensure that pages are not deleted from the documentation without a redirect in place. This builder is run as part of the ``build.sh`` script in the repository and as part of our automated build once you submit a Merge Request (MR).

What follows are some examples of situations where you should create redirects.

You are moving ``systemdev/calendars.rst`` to ``appdev/calendars.rst``. Add the following to the ``redirects.txt`` file::

    "systemdev/calendars.txt" "appdev/calendars.txt"

You are moving ``appdev/clickable.rst`` into several pages in ``appdev/clickable/`` to give significantly more information about the tool than there was previously. You have created an introduction page, ``appdev/clickable/introduction.rst``. In this case, it would be a good idea to redirect the old page to the new introduction page. This can be done by adding the following to ``redirects.txt``::

    "appdev/clickable.rst" "appdev/clickable/introduction.rst"

Warnings
^^^^^^^^

Your edits must not introduce any warnings into the documentation build. If any warnings occur, the build will fail and the merge request will be marked with a red 'X'. Please ensure that your RST is valid and correct before you create a merge request. This is done automatically (via sphinx-build crashing with your error) if you follow :ref:`our build instructions <doc-contribution-workflow>` below.


Line length
^^^^^^^^^^^

There is no restriction on line length in this repository. Please do not break lines at an arbitrary line length. Instead, turn on word wrap in your text editor.

.. _doc-contribution-workflow:

Contribution workflow
---------------------

The following steps explain how you can make a contribution to this documentation.

.. Note::
    You will need a GitLab account to complete these steps. If you do not have an account, go to `gitlab.com <https://gitlab.com>`_ to create one.

Forking the repository
^^^^^^^^^^^^^^^^^^^^^^

You can make more advanced edits to the documentation by forking `ubports/docs.ubports.com <https://gitlab.com/ubports/docs/docs.ubports.com>`_ on GitLab.

Building the documentation
^^^^^^^^^^^^^^^^^^^^^^^^^^

To build this documentation, follow these instructions on your *local copy* of your fork of the repository.

The documentation can be built by running ``./build.sh`` in the root of this repository. The script will also create a virtual build environment in ``~/ubportsdocsenv`` if none is present.

If all went well, you can enter the ``_build/html`` directory and open ``index.html`` to view the UBports documentation.

If you have trouble building the docs, the first thing to try is deleting the build environment. Run ``rm -r ~/ubportsdocsenv`` and try the build again.

Final check of your contribution
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

After you have created your Merge Request on GitLab, the Continuous Integration (CI) system will make a test build of your contribution. Please double check whether this builds successfully and whether the result looks as you intended it to:

* at the top of the "Overview" tab of your MR on gitlab you will see the "pipeline status"
* if it says "Checking pipeline status" then please wait another minute.
* if it shows a red X and says "Pipeline failed" then something went wrong, please click on the link to find the details
* if it shows a green check mark and says "Pipeline passed", it means the MR could be built successfully
* now please click on link of that pipeline
* click on "jenkinsci/mr-merge
* click on "Artifacts" on the top right
* click on "_build/html/..index.html"
* and finally click on "Go to start page"
* now you can browse a complete build of the UBports docs site online with your contribution included
* double check whether your changes look ok

Alternative methods to contribute
---------------------------------

Translations
^^^^^^^^^^^^

You may find the components of this document to translate at `its project in UBports Weblate`_.

Writing documents not in RST format
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you would like to write documents for UBports but are not comfortable writing ReStructuredText, please write it without formatting and post it on the `UBports Forum`_ in the relevant section (likely General). Someone will be able to help you revise your draft and write the required ReStructuredText.

Uncomfortable with Git
^^^^^^^^^^^^^^^^^^^^^^

If you've written a complete document in ReStructuredText but aren't comfortable using Git or GitLab, please post it on the `UBports Forum`_ in the relevant section (likely General). Someone will be able to help you revise your draft and submit it to this documentation.

Current TODOs
-------------

This section lists the TODOs that have been included in this documentation. If you know how to fix one, please send us a merge request to make it better!

To create a todo, add this markup to your page::

    .. todo::

       My todo text

.. todolist::

ReadTheDocs hosting
-------------------

The actual `documents website <https://docs.ubports.com>`_  is built and hosted for us by the `Read The Docs <https://readthedocs.org>`_ project.
Our RTD setup contains one main project for English and one additional project for each supported language added as translations to the main project.
If you are a maintainer and want to add a language, first create a new project with manual import and set the language appropriately.
Afterwards add this as a translation in the Admin page of the main project.

.. _Its project in UBports Weblate: https://hosted.weblate.org/projects/ubports/doc-ubports-com
.. _UBports Forum: https://forums.ubports.com/
