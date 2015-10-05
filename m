Return-Path: <elliot.smith@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 8EFEB75A2F
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Oct 2015 09:43:12 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 05 Oct 2015 02:43:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,637,1437462000"; d="scan'208";a="803809601"
Received: from blynch-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.3.31])
	by fmsmga001.fm.intel.com with ESMTP; 05 Oct 2015 02:43:11 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  5 Oct 2015 10:43:06 +0100
Message-Id: <cover.1444038048.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH 0/6] Fixes for toastergui
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
X-List-Received-Date: Mon, 05 Oct 2015 09:43:14 -0000

This patchset fixes creation of Target objects for command line builds
and provides a couple of usability fixes for toastergui module.

The following changes since commit 78b7cfc2d29209354a1ed3a3a787c651efd31f28:

  toaster: test get_alldeps API (2015-10-05 10:37:47 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib elliot/submit/ed/toaster/target-task
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=elliot/submit/ed/toaster/target-task

Ed Bartosh (6):
  event: add new property to BuildBase class
  event: add new parameter to Build* event APIs
  toaster: add task to the target_information
  toaster: add get_or_create_targets API
  toaster: ignore ReachableStamps event
  toaster: use meaningful logging levels

 lib/bb/cooker.py             |  8 ++++----
 lib/bb/event.py              | 18 +++++++++++++-----
 lib/bb/ui/buildinfohelper.py | 37 +++++++++++++++++++++----------------
 lib/bb/ui/toasterui.py       | 11 ++++++-----
 4 files changed, 44 insertions(+), 30 deletions(-)

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


