Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
	[209.85.212.181])
	by mail.openembedded.org (Postfix) with ESMTP id BECE07646B
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 11:21:51 +0000 (UTC)
Received: by wicja10 with SMTP id ja10so20959255wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 04:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=aqYoToTktMHoGsBcBET7Y0MX3Q6tz7G6wpQPdtnPTsA=;
	b=kIuQaDU3553glcfv95gb+eCyAV5zU0eoV3VaFrDUr3mk3X9t1t+ncbKeuhw/B29vsQ
	5QhTCh9cn2D5no7ocLnHf8Jwyw6JKwjS9OQ2f97r5lwkoPbnWlLUjGjV4o4h1CVTapre
	xsh+It06BLvrOAVZr/Vyf2qEzBUs0kPSPUctoPqRU3DexKMbaGe2Sa7u+J6L240Tfwq2
	vpToE6X4AgYuuP1d8ZMPfsITgK5/xt0smwusEwe0qC4pF2JHZoVhU3YpP1g+1gdXJVCD
	YcoNN4kiDTmk6FKwM4P/GKg1k65fPDoh53z3pGNA7esxIjuTBVpdWm66kneXIz3upqGT
	CJ1w==
X-Gm-Message-State: ALoCoQmIiqXlHhMrFwK07B7HCArKBTPJXrwejxRRVvXk98pudKN5R+W6wUYY4Vuc2+5n2HNlTVeu
X-Received: by 10.194.84.211 with SMTP id b19mr45924160wjz.120.1439205711749; 
	Mon, 10 Aug 2015 04:21:51 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	c11sm13292834wib.1.2015.08.10.04.21.50
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 10 Aug 2015 04:21:51 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 10 Aug 2015 12:21:34 +0100
Message-Id: <aa65351b246b099b8d8b72fbec41a6cbed01b208.1439205232.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1e8409b1d3149ca2483e5581c5428e58b6fadefe.1439205232.git.michael.g.wood@intel.com>
References: <cover.1439205232.git.michael.g.wood@intel.com>
	<1e8409b1d3149ca2483e5581c5428e58b6fadefe.1439205232.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439205232.git.michael.g.wood@intel.com>
References: <cover.1439205232.git.michael.g.wood@intel.com>
Subject: [PATCH 11/11] toaster: move code from setup_lv_tests to setUp
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
X-List-Received-Date: Mon, 10 Aug 2015 11:21:52 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

As ProjectLVSelectionTestCase was removed there is no point
to keep this function. Moved code back to setUp method.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/tests.py | 57 +++++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/lib/toaster/orm/tests.py b/lib/toaster/orm/tests.py
index 5246909..783aea8 100644
--- a/lib/toaster/orm/tests.py
+++ b/lib/toaster/orm/tests.py
@@ -81,40 +81,37 @@ class LILSUpdateTestCase(TransactionTestCase):
         self.assertTrue(lsobj.branch_set.all().count() > 0,
                         "no branches fetched")
 
-
-def setup_lv_tests(self):
-    """Create required objects."""
-    # create layer source
-    self.lsrc = LayerSource.objects.create(name="dummy-layersource",
-                                           sourcetype=LayerSource.TYPE_LOCAL)
-    # create release
-    bbv = BitbakeVersion.objects.create(\
-              name="master", giturl="git://git.openembedded.org/bitbake")
-    self.release = Release.objects.create(name="default-release",
-                                          bitbake_version=bbv,
-                                          branch_name="master")
-    # attach layer source to release
-    ReleaseLayerSourcePriority.objects.create(\
-        release=self.release, layer_source=self.lsrc, priority=1)
-
-    # create a layer version for the layer on the specified branch
-    self.layer = Layer.objects.create(name="meta-testlayer",
-                                      layer_source=self.lsrc)
-    self.branch = Branch.objects.create(name="master", layer_source=self.lsrc)
-    self.lver = Layer_Version.objects.create(\
-        layer=self.layer, layer_source=self.lsrc, up_branch=self.branch)
-
-    # create project and project layer
-    self.project = Project.objects.create_project(name="test-project",
-                                                  release=self.release)
-    ProjectLayer.objects.create(project=self.project,
-                                layercommit=self.lver)
-
 class LayerVersionEquivalenceTestCase(TestCase):
     """Verify Layer_Version priority selection."""
 
     def setUp(self):
-        setup_lv_tests(self)
+        """Create required objects."""
+        # create layer source
+        self.lsrc = LayerSource.objects.create(name="dummy-layersource",
+                                               sourcetype=LayerSource.TYPE_LOCAL)
+        # create release
+        bbv = BitbakeVersion.objects.create(\
+                  name="master", giturl="git://git.openembedded.org/bitbake")
+        self.release = Release.objects.create(name="default-release",
+                                              bitbake_version=bbv,
+                                              branch_name="master")
+        # attach layer source to release
+        ReleaseLayerSourcePriority.objects.create(\
+            release=self.release, layer_source=self.lsrc, priority=1)
+
+        # create a layer version for the layer on the specified branch
+        self.layer = Layer.objects.create(name="meta-testlayer",
+                                          layer_source=self.lsrc)
+        self.branch = Branch.objects.create(name="master", layer_source=self.lsrc)
+        self.lver = Layer_Version.objects.create(\
+            layer=self.layer, layer_source=self.lsrc, up_branch=self.branch)
+
+        # create project and project layer
+        self.project = Project.objects.create_project(name="test-project",
+                                                      release=self.release)
+        ProjectLayer.objects.create(project=self.project,
+                                    layercommit=self.lver)
+
         # create spoof layer that should not appear in the search results
         layer = Layer.objects.create(name="meta-notvalid",
                                      layer_source=self.lsrc)
-- 
2.1.4


