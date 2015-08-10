Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
	[209.85.212.182])
	by mail.openembedded.org (Postfix) with ESMTP id 9A6017688B
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 11:21:48 +0000 (UTC)
Received: by wicja10 with SMTP id ja10so20957362wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 04:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=By9JKzxIF4Z/mMRNFpL2TbDtnqgxPkM4ymIHIJzlRQw=;
	b=eqH7XDiPtz47ojUE959qYfLvFtz4zMDCS4SYboxZjC6y1HIQxt+yXJtom2atehLPtm
	+csTc9nCNQiwAGFizMUnn/TGtMPy0CRzJpJDuZR0mfnP0u8/XCVTlVuudpLSHnc7JRPe
	jbdQ+jrwB2AMVD/dljkM8XOfnL/zzdJCLEvfQ9B2ChJl52j4pBbNfP0XIiWxOofs3H0G
	9xorSQeSj8SFP+hYouleL/EMMaEBxuyHqGUFvtw1OhnMpq4ZNiTbZH11PKE1gkr68hm5
	f3nJp4wAp8XpAWtzjipnO8Cn1o6jPrGdrk242SHxfBNw7dJMhKcs8JdZGshikTJlMNWH
	ywdA==
X-Gm-Message-State: ALoCoQkYQc/JcWBkmKHP1tJjgXQSzxaU9hgni+6lyKCp5JcJBSE1cUUM02oadZA+zTsf6H8kIjbm
X-Received: by 10.194.89.5 with SMTP id bk5mr44684562wjb.144.1439205708236;
	Mon, 10 Aug 2015 04:21:48 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	c11sm13292834wib.1.2015.08.10.04.21.47
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 10 Aug 2015 04:21:47 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 10 Aug 2015 12:21:30 +0100
Message-Id: <2524ab1a33daa591eaaeb345bf0cb477811f969e.1439205232.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1e8409b1d3149ca2483e5581c5428e58b6fadefe.1439205232.git.michael.g.wood@intel.com>
References: <cover.1439205232.git.michael.g.wood@intel.com>
	<1e8409b1d3149ca2483e5581c5428e58b6fadefe.1439205232.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439205232.git.michael.g.wood@intel.com>
References: <cover.1439205232.git.michael.g.wood@intel.com>
Subject: [PATCH 07/11] toaster: remove duplicated code
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
X-List-Received-Date: Mon, 10 Aug 2015 11:21:49 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Removed test_dual_layersource method from ProjectLVSelectionTestCase
as identical method presents in LayerVersionEquivalenceTestCase.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/tests.py | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/lib/toaster/orm/tests.py b/lib/toaster/orm/tests.py
index 168bafa..6837038 100644
--- a/lib/toaster/orm/tests.py
+++ b/lib/toaster/orm/tests.py
@@ -166,20 +166,3 @@ class ProjectLVSelectionTestCase(TestCase):
         self.assertTrue(len(compatible_layerversions) == 1)
         self.assertTrue(compatible_layerversions[0] == self.lver)
 
-
-    def test_dual_layersource(self):
-         # if we have two layers with the same name, from different layer sources, we expect both layers in, in increasing priority of the layer source
-        ls2 = LayerSource.objects.create(name = "dummy-layersource2", sourcetype = LayerSource.TYPE_LOCAL, apiurl="testing")
-
-        # assign a lower priority for the second layer source
-        Release.objects.get(name="default-release").releaselayersourcepriority_set.create(layer_source = ls2, priority = 2)
-
-        # create a new layer_version for a layer with the same name coming from the second layer source
-        self.layer2 = Layer.objects.create(name="meta-testlayer", layer_source = ls2)
-        self.layerversion2 = Layer_Version.objects.create(layer = self.layer2, layer_source = ls2, up_branch = self.branch)
-
-         # expect two layer versions, in the priority order
-        equivalent_list = self.project.compatible_layerversions()
-        self.assertTrue(len(equivalent_list) == 2)
-        self.assertTrue(equivalent_list[0] == self.layerversion2)
-        self.assertTrue(equivalent_list[1] == self.lver)
-- 
2.1.4


