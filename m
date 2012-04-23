Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SMR4S-0000Ho-P9
	for bitbake-devel@lists.openembedded.org;
	Mon, 23 Apr 2012 23:45:21 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 23 Apr 2012 14:35:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="132995958"
Received: from unknown (HELO shamshir.jf.intel.com) ([10.7.198.56])
	by orsmga001.jf.intel.com with ESMTP; 23 Apr 2012 14:35:46 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 23 Apr 2012 14:35:43 -0700
Message-Id: <cover.1335216391.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
Subject: [PATCH 0/1] Allow Hob to run with sanity checks disabled
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 23 Apr 2012 21:45:21 -0000

Currently sanity check failures prevent Hob from launching, however we want
users to be able to change the various sanity failure causing settings - such
as proxy configuration - from the GUI.

This change and a related set of changes to OE-Core allow Hob to start with the
sanity checks disabled and enable them once the GUI is in place to a) report
errors and b) affect settings.

In tandem with an OE-Core change fixes [YOCTO #2361].

Regards,

Joshua

The following changes since commit 1a39698ab8498410d159c665c015f9297f153797:

  lib/bb/ui/crumbs/recipeselectionpage: fix type availabel->available (2012-04-17 16:41:30 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake josh/hob
  https://github.com/incandescant/bitbake/tree/josh/hob

Joshua Lock (1):
  hob: enable sanity checks after launch

 lib/bb/ui/crumbs/builder.py         |    2 ++
 lib/bb/ui/crumbs/hobeventhandler.py |    3 +++
 2 files changed, 5 insertions(+), 0 deletions(-)

-- 
1.7.7.6



