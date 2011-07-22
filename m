Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1QkJcr-0000xQ-CP
	for bitbake-devel@lists.openembedded.org;
	Fri, 22 Jul 2011 19:35:01 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 22 Jul 2011 10:30:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,248,1309762800"; d="scan'208";a="30862689"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.255.17.206])
	by orsmga001.jf.intel.com with ESMTP; 22 Jul 2011 10:30:41 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 22 Jul 2011 18:30:29 +0100
Message-Id: <cover.1311355686.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 0/6] Misc minor fixes
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
X-List-Received-Date: Fri, 22 Jul 2011 17:35:01 -0000

Some minor usability-related fixes for bitbake and bitbake-layers.

The changes (against poky, apply against bitbake master with -p2) are
available in the git repository at:
  git://git.pokylinux.org/poky-contrib paule/bitbake-tweaks
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=paule/bitbake-tweaks

Paul Eggleton (6):
  bitbake: add note to -b option indicating no dependency handling
  bitbake/cooker: show a warning when -b is specified
  bitbake: adjust comments/messages for default server change
  bitbake-layers: check for errors before parsing
  bitbake-layers: add command help
  bitbake-layers: remove unneeded do_EOF

 bitbake/bin/bitbake        |    8 +++---
 bitbake/bin/bitbake-layers |   45 +++++++++++++++++++++++++++++++++++++++----
 bitbake/lib/bb/cooker.py   |    4 +++
 3 files changed, 48 insertions(+), 9 deletions(-)

-- 
1.7.4.1



