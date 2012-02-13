Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1RwuQm-0003dN-M0
	for bitbake-devel@lists.openembedded.org;
	Mon, 13 Feb 2012 12:50:52 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 13 Feb 2012 03:41:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="116995917"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.241])
	by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2012 03:41:37 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 13 Feb 2012 11:41:31 +0000
Message-Id: <b34295284685ccf829dfdaa7f24b574c5cc2dbe2.1329133148.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1329133148.git.paul.eggleton@linux.intel.com>
References: <cover.1329133148.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1329133148.git.paul.eggleton@linux.intel.com>
References: <cover.1329133148.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/3] bitbake: show appropriate warnings for universe target
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
X-List-Received-Date: Mon, 13 Feb 2012 11:50:52 -0000

When building the universe target:
* Show a warning about universe likely producing errors
* Multiprovider errors are now shown as warnings

Also remove an unused "error" variable in runqueue.py.

Fixes [YOCTO #1936]

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/cooker.py   |    4 ++++
 bitbake/lib/bb/runqueue.py |   10 +++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index bb09dff..b5cf9e1 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1083,6 +1083,7 @@ class BBCooker:
         if (task == None):
             task = self.configuration.cmd
 
+        universe = ('universe' in targets)
         targets = self.checkPackages(targets)
 
         def buildTargetsIdle(server, rq, abort):
@@ -1126,6 +1127,8 @@ class BBCooker:
         taskdata.add_unresolved(localdata, self.status)
 
         rq = bb.runqueue.RunQueue(self, self.configuration.data, self.status, taskdata, runlist)
+        if universe:
+            rq.rqdata.warn_multi_bb = True
 
         self.server_registration_cb(buildTargetsIdle, rq)
 
@@ -1179,6 +1182,7 @@ class BBCooker:
                 pkgs_to_build.append(t)
 
         if 'universe' in pkgs_to_build:
+            parselog.warn("The \"universe\" target is only intended for testing and may produce errors.")
             parselog.debug(1, "collating packages for \"universe\"")
             pkgs_to_build.remove('universe')
             for t in self.status.universe_target:
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 7bf4320..c24841f 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -187,6 +187,7 @@ class RunQueueData:
         self.taskData = taskData
         self.targets = targets
         self.rq = rq
+        self.warn_multi_bb = False
 
         self.stampwhitelist = cfgData.getVar("BB_STAMP_WHITELIST", 1) or ""
         self.multi_provider_whitelist = (cfgData.getVar("MULTI_PROVIDER_WHITELIST", 1) or "").split()
@@ -674,11 +675,14 @@ class RunQueueData:
                     prov_list[prov] = [fn]
                 elif fn not in prov_list[prov]:
                     prov_list[prov].append(fn)
-        error = False
         for prov in prov_list:
             if len(prov_list[prov]) > 1 and prov not in self.multi_provider_whitelist:
-                error = True
-                logger.error("Multiple .bb files are due to be built which each provide %s (%s).\n This usually means one provides something the other doesn't and should.", prov, " ".join(prov_list[prov]))
+                msg = "Multiple .bb files are due to be built which each provide %s (%s)." % (prov, " ".join(prov_list[prov]))
+                if self.warn_multi_bb:
+                    logger.warn(msg)
+                else:
+                    msg += "\n This usually means one provides something the other doesn't and should."
+                    logger.error(msg)
 
 
         # Create a whitelist usable by the stamp checks
-- 
1.7.5.4



