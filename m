Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
	[209.85.212.176])
	by mail.openembedded.org (Postfix) with ESMTP id C4930768C8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 17:27:24 +0000 (UTC)
Received: by wicne3 with SMTP id ne3so30781657wic.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 10:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=8gk8uw/fxQbxC/VJSlN+t22SqaJ1r+nsAh4PhUomFi4=;
	b=YBI/bEkfApxAQc4G3tvQosK1iYeH0p9K8KMFYTJVXsWhsc9vb7Ww979i8jEZP5hapl
	UoJ++cVkkK5cHIybYZsNFI0Y8F2v+V0DBBG9l+2MOVZu9rDR8Dnx4+w61PWgor8+XXpD
	mSo3cbQ/QqlY1xoswl1C6ZeYxDPx+bfqOYlMX7mTJWPNwDA26btGyF0Z06cpZMqk+naT
	j543s0qCARRU68NHPSkjkPLLsuI9Q39j131cCzZ6VDa65nCyl86c2pX81W7R/f/BPgpA
	a6z7zhO7U1JysDF35EhrUhUP8RWUHwq4c932WG2PPbk+LT/vhvYsB6ehyosfxU1T8yr1
	4U7w==
X-Gm-Message-State: ALoCoQljCNS48S1dv/QDeIxV9/wjq4JNonLuJlsHVF2bK/azDI52ANxO82HOj5zFd/3CoGhN677g
X-Received: by 10.180.105.234 with SMTP id gp10mr14276383wib.40.1439227644262; 
	Mon, 10 Aug 2015 10:27:24 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	cw8sm30396731wjb.49.2015.08.10.10.27.23
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 10 Aug 2015 10:27:23 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 10 Aug 2015 18:27:09 +0100
Message-Id: <1a904b9bac325bd2ca928447391da13a0ad736db.1439226591.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <dd3a557b5759abe26b64c22379333c25d83b8708.1439226591.git.michael.g.wood@intel.com>
References: <cover.1439226591.git.michael.g.wood@intel.com>
	<dd3a557b5759abe26b64c22379333c25d83b8708.1439226591.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439226591.git.michael.g.wood@intel.com>
References: <cover.1439226591.git.michael.g.wood@intel.com>
Subject: [PATCH 02/11] toaster: wrap long lines
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

Fixed pylint warning Line too long (line-too-long).

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/tests.py | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 39586e0..a9edd54 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -1,16 +1,22 @@
 from django.test import TestCase
 from django.core.urlresolvers import reverse
 from orm.models import Project, Release, BitbakeVersion, Build
-from orm.models import ReleaseLayerSourcePriority, LayerSource, Layer, Layer_Version, Recipe, Machine, ProjectLayer
+from orm.models import ReleaseLayerSourcePriority, LayerSource, Layer
+from orm.models import Layer_Version, Recipe, Machine, ProjectLayer
 import json
 
+PROJECT_NAME = "test project"
+
 class ProvisionedProjectTestCase(TestCase):
-    TEST_PROJECT_NAME = "test project"
 
     def setUp(self):
-        self.bbv, created = BitbakeVersion.objects.get_or_create(name="test bbv", giturl="/tmp/", branch="master", dirpath="")
-        self.release, created = Release.objects.get_or_create(name="test release", bitbake_version = self.bbv)
-        self.project = Project.objects.create_project(name=AllProjectsViewTestCase.TEST_PROJECT_NAME, release=self.release)
+        self.bbv = BitbakeVersion.objects.create(\
+                       name="test bbv", giturl="/tmp/",
+                       branch="master", dirpath="")
+        self.release = Release.objects.create(\
+                           name="test release", bitbake_version=self.bbv)
+        self.project = Project.objects.create_project(name=PROJECT_NAME,
+                                                      release=self.release)
 
 
 class AllProjectsViewTestCase(ProvisionedProjectTestCase):
@@ -20,10 +26,11 @@ class AllProjectsViewTestCase(ProvisionedProjectTestCase):
         self.assertEqual(response.status_code, 200)
         self.assertTrue(response['Content-Type'].startswith('text/html'))
         self.assertTemplateUsed(response, "projects.html")
-        self.assertTrue(AllProjectsViewTestCase.TEST_PROJECT_NAME in response.content)
+        self.assertTrue(PROJECT_NAME in response.content)
 
     def test_get_json_call_returns_json(self):
-        response = self.client.get(reverse('all-projects'), {"format": "json"}, follow=True)
+        url = reverse('all-projects')
+        response = self.client.get(url, {"format": "json"}, follow=True)
         self.assertEqual(response.status_code, 200)
         self.assertTrue(response['Content-Type'].startswith('application/json'))
 
@@ -36,7 +43,7 @@ class AllProjectsViewTestCase(ProvisionedProjectTestCase):
         self.assertEqual(data["error"], "ok")
         self.assertTrue("rows" in data)
 
-        self.assertTrue(AllProjectsViewTestCase.TEST_PROJECT_NAME in map(lambda x: x["name"], data["rows"]))
+        self.assertTrue(PROJECT_NAME in [x["name"] for x in data["rows"]])
         self.assertTrue("id" in data["rows"][0])
         self.assertTrue("projectLayersUrl" in data["rows"][0])
         self.assertTrue("projectPageUrl" in data["rows"][0])
@@ -49,10 +56,17 @@ class ProvisionedLayersProjectTestCase(ProvisionedProjectTestCase):
 
     def setUp(self):
         super(ProvisionedLayersProjectTestCase, self).setUp()
-        self.layersource, created = LayerSource.objects.get_or_create(sourcetype = LayerSource.TYPE_IMPORTED)
-        self.releaselayersourcepriority, created = ReleaseLayerSourcePriority.objects.get_or_create(release = self.release, layer_source = self.layersource)
-        self.layer, created = Layer.objects.get_or_create(name=XHRDataTypeAheadTestCase.LAYER_NAME, layer_source=self.layersource, vcs_url="/tmp/")
-        self.lv, created = Layer_Version.objects.get_or_create(layer = self.layer, project = self.project, layer_source=self.layersource, commit="master")
+        self.layersrc = LayerSource.objects.create(\
+                               sourcetype=LayerSource.TYPE_IMPORTED)
+        self.priority = ReleaseLayerSourcePriority.objects.create(\
+                               release=self.release,
+                               layer_source=self.layersrc)
+        self.layer = Layer.objects.create(\
+                         name=XHRDataTypeAheadTestCase.LAYER_NAME,
+                         layer_source=self.layersrc, vcs_url="/tmp/")
+        self.lver = Layer_Version.objects.create(\
+                        layer=self.layer, project=self.project,
+                        layer_source=self.layersrc, commit="master")
 
         self.recipe, created = Recipe.objects.get_or_create(layer_source=self.layersource, name=ProvisionedLayersProjectTestCase.RECIPE_NAME, version="1.2", summary="one recipe", description="recipe", layer_version=self.lv)
 
@@ -66,7 +80,7 @@ class XHRDataTypeAheadTestCase(ProvisionedLayersProjectTestCase):
 
     def setUp(self):
         super(XHRDataTypeAheadTestCase, self).setUp()
-        self.assertTrue(self.lv in self.project.compatible_layerversions())
+        self.assertTrue(self.lver in self.project.compatible_layerversions())
 
     def test_typeaheads(self):
         layers_url = reverse('xhr_layerstypeahead', args=(self.project.id,))
-- 
2.1.4


