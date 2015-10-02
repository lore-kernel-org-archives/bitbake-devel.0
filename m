Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
	[209.85.220.52])
	by mail.openembedded.org (Postfix) with ESMTP id CFD9360125
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Oct 2015 18:03:37 +0000 (UTC)
Received: by padhy16 with SMTP id hy16so112576723pad.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Oct 2015 11:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=s39O9f9Vmxl8fquHqsH3y9dZBF8CwFNF5APBKrlL/b8=;
	b=TNDEMjiEO5UcgOS3/5V9h7BLadgCS4mUnFacAVu3zA2KuEZYP0boK9a45LaQo4SQt0
	sKcGLkCRCZ9sPkcV7SqH6441HLbE/tcw3J64bdyo6G85dWsmXVXbUgngAPYeRIXHtavh
	1lwGnVeZFHSWpD/Wv0cz3jBw7Tc1/apJFBjVEN47XUaGv6UKbTsshfXxbbh1a8h2nu97
	xz5VFVlAzmO6pg2h42SQA8pNdPA3R0wP5GWGRO6F68f0+OJivCTw+ieJ572CSTPNQEdY
	AC3uUgxyUpfCVGUsHQ2d9uC8UV3/kAiQIAD7GB6Hb9M6nESe7sd4NOStyRRx9Sf6rWIW
	7Yjw==
X-Received: by 10.67.7.137 with SMTP id dc9mr21625041pad.116.1443809017618;
	Fri, 02 Oct 2015 11:03:37 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	kw10sm13142211pbc.25.2015.10.02.11.03.36
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 02 Oct 2015 11:03:36 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Oct 2015 11:05:16 -0700
Message-Id: <212282c8f34eb9b28b18d13811260a3f463e9ce6.1443809021.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f026371a5150719b58b806622ad111dd1567513f.1443809021.git.avery.brian@gmail.com>
References: <f026371a5150719b58b806622ad111dd1567513f.1443809021.git.avery.brian@gmail.com>
In-Reply-To: <cover.1443809021.git.avery.brian@gmail.com>
References: <cover.1443809021.git.avery.brian@gmail.com>
Subject: [PATCH 5/5] toaster: test get_alldeps API
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
X-List-Received-Date: Fri, 02 Oct 2015 18:03:38 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Added test case to test Layer_Version.get_alldeps API.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/orm/tests.py | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/orm/tests.py b/lib/toaster/orm/tests.py
index c30f99a..719266e 100644
--- a/lib/toaster/orm/tests.py
+++ b/lib/toaster/orm/tests.py
@@ -23,7 +23,7 @@
 
 from django.test import TestCase, TransactionTestCase
 from orm.models import LocalLayerSource, LayerIndexLayerSource, ImportedLayerSource, LayerSource
-from orm.models import Branch
+from orm.models import Branch, LayerVersionDependency
 
 from orm.models import Project, Layer, Layer_Version, Branch, ProjectLayer
 from orm.models import Release, ReleaseLayerSourcePriority, BitbakeVersion
@@ -160,3 +160,21 @@ class LayerVersionEquivalenceTestCase(TestCase):
         compat_lv = self.project.get_all_compatible_layer_versions()
         self.assertEqual(list(compat_lv), [self.lver, self.lver2])
 
+    def test_layerversion_get_alldeps(self):
+        """Test Layer_Version.get_alldeps API."""
+        lvers = {}
+        for i in range(10):
+            name = "layer%d" % i
+            lvers[name] = Layer_Version.objects.create(layer=Layer.objects.create(name=name),
+                                                       project=self.project)
+            if i:
+                LayerVersionDependency.objects.create(layer_version=lvers["layer%d" % (i - 1)],
+                                                      depends_on=lvers[name])
+                # Check dinamically added deps
+                self.assertEqual(lvers['layer0'].get_alldeps(self.project.id),
+                                 [lvers['layer%d' % n] for n in range(1, i+1)])
+
+        # Check chain of deps created in previous loop
+        for i in range(10):
+            self.assertEqual(lvers['layer%d' % i].get_alldeps(self.project.id),
+                             [lvers['layer%d' % n] for n in range(i+1, 10)])
-- 
1.9.1


