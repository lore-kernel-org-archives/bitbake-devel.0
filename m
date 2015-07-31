Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 9BD34765B6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 12:09:40 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 31 Jul 2015 05:09:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,584,1432623600"; d="scan'208";a="739515390"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga001.jf.intel.com with ESMTP; 31 Jul 2015 05:09:31 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id 528696A4083
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 05:08:46 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 Jul 2015 15:09:01 +0300
Message-Id: <cover.1438343854.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH 00/22] Toaster UI changes
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
X-List-Received-Date: Fri, 31 Jul 2015 12:09:40 -0000

Hi reviewers,

This is a set of fixes for Toaster UI from Michael:
- The new project page [YOCTO #7329]
- The navigation changes needed for the new project page [YOCTO #7329]
- Fixes needed for the new project page
- Fixes needed to test the new project page (import layers, new build button)
- Removes dependency on angular

The patchset has been reviewed by me. Please review and accept.

The following changes since commit eb1c88c13f0490fa42fbe1681ac712ee883061a3:

  distro/maintainers.inc: Fix parsing error due to lack of " at end. (2015-07-29 20:27:51 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib ed/toaster/submit/michaelw/toaster/import-project-navigation-work
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=ed/toaster/submit/michaelw/toaster/import-project-navigation-work

Michael Wood (22):
  bitbake: toastergui: Implement new top navigation design
  bitbake: toastergui: Implement new project navigation
  bitbake: toastergui: base Fix html indentation
  bitbake: toastergui: importlayer Add format type to JSON calls
  bitbake: toastergui: Remove erroneous CSS property
  bitbake: toastergui: Standardise the layer object property
    layerdetailurl
  bitbake: toastergui: libtoaster Add show change notification function
  bitbake: toastergui: tables Add name field to layers table
  bitbake: toastergui: http api Add guard against incomplete change
    requests
  bitbake: toastergui: css Add new rules for new project page
  bitbake: toastergui: Add new project page and navigation
  bitbake: toastergui: css Remove redundant css rules
  bitbake: toastergui: libtoaster Make sure we always pass format=json
  bitbake: toastergui: libtoaster: Add guard against missing name
    property
  bitbake: toastergui: Fix Duplicate layer importlayer api calls
  bitbake: toastergui: base Use removeAttr / attr
  bitbake: toastergui: Change build button popover to a build-button
  bitbake: toastergui: newbuildbutton Fix typo on project save function
  bitbake: toastergui: newbuildbutton Fix removed elements
  bitbake: toastergui: Remove angularJS and projectapp based on angular
  bitbake: toastergui: layerBtn use libtoaster for change notification
  bitbake: toastergui: project page Add inline project name change
    feature

 lib/toaster/toastergui/static/css/default.css      |  33 +-
 .../toastergui/static/js/angular-animate.min.js    |  28 -
 .../toastergui/static/js/angular-cookies.min.js    |   8 -
 .../toastergui/static/js/angular-route.min.js      |  14 -
 .../toastergui/static/js/angular-sanitize.min.js   |  15 -
 lib/toaster/toastergui/static/js/angular.min.js    | 215 -----
 .../toastergui/static/js/angular.min.js.map        |   8 -
 lib/toaster/toastergui/static/js/base.js           | 165 ++--
 lib/toaster/toastergui/static/js/importlayer.js    |  42 +-
 lib/toaster/toastergui/static/js/layerBtn.js       |   4 +-
 lib/toaster/toastergui/static/js/layerdetails.js   |  16 +-
 lib/toaster/toastergui/static/js/libtoaster.js     |  37 +-
 lib/toaster/toastergui/static/js/projectapp.js     | 985 ---------------------
 lib/toaster/toastergui/static/js/projectpage.js    | 429 +++++++++
 lib/toaster/toastergui/tables.py                   |  12 +-
 lib/toaster/toastergui/templates/base.html         | 236 ++---
 .../templates/baseprojectbuildspage.html           |  15 +
 .../toastergui/templates/baseprojectpage.html      |  62 +-
 .../toastergui/templates/basetable_top.html        |   1 -
 .../templates/basetable_top_buildprojects.html     |  14 -
 .../templates/basetable_top_projectbuilds.html     |  14 -
 .../toastergui/templates/buildrequestdetails.html  |   3 -
 lib/toaster/toastergui/templates/builds.html       |   2 +-
 .../templates/generic-toastertable-page.html       |  24 +-
 lib/toaster/toastergui/templates/importlayer.html  |  19 +-
 lib/toaster/toastergui/templates/layer_btn.html    |   4 +-
 lib/toaster/toastergui/templates/layerdetails.html |  29 +-
 lib/toaster/toastergui/templates/machine_btn.html  |   4 +-
 lib/toaster/toastergui/templates/project.html      | 518 ++---------
 .../toastergui/templates/projectbuilds.html        |   5 +-
 lib/toaster/toastergui/templates/projectconf.html  |   8 +-
 lib/toaster/toastergui/templates/projects.html     |   2 +-
 .../toastergui/templates/projecttopbar.html        |  57 ++
 lib/toaster/toastergui/templates/recipe_btn.html   |   2 +-
 lib/toaster/toastergui/urls.py                     |   6 +-
 lib/toaster/toastergui/views.py                    |  32 +-
 36 files changed, 1036 insertions(+), 2032 deletions(-)
 delete mode 100644 bitbake/lib/toaster/toastergui/static/js/angular-animate.min.js
 delete mode 100644 bitbake/lib/toaster/toastergui/static/js/angular-cookies.min.js
 delete mode 100644 bitbake/lib/toaster/toastergui/static/js/angular-route.min.js
 delete mode 100644 bitbake/lib/toaster/toastergui/static/js/angular-sanitize.min.js
 delete mode 100644 bitbake/lib/toaster/toastergui/static/js/angular.min.js
 delete mode 100644 bitbake/lib/toaster/toastergui/static/js/angular.min.js.map
 delete mode 100644 bitbake/lib/toaster/toastergui/static/js/projectapp.js
 create mode 100644 bitbake/lib/toaster/toastergui/static/js/projectpage.js
 create mode 100644 bitbake/lib/toaster/toastergui/templates/baseprojectbuildspage.html
 delete mode 100644 bitbake/lib/toaster/toastergui/templates/basetable_top_buildprojects.html
 delete mode 100644 bitbake/lib/toaster/toastergui/templates/basetable_top_projectbuilds.html
 create mode 100644 bitbake/lib/toaster/toastergui/templates/projecttopbar.html

--
Ed

