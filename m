Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
	[209.85.212.182])
	by mail.openembedded.org (Postfix) with ESMTP id 840ED76861
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 11:21:50 +0000 (UTC)
Received: by wijp15 with SMTP id p15so131344252wij.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 04:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=fbnlPm8YJmYcJRDJyuDa3sm36MUoAV8uEtojiXIrwEI=;
	b=XgP1GRDhvrV9g6dC5nK6icUiZgxS4vCw6n4X1HNVcQ8iHj2W713LL1LRouMut11r1k
	kMtVH5kGxsnhXbLv1sNRwVbrmM7zAwbGXDpb8MbEiTFY7iAt8imEot2KM2DEoZ1uBhwL
	yUl6yG5/H5edNKUfeFlaCsVbEOkls2nIzQXCWkRa84h/kHHFTGqdIj5STcXkwpUJVeXN
	h4y/J8RRUVdP7VhGQyOzy5GK5r2LnlFx4TdoIbrkpRW5Z7/9IrhQ5/Ed4bdjX3Vh2TL0
	ro9NC+Z6s6Zc3MSIEul8yYSVenah3QalGCUOeeh5HKyvXB6MApn7vIDolMa9wKbgRXIk
	YO7A==
X-Gm-Message-State: ALoCoQmuvrf/cg4dMN87Y5qVm92l7ANrgUUUWOt5SnGnXmHzgV0bPfB9uz/vHjTgeDg7wvoJ592B
X-Received: by 10.181.13.195 with SMTP id fa3mr23672898wid.7.1439205710648;
	Mon, 10 Aug 2015 04:21:50 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	c11sm13292834wib.1.2015.08.10.04.21.49
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 10 Aug 2015 04:21:50 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 10 Aug 2015 12:21:33 +0100
Message-Id: <10c10d593ad2e20584e3558c1fa08d750eab5184.1439205232.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1e8409b1d3149ca2483e5581c5428e58b6fadefe.1439205232.git.michael.g.wood@intel.com>
References: <cover.1439205232.git.michael.g.wood@intel.com>
	<1e8409b1d3149ca2483e5581c5428e58b6fadefe.1439205232.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439205232.git.michael.g.wood@intel.com>
References: <cover.1439205232.git.michael.g.wood@intel.com>
Subject: [PATCH 10/11] toaster: remove ProjectLVSelectionTestCase
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
X-List-Received-Date: Mon, 10 Aug 2015 11:21:50 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Moved code from ProjectLVSelectionTestCase.test_single_layersource to
LayerVersionEquivalenceTestCase.test_compatible_layerversions.

Removed ProjectLVSelectionTestCase.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/tests.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/lib/toaster/orm/tests.py b/lib/toaster/orm/tests.py
index 99f4fa0..5246909 100644
--- a/lib/toaster/orm/tests.py
+++ b/lib/toaster/orm/tests.py
@@ -118,8 +118,9 @@ class LayerVersionEquivalenceTestCase(TestCase):
         # create spoof layer that should not appear in the search results
         layer = Layer.objects.create(name="meta-notvalid",
                                      layer_source=self.lsrc)
-        Layer_Version.objects.create(layer=layer, layer_source=self.lsrc,
-                                     up_branch=self.branch)
+        self.lver2 = Layer_Version.objects.create(layer=layer,
+                                                  layer_source=self.lsrc,
+                                                  up_branch=self.branch)
 
     def test_single_layersource(self):
         """
@@ -179,12 +180,11 @@ class LayerVersionEquivalenceTestCase(TestCase):
 
         self.assertEqual(list(equivqs), list(bequivqs))
 
-class ProjectLVSelectionTestCase(TestCase):
-
-    def setUp(self):
-        setup_lv_tests(self)
-
-    def test_single_layersource(self):
+    def test_compatible_layerversions(self):
+        """
+        When we have a 2 layer versions, compatible_layerversions()
+        should return a queryset with both.
+        """
         compat_lv = self.project.compatible_layerversions()
-        self.assertEqual(list(compat_lv), [self.lver])
+        self.assertEqual(list(compat_lv), [self.lver, self.lver2])
 
-- 
2.1.4


