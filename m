Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
	[209.85.212.169])
	by mail.openembedded.org (Postfix) with ESMTP id D35777687E
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 11:21:45 +0000 (UTC)
Received: by wibhh20 with SMTP id hh20so146009395wib.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 04:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=ajE5owDFAY17gvJq2t16qNTkc0SWIM57EvXnhNy824o=;
	b=i7iotDLzGcqO4yLfDVFbt8gjEbKlltzQ7m4KM6+iGTKXVFT33qhjsHncDIzKCrQY2g
	uA27jF5LyurKlaFfO5qJopyMTwz0NciT5cYhINEiLWmaGxoD6geQjJrIE8D+unJXYP1s
	FXuL7cQGQHIPj7YUgdfT2JNciTGJC+vJ7FNF/nlnbHO2V8pWX3gUJdQW0jgzqh0FUsm6
	JL194n34Khn/+o+w8eTpcwVCRD2EQ0sMVKlRrPM/WT1de7/Qbb9Z4OI4GUBW3XhXlsgk
	veC8fmYySi8n/Agi3f3zVIv4zB2KqAITa/nD3UtAYnwGPca8RAdnztYxsyk97juyj6EY
	pcxQ==
X-Gm-Message-State: ALoCoQlQtjLmBLDF7P5tqHeaEWXe+hPZlb/X3uZOOBXKzidZ/8ifq1AOcHdeW87h3oWvg26ZwTAV
X-Received: by 10.194.238.168 with SMTP id vl8mr44646714wjc.128.1439205705466; 
	Mon, 10 Aug 2015 04:21:45 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	c11sm13292834wib.1.2015.08.10.04.21.44
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 10 Aug 2015 04:21:44 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 10 Aug 2015 12:21:27 +0100
Message-Id: <82337d0e94dfb61959de93f5559d9eabe6b60277.1439205232.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1e8409b1d3149ca2483e5581c5428e58b6fadefe.1439205232.git.michael.g.wood@intel.com>
References: <cover.1439205232.git.michael.g.wood@intel.com>
	<1e8409b1d3149ca2483e5581c5428e58b6fadefe.1439205232.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439205232.git.michael.g.wood@intel.com>
References: <cover.1439205232.git.michael.g.wood@intel.com>
Subject: [PATCH 04/11] toaster: rewrite LILSUpdateTestCase
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
X-List-Received-Date: Mon, 10 Aug 2015 11:21:46 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Reformatted code. Added docstings.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/tests.py | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/lib/toaster/orm/tests.py b/lib/toaster/orm/tests.py
index b0c01db..3384f01 100644
--- a/lib/toaster/orm/tests.py
+++ b/lib/toaster/orm/tests.py
@@ -37,22 +37,26 @@ class LayerSourceVerifyInheritanceSaveLoad(TestCase):
 
 
 class LILSUpdateTestCase(TransactionTestCase):
+    """Test Layer Source update."""
+
     def setUp(self):
-        # create release
-        bbv = BitbakeVersion.objects.create(name="master", giturl="git://git.openembedded.org/bitbake")
-        release = Release.objects.create(name="default-release", bitbake_version = bbv, branch_name = "master")
+        """Create release."""
+        bbv = BitbakeVersion.objects.create(\
+                  name="master", giturl="git://git.openembedded.org/bitbake")
+        Release.objects.create(name="default-release", bitbake_version=bbv,
+                               branch_name="master")
 
     def test_update(self):
-        layer_index_url = os.getenv("TTS_LAYER_INDEX")
-        if layer_index_url == None:
-            layer_index_url = "http://layers.openembedded.org/"
-
-        lils = LayerSource.objects.create(name = "b1", sourcetype = LayerSource.TYPE_LAYERINDEX, apiurl = layer_index_url + "layerindex/api/")
-        lils.update()
-
-        # run asserts
-        self.assertTrue(lils.branch_set.all().count() > 0, "update() needs to fetch some branches")
-
+        """Check if LayerSource.update can fetch branches."""
+        url = os.getenv("TTS_LAYER_INDEX",
+                        default="http://layers.openembedded.org/")
+
+        lsobj = LayerSource.objects.create(\
+                    name="b1", sourcetype=LayerSource.TYPE_LAYERINDEX,
+                    apiurl=url + "layerindex/api/")
+        lsobj.update()
+        self.assertTrue(lsobj.branch_set.all().count() > 0,
+                        "no branches fetched")
 
 
 # tests to verify layer_version priority selection
-- 
2.1.4


