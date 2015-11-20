Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 1A72B6011C
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Nov 2015 04:11:38 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga101.jf.intel.com with ESMTP; 19 Nov 2015 20:11:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,320,1444719600"; d="scan'208";a="690115961"
Received: from ywong15-mobl2.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.131.114])
	by orsmga003.jf.intel.com with ESMTP; 19 Nov 2015 20:11:36 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 20 Nov 2015 17:11:14 +1300
Message-Id: <cover.1447992540.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
Subject: [PATCH v2 0/2] A couple of fixes for metadata editing functions
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
X-List-Received-Date: Fri, 20 Nov 2015 04:11:40 -0000

Since v1, fixed edit_bblayers_conf() changes for a regression which
meant that removing and adding the same path in a single call (which
devtool in OE does, perhaps unnecessarily) resulted in the layer being
removed.


The following changes since commit 50d7ffa697764d84d96f26a3ae58a9dacde7b31e:

  toaster: builds pages Fix the download cooker log link (2015-11-16 11:51:24 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-utils-fixes
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-utils-fixes

Paul Eggleton (2):
  lib/bb/utils: fix error in edit_metadata() when deleting first line
  lib/bb/utils: improve edit_bblayers_conf() handling of bblayers.conf
    formatting

 lib/bb/tests/utils.py | 203 ++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/bb/utils.py       |  80 ++++++++++++++++----
 2 files changed, 268 insertions(+), 15 deletions(-)

-- 
2.1.0


