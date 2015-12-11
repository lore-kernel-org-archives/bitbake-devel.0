Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id C134D605B3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Dec 2015 02:33:15 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga103.jf.intel.com with ESMTP; 10 Dec 2015 18:33:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,411,1444719600"; d="scan'208";a="858518112"
Received: from exxie-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.172.26])
	by fmsmga001.fm.intel.com with ESMTP; 10 Dec 2015 18:33:12 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 11 Dec 2015 15:32:54 +1300
Message-Id: <cover.1449801133.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.0
Subject: [1.28][PATCH 0/2] Backport two bb.utils fixes to 1.28
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
X-List-Received-Date: Fri, 11 Dec 2015 02:33:18 -0000

The following changes since commit 7974203cd8bc66dff1fcc55f8723dedefaf72840:

  toasterui: Create per-build logs (2015-10-29 22:03:34 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-fixes-1.28
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-fixes-1.28

Paul Eggleton (2):
  lib/bb/utils: fix error in edit_metadata() when deleting first line
  lib/bb/utils: improve edit_bblayers_conf() handling of bblayers.conf
    formatting

 lib/bb/tests/utils.py | 203 ++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/bb/utils.py       |  80 ++++++++++++++++----
 2 files changed, 268 insertions(+), 15 deletions(-)

-- 
2.5.0


