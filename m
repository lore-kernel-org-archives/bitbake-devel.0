Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1Stdfi-0002hb-SD
	for bitbake-devel@lists.openembedded.org;
	Tue, 24 Jul 2012 13:53:03 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 24 Jul 2012 04:41:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="176729947"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.60])
	by orsmga002.jf.intel.com with ESMTP; 24 Jul 2012 04:41:33 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Jul 2012 12:41:24 +0100
Message-Id: <1343130085-19070-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] bitbake-layers: fix help for show-overlayed to match behaviour
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
X-List-Received-Date: Tue, 24 Jul 2012 11:53:03 -0000

show-overlayed actually lists the same recipe in multiple layers
regardless of priority, so change the help description to match.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-layers |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 6d35386..1dacc25 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -138,7 +138,7 @@ class Commands(cmd.Cmd):
 
 
     def do_show_overlayed(self, args):
-        """list overlayed recipes (where the same recipe exists in another layer that has a higher layer priority)
+        """list overlayed recipes (where the same recipe exists in another layer)
 
 usage: show-overlayed [-f] [-s]
 
-- 
1.7.9.5



