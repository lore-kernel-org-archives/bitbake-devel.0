Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id A4AB772472
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Dec 2014 10:50:30 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 08 Dec 2014 02:50:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.07,537,1413270000"; d="scan'208";a="644158887"
Received: from apwitke-mobl2.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.30.33])
	by fmsmga002.fm.intel.com with ESMTP; 08 Dec 2014 02:50:29 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  8 Dec 2014 10:50:21 +0000
Message-Id: <cover.1418034514.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH 0/4] Developer workflow related enhancements / fixes
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
X-List-Received-Date: Mon, 08 Dec 2014 10:50:34 -0000

The following series is the set of BitBake changes that are part of the
developer workflow improvements currently being worked on [1].

Of particular note is the final patch for resetting the class handlers
object - this was discovered incidentally and fixes a rather nasty bug.
It should probably be considered separately from the rest of the series.

[1] https://bugzilla.yoctoproject.org/show_bug.cgi?id=6662

The following changes since commit 94d9590a4310f96396e8e782bcf65918f4dcdb36:

  bitbake: Update to 1.25.0 as development version after release (2014-12-03 12:14:43 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/devtool-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/devtool-bb

Paul Eggleton (4):
  utils: add exec_flat_python_func()
  fetch2: add means of disabling SRC_URI checksums
  event: add a means of filtering events internally
  event: fix resetting class handlers object

 lib/bb/event.py           |  9 +++++++++
 lib/bb/fetch2/__init__.py |  3 ++-
 lib/bb/utils.py           | 22 ++++++++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

-- 
1.9.3


