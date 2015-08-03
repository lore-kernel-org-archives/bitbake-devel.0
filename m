Return-Path: <mariano.lopez@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 316DC76400
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Aug 2015 16:53:18 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 03 Aug 2015 09:53:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,602,1432623600"; d="scan'208";a="760997861"
Received: from yctb01.ostc.intel.com (HELO yctb01.otcr.intel.com)
	([10.23.219.46])
	by fmsmga001.fm.intel.com with ESMTP; 03 Aug 2015 09:53:15 -0700
From: mariano.lopez@linux.intel.com
To: bitbake-devel@lists.openembedded.org
Date: Mon,  3 Aug 2015 08:45:05 +0000
Message-Id: <1438591505-44081-1-git-send-email-mariano.lopez@linux.intel.com>
X-Mailer: git-send-email 1.8.4.5
Cc: paul.eggleton@linux.intel.com
Subject: [PATCH] runqueue.py: Add provides to taskdepdata
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 03 Aug 2015 16:53:21 -0000

From: Mariano Lopez <mariano.lopez@linux.intel.com>

Currently bitbake is the only one that knows the relation
between PN and PROVIDES. In some cases it is needed to have
this relation in the data store (the bootloader it's a good
case).

This adds the PROVIDES to the taskdata, so it would be in
the data store as one field of BB_TASKDEPDATA.

Signed-off-by: Mariano Lopez <mariano.lopez@linux.intel.com>
---
 lib/bb/runqueue.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 17a55d3..0f99e5a 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1630,7 +1630,8 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 pn = self.rqdata.dataCache.pkg_fn[fn]
                 taskname = self.rqdata.runq_task[revdep]
                 deps = self.rqdata.runq_depends[revdep]
-                taskdepdata[revdep] = [pn, taskname, fn, deps]
+                provides = self.rqdata.dataCache.fn_provides[fn]
+                taskdepdata[revdep] = [pn, taskname, fn, deps, provides]
                 for revdep2 in deps:
                     if revdep2 not in taskdepdata:
                         additional.append(revdep2)
-- 
1.8.4.5


