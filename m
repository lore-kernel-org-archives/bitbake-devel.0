Return-Path: <elliot.smith@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 78F3677306
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Nov 2015 13:48:31 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga103.jf.intel.com with ESMTP; 13 Nov 2015 05:48:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,287,1444719600"; d="scan'208";a="836998314"
Received: from lquinn-mobl2.amr.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.6.239])
	by fmsmga001.fm.intel.com with ESMTP; 13 Nov 2015 05:48:31 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Nov 2015 13:48:18 +0000
Message-Id: <cover.1447422301.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH 0/4] Remove the new build input
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
X-List-Received-Date: Fri, 13 Nov 2015 13:48:34 -0000

Remove the new build input from the templates, and all supporting
code which maintained its state.

The following changes since commit aa7690e182c9c307785e6e9679f3490583176421
(contrib/toaster-next):

  toaster: builds pages Fix the download cooker log link (2015-11-10 17:04:19 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib elliot/submit/michaelw/toaster/remove-new-build-form
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=elliot/submit/michaelw/toaster/remove-new-build-form

Michael Wood (4):
  toaster: orm Fix get_number_of_builds to count all apart from
    IN_PROGRESS
  toaster: projectpage Disable/Enable build input if we have 0 layers
  toaster: projecttopbar Use the project in context to get num builds
  toaster: Remove the new-build-input button widget

 lib/toaster/orm/models.py                          |   9 +-
 lib/toaster/toastergui/static/js/base.js           | 229 ---------------------
 lib/toaster/toastergui/static/js/projectpage.js    |  13 +-
 lib/toaster/toastergui/static/js/projecttopbar.js  |  81 ++++++++
 lib/toaster/toastergui/templates/base.html         | 133 +++---------
 .../toastergui/templates/projecttopbar.html        |  20 +-
 6 files changed, 147 insertions(+), 338 deletions(-)
 delete mode 100644 bitbake/lib/toaster/toastergui/static/js/base.js
 create mode 100644 bitbake/lib/toaster/toastergui/static/js/projecttopbar.js

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


