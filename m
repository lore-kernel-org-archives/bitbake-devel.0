Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 0E2A479367
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 26 Aug 2018 22:36:52 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w7QMarFt012889
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 26 Aug 2018 15:36:54 -0700
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.217) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Sun, 26 Aug 2018 15:36:53 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 26 Aug 2018 15:33:24 -0700
Message-ID: <765aac6ca728e657b0f745c52fe014bce427ded9.1535322629.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1535322629.git.David.Reyna@windriver.com>
References: <cover.1535322629.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.217]
Subject: [PATCH 1/9] toaster: allow pokydirname to be evaluated when all layers are local
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
X-List-Received-Date: Sun, 26 Aug 2018 22:36:53 -0000
Content-Type: text/plain

From: Awais Belal <awais_belal@mentor.com>

Toaster depends on pokydirname for identifying the location of
the oe-init-build-env script (and there might be other purposes
in the future). The problem with current approach is that it
only checks/sets the variable with git based repos, whereas
toaster provides mechanisms to allow having layers that are all
locally available. The evaluation of the variable fails in such
scenarios, so use a more flexible mechanism in this case and
try to locate poky in the local layers as well, if not already
set.

[YOCTO #12891]

Signed-off-by: Awais Belal <awais.belal@mentor.com>
Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 6bdd743..5df2290 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -222,9 +222,21 @@ class LocalhostBEController(BuildEnvironmentController):
         self.setCloneStatus(bitbake,'complete',clone_total,clone_count,'')
         logger.debug("localhostbecontroller: current layer list %s " % pformat(layerlist))
 
-        if self.pokydirname is None and os.path.exists(os.path.join(self.be.sourcedir, "oe-init-build-env")):
-            logger.debug("localhostbecontroller: selected poky dir name %s" % self.be.sourcedir)
-            self.pokydirname = self.be.sourcedir
+        # Resolve self.pokydirname if not resolved yet, consider the scenario
+        # where all layers are local, that's the else clause
+        if self.pokydirname is None:
+            if os.path.exists(os.path.join(self.be.sourcedir, "oe-init-build-env")):
+                logger.debug("localhostbecontroller: selected poky dir name %s" % self.be.sourcedir)
+                self.pokydirname = self.be.sourcedir
+            else:
+                # Alternatively, scan local layers for relative "oe-init-build-env" location
+                for layer in layers:
+                    if os.path.exists(os.path.join(layer.layer_version.layer.local_source_dir,"..","oe-init-build-env")):
+                        logger.debug("localhostbecontroller, setting pokydirname to %s" % (layer.layer_version.layer.local_source_dir))
+                        self.pokydirname = os.path.join(layer.layer_version.layer.local_source_dir,"..")
+                        break
+                else:
+                    logger.error("pokydirname is not set, you will run into trouble!")
 
         # 5. create custom layer and add custom recipes to it
         for target in targets:
-- 
1.9.1


