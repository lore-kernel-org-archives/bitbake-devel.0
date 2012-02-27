Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1S25qO-0001wh-A6
	for bitbake-devel@lists.openembedded.org;
	Mon, 27 Feb 2012 20:02:44 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 27 Feb 2012 10:54:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="70898407"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.123.30])
	by AZSMGA002.ch.intel.com with ESMTP; 27 Feb 2012 10:54:15 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 27 Feb 2012 18:54:10 +0000
Message-Id: <cover.1330368761.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH 0/2] bitbake patches
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
X-List-Received-Date: Mon, 27 Feb 2012 19:02:44 -0000

A couple of bitbake patches.

The patches (against Poky, but apply cleanly with -p2 against bitbake
master) are available in the git repository at:
  git://git.yoctoproject.org/poky-contrib paule/bitbake-errors4
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bitbake-errors4

Paul Eggleton (2):
  bitbake: fix setscene task start/failure handling
  bitbake/runqueue: make dry-run do everything except execute

 bitbake/lib/bb/build.py       |   10 +++++++++-
 bitbake/lib/bb/runqueue.py    |   27 +++++++++++++++------------
 bitbake/lib/bb/ui/knotty.py   |    9 +++++++++
 bitbake/lib/bb/ui/uihelper.py |    3 +--
 4 files changed, 34 insertions(+), 15 deletions(-)

-- 
1.7.5.4



