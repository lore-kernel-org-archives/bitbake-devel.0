Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1R4YRR-0001fs-OE
	for bitbake-devel@lists.openembedded.org;
	Fri, 16 Sep 2011 15:26:53 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 16 Sep 2011 06:21:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="49107868"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.120.40])
	by orsmga001.jf.intel.com with ESMTP; 16 Sep 2011 06:21:39 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Sep 2011 14:21:36 +0100
Message-Id: <cover.1316178644.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 0/1] Fix git fetcher subpath option
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
X-List-Received-Date: Fri, 16 Sep 2011 13:26:54 -0000

This patch makes the git fetcher (fetch2) subpath option work the way
the Opie git recipes (the main user of the option) expect.

The patch (against poky, but applies cleanly to bitbake master with
 -p2) is available at:

  git://git.pokylinux.org/poky-contrib paule/subpath
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=paule/subpath

Paul Eggleton (1):
  fetch2/git: fix subpath destination directory

 bitbake/lib/bb/fetch2/git.py |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

-- 
1.7.4.1



