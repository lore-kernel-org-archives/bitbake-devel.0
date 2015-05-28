Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by mail.openembedded.org (Postfix) with ESMTP id E26CC7570F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 14:17:25 +0000 (UTC)
Received: by wicmc15 with SMTP id mc15so125288391wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 07:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=2MSZ/jYM+PCRwLQHyQPxCiQdJz5yY9ubj3QzVH9iOm8=;
	b=gea5CIXi7AWr7z8hXy/fractei8a6V41hzLKlrWpFr2A/+ow/vZdfhmwDK2TQWNiz/
	Dcxp6lKPB9NdZfgp09pmL+iOis7BUhBJSCB0Hx/oNyQDq0xU3xuqNTlXhkdpEmZ1hFhK
	8lI+gdX/g1Pr4HrhOMEBzErvRE0zs0Yg/Yt12pGLOEAlthpp3u1BTbJfKotKjPkfTxsY
	gdQeo1HWhLhhA90IE0EyWlqUYc8jrUZ+pWbA6hfcl7dlgnym1MipfxZKxxbkwCdCzH1v
	57ahyDTwEHuqV2k8tdV8bHNrldxHAq7fjVkvRXUEQLLQ5zHXjRK1pL3fHSQVN3nrfcCX
	d87g==
X-Gm-Message-State: ALoCoQkuvuX/0I8q4b1rlWQL3Rr/cWv7x7eaXTSJreNsBdtBbHDk2nS+S6EX+m5HQSz0qTzDSN1s
X-Received: by 10.194.171.198 with SMTP id aw6mr1042460wjc.101.1432822646028; 
	Thu, 28 May 2015 07:17:26 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id hm8sm3563481wjc.28.2015.05.28.07.17.24
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 May 2015 07:17:25 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id D09ED5613ED; Thu, 28 May 2015 15:14:17 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 28 May 2015 15:14:10 +0100
Message-Id: <851fef921b05dab83d9cf7bece07c0f87a21114b.1432822343.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
References: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1432822343.git.alexandru.damian@intel.com>
References: <cover.1432822343.git.alexandru.damian@intel.com>
Subject: [PATCH 16/22] toastergui: add tests for xhr_datatypeahead calls
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
X-List-Received-Date: Thu, 28 May 2015 14:17:26 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

In order to make sure we replace the xhr_datatypeahead calls
with similar APIs, we add tests that validate the data returned
by the xhr_datatypeahead. A copy of these tests will be enabled
for each type of datatypeahead that will be replaced.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/tests.py | 50 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 8a78a41..0f10020 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -1,14 +1,18 @@
 from django.test import TestCase
 from django.core.urlresolvers import reverse
 from orm.models import Project, Release, BitbakeVersion, Build
+from orm.models import ReleaseLayerSourcePriority, LayerSource, Layer, Layer_Version
 
-class AllProjectsViewTestCase(TestCase):
+class ProvisionedProjectTestCase(TestCase):
     TEST_PROJECT_NAME = "test project"
 
     def setUp(self):
-        bbv, created = BitbakeVersion.objects.get_or_create(name="test bbv", giturl="/tmp/", branch="master", dirpath="")
-        release, created = Release.objects.get_or_create(name="test release", bitbake_version = bbv)
-        Project.objects.create_project(name=AllProjectsViewTestCase.TEST_PROJECT_NAME, release=release)
+        self.bbv, created = BitbakeVersion.objects.get_or_create(name="test bbv", giturl="/tmp/", branch="master", dirpath="")
+        self.release, created = Release.objects.get_or_create(name="test release", bitbake_version = self.bbv)
+        self.project = Project.objects.create_project(name=AllProjectsViewTestCase.TEST_PROJECT_NAME, release=self.release)
+
+
+class AllProjectsViewTestCase(ProvisionedProjectTestCase):
 
     def test_get_base_call_returns_html(self):
         response = self.client.get(reverse('all-projects'), follow=True)
@@ -21,16 +25,54 @@ class AllProjectsViewTestCase(TestCase):
         response = self.client.get(reverse('all-projects'), {"format": "json"}, follow=True)
         self.assertEqual(response.status_code, 200)
         self.assertTrue(response['Content-Type'].startswith('application/json'))
+
         try:
             import json
             data = json.loads(response.content)
         except:
             self.fail("Response %s is not json-loadable" % response.content)
 
+        self.assertTrue("error" in data)
+        self.assertEqual(data["error"], "ok")
         self.assertTrue("list" in data)
+
         self.assertTrue(AllProjectsViewTestCase.TEST_PROJECT_NAME in map(lambda x: x["name"], data["list"]))
         self.assertTrue("id" in data["list"][0])
         self.assertTrue("xhrProjectDataTypeaheadUrl" in data["list"][0])
         self.assertTrue("projectPageUrl" in data["list"][0])
         self.assertTrue("xhrProjectEditUrl" in data["list"][0])
         self.assertTrue("projectBuildUrl" in data["list"][0])
+
+class ProvisionedLayersProjectTestCase(ProvisionedProjectTestCase):
+    LAYER_NAME = "base-layer"
+    def setUp(self):
+        super(ProvisionedLayersProjectTestCase, self).setUp()
+        self.layersource, created = LayerSource.objects.get_or_create(sourcetype = LayerSource.TYPE_IMPORTED)
+        self.releaselayersourcepriority, created = ReleaseLayerSourcePriority.objects.get_or_create(release = self.release, layer_source = self.layersource)
+        self.layer, created = Layer.objects.get_or_create(name=XHRDataTypeAheadTestCase.LAYER_NAME, layer_source=self.layersource, vcs_url="/tmp/")
+        self.lv, created = Layer_Version.objects.get_or_create(layer = self.layer, project = self.project, layer_source=self.layersource, commit="master")
+
+
+class XHRDataTypeAheadTestCase(ProvisionedLayersProjectTestCase):
+
+    def setUp(self):
+        super(XHRDataTypeAheadTestCase, self).setUp()
+        self.assertTrue(self.lv in self.project.compatible_layerversions())
+
+    def test_xhr_datatypeahead_layer(self):
+        response = self.client.get(reverse('xhr_datatypeahead', args=(self.project.id,)), {"type": "layers"})
+        self.assertEqual(response.status_code, 200)
+        self.assertTrue(response['Content-Type'].startswith('application/json'))
+
+        try:
+            import json
+            data = json.loads(response.content)
+        except:
+            self.fail("Response %s is not json-loadable" % response.content)
+
+        self.assertTrue("error" in data)
+        self.assertEqual(data["error"], "ok")
+        self.assertTrue("list" in data)
+        self.assertTrue(len(data["list"]) > 0)
+
+        self.assertTrue(XHRDataTypeAheadTestCase.LAYER_NAME in map(lambda x: x["name"], data["list"]))
-- 
1.9.1


