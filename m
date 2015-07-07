Return-Path: <leonardo.sandoval.gonzalez@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id BD02975D16
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Jul 2015 17:50:47 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga103.jf.intel.com with ESMTP; 07 Jul 2015 10:50:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,425,1432623600"; d="scan'208";a="742336488"
Received: from yctb05.ostc.intel.com (HELO yctb05.otcr.jf.intel.com)
	([10.23.219.54])
	by fmsmga001.fm.intel.com with ESMTP; 07 Jul 2015 10:50:47 -0700
From: leonardo.sandoval.gonzalez@linux.intel.com
To: bitbake-devel@lists.openembedded.org
Date: Tue,  7 Jul 2015 09:45:58 +0000
Message-Id: <cover.1436261758.git.leonardo.sandoval.gonzalez@linux.intel.com>
X-Mailer: git-send-email 1.8.4.5
Subject: [PATCH 0/3] On knotty, Make sure bitbake.lock is unlocked before exiting
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
X-List-Received-Date: Tue, 07 Jul 2015 17:50:47 -0000

From: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>

Solves issues recently found on the AutoBuilder, where between one build and another the
following log error is seen:

	  ERROR: Only one copy of bitbake should be run against a build directory

More info on https://bugzilla.yoctoproject.org/show_bug.cgi?id=7941

The following changes since commit b78b1a6bb82fb864f1f857bf7259908d0ed930b5:

  tune-i586-nlp: Add new tune file to support Quark/X1000 CPU (2015-07-01 15:40:00 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib lsandov1/PR-Service-selftest-failures-7941
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=lsandov1/PR-Service-selftest-failures-7941

Leonardo Sandoval (3):
  cooker.py: Lock/Unlock members function into BBCooker
  command.py: Unlock function included into CommandsSync class
  knotty.py: Make sure bitbake.lock is unlocked before exiting

 bitbake/lib/bb/command.py   |  6 ++++++
 bitbake/lib/bb/cooker.py    | 17 ++++++++++++++---
 bitbake/lib/bb/ui/knotty.py | 20 ++++++++++++++++++++
 3 files changed, 40 insertions(+), 3 deletions(-)

-- 
1.8.4.5


