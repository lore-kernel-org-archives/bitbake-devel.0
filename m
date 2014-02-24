Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 219CF6E8E2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Feb 2014 18:50:25 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 24 Feb 2014 10:50:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,536,1389772800"; d="scan'208";a="487258402"
Received: from mmckenna-mobl2.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.123.143])
	by fmsmga002.fm.intel.com with ESMTP; 24 Feb 2014 10:50:15 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Feb 2014 18:50:01 +0000
Message-Id: <cover.1393267755.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.5.3
Subject: [PATCH 0/4] gitsm fetcher / test improvements
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
X-List-Received-Date: Mon, 24 Feb 2014 18:50:28 -0000

The following changes since commit 348971d410bfd5d8b1757468d73e1d24ae78a594:

  fetch2: Fix mirror repo tarball creation (2014-02-24 13:00:29 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/gitsm
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/gitsm

Paul Eggleton (4):
  fetch2: fix fetching git submodules with git 1.7.9.x or older
  bitbake-selftest: enable specifying tests to run on command line
  tests: add missing import
  tests: add test for gitsm fetcher

 bin/bitbake-selftest   | 21 ++++++++++++++++-----
 lib/bb/fetch2/gitsm.py | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 lib/bb/tests/data.py   |  1 +
 lib/bb/tests/fetch.py  |  7 +++++++
 4 files changed, 72 insertions(+), 5 deletions(-)

-- 
1.8.5.3


