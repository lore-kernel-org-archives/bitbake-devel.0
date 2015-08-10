Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
	[209.85.212.177])
	by mail.openembedded.org (Postfix) with ESMTP id 3A9E17687E
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 11:21:47 +0000 (UTC)
Received: by wicne3 with SMTP id ne3so17990068wic.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 04:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=EUn2/tw++458ZBgvvM2S8Vp48eqpvG0WmDvpnNuQudU=;
	b=JMqTFzGVE9HSoZON5EwewT3cWlnAJSa4uCw4EE5891rKapWLt40bWR/m1Ptw67LPcO
	fS903BkjTNmQQCHOacjyDC9rP5rvhMCMEPh0TBfr6nH51QPLnw2WkG9X1CZ8wY+QF8fB
	PLBfTq6tLbilNyVTAo/+UyadX89FKhH+2Z3dUs8ejGCb+aacdUr08zn4s8xoRDCdRdWU
	XQAnB4ThGQE+wkvO1M4D1BZbXvkMZXUrEv2SZ+D2pgOtz908SSH7SObpDcShhl1Y3sUs
	LFK54ENj0u+HxGU49gKXGBWcFJ97wu2++Getx8y8gzofPuUPWxLZxV0cpIPpEs3H+tGz
	hWFg==
X-Gm-Message-State: ALoCoQka/FLiTXo/CxnNi4Jze5cVg4sqHkSEXymrD6tLWU8z+x8Xsi/C81jbQg+sn7VwpbzIENwK
X-Received: by 10.194.108.5 with SMTP id hg5mr45791791wjb.25.1439205707477;
	Mon, 10 Aug 2015 04:21:47 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	c11sm13292834wib.1.2015.08.10.04.21.46
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 10 Aug 2015 04:21:46 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 10 Aug 2015 12:21:29 +0100
Message-Id: <72d402dc80c32209c11cfdbff00b83a77c0d13be.1439205232.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1e8409b1d3149ca2483e5581c5428e58b6fadefe.1439205232.git.michael.g.wood@intel.com>
References: <cover.1439205232.git.michael.g.wood@intel.com>
	<1e8409b1d3149ca2483e5581c5428e58b6fadefe.1439205232.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439205232.git.michael.g.wood@intel.com>
References: <cover.1439205232.git.michael.g.wood@intel.com>
Subject: [PATCH 06/11] toaster: reuse common code
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
X-List-Received-Date: Mon, 10 Aug 2015 11:21:48 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Moved setup code of LayerVersion tests to a function
and call it from setUp methods of 2 classes.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/tests.py | 90 +++++++++++++++++++-----------------------------
 1 file changed, 36 insertions(+), 54 deletions(-)

diff --git a/lib/toaster/orm/tests.py b/lib/toaster/orm/tests.py
index 75783ce..168bafa 100644
--- a/lib/toaster/orm/tests.py
+++ b/lib/toaster/orm/tests.py
@@ -59,42 +59,45 @@ class LILSUpdateTestCase(TransactionTestCase):
                         "no branches fetched")
 
 
+def setup_lv_tests(self):
+    """Create required objects."""
+    # create layer source
+    self.lsrc = LayerSource.objects.create(name="dummy-layersource",
+                                           sourcetype=LayerSource.TYPE_LOCAL)
+    # create release
+    bbv = BitbakeVersion.objects.create(\
+              name="master", giturl="git://git.openembedded.org/bitbake")
+    self.release = Release.objects.create(name="default-release",
+                                          bitbake_version=bbv,
+                                          branch_name="master")
+    # attach layer source to release
+    ReleaseLayerSourcePriority.objects.create(\
+        release=self.release, layer_source=self.lsrc, priority=1)
+
+    # create a layer version for the layer on the specified branch
+    self.layer = Layer.objects.create(name="meta-testlayer",
+                                      layer_source=self.lsrc)
+    self.branch = Branch.objects.create(name="master", layer_source=self.lsrc)
+    self.lver = Layer_Version.objects.create(\
+        layer=self.layer, layer_source=self.lsrc, up_branch=self.branch)
+
+    # create project and project layer
+    self.project = Project.objects.create_project(name="test-project",
+                                                  release=self.release)
+    ProjectLayer.objects.create(project=self.project,
+                                layercommit=self.lver)
+
 class LayerVersionEquivalenceTestCase(TestCase):
     """Verify Layer_Version priority selection."""
 
     def setUp(self):
-        """Create required objects."""
-        # create layer source
-        lsrc = LayerSource.objects.create(name="dummy-layersource",
-                                          sourcetype=LayerSource.TYPE_LOCAL)
-        # create release
-        bbv = BitbakeVersion.objects.create(\
-                  name="master", giturl="git://git.openembedded.org/bitbake")
-        self.release = Release.objects.create(name="default-release",
-                                              bitbake_version=bbv,
-                                              branch_name="master")
-        # attach layer source to release
-        ReleaseLayerSourcePriority.objects.create(\
-            release=self.release, layer_source=lsrc, priority=1)
-
-        # create a layer version for the layer on the specified branch
-        self.layer = Layer.objects.create(name="meta-testlayer",
-                                          layer_source=lsrc)
-        self.branch = Branch.objects.create(name="master", layer_source=lsrc)
-        self.lver = Layer_Version.objects.create(\
-            layer=self.layer, layer_source=lsrc, up_branch=self.branch)
-
+        setup_lv_tests(self)
         # create spoof layer that should not appear in the search results
-        layer = Layer.objects.create(name="meta-notvalid", layer_source=lsrc)
-        Layer_Version.objects.create(layer=layer, layer_source=lsrc,
+        layer = Layer.objects.create(name="meta-notvalid",
+                                     layer_source=self.lsrc)
+        Layer_Version.objects.create(layer=layer, layer_source=self.lsrc,
                                      up_branch=self.branch)
 
-        # create project and project layer
-        self.project = Project.objects.create_project(name="test-project",
-                                                      release=self.release)
-        ProjectLayer.objects.create(project=self.project,
-                                    layercommit=self.lver)
-
     def test_single_layersource(self):
         """
         When we have a single layer version,
@@ -154,35 +157,14 @@ class LayerVersionEquivalenceTestCase(TestCase):
         self.assertEqual(list(equivqs), list(bequivqs))
 
 class ProjectLVSelectionTestCase(TestCase):
-    def setUp(self):
-        # create layer sources
-        ls = LayerSource.objects.create(name = "dummy-layersource", sourcetype = LayerSource.TYPE_LOCAL)
 
-        # create bitbake version
-        bbv = BitbakeVersion.objects.create(name="master", giturl="git://git.openembedded.org/bitbake")
-        # create release
-        release = Release.objects.create(name="default-release", bitbake_version = bbv, branch_name="master")
-        # attach layer source to release
-        ReleaseLayerSourcePriority.objects.create(release = release, layer_source = ls, priority = 1)
-
-        # create layer attach
-        self.layer = Layer.objects.create(name="meta-testlayer", layer_source = ls)
-        # create branch
-        self.branch = Branch.objects.create(name="master", layer_source = ls)
-
-        # set a layer version for the layer on the specified branch
-        self.layerversion = Layer_Version.objects.create(layer = self.layer, layer_source = ls, up_branch = self.branch)
-
-
-        # create a project ...
-        self.project = Project.objects.create_project(name="test-project", release = release)
-        # ... and set it up with a single layer version
-        ProjectLayer.objects.create(project=  self.project, layercommit = self.layerversion)
+    def setUp(self):
+        setup_lv_tests(self)
 
     def test_single_layersource(self):
         compatible_layerversions = self.project.compatible_layerversions()
         self.assertTrue(len(compatible_layerversions) == 1)
-        self.assertTrue(compatible_layerversions[0] == self.layerversion)
+        self.assertTrue(compatible_layerversions[0] == self.lver)
 
 
     def test_dual_layersource(self):
@@ -200,4 +182,4 @@ class ProjectLVSelectionTestCase(TestCase):
         equivalent_list = self.project.compatible_layerversions()
         self.assertTrue(len(equivalent_list) == 2)
         self.assertTrue(equivalent_list[0] == self.layerversion2)
-        self.assertTrue(equivalent_list[1] == self.layerversion)
+        self.assertTrue(equivalent_list[1] == self.lver)
-- 
2.1.4


