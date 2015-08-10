Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
	[209.85.212.176])
	by mail.openembedded.org (Postfix) with ESMTP id C3407768C6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 17:27:26 +0000 (UTC)
Received: by wicja10 with SMTP id ja10so35112029wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 10:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=tYVWex7pUZn3jmtibm4i+1X0v0IxZtUkk8Wl+6G/b8c=;
	b=lAgr52i8nZCaKrxLDpIlQbuhWmXwD+iI3HEe2KGp57W5IDNIJDH/+AMIsVceIZrjLB
	DPg59VfJ/MiZqMyelkRcQXGPij4az6gonz2vUxiNotfs/z2QPxS1MiF+dnCfT32snOp3
	JwatQigOhXkeELuIJoCCLKGHUr3Z6JD4C5sEKuJ+wULkao7iiOjcoN1G1UEq+qNH2iOq
	oj/iFZSmhGsFSKzDmNmN1GGIh8I5t8HPkyjNUHmfgDa16hXFMHDvAo7TwC0FjsbTyPEt
	/JESrpkT1aesE4dgbekW2vfEIwokf8gQyKhhlKxEMi/BEuj/tdZi7voo3GX8W6fwrhXX
	QRLA==
X-Gm-Message-State: ALoCoQkqUGJyNIFautanCBE5PzwdjESiFZ500RwVMqdVmOgJjg/DogjEgyKP9iOr96hjI16wWwNQ
X-Received: by 10.180.105.36 with SMTP id gj4mr26514892wib.64.1439227646012;
	Mon, 10 Aug 2015 10:27:26 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	cw8sm30396731wjb.49.2015.08.10.10.27.25
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 10 Aug 2015 10:27:25 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 10 Aug 2015 18:27:11 +0100
Message-Id: <d30b436e89abb095f444adb95d8699b81aec5003.1439226591.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <dd3a557b5759abe26b64c22379333c25d83b8708.1439226591.git.michael.g.wood@intel.com>
References: <cover.1439226591.git.michael.g.wood@intel.com>
	<dd3a557b5759abe26b64c22379333c25d83b8708.1439226591.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439226591.git.michael.g.wood@intel.com>
References: <cover.1439226591.git.michael.g.wood@intel.com>
Subject: [PATCH 04/11] toaster: put all test cases into one class
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
X-List-Received-Date: Mon, 10 Aug 2015 17:27:27 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Moved all functionality (one setup method and one test case) from
ProvisionedLayersProjectTestCase and XHRDataTypeAheadTestCase to
AllProjectsViewTestCase.

Renamed AllProjectsViewTestCase -> ViewTests.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/tests.py | 63 +++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 34 deletions(-)

diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 6f3930d..986e6a5 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -7,7 +7,10 @@ import json
 
 PROJECT_NAME = "test project"
 
-class AllProjectsViewTestCase(TestCase):
+class ViewTests(TestCase):
+    """Tests to verify view APIs."""
+    LAYER_NAME = "base-layer"
+    RECIPE_NAME = "base-recipe"
 
     def setUp(self):
         self.bbv = BitbakeVersion.objects.create(\
@@ -17,6 +20,31 @@ class AllProjectsViewTestCase(TestCase):
                            name="test release", bitbake_version=self.bbv)
         self.project = Project.objects.create_project(name=PROJECT_NAME,
                                                       release=self.release)
+        self.layersrc = LayerSource.objects.create(\
+                               sourcetype=LayerSource.TYPE_IMPORTED)
+        self.priority = ReleaseLayerSourcePriority.objects.create(\
+                               release=self.release,
+                               layer_source=self.layersrc)
+        self.layer = Layer.objects.create(\
+                         name=self.LAYER_NAME,
+                         layer_source=self.layersrc, vcs_url="/tmp/")
+        self.lver = Layer_Version.objects.create(\
+                        layer=self.layer, project=self.project,
+                        layer_source=self.layersrc, commit="master")
+
+        self.recipe = Recipe.objects.create(\
+                          layer_source=self.layersrc, name=self.RECIPE_NAME,
+                          version="1.2", summary="one recipe",
+                          description="recipe", layer_version=self.lver)
+
+        self.machine = Machine.objects.create(\
+                          layer_version=self.lver, name="wisk",
+                          description="wisking machine")
+
+        ProjectLayer.objects.create(project=self.project,
+                                    layercommit=self.lver)
+
+        self.assertTrue(self.lver in self.project.compatible_layerversions())
 
     def test_get_base_call_returns_html(self):
         response = self.client.get(reverse('all-projects'), follow=True)
@@ -46,39 +74,6 @@ class AllProjectsViewTestCase(TestCase):
         self.assertTrue("projectPageUrl" in data["rows"][0])
         self.assertTrue("projectBuildsUrl" in data["rows"][0])
 
-class ProvisionedLayersProjectTestCase(ProvisionedProjectTestCase):
-    LAYER_NAME = "base-layer"
-    RECIPE_NAME = "base-recipe"
-
-
-    def setUp(self):
-        super(ProvisionedLayersProjectTestCase, self).setUp()
-        self.layersrc = LayerSource.objects.create(\
-                               sourcetype=LayerSource.TYPE_IMPORTED)
-        self.priority = ReleaseLayerSourcePriority.objects.create(\
-                               release=self.release,
-                               layer_source=self.layersrc)
-        self.layer = Layer.objects.create(\
-                         name=XHRDataTypeAheadTestCase.LAYER_NAME,
-                         layer_source=self.layersrc, vcs_url="/tmp/")
-        self.lver = Layer_Version.objects.create(\
-                        layer=self.layer, project=self.project,
-                        layer_source=self.layersrc, commit="master")
-
-        self.recipe, created = Recipe.objects.get_or_create(layer_source=self.layersource, name=ProvisionedLayersProjectTestCase.RECIPE_NAME, version="1.2", summary="one recipe", description="recipe", layer_version=self.lv)
-
-        self.machine, created = Machine.objects.get_or_create(layer_version=self.lv, name="wisk", description="wisking machine")
-
-        ProjectLayer.objects.get_or_create(project = self.project,
-                                           layercommit = self.lv)
-
-
-class XHRDataTypeAheadTestCase(ProvisionedLayersProjectTestCase):
-
-    def setUp(self):
-        super(XHRDataTypeAheadTestCase, self).setUp()
-        self.assertTrue(self.lver in self.project.compatible_layerversions())
-
     def test_typeaheads(self):
         layers_url = reverse('xhr_layerstypeahead', args=(self.project.id,))
         prj_url = reverse('xhr_projectstypeahead')
-- 
2.1.4


