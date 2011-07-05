Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1Qe5gS-0005Yl-5c
	for bitbake-devel@lists.openembedded.org;
	Tue, 05 Jul 2011 15:29:00 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 05 Jul 2011 06:25:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,479,1304319600"; d="scan'208";a="22815065"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.255.17.114])
	by azsmga001.ch.intel.com with ESMTP; 05 Jul 2011 06:25:08 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  5 Jul 2011 14:25:04 +0100
Message-Id: <cover.1309872199.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 0/2] Fix bitbake-layers errors
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
X-List-Received-Date: Tue, 05 Jul 2011 13:29:00 -0000

These patches fix two issues with bitbake-layers caused by interaction
between several recent bitbake patches.

The changes are available (against Poky, but apply cleanly against bitbake
master with -p2) at:
  git://git.pokylinux.org/poky-contrib paule/bitbake-layers-fix
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=paule/bitbake-layers-fix

Paul Eggleton (2):
  bitbake-layers: fix sorting by package name for cooker change
  bitbake-layers: fix error on startup caused by recent cooker change

 bitbake/bin/bitbake-layers |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

-- 
1.7.4.1



