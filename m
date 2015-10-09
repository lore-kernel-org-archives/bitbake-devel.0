Return-Path: <elliot.smith@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id DFBDD73CBD
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Oct 2015 09:32:39 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 09 Oct 2015 02:32:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,657,1437462000"; d="scan'208";a="788373582"
Received: from sarallen-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.18.21])
	by orsmga001.jf.intel.com with ESMTP; 09 Oct 2015 02:32:36 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  9 Oct 2015 10:32:31 +0100
Message-Id: <cover.1444383025.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH 0/5] toaster UI fixes
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
X-List-Received-Date: Fri, 09 Oct 2015 09:32:42 -0000

A number of UI fixes:

* Add/Rm layer button not updated in some cases [YOCTO #8294]
* Updates to the JS unit tests
* A fix for the project layers returned
* Fix a bug noticed in the layer details page where the button class names were
incorrect meaning the toggle of the add/remove layer didn't enable/disable
the buttons to trigger recipe builds.

[YOCTO #8294]

The following changes since commit 06cdf52fec2f46e3e063ec64ee4cba6c79bfebe5:

  toaster: fix naming for clone directory (2015-10-07 15:35:13 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib elliot/submit/michaelw/toaster/table-ui-fixes
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=elliot/submit/michaelw/toaster/table-ui-fixes

Michael Wood (5):
  toaster: layerdetails update build recipe button class name
  toaster: Fix typo in returning pk list of layer versions in current
    project
  toaster: tables Add the recipe filter back into the Recipe table
  toaster: Fix stale layer state buttons
  toaster: Update JS unit tests

 lib/toaster/orm/models.py                          |  2 +-
 lib/toaster/toastergui/static/js/layerBtn.js       |  9 +-----
 lib/toaster/toastergui/static/js/layerdetails.js   |  4 +--
 lib/toaster/toastergui/static/js/table.js          |  2 +-
 lib/toaster/toastergui/static/js/tests/test.js     | 34 +++++++++++-----------
 lib/toaster/toastergui/tables.py                   | 20 +++++++++++--
 .../toastergui/templates/js-unit-tests.html        | 16 +++++++---
 lib/toaster/toastergui/templates/layer_btn.html    | 12 ++++++--
 lib/toaster/toastergui/templates/recipe_btn.html   | 12 ++++++--
 lib/toaster/toastergui/templates/toastertable.html |  1 -
 10 files changed, 71 insertions(+), 41 deletions(-)

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


