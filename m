Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1RmoBE-0002xR-DK
	for bitbake-devel@lists.openembedded.org;
	Mon, 16 Jan 2012 16:09:04 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 16 Jan 2012 07:01:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="96995169"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.171])
	by orsmga001.jf.intel.com with ESMTP; 16 Jan 2012 07:01:12 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Jan 2012 15:01:07 +0000
Message-Id: <cover.1326725777.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH 0/1] Allow resuming interrupted fetch
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
X-List-Received-Date: Mon, 16 Jan 2012 15:09:04 -0000

This patch fixes an annoyance of mine that I've observed others running
into, where (either due to network issues or deliberate Ctrl+C) a fetch
is interrupted and won't properly resume the next time.

The patch (against Poky, but applies cleanly with -p2 against bitbake
master) is available in the git repository at:
  git://git.yoctoproject.org/poky-contrib paule/fetchresume
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/fetchresume

Paul Eggleton (1):
  bitbake/fetch2: allow resuming interrupted fetch

 bitbake/lib/bb/fetch2/__init__.py |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.7.5.4



