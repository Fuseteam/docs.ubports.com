Issue-Tracking Guidelines
=========================

This document describes the standard process of dealing with issues in UBports projects.
(Not to be confused with the :doc:`guide on writing a good bugreport </contribute/bugreporting>`.)

Where are bugs tracked?
-----------------------

The primary issue tracker for Ubuntu Touch is the `ubports/development/ubuntu-touch GitLab project`_. This project tracks all system-level Ubuntu Touch issues, and serves as an entry point for users to report issues they've encountered.

Meanwhile, other projects in the group also have their issue trackers enabled too:

- Device-specific issues are tracked under each device's project under `ubports/porting`_ group.
- Core applications under `ubports/development/apps`_ track their own issues.
- System issues can also be filed against each component under `ubports/development/core`_ directly as well, if it's clear which component is responsible for an issue.

GitLab allows showing `issues across the group`_, cross-project issue reference, and issue transfer between projects, making the exact project an issue is filed less important. If a port-specific or website issue ended up in ubports/development/ubuntu-touch project, they can be moved to the appropriate project.

.. _ubports/development/ubuntu-touch GitLab project: https://gitlab.com/ubports/development/ubuntu-touch
.. _ubports/porting: https://gitlab.com/ubports/porting
.. _ubports/development/apps: https://gitlab.com/ubports/development/apps
.. _ubports/development/core: https://gitlab.com/ubports/development/core
.. _issues across the group: https://gitlab.com/groups/ubports/development/-/issues

Labels
------

All issues — even closed ones — should be labeled to allow use of GitLab's filtering. For example, these are `issues labeled 'Kind: enhancement' inside ubports/development group`_. Consult the `GitLab help pages`_ to learn more about searching and filtering.

.. _issues labeled 'Kind\: enhancement' inside ubports/development group: https://gitlab.com/groups/ubports/development/-/issues/?sort=created_date&state=opened&or%5Blabel_name%5D%5B%5D=Kind%3A%20enhancement&first_page_size=20
.. _GitLab help pages: https://docs.gitlab.com/user/project/issues/managing_issues/#filter-the-list-of-issues

The following labels are used inside UBports projects:

- **Kind:** describe the nature of the issue
    - **Kind: bug**: this issue describes something that doesn't work correctly.
    - **Kind: enhancement**: this issue is a feature request or describes something that can be improved.
    - **Kind: maintenance**: this issue describes a technical debt; something we need to clean up.
    - **Kind: FTBFS**: this issue describes a "Fails To Build From Source" issue (`an accronym from Debian`_).
    - **Kind: process**: this issue is a tracking issue for some process. For example, a process on releasing an Ubuntu Touch release.
    - **Kind: question**: This issue is a support request or general question. It should be directed to forums instead.
- **Needs:** describe some action that can/has to be done
    - **Needs: help from community**: the maintainers currently don't have capacity to solve this issue and would like help from the community.
    - **Needs: confirmation/more info**: the bug needs confirmation and / or further detailing by affected users.
    - **Needs: feedback from author**: used to flag a merge request which requires a feedback from author after a review. This is different from **Needs: confirmation/more info** which is intended to be used on an issue.
    - **Needs: discussion**: it is not clear how to solve this issue and further discussion is required.
    - **Needs: rebase**: this merge request has to be rebased, but maintainers do not have a permission to push to the source branch.
- **Severity:** how severe is the issue.
    - **Severity: critical**: this issue is very severe and should block the rollout of the release (defined by its milestone).
- **Area:** this issue is related to a certain area of Ubuntu Touch (e.g. HAL, middleware, UI). Labels of this prefix can be created as appropriate.
- **Topic:** this issue is related to a certain topic of interest (e.g. VoLTE, contact backend migration). Labels of this prefix can also be created as appropriate.
- **Resolution:** used when the issue is closed for other reason than the issue being fixed.
    - **Resolution: unable to confirm**: we are unable to reproduce the issue and not enough information is provided.
    - **Resolution: not our bug**: the issue is not an issue in Ubuntu Touch, but rather is an issue in a third-party software installed by the user.
    - **Resolution: won't fix**: A bug it does not make sense to fix, since it will probably resolve itself, be too much work, isn't fixable, or an underlying component will soon change.
    - **Resolution: work as intended**: The behavior described in the issue is the intended behavior of the software.
- **Status:** indicates the progress of the issue. This is primarily used to update GitLab's issue boards (see below).
    - **Status: in progress**: a developer is actively working on the issue.
    - **Status: blocked**: something else has to be solved outside of this issue before this issue can progress.
    - **Status: has MR**: a non-draft MR exists that will fix this issue.
- **Backport to: <branch name>**: used by the automation to automatically backport an MR to a stable release branches.
- Miscellaneous labels
    - **Good first issue**: the report contains instructions or hints required to fix it. It is an excellent place for someone new to learn about the project by fixing a real issue.
    - **Hotfix**: This MR/issue classifies for being included/resolved as part of a point release of Ubuntu Touch

.. note::
    If a repository tracking issues locally defines it's own labels, they
    should be documented in the README.md.

.. _an accronym from Debian: https://wiki.debian.org/FTBFS

Milestones
----------

Milestones are used to define which release an issue targets. At a given time, up to 3 milestones are open:

- A milestone for the upcoming stable release e.g. 'Ubuntu Touch 24.04-1.1'.
- A milestone for the in development major release e.g. 'Ubuntu Touch 24.04-2.0'.
- Once the in development release enters a stabilization phase, a milestone for the next major release (e.g. 'Ubuntu Touch 24.04-3.0') can be created.

Developers are encouraged to avoid assigning too many issues to a milestone; an overflowing milestone makes the milestone not as useful as it could be in tracking progress of a release.

Assignees
---------

To make it transparent who's working on an issue, the developer should
be assigned. This also allows the use of GitHub's global filtering as a
type of TODO list.

Developers are encouraged to keep their list short and update the status of their issues.

GitLab issue board
------------------

We use GitLab's issue boards to visualize progress of issues in each milestone. The boards are kanban boards, where each column corresponds to each **Status:** label (in-progress, blocked, has MR), with additional columns for opened issues without **Status:** label (which indicate that the issue has not been started yet) and closed issues.

GitLab epic
-----------

We use GitLab's epics to denote a topic which might span single or multiple milestones/releases. This helps organizing some long-term goals which are too large to implement at once.

How labels, milestone etc. are being used?
-------------------------------------------

Think of labels, milestone, and other fields as tools a person can use to efficiently communicate with the reporter, other developers, and interested parties. They could be use in a few ways:

- Because those fields show up in the issue list, it can give an at-a-glance info about the issue, helping developers to quickly understand the issue. For example, a developer could look at an issue on the list, notice that the issue has "needs discussion" label, and decide to jump in to give their 2 cents.
- A field could be used to filter only interested issues. For example, a community member wanting to contribute into confirming issues can filter only issues with "needs confirmation" label and start jumping in.
- A field could also be used to filter out uninteresting issues. For example, when a developer want to look for an issue to work on, one would want to filter out "Kind: process" label (used for e.g. tracking issue for a release).

Since we don't always have someone to specifically triage issues and set those labels, developers are encouraged to set all those fields as they work on an issue. This will help comminicating what has been done on the issue, and also help summarizing the issue for quicker understanding.
