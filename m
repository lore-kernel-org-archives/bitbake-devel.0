Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
	[209.85.212.170])
	by mail.openembedded.org (Postfix) with ESMTP id DB46A768C8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 17:27:32 +0000 (UTC)
Received: by wicne3 with SMTP id ne3so144914467wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 10:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=KFGCSCYzEMGbQag+72WjqJdQAGjz7V4FQNWl2Wlh0yY=;
	b=JnZVvBX1O4v1a649hVw/kVj0eeayag4wyAsvPZ6wVObyvYKwK78ycmvWqtqn+IBFav
	f0h83lJ/SOMWXFzX3k1lDjMaLGpm+LFUQnXnpDyCWe7SUxAnkp5G24Nv5HotnKlhkAOD
	g5BjGLI/k6t5FtRahcahytdGNafknB8Gp81mlMBNGfJTrv/HDsoSouqxE90NIvUhAZ4T
	vkp9zZ9Mi+f8eOhdhvW14ZcbXvXfQwCz02apomnCVu5v9P8W6t31ms1Y2mDY4DXoa6f3
	4TO3LbysYU2lysSOjStVbHXYMTQCVXiSgU3hib7Vxxdh723ufqkLx6Z8lotseW6/+6m7
	06aQ==
X-Gm-Message-State: ALoCoQnY2ktHc28hNCMgIOK5vZT0s1Akl9s3YbmgXIqID5ZL4yh94I7KiPPWRu0SVqDt3fzU78/G
X-Received: by 10.194.23.36 with SMTP id j4mr45867146wjf.105.1439227652393;
	Mon, 10 Aug 2015 10:27:32 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	cw8sm30396731wjb.49.2015.08.10.10.27.31
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 10 Aug 2015 10:27:31 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 10 Aug 2015 18:27:18 +0100
Message-Id: <c9274dff8d66225fcc5a371357309ce0427f4db6.1439226591.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <dd3a557b5759abe26b64c22379333c25d83b8708.1439226591.git.michael.g.wood@intel.com>
References: <cover.1439226591.git.michael.g.wood@intel.com>
	<dd3a557b5759abe26b64c22379333c25d83b8708.1439226591.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439226591.git.michael.g.wood@intel.com>
References: <cover.1439226591.git.michael.g.wood@intel.com>
Subject: [PATCH 11/11] toaster: reduced amount of instance attributes
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
X-List-Received-Date: Mon, 10 Aug 2015 17:27:33 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Used local variables instead of instance attributes in ViewTests.setUp

Fixed pylint warning:
    Too many instance attributes (9/7) (too-many-instance-attributes)

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/tests.py | 55 ++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 31 deletions(-)

diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index bc10801..93a85ac 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -34,38 +34,31 @@ class ViewTests(TestCase):
     """Tests to verify view APIs."""
 
     def setUp(self):
-        self.bbv = BitbakeVersion.objects.create(\
-                       name="test bbv", giturl="/tmp/",
-                       branch="master", dirpath="")
-        self.release = Release.objects.create(\
-                           name="test release", bitbake_version=self.bbv)
+        bbv = BitbakeVersion.objects.create(name="test bbv", giturl="/tmp/",
+                                            branch="master", dirpath="")
+        release = Release.objects.create(name="test release",
+                                         bitbake_version=bbv)
         self.project = Project.objects.create_project(name=PROJECT_NAME,
-                                                      release=self.release)
-        self.layersrc = LayerSource.objects.create(\
-                               sourcetype=LayerSource.TYPE_IMPORTED)
-        self.priority = ReleaseLayerSourcePriority.objects.create(\
-                               release=self.release,
-                               layer_source=self.layersrc)
-        self.layer = Layer.objects.create(\
-                         name="base-layer",
-                         layer_source=self.layersrc, vcs_url="/tmp/")
-        self.lver = Layer_Version.objects.create(\
-                        layer=self.layer, project=self.project,
-                        layer_source=self.layersrc, commit="master")
-
-        self.recipe = Recipe.objects.create(\
-                          layer_source=self.layersrc, name="base-recipe",
-                          version="1.2", summary="one recipe",
-                          description="recipe", layer_version=self.lver)
-
-        self.machine = Machine.objects.create(\
-                          layer_version=self.lver, name="wisk",
-                          description="wisking machine")
-
-        ProjectLayer.objects.create(project=self.project,
-                                    layercommit=self.lver)
-
-        self.assertTrue(self.lver in self.project.compatible_layerversions())
+                                                      release=release)
+        layersrc = LayerSource.objects.create(sourcetype=LayerSource.TYPE_IMPORTED)
+        self.priority = ReleaseLayerSourcePriority.objects.create(release=release,
+                                                                  layer_source=layersrc)
+        layer = Layer.objects.create(name="base-layer", layer_source=layersrc,
+                                     vcs_url="/tmp/")
+
+        lver = Layer_Version.objects.create(layer=layer, project=self.project,
+                                            layer_source=layersrc, commit="master")
+
+        Recipe.objects.create(layer_source=layersrc, name="base-recipe",
+                              version="1.2", summary="one recipe",
+                              description="recipe", layer_version=lver)
+
+        Machine.objects.create(layer_version=lver, name="wisk",
+                               description="wisking machine")
+
+        ProjectLayer.objects.create(project=self.project, layercommit=lver)
+
+        self.assertTrue(lver in self.project.compatible_layerversions())
 
     def test_get_base_call_returns_html(self):
         """Basic test for all-projects view"""
-- 
2.1.4


