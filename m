Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id E274660125
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Oct 2015 13:20:55 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga103.fm.intel.com with ESMTP; 07 Oct 2015 06:20:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,649,1437462000"; d="scan'208";a="659587337"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga003.jf.intel.com with ESMTP; 07 Oct 2015 06:20:55 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 745B76A4083;
	Wed,  7 Oct 2015 06:19:57 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Oct 2015 16:20:49 +0300
Message-Id: <cover.1444223946.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH 00/10] toaster: Implement UI changes for "command line builds" project
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
X-List-Received-Date: Wed, 07 Oct 2015 13:20:56 -0000

Hi,

This implements changes across the UI to hide irrelevant options
for command-line builds, and show additional help icons explaining
why those options are hidden.

It also modifies the behaviour of the "New build" button to take
account of the special status of the command-line builds project.

For UI details, see the document attached to bug 8231
at https://bugzilla.yoctoproject.org/attachment.cgi?id=2760.

v2 (in response to Belen's review):

* Modify how the form for changing the project name is shown, so
that the edit buttons aren't lost after saving the new project name.
Also verify that project name changes take without requiring a page refresh.

* Never select the command-line builds project in the "New build"
drop-down form.

* Only show the "New build" button if there are one or more user-created
projects (i.e. not if there is only the command-line builds project).

v1:

* One of the changes in the design document has not been implemented:
it's not possible to hide the "customise image recipe" links and
buttons (page 9) as these are not in the templates yet.

* The visual design differs slightly from the design document, as it
incorporates a new layout for the build dashboard which is not
implemented yet.

* The "New build" button is displayed on the command line
builds project page, as we came to the conclusion that the logic
in the JavaScript (i.e. show the new build button if there is no
build input form on the page) should apply in the case of the
builds page for the "command line builds" project.

The following changes since commit 64680eb3a2eef5e6cf46c18f712b319edb1fc78a:

  toaster: remove bashisms so script works in dash as well (2015-10-07 15:06:40 +0300)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib ed/toaster/submit/elliot/toaster/cli_builds_ui-8231
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=ed/toaster/submit/elliot/toaster/cli_builds_ui-8231

Elliot Smith (10):
  toaster: Reorganise and lint tests
  toaster: Replace "Run again" button with help text for cli builds
  toaster: Show 'not applicable' for default project machine and release
  toaster: Make the builds view the project page for "command line
    builds"
  toaster: Hide tabs and add info popups for command line builds
  toaster: Show tooltip next to cli builds project name in all builds
  toaster: More linting of tests
  toaster: Clean up template code
  toaster: Exclude "command line builds" project from projects typeahead
  toaster: Modify "New build" button behaviour for cli builds project

 lib/toaster/toastergui/static/css/default.css      |   5 +
 lib/toaster/toastergui/static/js/base.js           |  18 +-
 lib/toaster/toastergui/templates/base.html         |  98 ++++---
 lib/toaster/toastergui/templates/builds.html       |  19 +-
 lib/toaster/toastergui/templates/mrb_section.html  |  66 +++--
 lib/toaster/toastergui/templates/projects.html     |  23 +-
 .../toastergui/templates/projecttopbar.html        |  80 ++---
 .../toastergui/templatetags/project_url_tag.py     |  34 +++
 lib/toaster/toastergui/tests.py                    | 322 ++++++++++++++++++---
 lib/toaster/toastergui/typeaheads.py               |   4 +-
 lib/toaster/toastergui/views.py                    |   9 +-
 11 files changed, 494 insertions(+), 184 deletions(-)
 create mode 100644 bitbake/lib/toaster/toastergui/templatetags/project_url_tag.py

-- 
2.1.4


