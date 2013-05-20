Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1UeSB1-0006Ia-HC
	for bitbake-devel@lists.openembedded.org;
	Mon, 20 May 2013 17:39:14 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 20 May 2013 08:20:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,707,1363158000"; d="scan'208";a="244169570"
Received: from unknown (HELO helios.amr.corp.intel.com) ([10.255.12.168])
	by AZSMGA002.ch.intel.com with ESMTP; 20 May 2013 08:20:18 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 20 May 2013 16:20:13 +0100
Message-Id: <cover.1369063091.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
Subject: [1.18][PATCH 0/3] Stable branch cherry-picks
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
X-List-Received-Date: Mon, 20 May 2013 15:39:46 -0000

The following changes (against poky, but apply cleanly with -p2 against
the 1.18 branch of bitbake) are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/dylan-next-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/dylan-next-bb

Laurentiu Palcu (1):
  data_smart.py: add some internal bitbake variables to configuration
    hash

Martin Donnelly (1):
  goggle: fix invalid error check

Richard Purdie (1):
  prserv/cooker: Handle PRService errors cleanly

 bitbake/lib/bb/cooker.py     |  5 ++++-
 bitbake/lib/bb/data_smart.py | 10 ++++++++++
 bitbake/lib/bb/ui/goggle.py  |  2 +-
 bitbake/lib/prserv/serv.py   |  9 ++++++---
 4 files changed, 21 insertions(+), 5 deletions(-)

-- 
1.8.1.2



