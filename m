Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1T3sBY-0001jx-LZ
	for bitbake-devel@lists.openembedded.org;
	Tue, 21 Aug 2012 19:24:12 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by fmsmga102.fm.intel.com with ESMTP; 21 Aug 2012 10:12:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.77,803,1336374000"; d="scan'208";a="136563907"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.105])
	by AZSMGA002.ch.intel.com with ESMTP; 21 Aug 2012 10:12:06 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 21 Aug 2012 18:11:44 +0100
Message-Id: <cover.1345568965.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH 0/3] bitbake-layers fixes
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
X-List-Received-Date: Tue, 21 Aug 2012 17:24:12 -0000

The following changes (against Poky, but apply cleanly with -p2 against
bitbake master) are available in the git repository at: 

  git://git.yoctoproject.org/poky-contrib paule/bblayers-fixes
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bblayers-fixes

Paul Eggleton (3):
  bitbake/cooker: minor refactor of parseConfiguration()
  bitbake-layers: avoid full parse for show-layers subcommand
  bitbake-layers: use parsable title for show-appends

 bitbake/bin/bitbake-layers |   13 ++++++++-----
 bitbake/lib/bb/cooker.py   |   16 ++++++----------
 2 files changed, 14 insertions(+), 15 deletions(-)

-- 
1.7.9.5



