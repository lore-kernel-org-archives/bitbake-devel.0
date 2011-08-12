Received: from vms173011pub.verizon.net ([206.46.173.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <denis@denix.org>) id 1Qryri-00055D-8N
	for bitbake-devel@lists.openembedded.org;
	Fri, 12 Aug 2011 23:02:02 +0200
Received: from gandalf.denix.org ([unknown] [108.18.140.4])
	by vms173011.mailsrvcs.net
	(Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16
	2009)) with ESMTPA id <0LPT005M7ZFKE9H2@vms173011.mailsrvcs.net> for
	bitbake-devel@lists.openembedded.org;
	Fri, 12 Aug 2011 14:57:21 -0500 (CDT)
Received: from elrond.denix.org (elrond [192.168.0.7])
	by gandalf.denix.org (Postfix) with ESMTP id 772D914AF5A; Fri,
	12 Aug 2011 15:57:20 -0400 (EDT)
From: Denys Dmytriyenko <denis@denix.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Aug 2011 15:57:14 -0400
Message-id: <1313179034-23154-1-git-send-email-denis@denix.org>
X-Mailer: git-send-email 1.7.6
Cc: Denys Dmytriyenko <denys@ti.com>
Subject: [PATCH] lib/bb/providers: make "checking PREFERRED_PROVIDER_%s" a debug message
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
X-List-Received-Date: Fri, 12 Aug 2011 21:02:02 -0000

From: Denys Dmytriyenko <denys@ti.com>

In verbose mode there are hundreds of these "checking PREFERRED_PROVIDER_%s"
messages, cluttering the output and obscuring the more important resulting
"selecting %s to satisfy runtime %s due to %s" messages. Individual "checking"
lines are more suited for debug mode, similar to "sorted providers for %s
are: %s", hence convert logger.verbose() to logger.debug().

Signed-off-by: Denys Dmytriyenko <denys@ti.com>
---
 lib/bb/providers.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/providers.py b/lib/bb/providers.py
index 22104f1..b2f9896 100644
--- a/lib/bb/providers.py
+++ b/lib/bb/providers.py
@@ -287,7 +287,7 @@ def filterProvidersRunTime(providers, item, cfgData, dataCache):
         provides = dataCache.pn_provides[pn]
         for provide in provides:
             prefervar = bb.data.getVar('PREFERRED_PROVIDER_%s' % provide, cfgData, 1)
-            logger.verbose("checking PREFERRED_PROVIDER_%s (value %s) against %s", provide, prefervar, pns.keys())
+            logger.debug(1, "checking PREFERRED_PROVIDER_%s (value %s) against %s", provide, prefervar, pns.keys())
             if prefervar in pns and pns[prefervar] not in preferred:
                 var = "PREFERRED_PROVIDER_%s = %s" % (provide, prefervar)
                 logger.verbose("selecting %s to satisfy runtime %s due to %s", prefervar, item, var)
-- 
1.7.0.4



