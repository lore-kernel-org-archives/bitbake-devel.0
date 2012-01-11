Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1Rl3Vi-0005TC-1x
	for bitbake-devel@lists.openembedded.org;
	Wed, 11 Jan 2012 20:06:58 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 11 Jan 2012 10:30:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="94832993"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.95])
	by azsmga001.ch.intel.com with ESMTP; 11 Jan 2012 10:30:54 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 11 Jan 2012 18:30:47 +0000
Message-Id: <cover.1326306561.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH 0/4] Minor improvements to error messages
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
X-List-Received-Date: Wed, 11 Jan 2012 19:06:58 -0000

A few minor improvements to error output. I'm still working on some
deeper improvements but these are ready to go in immediately.

The patches (against Poky, but apply cleanly with -p2 against bitbake
master) are available in the git repository at:
  git://git.yoctoproject.org/poky-contrib paule/errorhandling1
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/errorhandling1

Paul Eggleton (4):
  bitbake/knotty: don't count errors as warnings
  bitbake: improve error formatting for fetcher errors
  bitbake: make warning for initial fetch failure one line
  bitbake/runqueue: avoid "failed" in task summary if nothing did

 bitbake/lib/bb/build.py           |    2 +-
 bitbake/lib/bb/fetch2/__init__.py |   10 +++++++---
 bitbake/lib/bb/runqueue.py        |    6 +++++-
 bitbake/lib/bb/ui/knotty.py       |    2 +-
 4 files changed, 14 insertions(+), 6 deletions(-)

-- 
1.7.5.4



