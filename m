Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 5DC3D65C78
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Jul 2015 14:26:49 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga102.fm.intel.com with ESMTP; 14 Jul 2015 07:26:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,472,1432623600"; d="scan'208";a="728648413"
Received: from cbernard-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.31.54])
	by orsmga001.jf.intel.com with ESMTP; 14 Jul 2015 07:26:49 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 14 Jul 2015 15:26:40 +0100
Message-Id: <cover.1436883632.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
Subject: [PATCH 0/2] Shell message fixes (BitBake side)
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
X-List-Received-Date: Tue, 14 Jul 2015 14:26:50 -0000

BitBake side of some fixes for regressions caused by the recent shell
message changes.


The following changes since commit 5c5f8da509f6bbc1fad263462142519ef3d54a35:

  tests/data: Add new data tests (2015-07-12 22:50:27 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-shell-logging-fixes
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-shell-logging-fixes

Paul Eggleton (2):
  lib/bb: provide mechanism to bypass UI log suppression
  lib/bb/process: check output of select() before reading extrafiles

 lib/bb/__init__.py |  8 ++++----
 lib/bb/build.py    |  7 ++++++-
 lib/bb/process.py  | 21 +++++++++++----------
 3 files changed, 21 insertions(+), 15 deletions(-)

-- 
2.1.0


