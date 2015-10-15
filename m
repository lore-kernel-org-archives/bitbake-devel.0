Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id DF5657702A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Oct 2015 08:37:58 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga101.jf.intel.com with ESMTP; 15 Oct 2015 01:37:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,684,1437462000"; d="scan'208";a="811524878"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga001.fm.intel.com with ESMTP; 15 Oct 2015 01:37:47 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 41CEF6A4083;
	Thu, 15 Oct 2015 01:36:46 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Oct 2015 11:37:40 +0300
Message-Id: <1444898260-19877-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <CABcZANmHoWBvfF0JKMt4SCVef5-qgGvF+OJ+or6-Pu5pgpz46w@mail.gmail.com>
References: <CABcZANmHoWBvfF0JKMt4SCVef5-qgGvF+OJ+or6-Pu5pgpz46w@mail.gmail.com>
Subject: [PATCH v2] bitbake: normalize build targets
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
X-List-Received-Date: Thu, 15 Oct 2015 08:38:00 -0000

BuildStarted event not fully represents build tasks for
the targets. If -c option is used to specify default task
it's not included into the event.

Made build targets to always look as <target>:do_<task>.
Consider default task (do_build or specified by -c command
line option) when normalizing.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/cooker.py | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index a0d7d59..a416d2e 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1391,10 +1391,28 @@ class BBCooker:
         build.reset_cache()
         self.buildSetVars()
 
+        # If we are told to do the None task then query the default task
+        if (task == None):
+            task = self.configuration.cmd
+
+        if not task.startswith("do_"):
+            task = "do_%s" % task
+
         taskdata, runlist, fulltargetlist = self.buildTaskData(targets, task, self.configuration.abort)
 
         buildname = self.data.getVar("BUILDNAME", False)
-        bb.event.fire(bb.event.BuildStarted(buildname, fulltargetlist), self.data)
+
+        # make targets to always look as <target>:do_<task>
+        ntargets = []
+        for target in fulltargetlist:
+            if ":" in target:
+                if ":do_" not in target:
+                    target = "%s:do_%s" % tuple(target.split(":", 1))
+            else:
+                target = "%s:%s" % (target, task)
+            ntargets.append(target)
+
+        bb.event.fire(bb.event.BuildStarted(buildname, ntargets), self.data)
 
         rq = bb.runqueue.RunQueue(self, self.data, self.recipecache, taskdata, runlist)
         if 'universe' in targets:
-- 
2.1.4


