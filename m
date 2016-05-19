Return-Path: <elliot.smith@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id CC59565CBB
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 May 2016 12:59:43 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga104.fm.intel.com with ESMTP; 19 May 2016 05:59:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,334,1459839600"; d="scan'208";a="106841787"
Received: from gfois-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.8.121])
	by fmsmga004.fm.intel.com with ESMTP; 19 May 2016 05:59:45 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 19 May 2016 13:59:29 +0100
Message-Id: <1463662773-31389-2-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1463662773-31389-1-git-send-email-elliot.smith@intel.com>
References: <1463662773-31389-1-git-send-email-elliot.smith@intel.com>
Subject: [PATCH 2/6] toaster: runbuilds move the execution sequence out of the poll loop
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
X-List-Received-Date: Thu, 19 May 2016 12:59:43 -0000

From: Michael Wood <michael.g.wood@intel.com>

Move the execution sequence for a build out of the polling loop and into
it's own fuction. This means that we can call the function on it's own
if we just want to trigger one build rather than infinite polling.
This is something needed for the build tests.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 .../bldcontrol/management/commands/runbuilds.py    | 31 +++++++++++-----------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/bitbake/lib/toaster/bldcontrol/management/commands/runbuilds.py b/bitbake/lib/toaster/bldcontrol/management/commands/runbuilds.py
index 5532b9d..e3145e8 100644
--- a/bitbake/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/bitbake/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -158,22 +158,23 @@ class Command(NoArgsCommand):
             br.environment.lock = BuildEnvironment.LOCK_FREE
             br.environment.save()
 
+    def runbuild(self):
+        try:
+            self.cleanup()
+        except Exception as e:
+            logger.warn("runbuilds: cleanup exception %s" % str(e))
 
-    def handle_noargs(self, **options):
-        while True:
-            try:
-                self.cleanup()
-            except Exception as e:
-                logger.warning("runbuilds: cleanup exception %s" % str(e))
-
-            try:
-                self.archive()
-            except Exception as e:
-                logger.warning("runbuilds: archive exception %s" % str(e))
+        try:
+            self.archive()
+        except Exception as e:
+            logger.warn("runbuilds: archive exception %s" % str(e))
 
-            try:
-                self.schedule()
-            except Exception as e:
-                logger.warning("runbuilds: schedule exception %s" % str(e))
+        try:
+            self.schedule()
+        except Exception as e:
+            logger.warn("runbuilds: schedule exception %s" % str(e))
 
+    def handle_noargs(self, **options):
+        while True:
+            self.runbuild()
             time.sleep(1)
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


