Return-Path: <brian.avery@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 454547016E
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Sep 2016 02:36:27 +0000 (UTC)
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by orsmga102.jf.intel.com with ESMTP; 18 Sep 2016 19:36:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,360,1470726000"; d="scan'208";a="10721328"
Received: from bavery-ws-desk.jf.intel.com ([10.7.201.28])
	by orsmga005.jf.intel.com with ESMTP; 18 Sep 2016 19:36:28 -0700
From: bavery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 18 Sep 2016 19:37:51 -0700
Message-Id: <cover.1474252537.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: bavery <brian.avery@intel.com>
Subject: [PATCH 0/1] toaster: Add test for missing migrtions
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
X-List-Received-Date: Mon, 19 Sep 2016 02:36:31 -0000

Based on the same test as found in patchwork by Damien Lespiau
https://github.com/dlespiau/patchwork/blob/master/patchwork/tests/test_db.py

-bavery

The following changes since commit 58fe1ad0b87766312f844fa35ad62902ab573166:

  toaster: Remove duplicate layer information (2016-09-18 19:26:21 -0700)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/submit/toaster/mw/sep-18-mig
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/submit/toaster/mw/sep-18-mig

Michael Wood (1):
  toaster: Add tests to detect if we have missing db migrations

 lib/toaster/tests/db/__init__.py |  0
 lib/toaster/tests/db/test_db.py  | 55 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 bitbake/lib/toaster/tests/db/__init__.py
 create mode 100644 bitbake/lib/toaster/tests/db/test_db.py

--
1.9.1

