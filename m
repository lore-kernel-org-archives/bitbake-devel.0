Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 19D9C60167
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Apr 2015 12:34:33 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 22 Apr 2015 05:34:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.11,623,1422950400"; d="scan'208";a="699133462"
Received: from unknown (HELO peggleto-mobl.ger.corp.intel.com) ([10.252.14.70])
	by fmsmga001.fm.intel.com with ESMTP; 22 Apr 2015 05:34:33 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 22 Apr 2015 13:34:03 +0100
Message-Id: <cover.1429705929.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
Subject: [PATCH 0/2] Backport subpath fixes to 1.26 (cover letter only)
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
X-List-Received-Date: Wed, 22 Apr 2015 12:34:34 -0000

No changes were required.

The following changes since commit 4460e6de04844c4060f1fe87c8a4b247b731c63e:

  bin/image-writer: Add ext4 as a deployable image type (2015-03-31 22:38:21 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/subpath-fix-1.26
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/subpath-fix-1.26

Anders Darander (1):
  bitbake: fetch/git: Remove a possible trailing '/' in subpath

Paul Eggleton (1):
  bitbake: lib/bb/utils: add safeguard against recursively deleting
    things we shouldn't

 lib/bb/fetch2/git.py  |  2 +-
 lib/bb/tests/utils.py | 17 +++++++++++++++++
 lib/bb/utils.py       | 21 +++++++++++++++++++++
 3 files changed, 39 insertions(+), 1 deletion(-)

-- 
2.1.0


