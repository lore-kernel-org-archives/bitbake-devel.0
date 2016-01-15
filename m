Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 199CA731FC
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 12:57:41 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga101.jf.intel.com with ESMTP; 15 Jan 2016 04:57:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,299,1449561600"; d="scan'208";a="881986919"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga001.fm.intel.com with ESMTP; 15 Jan 2016 04:57:42 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 6CBB86A4004
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 05:45:38 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jan 2016 13:00:43 +0200
Message-Id: <cover.1452855461.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH 00/23] toaster: Convert projects and builds pages to ToasterTable
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 15 Jan 2016 12:57:42 -0000

Hi,

Many of the tables displayed by Toaster are backed by ToasterTable, but some
of the key ones (like "projects", "all builds", and "project builds") aren't.

This makes it difficult to keep styling consistent between tables, as some
are styled by making changes to ToasterTable, while others are styled
by modifying Django templates.

Improve the consistency and maintainability of these tables by converting
them to use ToasterTable.

Note that this patchset also reworks the ToasterTable API so that we can easily
support different column filter types.

To test:

1. Open the "projects", "all builds" and "project builds" pages in Toaster.
2. Check that the column filtering and sorting works correctly, and projects/builds
   display correctly.

Related bug: https://bugzilla.yoctoproject.org/show_bug.cgi?id=8738

The following changes since commit ea666f60d2ddf492d146330fe69b474a0f9796d5:

  toaster-manual: describe the way to start Toaster (2016-01-15 09:56:25 +0200)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib ed/toaster/submit/elliot/toaster/tables-8738
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=ed/toaster/submit/elliot/toaster/tables-8738

Elliot Smith (23):
  toaster: toastergui: use ToasterTable for projects page
  toaster: move image file suffix list to model
  toaster: check inferred file suffixes against list of known types
  toaster: toastergui: switch projects/ view to ToasterTable
  toaster: toastergui: use event delegates for hover help elements
  toaster: toastergui: convert all builds page to ToasterTable
  toaster: toastergui: refactor ToasterTable filtering
  toaster: toastergui: switch off filter highlights when inactive
  toaster: toastergui: show recent builds on all builds page
  toaster: toastergui: implement date range filters for builds
  toaster: toastergui: implement "today" and "yesterday" filters
  toaster: toastergui: convert project builds page to ToasterTable
  toaster: toastergui: don't hide all elements with .col class
  toaster: toastergui: ensure filter_value updates
  toaster: toastergui: streamline construction of filter objects
  toaster: toastergui: serialise decimals correctly
  toaster: toastergui: set default visible and hideable columns
  toaster: toastergui: mute label for filter actions with no records
  toaster: toastergui: make "Apply" button state depend on filter range
  toaster: toastergui: fix error and warning counts for builds
  toaster: toastergui: remove unused views and template code
  toaster: tests: fix Django tests for new ToasterTable pages
  toaster: toastergui: code formatting and clean-up

 .../contrib/django-aggregate-if-master/.gitignore  |  10 -
 .../contrib/django-aggregate-if-master/.travis.yml |  50 --
 .../contrib/django-aggregate-if-master/LICENSE     |  21 -
 .../contrib/django-aggregate-if-master/README.rst  | 156 ----
 .../django-aggregate-if-master/aggregate_if.py     | 164 ----
 .../contrib/django-aggregate-if-master/runtests.py |  48 --
 .../contrib/django-aggregate-if-master/setup.py    |  33 -
 .../contrib/django-aggregate-if-master/tox.ini     | 198 -----
 lib/toaster/orm/models.py                          | 103 ++-
 lib/toaster/toastergui/static/js/libtoaster.js     |   6 +-
 lib/toaster/toastergui/static/js/projecttopbar.js  |   9 +
 lib/toaster/toastergui/static/js/table.js          | 325 ++++++--
 lib/toaster/toastergui/tablefilter.py              | 292 +++++++
 lib/toaster/toastergui/tables.py                   | 858 +++++++++++++++++++--
 .../toastergui/templates/baseprojectpage.html      |   1 +
 .../toastergui/templates/builds-toastertable.html  |  48 ++
 lib/toaster/toastergui/templates/builds.html       | 125 ---
 lib/toaster/toastergui/templates/mrb_section.html  |   4 +-
 .../templates/projectbuilds-toastertable.html      |  56 ++
 .../templates/projects-toastertable.html           |  36 +
 lib/toaster/toastergui/templates/projects.html     |  92 ---
 .../toastergui/templates/toastertable-filter.html  |   4 +-
 lib/toaster/toastergui/templates/toastertable.html |   7 +-
 lib/toaster/toastergui/tests.py                    | 265 +++++--
 lib/toaster/toastergui/urls.py                     |  14 +-
 lib/toaster/toastergui/views.py                    | 491 +-----------
 lib/toaster/toastergui/widgets.py                  | 112 +--
 lib/toaster/toastermain/settings.py                |   9 -
 28 files changed, 1898 insertions(+), 1639 deletions(-)
 delete mode 100644 bitbake/lib/toaster/contrib/django-aggregate-if-master/.gitignore
 delete mode 100644 bitbake/lib/toaster/contrib/django-aggregate-if-master/.travis.yml
 delete mode 100644 bitbake/lib/toaster/contrib/django-aggregate-if-master/LICENSE
 delete mode 100644 bitbake/lib/toaster/contrib/django-aggregate-if-master/README.rst
 delete mode 100644 bitbake/lib/toaster/contrib/django-aggregate-if-master/aggregate_if.py
 delete mode 100755 bitbake/lib/toaster/contrib/django-aggregate-if-master/runtests.py
 delete mode 100644 bitbake/lib/toaster/contrib/django-aggregate-if-master/setup.py
 delete mode 100644 bitbake/lib/toaster/contrib/django-aggregate-if-master/tox.ini
 create mode 100644 bitbake/lib/toaster/toastergui/tablefilter.py
 create mode 100644 bitbake/lib/toaster/toastergui/templates/builds-toastertable.html
 delete mode 100644 bitbake/lib/toaster/toastergui/templates/builds.html
 create mode 100644 bitbake/lib/toaster/toastergui/templates/projectbuilds-toastertable.html
 create mode 100644 bitbake/lib/toaster/toastergui/templates/projects-toastertable.html
 delete mode 100644 bitbake/lib/toaster/toastergui/templates/projects.html

--
Regards,
Ed


