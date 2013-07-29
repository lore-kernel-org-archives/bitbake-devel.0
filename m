Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id C8AF06B03A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Jul 2013 13:56:09 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 29 Jul 2013 06:56:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,769,1367996400"; d="scan'208";a="274793800"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.206])
	by AZSMGA002.ch.intel.com with ESMTP; 29 Jul 2013 06:56:08 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 29 Jul 2013 14:56:05 +0100
Message-Id: <cover.1375105805.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
MIME-Version: 1.0
Subject: [PATCH 0/4] CONSOLIDATED PULL: BitBake changes (cover letter only)
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 29 Jul 2013 13:56:10 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The following changes (against poky master, but apply cleanly against
bitbake master with -p2) are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bitbake
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bitbake

Cristiana Voicu (2):
  hob: changed the split of SSTATE_MIRRORS variable
  hob: sstatemirror is standard also for file://.* regex

Petter Mabäcker (1):
  bitbake: runqueue: add warning if invalidating invalid task

Robert Yang (1):
  providers.py: print a debug message for dynamic pacakge

 bitbake/lib/bb/providers.py                          |  1 +
 bitbake/lib/bb/runqueue.py                           |  3 +++
 bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py | 17 +++++------------
 3 files changed, 9 insertions(+), 12 deletions(-)

-- 
1.8.1.2


