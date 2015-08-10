Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
	[209.85.212.175])
	by mail.openembedded.org (Postfix) with ESMTP id E9B3A7688C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 11:21:44 +0000 (UTC)
Received: by wicja10 with SMTP id ja10so20955444wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 04:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=RQzkr0zVu3HgYgAoji6R2n6ktlgWJ7rdwTTU/upn1So=;
	b=Vq3ajKjMzt0lf0YSRqMsugtqSdFK44PlC/xhY7QjseTG0hBUFomZCs5ogXBwm7QM2B
	sPo4fSF/6pfrL3HvWiWPP+uhoxTa0HtGLGkHO9I5TZY0yBJJWt8yJLQnKk3xC0q8aUL0
	6vHap+APdRYlBFYHAxC9oYWmh2z/66qQDnEcgOMwmzvrFOJCZQEWfNTShQLMQ3YP1xXT
	abGc3YmqTV5NIsTnsktc7oEm9dfxY/kdxQWOlra+AiMOR+OCN/lu5pJOSjWVesjoHjRD
	duoDsnmg97Uj11gcwTQC55N6/QidRzXJblKLMXlVnNkdarioyR2ku5nFDaijr42oNd+k
	h4uA==
X-Gm-Message-State: ALoCoQl2ox4RtBCgrmpUYP13CDDERlV9pfWnhgk/ONyhQPy6P2YOZ7SSWAEYb8PPvP1ARdNR9Ict
X-Received: by 10.194.59.237 with SMTP id c13mr46170063wjr.24.1439205704598;
	Mon, 10 Aug 2015 04:21:44 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	c11sm13292834wib.1.2015.08.10.04.21.43
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 10 Aug 2015 04:21:44 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 10 Aug 2015 12:21:26 +0100
Message-Id: <cda5d183b67559b697287669dbe51b42253d349d.1439205232.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1e8409b1d3149ca2483e5581c5428e58b6fadefe.1439205232.git.michael.g.wood@intel.com>
References: <cover.1439205232.git.michael.g.wood@intel.com>
	<1e8409b1d3149ca2483e5581c5428e58b6fadefe.1439205232.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439205232.git.michael.g.wood@intel.com>
References: <cover.1439205232.git.michael.g.wood@intel.com>
Subject: [PATCH 03/11] toaster: rewrite test for LayerSource model
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
X-List-Received-Date: Mon, 10 Aug 2015 11:21:45 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Rewritten LayerSourceVerifyInheritanceSaveLoad class from scratch.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/tests.py | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/lib/toaster/orm/tests.py b/lib/toaster/orm/tests.py
index 8bb5dec..b0c01db 100644
--- a/lib/toaster/orm/tests.py
+++ b/lib/toaster/orm/tests.py
@@ -6,28 +6,34 @@ from orm.models import Project, Build, Layer, Layer_Version, Branch, ProjectLaye
 from orm.models import Release, ReleaseLayerSourcePriority, BitbakeVersion
 
 from django.utils import timezone
+from django.db import IntegrityError
 
 import os
 
 # set TTS_LAYER_INDEX to the base url to use a different instance of the layer index
 
-# tests to verify inheritance for the LayerSource proxy-inheritance classes
 class LayerSourceVerifyInheritanceSaveLoad(TestCase):
+    """
+    Tests to verify inheritance for the LayerSource proxy-inheritance classes.
+    """
     def test_object_creation(self):
-        lls = LayerSource.objects.create(name = "a1", sourcetype = LayerSource.TYPE_LOCAL, apiurl = "")
-        lils = LayerSource.objects.create(name = "a2", sourcetype = LayerSource.TYPE_LAYERINDEX, apiurl = "")
-        imls = LayerSource.objects.create(name = "a3", sourcetype = LayerSource.TYPE_IMPORTED, apiurl = "")
+        """Test LayerSource object creation."""
+        for name, sourcetype in [("a1", LayerSource.TYPE_LOCAL),
+                                 ("a2", LayerSource.TYPE_LAYERINDEX),
+                                 ("a3", LayerSource.TYPE_IMPORTED)]:
+            LayerSource.objects.create(name=name, sourcetype=sourcetype)
 
-        self.assertTrue(True in map(lambda x: isinstance(x, LocalLayerSource), LayerSource.objects.all()))
-        self.assertTrue(True in map(lambda x: isinstance(x, LayerIndexLayerSource), LayerSource.objects.all()))
-        self.assertTrue(True in map(lambda x: isinstance(x, ImportedLayerSource), LayerSource.objects.all()))
+        objects = LayerSource.objects.all()
+        self.assertTrue(isinstance(objects[0], LocalLayerSource))
+        self.assertTrue(isinstance(objects[1], LayerIndexLayerSource))
+        self.assertTrue(isinstance(objects[2], ImportedLayerSource))
 
     def test_duplicate_error(self):
-        def duplicate():
-            LayerSource.objects.create(name = "a1", sourcetype = LayerSource.TYPE_LOCAL, apiurl = "")
-            LayerSource.objects.create(name = "a1", sourcetype = LayerSource.TYPE_LOCAL, apiurl = "")
-
-        self.assertRaises(Exception, duplicate)
+        """Test creation of duplicate LayerSource objects."""
+        stype = LayerSource.TYPE_LOCAL
+        LayerSource.objects.create(name="a1", sourcetype=stype)
+        with self.assertRaises(IntegrityError):
+            LayerSource.objects.create(name="a1", sourcetype=stype)
 
 
 class LILSUpdateTestCase(TransactionTestCase):
-- 
2.1.4


