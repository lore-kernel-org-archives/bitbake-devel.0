Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1QlLga-0001bS-HB
	for bitbake-devel@lists.openembedded.org;
	Mon, 25 Jul 2011 15:59:08 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 25 Jul 2011 06:54:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,261,1309762800"; d="scan'208";a="34207818"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.255.17.240])
	by fmsmga001.fm.intel.com with ESMTP; 25 Jul 2011 06:54:53 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 25 Jul 2011 14:54:42 +0100
Message-Id: <b2dcb38115d98147dc863ee38f75594bf7f49731.1311601628.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1311601628.git.paul.eggleton@linux.intel.com>
References: <cover.1311601628.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1311601628.git.paul.eggleton@linux.intel.com>
References: <cover.1311601628.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/3] bitbake/taskdata: fix incorrect usage of rdependees instead of dependees
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
X-List-Received-Date: Mon, 25 Jul 2011 13:59:08 -0000

This looked like a copy-paste error - the code around is dealing with
depends and not rdepends.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/taskdata.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/taskdata.py b/bitbake/lib/bb/taskdata.py
index e857f9a..79602b6 100644
--- a/bitbake/lib/bb/taskdata.py
+++ b/bitbake/lib/bb/taskdata.py
@@ -387,7 +387,7 @@ class TaskData:
             return
 
         if not item in dataCache.providers:
-            bb.event.fire(bb.event.NoProvider(item, dependees=self.get_rdependees_str(item), reasons=self.get_reasons(item)), cfgData)
+            bb.event.fire(bb.event.NoProvider(item, dependees=self.get_dependees_str(item), reasons=self.get_reasons(item)), cfgData)
             raise bb.providers.NoProvider(item)
 
         if self.have_build_target(item):
-- 
1.7.4.1



