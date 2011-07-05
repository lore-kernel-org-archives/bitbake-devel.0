Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1Qe5gT-0005Yl-DC
	for bitbake-devel@lists.openembedded.org;
	Tue, 05 Jul 2011 15:29:02 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 05 Jul 2011 06:25:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,479,1304319600"; d="scan'208";a="22815068"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.255.17.114])
	by azsmga001.ch.intel.com with ESMTP; 05 Jul 2011 06:25:09 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  5 Jul 2011 14:25:05 +0100
Message-Id: <4a23fa4fd29855e33da40518f028bb2143000833.1309872199.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1309872199.git.paul.eggleton@linux.intel.com>
References: <cover.1309872199.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1309872199.git.paul.eggleton@linux.intel.com>
References: <cover.1309872199.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/2] bitbake-layers: fix sorting by package name for cooker change
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
X-List-Received-Date: Tue, 05 Jul 2011 13:29:02 -0000

Structure of cooker was changed since the patch for bitbake commit
edacf98cceb2fe1275042595d3fce6822fa411ca was created - cooker.pkg_pn now
has string keys, so sort it accordingly.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/bin/bitbake-layers |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index 5abf26c..bdfa4b6 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -150,7 +150,7 @@ class Commands(cmd.Cmd):
         logger.info('State of append files:')
 
         pnlist = list(self.cooker_data.pkg_pn.keys())
-        pnlist.sort( key=lambda item: item.pn )
+        pnlist.sort()
         for pn in pnlist:
             self.show_appends_for_pn(pn)
 
-- 
1.7.4.1



