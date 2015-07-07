Return-Path: <leonardo.sandoval.gonzalez@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id EDB9275D16
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Jul 2015 17:50:47 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga103.jf.intel.com with ESMTP; 07 Jul 2015 10:50:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,425,1432623600"; d="scan'208";a="742336491"
Received: from yctb05.ostc.intel.com (HELO yctb05.otcr.jf.intel.com)
	([10.23.219.54])
	by fmsmga001.fm.intel.com with ESMTP; 07 Jul 2015 10:50:48 -0700
From: leonardo.sandoval.gonzalez@linux.intel.com
To: bitbake-devel@lists.openembedded.org
Date: Tue,  7 Jul 2015 09:46:01 +0000
Message-Id: <12ce1ec04d79a7d7db3c4ad24c9b9c85d3312799.1436261758.git.leonardo.sandoval.gonzalez@linux.intel.com>
X-Mailer: git-send-email 1.8.4.5
In-Reply-To: <cover.1436261758.git.leonardo.sandoval.gonzalez@linux.intel.com>
References: <cover.1436261758.git.leonardo.sandoval.gonzalez@linux.intel.com>
In-Reply-To: <cover.1436261758.git.leonardo.sandoval.gonzalez@linux.intel.com>
References: <cover.1436261758.git.leonardo.sandoval.gonzalez@linux.intel.com>
Subject: [PATCH 3/3] knotty.py: Make sure bitbake.lock is unlocked before exiting
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
X-List-Received-Date: Tue, 07 Jul 2015 17:50:48 -0000

From: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>

Before exiting the UI, unlocks the bitbake.lock owned by cooker; this
way consecutive bitbake executions can lock it again without trouble.

[Yocto #7941]

Signed-off-by: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>
---
 bitbake/lib/bb/ui/knotty.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 2bee242..9788a92 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -310,6 +310,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     errors = 0
     warnings = 0
     taskfailures = []
+    locktries = 10
 
     termfilter = tf(main, helper, console, errconsole, format)
     atexit.register(termfilter.finish)
@@ -537,6 +538,25 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 _, error = server.runCommand(["stateForceShutdown"])
             main.shutdown = 2
     try:
+        topdir, error = server.runCommand(["getVariable", "TOPDIR"])
+        if error:
+            logger.warn("Unable to get the value of TOPDIR variable: %s" % error)
+        else:
+            lockfile = "%s/bitbake.lock" % topdir
+            _, error = server.runCommand(["unlockBitbake"])
+            if error:
+                logger.warn("Unable to unlock the file %s" % lockfile)
+            else:
+                while locktries:
+                    lf = bb.utils.lockfile(lockfile, False, False)
+                    if not lf:
+                        time.sleep(1)
+                        locktries -=1
+                    else:
+                        bb.utils.unlockfile(lf)
+                        break
+                if not locktries:
+                    logger.warn("Knotty could not lock the file ${TOPDIR}/bitbake.lock, probably locked by cooker and not unlocked yet. Immediate bitbake commands may failed")
         summary = ""
         if taskfailures:
             summary += pluralise("\nSummary: %s task failed:",
-- 
1.8.4.5


