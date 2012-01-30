Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1RruB4-0000QG-6L
	for bitbake-devel@lists.openembedded.org;
	Mon, 30 Jan 2012 17:33:58 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 30 Jan 2012 08:26:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="104198212"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.192])
	by orsmga002.jf.intel.com with ESMTP; 30 Jan 2012 08:25:57 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 30 Jan 2012 16:25:48 +0000
Message-Id: <cover.1327940413.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH 0/6] bitbake-layers improvements
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
X-List-Received-Date: Mon, 30 Jan 2012 16:33:58 -0000

Make some significant improvements to bitbake-layers that should provide
more information about what files each layer is overlaying as well as
making the utility easier to use.

The following changes (against Poky, but apply cleanly with -p2 against
bitbake master) are available in the git repository at:
  git://git.yoctoproject.org/poky-contrib paule/bitbake-layers-fix5
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bitbake-layers-fix5

Paul Eggleton (6):
  bitbake-layers: add copyright notice
  bitbake-layers: use dashes in subcommands
  bitbake-layers: use directory name as layer name
  bitbake-layers: improve show-overlayed output
  bitbake-layers: add show-recipes subcommand
  bitbake-layers: list overlayed classes in show-overlayed

 bitbake/bin/bitbake-layers  |  262 +++++++++++++++++++++++++++++++++++++------
 bitbake/lib/bb/cooker.py    |   14 +--
 bitbake/lib/bb/providers.py |   36 ++++++
 3 files changed, 265 insertions(+), 47 deletions(-)

-- 
1.7.5.4



