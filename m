Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
	[209.85.220.54])
	by mail.openembedded.org (Postfix) with ESMTP id 3296C770D7
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Oct 2015 18:03:36 +0000 (UTC)
Received: by padhy16 with SMTP id hy16so112576413pad.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Oct 2015 11:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=rAdHRsXcfHy/+hjAfScMeWrGp5NPJzUQ6VNz17O4gXk=;
	b=sRRLTQkhU2YGHmZyHcAkW6szYR+4k5BfUok3qMymPO28s2Wh7bD0zUcwvZJv4FboJ6
	R4dhjE10SXF0qQUgu0f1NA4meGhXdQFz2cjlNuKjFY7gXP0tLqCu9PVR5NA7IJ/AA1Rg
	/8tKBN4nKm3nyJK24FQRX5olTNQKd1hD8bmLpNOqYhB+3t/6wcT4YBBHgF53NfIV2E9y
	3CrUrBG1R8p8Pg8UoNshZfWvSfgdL7bDGyEVpcGLNDIz0xkIWAlof289DLZ2Q9Hwz19Y
	mNk40w4t717VAC/3A66xCRjLIvLe59DR7M7VFyMER1A/4s0GjbebEVU73L5a6HgByhHv
	x7Ew==
X-Received: by 10.66.145.193 with SMTP id sw1mr21668635pab.74.1443809016673;
	Fri, 02 Oct 2015 11:03:36 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	kw10sm13142211pbc.25.2015.10.02.11.03.35
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 02 Oct 2015 11:03:35 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Oct 2015 11:05:15 -0700
Message-Id: <073743c7c26cccddf5ed626c317a59abb57eb08d.1443809021.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f026371a5150719b58b806622ad111dd1567513f.1443809021.git.avery.brian@gmail.com>
References: <f026371a5150719b58b806622ad111dd1567513f.1443809021.git.avery.brian@gmail.com>
In-Reply-To: <cover.1443809021.git.avery.brian@gmail.com>
References: <cover.1443809021.git.avery.brian@gmail.com>
Subject: [PATCH 4/5] toaster: fix orm tests
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
X-List-Received-Date: Fri, 02 Oct 2015 18:03:36 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Cleaned up and fixed orm tests. Removed test_build_layerversion as
it's not needed due to changed compatible_layer_versions API.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/orm/tests.py | 33 ++++-----------------------------
 1 file changed, 4 insertions(+), 29 deletions(-)

diff --git a/lib/toaster/orm/tests.py b/lib/toaster/orm/tests.py
index 783aea8..c30f99a 100644
--- a/lib/toaster/orm/tests.py
+++ b/lib/toaster/orm/tests.py
@@ -25,10 +25,9 @@ from django.test import TestCase, TransactionTestCase
 from orm.models import LocalLayerSource, LayerIndexLayerSource, ImportedLayerSource, LayerSource
 from orm.models import Branch
 
-from orm.models import Project, Build, Layer, Layer_Version, Branch, ProjectLayer
+from orm.models import Project, Layer, Layer_Version, Branch, ProjectLayer
 from orm.models import Release, ReleaseLayerSourcePriority, BitbakeVersion
 
-from django.utils import timezone
 from django.db import IntegrityError
 
 import os
@@ -153,35 +152,11 @@ class LayerVersionEquivalenceTestCase(TestCase):
         equivqs = self.lver.get_equivalents_wpriority(self.project)
         self.assertEqual(list(equivqs), [lver2, self.lver])
 
-    def test_build_layerversion(self):
+    def test_compatible_layer_versions(self):
         """
-        Any layer version coming from the build should show up
-        before any layer version coming from upstream
-        """
-        build = Build.objects.create(project=self.project,
-                                     started_on=timezone.now(),
-                                     completed_on=timezone.now())
-        lvb = Layer_Version.objects.create(layer=self.layer, build=build,
-                                           commit="deadbeef")
-
-        # a build layerversion must be in the equivalence
-        # list for the original layerversion
-        equivqs = self.lver.get_equivalents_wpriority(self.project)
-        self.assertTrue(len(equivqs) == 2)
-        self.assertTrue(equivqs[0] == self.lver)
-        self.assertTrue(equivqs[1] == lvb)
-
-        # getting the build layerversion equivalent list must
-        # return the same list as the original layer
-        bequivqs = lvb.get_equivalents_wpriority(self.project)
-
-        self.assertEqual(list(equivqs), list(bequivqs))
-
-    def test_compatible_layerversions(self):
-        """
-        When we have a 2 layer versions, compatible_layerversions()
+        When we have a 2 layer versions, get_all_compatible_layerversions()
         should return a queryset with both.
         """
-        compat_lv = self.project.compatible_layerversions()
+        compat_lv = self.project.get_all_compatible_layer_versions()
         self.assertEqual(list(compat_lv), [self.lver, self.lver2])
 
-- 
1.9.1


