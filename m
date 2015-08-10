Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
	[209.85.212.172])
	by mail.openembedded.org (Postfix) with ESMTP id 185C476898
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 11:21:46 +0000 (UTC)
Received: by wicja10 with SMTP id ja10so32972190wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 04:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=YbVcHX3VVLAkpS928ipEm6Xca5va76bviFCnrhob6QU=;
	b=gxWJmUCWe1ipJWmV0DE/iKN2wMHffcF1k5p/8f2karAtemlgCulkIrTT5ZD2L4u9hS
	TNB+jhIRpFIc8+qbrQBE7vZ4cxpv9hrZAHL/rn+pxTVJmqNcJWrawenSusdbsGulEPPG
	cvBzqet2Rn40bXdcES+JJkqwUOAQIOGKREAC1bgh2XCRTbvqbOTYeIbKBrMDzmHbEEL5
	mZc+XkVELjyDmIDzQlqyt3Lm1BHXKgRwm1+Gi8cdPjMAmGLZ4cJ8EuitHnJwtdTOF14g
	tV/AVohvK61ULDaAOuFn+ybZe+X0PvEGO0FAMsFFo8YPFB88P5G8hy6UXXr1kAF7eSIa
	RQGg==
X-Gm-Message-State: ALoCoQni0V43uzlD5Klx+GuNSJwaWmXQQUMC0qqxTFeh30DEwBYx3d8Vca+7VK2lOP07aZVnoIij
X-Received: by 10.194.239.167 with SMTP id vt7mr46117527wjc.5.1439205706450;
	Mon, 10 Aug 2015 04:21:46 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	c11sm13292834wib.1.2015.08.10.04.21.45
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 10 Aug 2015 04:21:45 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 10 Aug 2015 12:21:28 +0100
Message-Id: <155ae20e847570342b9829b397d67a858e767382.1439205232.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1e8409b1d3149ca2483e5581c5428e58b6fadefe.1439205232.git.michael.g.wood@intel.com>
References: <cover.1439205232.git.michael.g.wood@intel.com>
	<1e8409b1d3149ca2483e5581c5428e58b6fadefe.1439205232.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439205232.git.michael.g.wood@intel.com>
References: <cover.1439205232.git.michael.g.wood@intel.com>
Subject: [PATCH 05/11] toaster: reformat LayerVersionEquivalenceTestCase
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
X-List-Received-Date: Mon, 10 Aug 2015 11:21:47 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Reformatted to increase readability and satisfy pylint.
Added docstings.
Shortened variable names.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/tests.py | 124 ++++++++++++++++++++++++++++-------------------
 1 file changed, 74 insertions(+), 50 deletions(-)

diff --git a/lib/toaster/orm/tests.py b/lib/toaster/orm/tests.py
index 3384f01..75783ce 100644
--- a/lib/toaster/orm/tests.py
+++ b/lib/toaster/orm/tests.py
@@ -59,75 +59,99 @@ class LILSUpdateTestCase(TransactionTestCase):
                         "no branches fetched")
 
 
-# tests to verify layer_version priority selection
 class LayerVersionEquivalenceTestCase(TestCase):
-    def setUp(self):
-        # create layer sources
-        ls = LayerSource.objects.create(name = "dummy-layersource", sourcetype = LayerSource.TYPE_LOCAL)
+    """Verify Layer_Version priority selection."""
 
-        # create bitbake version
-        bbv = BitbakeVersion.objects.create(name="master", giturl="git://git.openembedded.org/bitbake")
+    def setUp(self):
+        """Create required objects."""
+        # create layer source
+        lsrc = LayerSource.objects.create(name="dummy-layersource",
+                                          sourcetype=LayerSource.TYPE_LOCAL)
         # create release
-        release = Release.objects.create(name="default-release", bitbake_version = bbv, branch_name = "master")
+        bbv = BitbakeVersion.objects.create(\
+                  name="master", giturl="git://git.openembedded.org/bitbake")
+        self.release = Release.objects.create(name="default-release",
+                                              bitbake_version=bbv,
+                                              branch_name="master")
         # attach layer source to release
-        ReleaseLayerSourcePriority.objects.create(release = release, layer_source = ls, priority = 1)
+        ReleaseLayerSourcePriority.objects.create(\
+            release=self.release, layer_source=lsrc, priority=1)
 
-
-        # create layer attach
-        self.layer = Layer.objects.create(name="meta-testlayer", layer_source = ls)
-        # create branch
-        self.branch = Branch.objects.create(name="master", layer_source = ls)
-
-        # set a layer version for the layer on the specified branch
-        self.layerversion = Layer_Version.objects.create(layer = self.layer, layer_source = ls, up_branch = self.branch)
+        # create a layer version for the layer on the specified branch
+        self.layer = Layer.objects.create(name="meta-testlayer",
+                                          layer_source=lsrc)
+        self.branch = Branch.objects.create(name="master", layer_source=lsrc)
+        self.lver = Layer_Version.objects.create(\
+            layer=self.layer, layer_source=lsrc, up_branch=self.branch)
 
         # create spoof layer that should not appear in the search results
-        Layer_Version.objects.create(layer = Layer.objects.create(name="meta-notvalid", layer_source = ls), layer_source = ls, up_branch = self.branch)
+        layer = Layer.objects.create(name="meta-notvalid", layer_source=lsrc)
+        Layer_Version.objects.create(layer=layer, layer_source=lsrc,
+                                     up_branch=self.branch)
 
-
-        # create a project ...
-        self.project = Project.objects.create_project(name="test-project", release = release)
-        # ... and set it up with a single layer version
-        ProjectLayer.objects.create(project=  self.project, layercommit = self.layerversion)
+        # create project and project layer
+        self.project = Project.objects.create_project(name="test-project",
+                                                      release=self.release)
+        ProjectLayer.objects.create(project=self.project,
+                                    layercommit=self.lver)
 
     def test_single_layersource(self):
-        # when we have a single layer version, get_equivalents_wpriority() should return a list with just this layer_version
-        equivalent_list = self.layerversion.get_equivalents_wpriority(self.project)
-        self.assertTrue(len(equivalent_list) == 1)
-        self.assertTrue(equivalent_list[0] == self.layerversion)
+        """
+        When we have a single layer version,
+        get_equivalents_wpriority() should return a list with
+        just this layer_version.
+        """
+        equivqs = self.lver.get_equivalents_wpriority(self.project)
+        self.assertEqual(list(equivqs), [self.lver])
 
     def test_dual_layersource(self):
-        # if we have two layers with the same name, from different layer sources, we expect both layers in, in increasing priority of the layer source
-        ls2 = LayerSource.objects.create(name = "dummy-layersource2", sourcetype = LayerSource.TYPE_LOCAL, apiurl="test")
+        """
+        If we have two layers with the same name, from different layer sources,
+        we expect both layers in, in increasing priority of the layer source.
+        """
+        lsrc2 = LayerSource.objects.create(\
+                    name="dummy-layersource2",
+                    sourcetype=LayerSource.TYPE_LOCAL,
+                    apiurl="test")
 
         # assign a lower priority for the second layer source
-        Release.objects.get(name="default-release").releaselayersourcepriority_set.create(layer_source = ls2, priority = 2)
+        self.release.releaselayersourcepriority_set.create(layer_source=lsrc2,
+                                                           priority=2)
 
-        # create a new layer_version for a layer with the same name coming from the second layer source
-        self.layer2 = Layer.objects.create(name="meta-testlayer", layer_source = ls2)
-        self.layerversion2 = Layer_Version.objects.create(layer = self.layer2, layer_source = ls2, up_branch = self.branch)
+        # create a new layer_version for a layer with the same name
+        # coming from the second layer source
+        layer2 = Layer.objects.create(name="meta-testlayer",
+                                      layer_source=lsrc2)
+        lver2 = Layer_Version.objects.create(layer=layer2, layer_source=lsrc2,
+                                             up_branch=self.branch)
 
         # expect two layer versions, in the priority order
-        equivalent_list = self.layerversion.get_equivalents_wpriority(self.project)
-        self.assertTrue(len(equivalent_list) == 2)
-        self.assertTrue(equivalent_list[0] == self.layerversion2)
-        self.assertTrue(equivalent_list[1] == self.layerversion)
+        equivqs = self.lver.get_equivalents_wpriority(self.project)
+        self.assertEqual(list(equivqs), [lver2, self.lver])
 
     def test_build_layerversion(self):
-        # any layer version coming from the build should show up before any layer version coming from upstream
-        build = Build.objects.create(project = self.project, started_on = timezone.now(), completed_on = timezone.now())
-        self.layerversion_build = Layer_Version.objects.create(layer = self.layer, build = build, commit = "deadbeef")
-
-        # a build layerversion must be in the equivalence list for the original layerversion
-        equivalent_list = self.layerversion.get_equivalents_wpriority(self.project)
-        self.assertTrue(len(equivalent_list) == 2)
-        self.assertTrue(equivalent_list[0] == self.layerversion)
-        self.assertTrue(equivalent_list[1] == self.layerversion_build)
-
-        # getting the build layerversion equivalent list must return the same list as the original layer
-        build_equivalent_list = self.layerversion_build.get_equivalents_wpriority(self.project)
-
-        self.assertEqual(list(equivalent_list), list(build_equivalent_list))
+        """
+        Any layer version coming from the build should show up
+        before any layer version coming from upstream
+        """
+        build = Build.objects.create(project=self.project,
+                                     started_on=timezone.now(),
+                                     completed_on=timezone.now())
+        lvb = Layer_Version.objects.create(layer=self.layer, build=build,
+                                           commit="deadbeef")
+
+        # a build layerversion must be in the equivalence
+        # list for the original layerversion
+        equivqs = self.lver.get_equivalents_wpriority(self.project)
+        self.assertTrue(len(equivqs) == 2)
+        self.assertTrue(equivqs[0] == self.lver)
+        self.assertTrue(equivqs[1] == lvb)
+
+        # getting the build layerversion equivalent list must
+        # return the same list as the original layer
+        bequivqs = lvb.get_equivalents_wpriority(self.project)
+
+        self.assertEqual(list(equivqs), list(bequivqs))
 
 class ProjectLVSelectionTestCase(TestCase):
     def setUp(self):
-- 
2.1.4


