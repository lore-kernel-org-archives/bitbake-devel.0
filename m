Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
	[209.85.220.52])
	by mail.openembedded.org (Postfix) with ESMTP id 3B4D96FFDD
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Dec 2015 03:53:10 +0000 (UTC)
Received: by pacdm15 with SMTP id dm15so40517154pac.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Dec 2015 19:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=6OvUNTJZDn0ljkCmTCwm+SbDPsrhz9MaNgzxldc6HS4=;
	b=xE7gk12eJZgMEemmPvugGxw72YC6bLbjUS38O4VmdG7EGc1oh19cpfmNLWoec+57dz
	Rl5bef8coSXx1ATYLv0C8yAZFkb2D54Z82LF6fe+Xwi5UA61wqHfNuH4b9BHgNBsHaiq
	nuyCbzhr8YLoJrCiqYk9Re86eSIgGhD/ORb8mtVWjv4Mr2WznD68ifczWNATuzqk6Hq5
	n4Qib0ZMQbmh2mlxlEtcDEd/Bxtlu/GuMqqRN7OPKukMK7jH5hzZi9pkAx/EiyDY6VeN
	n2xUQFWa7unNYc0zerBkPFjoltCSM/rrI+UEmRwjz1cPQPdLra2o0BGSZd+aert+t1xy
	Dbng==
X-Received: by 10.66.102.97 with SMTP id fn1mr13414765pab.131.1449719591039;
	Wed, 09 Dec 2015 19:53:11 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	c20sm14761349pfd.17.2015.12.09.19.53.10
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 09 Dec 2015 19:53:10 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Dec 2015 19:56:38 -0800
Message-Id: <2104a63195b197908e81eab5912ae88a88741d52.1449719707.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f49f7e1b41ee18a9959be3f3e12856980d58a18b.1449719707.git.avery.brian@gmail.com>
References: <f49f7e1b41ee18a9959be3f3e12856980d58a18b.1449719707.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449719707.git.avery.brian@gmail.com>
References: <cover.1449719707.git.avery.brian@gmail.com>
Subject: [PATCH 13/18] toaster: use OneToOneField instead of ForeignKey
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
X-List-Received-Date: Thu, 10 Dec 2015 03:53:10 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Used OneToOneField to reference BuildRequest in BRBitbake model.

Fixed django warning:
WARNINGS: Setting unique=True on a ForeignKey has the same effect
          as using a OneToOneField.

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/bldcontrol/bbcontroller.py                  |  4 ++--
 lib/toaster/bldcontrol/localhostbecontroller.py         | 13 ++++++-------
 lib/toaster/bldcontrol/management/commands/runbuilds.py |  2 +-
 lib/toaster/bldcontrol/models.py                        |  2 +-
 lib/toaster/bldcontrol/tests.py                         |  6 +++---
 5 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/lib/toaster/bldcontrol/bbcontroller.py b/lib/toaster/bldcontrol/bbcontroller.py
index 781ff73..1387bda 100644
--- a/lib/toaster/bldcontrol/bbcontroller.py
+++ b/lib/toaster/bldcontrol/bbcontroller.py
@@ -141,10 +141,10 @@ class BuildEnvironmentController(object):
         raise Exception("FIXME: Must override in order to actually start the BB server")
 
 
-    def setLayers(self, bbs, ls):
+    def setLayers(self, bitbake, ls):
         """ Checks-out bitbake executor and layers from git repositories.
             Sets the layer variables in the config file, after validating local layer paths.
-            The bitbakes must be a 1-length list of BRBitbake
+            bitbake must be a single BRBitbake instance
             The layer paths must be in a list of BRLayer object
 
             a word of attention: by convention, the first layer for any build will be poky!
diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 00228e9..4f6f15c 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -115,18 +115,17 @@ class LocalhostBEController(BuildEnvironmentController):
         return local_checkout_path
 
 
-    def setLayers(self, bitbakes, layers, targets):
+    def setLayers(self, bitbake, layers, targets):
         """ a word of attention: by convention, the first layer for any build will be poky! """
 
         assert self.be.sourcedir is not None
-        assert len(bitbakes) == 1
         # set layers in the layersource
 
         # 1. get a list of repos with branches, and map dirpaths for each layer
         gitrepos = {}
 
-        gitrepos[(bitbakes[0].giturl, bitbakes[0].commit)] = []
-        gitrepos[(bitbakes[0].giturl, bitbakes[0].commit)].append( ("bitbake", bitbakes[0].dirpath) )
+        gitrepos[(bitbake.giturl, bitbake.commit)] = []
+        gitrepos[(bitbake.giturl, bitbake.commit)].append( ("bitbake", bitbake.dirpath) )
 
         for layer in layers:
             # we don't process local URLs
@@ -198,7 +197,7 @@ class LocalhostBEController(BuildEnvironmentController):
                 # make sure we have a working bitbake
                 if not os.path.exists(os.path.join(self.pokydirname, 'bitbake')):
                     logger.debug("localhostbecontroller: checking bitbake into the poky dirname %s " % self.pokydirname)
-                    self._shellcmd("git clone -b \"%s\" \"%s\" \"%s\" " % (bitbakes[0].commit, bitbakes[0].giturl, os.path.join(self.pokydirname, 'bitbake')))
+                    self._shellcmd("git clone -b \"%s\" \"%s\" \"%s\" " % (bitbake.commit, bitbake.giturl, os.path.join(self.pokydirname, 'bitbake')))
 
             # verify our repositories
             for name, dirpath in gitrepos[(giturl, commit)]:
@@ -224,7 +223,7 @@ class LocalhostBEController(BuildEnvironmentController):
         for target in targets:
             try:
                 customrecipe = CustomImageRecipe.objects.get(name=target.target,
-                                                             project=bitbakes[0].req.project)
+                                                             project=bitbake.req.project)
             except CustomImageRecipe.DoesNotExist:
                 continue # not a custom recipe, skip
 
@@ -278,7 +277,7 @@ class LocalhostBEController(BuildEnvironmentController):
 
 
     def triggerBuild(self, bitbake, layers, variables, targets):
-        # set up the buid environment with the needed layers
+        # set up the build environment with the needed layers
         self.setLayers(bitbake, layers, targets)
 
         # get the bb server running with the build req id and build env id
diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index d40dedb..edf71a7 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -57,7 +57,7 @@ class Command(NoArgsCommand):
             br.save()
 
             # this triggers an async build
-            bec.triggerBuild(br.brbitbake_set.all(), br.brlayer_set.all(), br.brvariable_set.all(), br.brtarget_set.all())
+            bec.triggerBuild(br.brbitbake, br.brlayer_set.all(), br.brvariable_set.all(), br.brtarget_set.all())
 
         except Exception as e:
             logger.error("runbuilds: Error launching build %s" % e)
diff --git a/lib/toaster/bldcontrol/models.py b/lib/toaster/bldcontrol/models.py
index ab41105..a3a49ce 100644
--- a/lib/toaster/bldcontrol/models.py
+++ b/lib/toaster/bldcontrol/models.py
@@ -106,7 +106,7 @@ class BRLayer(models.Model):
     layer_version = models.ForeignKey(Layer_Version, null=True)
 
 class BRBitbake(models.Model):
-    req         = models.ForeignKey(BuildRequest, unique = True)    # only one bitbake for a request
+    req         = models.OneToOneField(BuildRequest)    # only one bitbake for a request
     giturl      = models.CharField(max_length =254)
     commit      = models.CharField(max_length = 254)
     dirpath     = models.CharField(max_length = 254)
diff --git a/lib/toaster/bldcontrol/tests.py b/lib/toaster/bldcontrol/tests.py
index f54cf7f..141b42a 100644
--- a/lib/toaster/bldcontrol/tests.py
+++ b/lib/toaster/bldcontrol/tests.py
@@ -18,7 +18,7 @@ import subprocess
 import os
 
 # standard poky data hardcoded for testing
-BITBAKE_LAYERS = [type('bitbake_info', (object,), { "giturl": "git://git.yoctoproject.org/poky.git", "dirpath": "", "commit": "HEAD"})]
+BITBAKE_LAYER = type('bitbake_info', (object,), { "giturl": "git://git.yoctoproject.org/poky.git", "dirpath": "", "commit": "HEAD"})
 POKY_LAYERS = [
     type('poky_info', (object,), { "name": "meta", "giturl": "git://git.yoctoproject.org/poky.git", "dirpath": "meta", "commit": "HEAD"}),
     type('poky_info', (object,), { "name": "meta-yocto", "giturl": "git://git.yoctoproject.org/poky.git", "dirpath": "meta-yocto", "commit": "HEAD"}),
@@ -53,7 +53,7 @@ class BEControllerTests(object):
         bc = self._getBEController(obe)
         try:
             # setting layers, skip any layer info
-            bc.setLayers(BITBAKE_LAYERS, POKY_LAYERS)
+            bc.setLayers(BITBAKE_LAYER, POKY_LAYERS)
         except NotImplementedException,  e:
             print "Test skipped due to command not implemented yet"
             return True
@@ -80,7 +80,7 @@ class BEControllerTests(object):
         layerSet = False
         try:
             # setting layers, skip any layer info
-            layerSet = bc.setLayers(BITBAKE_LAYERS, POKY_LAYERS)
+            layerSet = bc.setLayers(BITBAKE_LAYER, POKY_LAYERS)
         except NotImplementedException:
             print "Test skipped due to command not implemented yet"
             return True
-- 
1.9.1


