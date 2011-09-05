Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1R0YOb-0002f2-Au
	for bitbake-devel@lists.openembedded.org;
	Mon, 05 Sep 2011 14:35:25 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 05 Sep 2011 05:30:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="45362397"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.120.53])
	by orsmga001.jf.intel.com with ESMTP; 05 Sep 2011 05:30:16 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  5 Sep 2011 13:30:09 +0100
Message-Id: <cover.1315225427.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 0/2] Hob second build fixes
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
X-List-Received-Date: Mon, 05 Sep 2011 12:35:25 -0000

The following two patches fix problems running the second build within
a single session of the hob UI.

The patches (against Poky, but apply cleanly with -p2 against BitBake
master) are  available in the git repository at:
  git://git.pokylinux.org/poky-contrib paule/hob-fixes
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=paule/hob-fixes

Paul Eggleton (2):
  hob: clear out temporary file list after deleting
  hob: fix segfault on second build

 bitbake/lib/bb/ui/crumbs/runningbuild.py |    5 +++++
 bitbake/lib/bb/ui/hob.py                 |    3 ++-
 2 files changed, 7 insertions(+), 1 deletions(-)

-- 
1.7.4.1



