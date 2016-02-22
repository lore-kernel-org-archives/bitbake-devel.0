Return-Path: <elliot.smith@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id A6E197570D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Feb 2016 09:08:41 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga103.jf.intel.com with ESMTP; 22 Feb 2016 01:08:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,483,1449561600"; d="scan'208";a="52333009"
Received: from mmisiak-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.31.233])
	by fmsmga004.fm.intel.com with ESMTP; 22 Feb 2016 01:08:34 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 22 Feb 2016 09:08:31 +0000
Message-Id: <cover.1456131920.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH 0/9] Minor Toaster UI fixes
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
X-List-Received-Date: Mon, 22 Feb 2016 09:08:41 -0000

Pulls together a variety of small Toaster UI tweaks by Belen.

The following changes since commit c0fe43b9bb8a82ecfc2ed72ad9b39f435fe3b707
(toaster-next):

  toaster: toastergui Fix invalid char test and implementation (2016-02-16 17:54:25 -0800)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib elliot/submit/bbarrosp/misc_ui_fixes
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=elliot/submit/bbarrosp/misc_ui_fixes

Belen Barros Pena (9):
  toaster: comment out project release change
  toaster: fix custom image name form
  toaster: apply error class to name field
  toaster: disable add layer button on click
  toaster: reduce max height of modal dialogs
  toaster: link to configuration in all breadcrumbs
  toaster: make 'configuration' the first tab
  toaster: adjust the search field width
  toaster: add missing link to image recipe details

 lib/toaster/toastergui/static/css/default.css         |  5 +++--
 lib/toaster/toastergui/static/js/layerdetails.js      | 15 ---------------
 .../toastergui/static/js/newcustomimage_modal.js      |  3 +++
 lib/toaster/toastergui/static/js/projectpage.js       |  2 ++
 lib/toaster/toastergui/tables.py                      |  7 +++++++
 .../toastergui/templates/basebuilddetailpage.html     |  4 ++--
 lib/toaster/toastergui/templates/basebuildpage.html   |  4 ++--
 lib/toaster/toastergui/templates/basetable_top.html   |  4 ++--
 lib/toaster/toastergui/templates/layerdetails.html    |  4 +---
 .../toastergui/templates/newcustomimage_modal.html    |  2 +-
 lib/toaster/toastergui/templates/project.html         | 19 ++++++++++++++-----
 lib/toaster/toastergui/templates/projecttopbar.html   | 10 +++++-----
 lib/toaster/toastergui/templates/recipedetails.html   |  5 +----
 lib/toaster/toastergui/templates/toastertable.html    |  4 ++--
 14 files changed, 45 insertions(+), 43 deletions(-)

--
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


