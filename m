Return-Path: <elliot.smith@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id D9D6360124
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Dec 2015 15:52:52 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga103.jf.intel.com with ESMTP; 07 Dec 2015 07:52:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,395,1444719600"; d="scan'208";a="855691239"
Received: from jamullin-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.16.98])
	by fmsmga001.fm.intel.com with ESMTP; 07 Dec 2015 07:52:51 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  7 Dec 2015 15:52:47 +0000
Message-Id: <cover.1449503378.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Cc: Mihail Stanciu <stanciux.mihail@intel.com>
Subject: [PATCH 0/2] Update UI tests to work with changes in Toaster 2.0
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
X-List-Received-Date: Mon, 07 Dec 2015 15:52:53 -0000

Add additional back-end tests and update all tests to work for Toaster 2.0.

The following changes since commit d27c3c279025a7c4bd1c0851ad40195cad318937
(poky-contrib, toaster-next):

  toasterui: process CommandStarted event (2015-12-02 09:40:21 -0800)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib elliot/submit/mihai/ui-tests-update
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=elliot/submit/mihai/ui-tests-update

Mihail Stanciu (2):
  toaster: tests Automated build-mode backend tests
  toaster: tests Update UI tests to work with 2.0 changes

 .../contrib/tts/toasteruitest/toaster.sqlite       |   1 +
 .../tts/toasteruitest/toaster_automation_test.py   | 702 ++++++++++++++++++---
 .../contrib/tts/toasteruitest/toasterconf.json     |   1 +
 3 files changed, 623 insertions(+), 81 deletions(-)
 create mode 120000 bitbake/lib/toaster/contrib/tts/toasteruitest/toaster.sqlite
 create mode 120000 bitbake/lib/toaster/contrib/tts/toasteruitest/toasterconf.json

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


