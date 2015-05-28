Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
	[209.85.212.171])
	by mail.openembedded.org (Postfix) with ESMTP id 012417570F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 14:17:48 +0000 (UTC)
Received: by wizk4 with SMTP id k4so148681942wiz.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 07:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=ufUpa4d0gT2B7QLbvIrs/oJ0WSRt2ao8L83pYW4fCk4=;
	b=T0lCqYeY8SU0m6S1U3NR6j+UAKYeqlo35mg6OJU0PoTzTAcWhQK6nvj39jnsbpjGUm
	elarPuyoby6n7CjiRXwNvr4zTnMupAhMlzZkCjDXn/zKhfeW52Dv1t6A/8blACf5S8iM
	ksw/MzWGf27fS+85MUdOAA2RjXkPuxrGlaaONEesFYW2UYraQos7Ur0TU7bthRuX47BG
	7d/EMZi2j9VoGbWm1fnSZbw/peylo5rw/V+cQah57muoVYhQiVb2nA2nN/s+WhEJwVlJ
	82fXy3geXnuGqsNcFK4eQgAivV1vgCSYKSbXdpmpo/zlTXSMuc1tg95QqjiQsRTCycBP
	mGnQ==
X-Gm-Message-State: ALoCoQnyoQZaUM6AagpD7h9MYWmCUW2v3c1YUtIP6mtyiWm8OgymP6nT1qRKhFKDp4loekO/SVIC
X-Received: by 10.180.91.100 with SMTP id cd4mr61720502wib.57.1432822669791;
	Thu, 28 May 2015 07:17:49 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id g14sm3544617wjs.47.2015.05.28.07.17.48
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 May 2015 07:17:48 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id D38E85615AD; Thu, 28 May 2015 15:14:17 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 28 May 2015 15:14:12 +0100
Message-Id: <d2b9600d3bb26e36f23c132bb7006710813a831e.1432822343.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
References: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1432822343.git.alexandru.damian@intel.com>
References: <cover.1432822343.git.alexandru.damian@intel.com>
Subject: [PATCH 18/22] orm: Fix all failing unit test
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
X-List-Received-Date: Thu, 28 May 2015 14:17:49 -0000

From: Michael Wood <michael.g.wood@intel.com>

This fixes all the unit tests for the orm. Also added is the ability to
set a custom Layer index if you want to avoid using the public one by
specifying TTS_LAYER_INDEX

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/models.py |  5 ++++-
 lib/toaster/orm/tests.py  | 32 ++++++++++++++++++++------------
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 8a9a21e..198c6f5 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -782,8 +782,11 @@ class LayerIndexLayerSource(LayerSource):
             print "EE: could not connect to %s, skipping update: %s\n%s" % (self.apiurl, e, traceback.format_exc(e))
             return
 
-        # update branches; only those that we already have names listed in the Releases table
+        # update branches; only those that we already have names listed in the
+        # Releases table
         whitelist_branch_names = map(lambda x: x.branch_name, Release.objects.all())
+        if len(whitelist_branch_names) == 0:
+            raise Exception("Failed to make list of branches to fetch")
 
         print "Fetching branches"
         branches_info = _get_json_response(apilinks['branches']
diff --git a/lib/toaster/orm/tests.py b/lib/toaster/orm/tests.py
index 7b1b963..d4d97ee 100644
--- a/lib/toaster/orm/tests.py
+++ b/lib/toaster/orm/tests.py
@@ -1,4 +1,4 @@
-from django.test import TestCase
+from django.test import TestCase, TransactionTestCase
 from orm.models import LocalLayerSource, LayerIndexLayerSource, ImportedLayerSource, LayerSource
 from orm.models import Branch
 
@@ -7,6 +7,10 @@ from orm.models import Release, ReleaseLayerSourcePriority, BitbakeVersion
 
 from django.utils import timezone
 
+import os
+
+# set TTS_LAYER_INDEX to the base url to use a different instance of the layer index
+
 # tests to verify inheritance for the LayerSource proxy-inheritance classes
 class LayerSourceVerifyInheritanceSaveLoad(TestCase):
     def test_object_creation(self):
@@ -29,17 +33,20 @@ class LayerSourceVerifyInheritanceSaveLoad(TestCase):
         self.assertRaises(Exception, duplicate)
 
 
-# test to verify the layer source update functionality for layerindex. edit to pass the URL to a layerindex application
-class LILSUpdateTestCase(TestCase):
-    def test_update(self):
-        lils = LayerSource.objects.create(name = "b1", sourcetype = LayerSource.TYPE_LAYERINDEX, apiurl = "http://adamian-desk.local:8080/layerindex/api/")
-        lils.update()
+class LILSUpdateTestCase(TransactionTestCase):
+    def setUp(self):
+        # create release
+        bbv = BitbakeVersion.objects.create(name="master", giturl="git://git.openembedded.org/bitbake")
+        release = Release.objects.create(name="default-release", bitbake_version = bbv, branch_name = "master")
 
-        # run second update
-        # lils.update()
+    def test_update(self):
+        layer_index_url = os.getenv("TTS_LAYER_INDEX")
+        if layer_index_url == None:
+            print "Using layers.openembedded.org for layer index. override with TTS_LAYER_INDEX enviroment variable"
+            layer_index_url = "http://layers.openembedded.org/"
 
-        # print vars(lils)
-        #print map(lambda x: vars(x), Branch.objects.all())
+        lils = LayerSource.objects.create(name = "b1", sourcetype = LayerSource.TYPE_LAYERINDEX, apiurl = layer_index_url + "layerindex/api/")
+        lils.update()
 
         # run asserts
         self.assertTrue(lils.branch_set.all().count() > 0, "update() needs to fetch some branches")
@@ -59,6 +66,7 @@ class LayerVersionEquivalenceTestCase(TestCase):
         # attach layer source to release
         ReleaseLayerSourcePriority.objects.create(release = release, layer_source = ls, priority = 1)
 
+
         # create layer attach
         self.layer = Layer.objects.create(name="meta-testlayer", layer_source = ls)
         # create branch
@@ -84,7 +92,7 @@ class LayerVersionEquivalenceTestCase(TestCase):
 
     def test_dual_layersource(self):
         # if we have two layers with the same name, from different layer sources, we expect both layers in, in increasing priority of the layer source
-        ls2 = LayerSource.objects.create(name = "dummy-layersource2", sourcetype = LayerSource.TYPE_LOCAL)
+        ls2 = LayerSource.objects.create(name = "dummy-layersource2", sourcetype = LayerSource.TYPE_LOCAL, apiurl="test")
 
         # assign a lower priority for the second layer source
         Release.objects.get(name="default-release").releaselayersourcepriority_set.create(layer_source = ls2, priority = 2)
@@ -149,7 +157,7 @@ class ProjectLVSelectionTestCase(TestCase):
 
     def test_dual_layersource(self):
          # if we have two layers with the same name, from different layer sources, we expect both layers in, in increasing priority of the layer source
-        ls2 = LayerSource.objects.create(name = "dummy-layersource2", sourcetype = LayerSource.TYPE_LOCAL)
+        ls2 = LayerSource.objects.create(name = "dummy-layersource2", sourcetype = LayerSource.TYPE_LOCAL, apiurl="testing")
 
         # assign a lower priority for the second layer source
         Release.objects.get(name="default-release").releaselayersourcepriority_set.create(layer_source = ls2, priority = 2)
-- 
1.9.1


