Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1QruRi-0007qD-0U
	for bitbake-devel@lists.openembedded.org;
	Fri, 12 Aug 2011 18:18:54 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 12 Aug 2011 09:14:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,363,1309762800"; d="scan'208";a="38827047"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.255.18.64])
	by fmsmga002.fm.intel.com with ESMTP; 12 Aug 2011 09:14:02 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Aug 2011 17:13:55 +0100
Message-Id: <cover.1313165343.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 0/4] bitbake-layers minor improvements
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
X-List-Received-Date: Fri, 12 Aug 2011 16:18:54 -0000

Several improvements to the help and show_layers function in
bitbake-layers.

The changes are available (against Poky, but apply cleanly against bitbake
master with -p2) at:
  git://git.pokylinux.org/poky-contrib paule/bitbake-layers-3
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=paule/bitbake-layers-3

Paul Eggleton (4):
  bitbake-layers: improve default command help
  bitbake-layers: show help with no command specified
  bitbake-layers: use logger.plain instead of info
  bitbake-layers: extend show_layers

 bitbake/bin/bitbake-layers |   89 ++++++++++++++++++++++++++++++-------------
 1 files changed, 62 insertions(+), 27 deletions(-)

-- 
1.7.4.1



