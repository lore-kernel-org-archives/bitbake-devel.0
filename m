Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1URkfg-0002TH-Ly
	for bitbake-devel@lists.openembedded.org;
	Mon, 15 Apr 2013 16:46:17 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 15 Apr 2013 07:27:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,476,1363158000"; d="scan'208";a="286323703"
Received: from unknown (HELO helios.amr.corp.intel.com) ([10.255.13.245])
	by azsmga001.ch.intel.com with ESMTP; 15 Apr 2013 07:27:41 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 15 Apr 2013 15:27:34 +0100
Message-Id: <1366036054-12799-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.10.4
Subject: [PATCH] data: fix performance regression
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
X-List-Received-Date: Mon, 15 Apr 2013 14:46:17 -0000

BitBake commit 7c568132c54a21161de28907159f902462f1e2bb resulted in a
fairly serious performance regression during parsing, almost doubling
the time taken to do a full parse and almost certainly impacting
performance during building. The expandKeys function is called
frequently, and if we avoid using keys() and instead just use the normal
variable lookup mechanism, performance is restored.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/data.py |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 110666c..abf210a 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -158,9 +158,9 @@ def expandKeys(alterdata, readdata = None):
 
     for key in todolist:
         ekey = todolist[key]
-        if ekey in keys(alterdata):
+        newval = alterdata.getVar(ekey, 0)
+        if newval:
             val = alterdata.getVar(key, 0)
-            newval = alterdata.getVar(ekey, 0)
             if val is not None and newval is not None:
                 bb.warn("Variable key %s (%s) replaces original key %s (%s)." % (key, val, ekey, newval))
         alterdata.renameVar(key, ekey)
-- 
1.7.10.4



