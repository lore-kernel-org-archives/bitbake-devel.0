Return-Path: <elliot.smith@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 6C57577109
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Nov 2015 15:29:08 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 13 Nov 2015 07:28:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,287,1444719600"; d="scan'208";a="819215836"
Received: from lquinn-mobl2.amr.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.6.239])
	by orsmga001.jf.intel.com with ESMTP; 13 Nov 2015 07:28:40 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Nov 2015 15:28:07 +0000
Message-Id: <1447428487-11554-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: localhostbectrl Pass DATABASE_URL in via the process environment
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
X-List-Received-Date: Fri, 13 Nov 2015 15:29:12 -0000

Instead of putting the DATABASE_URL as part of the command for launching
the bitbake observer process set it as part of environment.

This fixes two issues 1. Where the value isn't quoted and therefore will be
interpreted in the shell and 2. Anyone being able to see the value of
DATABASE_URL in the process tree.

[YOCTO #8669]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/bldcontrol/localhostbecontroller.py | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py b/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
index b5cf559..854a6bb 100644
--- a/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -48,7 +48,6 @@ class LocalhostBEController(BuildEnvironmentController):
 
     def __init__(self, be):
         super(LocalhostBEController, self).__init__(be)
-        self.dburl = settings.getDATABASE_URL()
         self.pokydirname = None
         self.islayerset = False
 
@@ -126,9 +125,17 @@ class LocalhostBEController(BuildEnvironmentController):
                     port = i.split(" ")[-1]
                     logger.debug("localhostbecontroller: Found bitbake server port %s" % port)
 
-        cmd = "bash -c \"source %s/oe-init-build-env-memres -1 %s && DATABASE_URL=%s %s --observe-only -u toasterui --remote-server=0.0.0.0:-1 -t xmlrpc\"" % (self.pokydirname, self.be.builddir, self.dburl, own_bitbake)
+        cmd = "bash -c \"source %s/oe-init-build-env-memres -1 %s && %s --observe-only -u toasterui --remote-server=0.0.0.0:-1 -t xmlrpc\"" % \
+                (self.pokydirname, self.be.builddir, own_bitbake)
+
+        # Use a copy of the current environment and add the DATABASE_URL
+        # for the bitbake observer process.
+        env = os.environ.copy()
+        env['DATABASE_URL'] = settings.getDATABASE_URL()
+
         with open(toaster_ui_log_filepath, "a+") as f:
-            p = subprocess.Popen(cmd, cwd = self.be.builddir, shell=True, stdout=f, stderr=f)
+            p = subprocess.Popen(cmd, cwd = self.be.builddir, shell=True,
+                                 stdout=f, stderr=f, env=env)
 
         def _toaster_ui_started(filepath, filepos = 0):
             if not os.path.exists(filepath):
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


