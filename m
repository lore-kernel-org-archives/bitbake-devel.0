Return-Path: <elliot.smith@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 1FF50734B8
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Oct 2015 10:29:17 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga102.fm.intel.com with ESMTP; 09 Oct 2015 03:29:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,657,1437462000"; d="scan'208";a="577231391"
Received: from sarallen-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.18.21])
	by FMSMGA003.fm.intel.com with ESMTP; 09 Oct 2015 03:29:16 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  9 Oct 2015 11:28:58 +0100
Message-Id: <1444386538-25428-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: Don't descend into directories for cached_layers
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
X-List-Received-Date: Fri, 09 Oct 2015 10:29:18 -0000

From: Michael Wood <michael.g.wood@intel.com>

As toaster makes use of clones of itself we have a mechanism to just
clone the current checkout and use that as a basis for the git clone for
the layers inside. For instance, in poky, if we're running in that directory,
we don't ever want to change the current checkout so we make a copy of
ourselves to do this work in.

This steps through cached_layers and previously-traversed directories
inside the current checkout to find any pre-existing checkouts.

This was ending up traversing too many directories down, so remove
the traverse and only deal with the current directory.

[YOCTO #8463]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 .../toaster/bldcontrol/localhostbecontroller.py    | 29 ++++++++++++----------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py b/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
index 3ee68ae..b5cf559 100644
--- a/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -218,23 +218,26 @@ class LocalhostBEController(BuildEnvironmentController):
         logger.debug("localhostbecontroller, our git repos are %s" % pformat(gitrepos))
 
 
-        # 2. find checked-out git repos in the sourcedir directory that may help faster cloning
+        # 2. Note for future use if the current source directory is a
+        # checked-out git repos that could match a layer's vcs_url and therefore
+        # be used to speed up cloning (rather than fetching it again).
 
         cached_layers = {}
-        for ldir in os.listdir(self.be.sourcedir):
-            fldir = os.path.join(self.be.sourcedir, ldir)
-            if os.path.isdir(fldir):
+
+        try:
+            for remotes in self._shellcmd("git remote -v", self.be.sourcedir).split("\n"):
                 try:
-                    for line in self._shellcmd("git remote -v", fldir).split("\n"):
-                        try:
-                            remote = line.split("\t")[1].split(" ")[0]
-                            if remote not in cached_layers:
-                                cached_layers[remote] = fldir
-                        except IndexError:
-                            pass
-                except ShellCmdException:
-                    # ignore any errors in collecting git remotes
+                    remote = remotes.split("\t")[1].split(" ")[0]
+                    if remote not in cached_layers:
+                        cached_layers[remote] = self.be.sourcedir
+                except IndexError:
                     pass
+        except ShellCmdException:
+            # ignore any errors in collecting git remotes this is an optional
+            # step
+            pass
+
+        logger.info("Using pre-checked out source for layer %s", cached_layers)
 
         layerlist = []
 
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


