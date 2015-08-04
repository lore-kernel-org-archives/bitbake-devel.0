Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 4AFEF73231
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Aug 2015 19:45:11 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga103.fm.intel.com with ESMTP; 04 Aug 2015 12:45:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,610,1432623600"; d="scan'208";a="777765886"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga002.jf.intel.com with ESMTP; 04 Aug 2015 12:45:12 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id 779756A4083;
	Tue,  4 Aug 2015 12:44:25 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  4 Aug 2015 22:45:02 +0300
Message-Id: <cover.1438717072.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH 00/12] toaster: bring back the correct typeahead behaviour as a modular widget
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
X-List-Received-Date: Tue, 04 Aug 2015 19:45:13 -0000

Hi,

This is a set of patches from Michael reviewed by me.

List of changes in this patchset:

- New typeahead widget
- Switch to Implementation of widget in frontend
- Utility functions in the models so that the querysets which are used
  for the ToasterTables are the same queries that are used for the
  typeaheads.
- Added/Fixed typeahead widget unit tests

Please, review.

The following changes since commit a8b723498c9a7106210db140452886894494b4d6:

  bitbake: cooker: Resolve file monitoring race issues when using memres bitbake (2015-08-03 07:36:25 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib ed/toaster/submit/michaelw/toaster/fix-typeahead-behaviour
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=ed/toaster/submit/michaelw/toaster/fix-typeahead-behaviour

Michael Wood (12):
  bitbake: toaster: orm Add util function to return the url to layerversion
  bitbake: toaster: orm Add util functions to return common querysets
  bitbake: toastergui: tables Use util functions for the common querysets
  bitbake: toastergui: widgets Add a typeahead widget
  bitbake: toastergui: Add typeaheads layers, machines, projects, recipes
  bitbake: toastergui: Switch to using the new toaster typeahead widget
  bitbake: toastergui: libtoaster Throw an exception no url is specified
  bitbake: toasterui: views Remove unused xhr_typeahead view definition
  bitbake: toastergui: views Standardise the fields project layer response
  bitbake: toastergui: tests Fix and more comprehensive typeahead unittest
  bitbake: toastergui: libtoaster: typeahead resiliency for slow server
  bitbake: toastergui: libtoaster typeahead Add in results highlighter

 lib/toaster/orm/models.py                        |  45 ++++++-
 lib/toaster/toastergui/static/js/base.js         |  26 ++--
 lib/toaster/toastergui/static/js/importlayer.js  |  12 +-
 lib/toaster/toastergui/static/js/layerdetails.js |   2 +-
 lib/toaster/toastergui/static/js/libtoaster.js   |  37 ++++--
 lib/toaster/toastergui/static/js/projectpage.js  |   8 +-
 lib/toaster/toastergui/tables.py                 |  11 +-
 lib/toaster/toastergui/templates/base.html       |   8 +-
 lib/toaster/toastergui/templates/project.html    |   3 +-
 lib/toaster/toastergui/tests.py                  |  88 +++++++++++---
 lib/toaster/toastergui/typeaheads.py             | 145 +++++++++++++++++++++++
 lib/toaster/toastergui/urls.py                   |  19 ++-
 lib/toaster/toastergui/views.py                  |  71 +++++------
 lib/toaster/toastergui/widgets.py                |  52 ++++++++
 14 files changed, 423 insertions(+), 104 deletions(-)
 create mode 100644 bitbake/lib/toaster/toastergui/typeaheads.py

--
Regards,
Ed


