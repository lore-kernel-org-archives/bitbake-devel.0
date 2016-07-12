Return-Path: <brian.avery@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 17840731A1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Jul 2016 22:53:41 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga102.fm.intel.com with ESMTP; 12 Jul 2016 15:53:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,354,1464678000"; d="scan'208";a="845145187"
Received: from bavery-ws-desk.jf.intel.com ([10.7.201.28])
	by orsmga003.jf.intel.com with ESMTP; 12 Jul 2016 15:53:42 -0700
From: bavery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Jul 2016 15:54:56 -0700
Message-Id: <cover.1468363530.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: bavery <brian.avery@intel.com>
Subject: [PATCH 00/17] toaster: Better SDK artifacts and fstypes V2
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
X-List-Received-Date: Tue, 12 Jul 2016 22:53:42 -0000

This is part of a patch set that is split over the openembedded-core and
bitbake-devel mailing lists.  This is a second version of the patch.

These patches remove complexity from the toaster.bbclass in order to move those
functions to bitbake/lib/toaster.

The overall intent of this set is to improve Toaster's ability to locate artifacts,
specify fstypes correctly, and add some tests for these changes.

-brian avery
an Intel employee


The following changes since commit 0659b4f780120b1459b068c85794be4f04f943bd:

  toaster: fix typo in arguments for libtoaster.js function (2016-07-12 14:12:16 -0700)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/submit/elliot/toaster/8556-image_fstypesV2_forbb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/submit/elliot/toaster/8556-image_fstypesV2_forbb

Ed Bartosh (1):
  runqueue: improve exception logging

Elliot Smith (16):
  toaster: display Target targets in build dashboard
  toaster: do image and artifact scan on BuildCompleted
  toaster: improve image file suffix retrieval
  toaster: attach kernel artifacts to targets
  buildinfohelper: fix retrieval of targets
  toaster: improve scan for SDK artifacts
  buildinfohelper: only record image files for tasks which make images
  toaster: use has_images() methods to display images correctly
  toaster: only show "New custom image" button for builds with image
    targets
  toaster: show manifests in their own section of the build dashboard
  toaster: better display of targets which produced no images
  toaster: add package manifest path to Target objects
  toaster: the customise image button shouldn't rely on targets
  toaster-tests: add tests for build artifact display on build dashboard
  toaster-tests: new custom image button shouldn't show for non-image
    builds
  toaster-tests: package count/size shouldn't show for non-image builds

 lib/bb/runqueue.py                                 |   4 +-
 lib/bb/ui/buildinfohelper.py                       | 408 ++++++++++++++++++---
 lib/bb/ui/toasterui.py                             |  11 +-
 .../migrations/0008_refactor_artifact_models.py    |  39 ++
 .../0009_target_package_manifest_path.py           |  19 +
 lib/toaster/orm/models.py                          | 279 ++++++++++----
 lib/toaster/tests/browser/selenium_helpers.py      |   7 +
 .../tests/browser/test_builddashboard_page.py      |  20 +
 .../browser/test_builddashboard_page_artifacts.py  | 217 +++++++++++
 .../toastergui/templates/basebuildpage.html        |  52 +--
 .../toastergui/templates/builddashboard.html       | 117 ++++--
 .../toastergui/templatetags/field_values_filter.py |  18 +
 lib/toaster/toastergui/views.py                    |  77 ++--
 13 files changed, 1055 insertions(+), 213 deletions(-)
 create mode 100644 bitbake/lib/toaster/orm/migrations/0008_refactor_artifact_models.py
 create mode 100644 bitbake/lib/toaster/orm/migrations/0009_target_package_manifest_path.py
 create mode 100644 bitbake/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py
 create mode 100644 bitbake/lib/toaster/toastergui/templatetags/field_values_filter.py

--
1.9.1

