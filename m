Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
	by mail.openembedded.org (Postfix) with ESMTP id 65CAB6093A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 11:20:33 +0000 (UTC)
Received: by mail-wm0-f50.google.com with SMTP id t79so57023795wmt.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 03:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=ug57DsNWViRBmWATuJkPr4UIQwDngxZ1gv8vdqTj+Zg=;
	b=vAofh1f4xbr6gxsYgm3fK5NFjlKfx84HwJxUfy0n7Oln3RT374K2mL/FXPswtF0bTv
	M5B7mHXj2jgRS1p6A80HF8j423rw54KFG1afh1wxbXsiL6JhbPzVz7Xmul165mE8HkKA
	vPqnejRqZiV68d0Hfk0a30suP17ag1n5OI3DJOacE8nscIqQvlFWPvxKkmvBp6MqXLph
	OsfWVyCbtmPR1QoVIOvfLOhjGE9yLkBFN9FOFjt4AxUzNVkPxuxkl4A+Fe45xGRXYPJc
	dHWjjX2ReBGBIRESHbo3D8/drdf7FNxcbzmdi+CfLdLETnFCq4oghFIbowD+CF+bDNSJ
	Bejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=ug57DsNWViRBmWATuJkPr4UIQwDngxZ1gv8vdqTj+Zg=;
	b=g6Unob/r8jqZvHEN8RRijPhJplWN2+uUCvPWv9G32iRYpzd1OgYiCjzijiHNTNf37r
	IPoDpYh0ATS2GRKYNNgXFkBkPW/9TmHV2E1qQNPify7yNlogsdPZYNVokK3bNQlPkt4l
	65ztFGYFixRr3WSsMI3cqTweawnSdpL5Tm1JnA8OyoA+cLphrYl77ZZIWP4OqSKIGOpd
	6vJlBSVLl/TxdnXsorQLEZ3YuYOFi76uS9lFEA1HqsIsay2LXrtpHV7deZboZ+qahfst
	UfPQY2dZbc9aBC4P7SevTugfi2ZT/AN6KQIYhAU7pmCHyVCOkTHDaEEYj29telTjGW8Q
	nhBA==
X-Gm-Message-State: AKaTC03Oo6pnkIDZoThS5VP+fBVuROfn1mpWXOXe1q98eyuvRznQnQFVii8Xa6d7T9ad96x3
X-Received: by 10.28.17.213 with SMTP id 204mr1844442wmr.17.1479986433251;
	Thu, 24 Nov 2016 03:20:33 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
	by smtp.gmail.com with ESMTPSA id
	g184sm7696900wme.23.2016.11.24.03.20.32
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 24 Nov 2016 03:20:32 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 Nov 2016 11:20:03 +0000
Message-Id: <1479986406-4657-13-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1479986406-4657-1-git-send-email-michael.g.wood@intel.com>
References: <1479986406-4657-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 12/15] toaster: bldcontrol Move CustomImageRecipe file creation into own function
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
X-List-Received-Date: Thu, 24 Nov 2016 11:20:33 -0000

Move the custom image file creation (i.e. create the layer file
structure, conf and recipe file) into it's own function and remove the
creation of the BRLayer as this is done at schedule_build just like all
the other layers.

Fix a bug where the toaster-custom-images layer was always being appened
to the layer list if the directory exists.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 144 ++++++++++++------------
 1 file changed, 75 insertions(+), 69 deletions(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 18870d9..62e62fe 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -201,82 +201,88 @@ class LocalhostBEController(BuildEnvironmentController):
         logger.debug("localhostbecontroller: current layer list %s " % pformat(layerlist))
 
         # 5. create custom layer and add custom recipes to it
-        layerpath = os.path.join(self.be.builddir,
-                                 CustomImageRecipe.LAYER_NAME)
         for target in targets:
             try:
-                customrecipe = CustomImageRecipe.objects.get(name=target.target,
-                                                             project=bitbake.req.project)
+                customrecipe = CustomImageRecipe.objects.get(
+                    name=target.target,
+                    project=bitbake.req.project)
+
+                custom_layer_path = self.setup_custom_image_recipe(
+                    customrecipe, layers)
+
+                if os.path.isdir(custom_layer_path):
+                    layerlist.append(custom_layer_path)
+
             except CustomImageRecipe.DoesNotExist:
-                continue # not a custom recipe, skip
-
-            # create directory structure
-            for name in ("conf", "recipes"):
-                path = os.path.join(layerpath, name)
-                if not os.path.isdir(path):
-                    os.makedirs(path)
-
-            # create layer.oonf
-            config = os.path.join(layerpath, "conf", "layer.conf")
-            if not os.path.isfile(config):
-                with open(config, "w") as conf:
-                    conf.write('BBPATH .= ":${LAYERDIR}"\nBBFILES += "${LAYERDIR}/recipes/*.bb"\n')
-
-            # Update the Layer_Version dirpath that has our base_recipe in
-            # to be able to read the base recipe to then  generate the
-            # custom recipe.
-            br_layer_base_recipe = layers.get(
-                layer_version=customrecipe.base_recipe.layer_version)
-
-            # If the layer is one that we've cloned we know where it lives
-            if br_layer_base_recipe.giturl and br_layer_base_recipe.commit:
-                layer_path = self.getGitCloneDirectory(
-                    br_layer_base_recipe.giturl,
-                    br_layer_base_recipe.commit)
-            # Otherwise it's a local layer
-            elif br_layer_base_recipe.local_source_dir:
-                layer_path = br_layer_base_recipe.local_source_dir
-            else:
-                logger.error("Unable to workout the dir path for the custom"
-                             " image recipe")
-
-            br_layer_base_dirpath = os.path.join(
-                self.be.sourcedir,
-                layer_path,
-                customrecipe.base_recipe.layer_version.dirpath)
-
-            customrecipe.base_recipe.layer_version.dirpath = \
-                         br_layer_base_dirpath
-
-            customrecipe.base_recipe.layer_version.save()
-
-            # create recipe
-            recipe_path = \
-                    os.path.join(layerpath, "recipes", "%s.bb" % target.target)
-            with open(recipe_path, "w") as recipef:
-                recipef.write(customrecipe.generate_recipe_file_contents())
-
-            # Update the layer and recipe objects
-            customrecipe.layer_version.dirpath = layerpath
-            customrecipe.layer_version.layer.local_source_dir = layerpath
-            customrecipe.layer_version.layer.save()
-            customrecipe.layer_version.save()
-
-            customrecipe.file_path = recipe_path
-            customrecipe.save()
-
-            # create *Layer* objects needed for build machinery to work
-            BRLayer.objects.get_or_create(req=target.req,
-                                          name=layer.name,
-                                          dirpath=layerpath,
-                                          giturl="file://%s" % layerpath)
-        if os.path.isdir(layerpath):
-            layerlist.append(layerpath)
+                continue  # not a custom recipe, skip
 
-        self.islayerset = True
         layerlist.extend(nongitlayerlist)
+        logger.debug("\n\nset layers gives this list \n %s" % ''.join(layerlist))
+        self.islayerset = True
         return layerlist
 
+    def setup_custom_image_recipe(self, customrecipe, layers):
+        """ Set up toaster-custom-images layer and recipe files """
+        layerpath = os.path.join(self.be.builddir,
+                                 CustomImageRecipe.LAYER_NAME)
+
+        # create directory structure
+        for name in ("conf", "recipes"):
+            path = os.path.join(layerpath, name)
+            if not os.path.isdir(path):
+                os.makedirs(path)
+
+        # create layer.conf
+        config = os.path.join(layerpath, "conf", "layer.conf")
+        if not os.path.isfile(config):
+            with open(config, "w") as conf:
+                conf.write('BBPATH .= ":${LAYERDIR}"\nBBFILES += "${LAYERDIR}/recipes/*.bb"\n')
+
+        # Update the Layer_Version dirpath that has our base_recipe in
+        # to be able to read the base recipe to then  generate the
+        # custom recipe.
+        br_layer_base_recipe = layers.get(
+            layer_version=customrecipe.base_recipe.layer_version)
+
+        # If the layer is one that we've cloned we know where it lives
+        if br_layer_base_recipe.giturl and br_layer_base_recipe.commit:
+            layer_path = self.getGitCloneDirectory(
+                br_layer_base_recipe.giturl,
+                br_layer_base_recipe.commit)
+        # Otherwise it's a local layer
+        elif br_layer_base_recipe.local_source_dir:
+            layer_path = br_layer_base_recipe.local_source_dir
+        else:
+            logger.error("Unable to workout the dir path for the custom"
+                         " image recipe")
+
+        br_layer_base_dirpath = os.path.join(
+            self.be.sourcedir,
+            layer_path,
+            customrecipe.base_recipe.layer_version.dirpath)
+
+        customrecipe.base_recipe.layer_version.dirpath = br_layer_base_dirpath
+
+        customrecipe.base_recipe.layer_version.save()
+
+        # create recipe
+        recipe_path = os.path.join(layerpath, "recipes", "%s.bb" %
+                                   customrecipe.name)
+        with open(recipe_path, "w") as recipef:
+            recipef.write(customrecipe.generate_recipe_file_contents())
+
+        # Update the layer and recipe objects
+        customrecipe.layer_version.dirpath = layerpath
+        customrecipe.layer_version.layer.local_source_dir = layerpath
+        customrecipe.layer_version.layer.save()
+        customrecipe.layer_version.save()
+
+        customrecipe.file_path = recipe_path
+        customrecipe.save()
+
+        return layerpath
+
+
     def readServerLogFile(self):
         return open(os.path.join(self.be.builddir, "toaster_server.log"), "r").read()
 
-- 
2.7.4


