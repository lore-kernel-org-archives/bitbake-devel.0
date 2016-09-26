Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id C5CB560125
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Sep 2016 10:59:50 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga102.jf.intel.com with ESMTP; 26 Sep 2016 03:59:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,399,1470726000"; d="scan'208";a="766007343"
Received: from linux.intel.com ([10.54.29.200])
	by FMSMGA003.fm.intel.com with ESMTP; 26 Sep 2016 03:59:51 -0700
Received: from ed.fi.intel.com (ed.fi.intel.com [10.237.72.179])
	by linux.intel.com (Postfix) with ESMTP id 0B5626A4006
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Sep 2016 03:59:24 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 26 Sep 2016 13:59:27 +0300
Message-Id: <cover.1474887106.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.6.6
Subject: [PATCH 00/10] delete builds, projects, recipes, layers
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
X-List-Received-Date: Mon, 26 Sep 2016 10:59:50 -0000

Work to implement deleting of builds projects recipes and layers.
Includes a number of clean ups in affected areas.

The following changes since commit 725e66e1d08ae000d8f68455ddca0e192080dc1f:

  meta-environment: ensure corret TOOLCHAIN_CONFIGSITE_NOCACHE value (2016-09-26 10:06:02 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib ed/submit/michaelw/toaster/delete_buttons
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=ed/submit/michaelw/toaster/delete_buttons

Michael Wood (10):
  toaster: Clean up and convert to rest api project edit and get calls
  toaster: move MostRecentBuildsView to its own widget
  toaster: libtoaster Add a global notification set/show mechanism
  toaster: project page Implement front end feature to delete project
  toaster: alerts and modals Avoid modals and alerts overlaying each
    other
  toaster: Add backend API for deleting a build
  toaster: Add front end controls for deleting a build
  toaster: importlayer Convert success import to new notification system
  toaster: customrecipe Add frontend feature to delete custom image
    recipe
  toaster: layerdetails Update implementation of delete imported layer

 lib/toaster/toastergui/api.py                      | 312 +++++++++++++--------
 lib/toaster/toastergui/static/js/customrecipe.js   |  32 +++
 lib/toaster/toastergui/static/js/importlayer.js    |  59 +++-
 lib/toaster/toastergui/static/js/layerDepsModal.js |  12 +-
 lib/toaster/toastergui/static/js/layerdetails.js   |   7 +-
 lib/toaster/toastergui/static/js/libtoaster.js     |  42 ++-
 lib/toaster/toastergui/static/js/projectpage.js    | 237 +++-------------
 lib/toaster/toastergui/static/js/projecttopbar.js  |   6 +-
 lib/toaster/toastergui/static/js/tests/test.js     |   7 +-
 lib/toaster/toastergui/templates/base.html         |   1 +
 .../toastergui/templates/basebuildpage.html        | 138 ++++++---
 .../toastergui/templates/baseprojectpage.html      |   6 +
 .../toastergui/templates/builddashboard.html       |   2 +-
 lib/toaster/toastergui/templates/customrecipe.html |  35 ++-
 lib/toaster/toastergui/templates/layerdetails.html |   9 +-
 lib/toaster/toastergui/templates/project.html      |  35 ++-
 .../toastergui/templates/projecttopbar.html        |   2 +-
 lib/toaster/toastergui/urls.py                     |  11 +-
 lib/toaster/toastergui/views.py                    | 131 +--------
 lib/toaster/toastergui/widgets.py                  | 141 ++++++++--
 20 files changed, 679 insertions(+), 546 deletions(-)

-- 
2.6.6


