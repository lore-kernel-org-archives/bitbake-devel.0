Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 37AEE60167
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Apr 2015 12:41:51 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga103.fm.intel.com with ESMTP; 22 Apr 2015 05:41:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.11,623,1422950400"; d="scan'208";a="713553916"
Received: from unknown (HELO peggleto-mobl.ger.corp.intel.com) ([10.252.14.70])
	by fmsmga002.fm.intel.com with ESMTP; 22 Apr 2015 05:41:53 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 22 Apr 2015 13:41:26 +0100
Message-Id: <cover.1429706415.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
Subject: [PATCH 0/2] Backport subpath fixes to 1.24 (cover letter only)
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
X-List-Received-Date: Wed, 22 Apr 2015 12:41:55 -0000

Patch 2/2 needed minor conflict resolution for the test case but
otherwise this is just a straight cherry-pick.


The following changes since commit ed950f95fc80f069e800e9c6e785641f307e6512:

  bitbake: tests/data: add test for incorrect remove behaviour (2015-04-15 15:55:08 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/subpath-fix-1.24
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/subpath-fix-1.24

Anders Darander (1):
  fetch/git: Remove a possible trailing '/' in subpath

Paul Eggleton (1):
  lib/bb/utils: add safeguard against recursively deleting things we
    shouldn't

 lib/bb/fetch2/git.py  |  2 +-
 lib/bb/tests/utils.py | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/bb/utils.py       | 21 +++++++++++++++++++++
 3 files changed, 72 insertions(+), 1 deletion(-)

-- 
2.1.0


