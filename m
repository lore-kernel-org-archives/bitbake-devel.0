Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
	[209.85.220.48])
	by mail.openembedded.org (Postfix) with ESMTP id B2BB47701C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 04:43:57 +0000 (UTC)
Received: by pacex6 with SMTP id ex6so194491763pac.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Sep 2015 21:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=pDT9tran2v9jLXgrgn0KXU+SAd8vEMDG0ornatUhJus=;
	b=swoQHFCeETABeFXbI1r85sohf5/ZwTYgjH9q+tULCbbJNdNKHmdcq+wDGtLun8PaTp
	DmTcUQ7NB9jkYPW+ZpWpLNPI1ojwx/mp/mfLYIFBNbwjAxFBjOQlykTLCJweeqkdfJud
	BVF7zQilnOoVHcI1qvy3RKveqPXDXG4ie7bV1WHmCSL9+zIJk9WBVEHrnGdcxGKSf+sP
	vtcdsnWfB6aQe6r3W7p+bpQUO1M8LEeBwvZ1p7TiSqbyV0vHnyHd+sbTk5CXaYrJt37/
	Q6CfmuZr3cjneluQCHhSX4ZGAcFTZmvT4YV1+9DhcxqHWW6zki8sTFX5Rtf7plwJtQaB
	HiUA==
X-Received: by 10.66.165.106 with SMTP id yx10mr31153977pab.102.1443501837643; 
	Mon, 28 Sep 2015 21:43:57 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	g5sm22686368pat.21.2015.09.28.21.43.56
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 28 Sep 2015 21:43:57 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Sep 2015 21:45:13 -0700
Message-Id: <23cf64cdb9c80b93d35756ca06d0a122505f970c.1443497922.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
References: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
In-Reply-To: <cover.1443497922.git.avery.brian@gmail.com>
References: <cover.1443497922.git.avery.brian@gmail.com>
Subject: [PATCH 03/22] toaster: create custom layer and recipes for Image customisation
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
X-List-Received-Date: Tue, 29 Sep 2015 04:43:57 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

When building customised recipes toaster creates custom layer directory
and puts layer.conf and custom recipes to it.

[YOCTO #8075]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 51 ++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index a9909b8..62fff1d 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -23,9 +23,11 @@
 import os
 import sys
 import re
+import shutil
 from django.db import transaction
 from django.db.models import Q
 from bldcontrol.models import BuildEnvironment, BRLayer, BRVariable, BRTarget, BRBitbake
+from orm.models import CustomImageRecipe, Layer, Layer_Version, ProjectLayer
 import subprocess
 
 from toastermain import settings
@@ -197,7 +199,7 @@ class LocalhostBEController(BuildEnvironmentController):
         return local_checkout_path
 
 
-    def setLayers(self, bitbakes, layers):
+    def setLayers(self, bitbakes, layers, targets):
         """ a word of attention: by convention, the first layer for any build will be poky! """
 
         assert self.be.sourcedir is not None
@@ -299,6 +301,51 @@ class LocalhostBEController(BuildEnvironmentController):
         if not os.path.exists(bblayerconf):
             raise BuildSetupException("BE is not consistent: bblayers.conf file missing at %s" % bblayerconf)
 
+        # 6. create custom layer and add custom recipes to it
+        layerpath = os.path.join(self.be.sourcedir, "_meta-toaster-custom")
+        if os.path.isdir(layerpath):
+            shutil.rmtree(layerpath) # remove leftovers from previous builds
+        for target in targets:
+            try:
+                customrecipe = CustomImageRecipe.objects.get(name=target.target,
+                                                             project=bitbakes[0].req.project)
+            except CustomImageRecipe.DoesNotExist:
+                continue # not a custom recipe, skip
+
+            # create directory structure
+            for name in ("conf", "recipes"):
+                path = os.path.join(layerpath, name)
+                if not os.path.isdir(path):
+                    os.makedirs(path)
+
+            # create layer.oonf
+            config = os.path.join(layerpath, "conf", "layer.conf")
+            if not os.path.isfile(config):
+                with open(config, "w") as conf:
+                    conf.write('BBPATH .= ":${LAYERDIR}"\nBBFILES += "${LAYERDIR}/recipes/*.bb"\n')
+
+            # create recipe
+            recipe = os.path.join(layerpath, "recipes", "%s.bb" % target.target)
+            with open(recipe, "w") as recipef:
+                recipef.write("require %s\n" % customrecipe.base_recipe.recipe.file_path)
+                packages = [pkg.name for pkg in customrecipe.packages.all()]
+                if packages:
+                    recipef.write('IMAGE_INSTALL = "%s"\n' % ' '.join(packages))
+
+            # create *Layer* objects needed for build machinery to work
+            layer = Layer.objects.get_or_create(name="Toaster Custom layer",
+                                                summary="Layer for custom recipes",
+                                                vcs_url="file://%s" % layerpath)[0]
+            breq = target.req
+            lver = Layer_Version.objects.get_or_create(project=breq.project, layer=layer,
+                                                       dirpath=layerpath, build=breq.build)[0]
+            ProjectLayer.objects.get_or_create(project=breq.project, layercommit=lver,
+                                               optional=False)
+            BRLayer.objects.get_or_create(req=breq, name=layer.name, dirpath=layerpath,
+                                          giturl="file://%s" % layerpath)
+        if os.path.isdir(layerpath):
+            layerlist.append(layerpath)
+
         BuildEnvironmentController._updateBBLayers(bblayerconf, layerlist)
 
         self.islayerset = True
@@ -316,7 +363,7 @@ class LocalhostBEController(BuildEnvironmentController):
 
     def triggerBuild(self, bitbake, layers, variables, targets):
         # set up the buid environment with the needed layers
-        self.setLayers(bitbake, layers)
+        self.setLayers(bitbake, layers, targets)
         self.writeConfFile("conf/toaster-pre.conf", variables)
         self.writeConfFile("conf/toaster.conf", raw = "INHERIT+=\"toaster buildhistory\"")
 
-- 
1.9.1


