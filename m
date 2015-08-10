Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
	[209.85.212.181])
	by mail.openembedded.org (Postfix) with ESMTP id 4C5AB7646B
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 11:21:42 +0000 (UTC)
Received: by wibhh20 with SMTP id hh20so146007893wib.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 04:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=DQQY76djFWoAjCCeR1+XV+0w9rBX/MYDsIIbwlhNOzM=;
	b=hDA2Niqljza0B2tIKgRrZugkcJqU+P/AU7s2wzq00AM4Az3OWFCP0b+3uEGB5+yCW5
	rSgb2fHdN3nD/2LiWls+iO9XSoYhjyckl8zOFlhmnN8I1RXWZxJSjcYpmq4opJx8M0U1
	qM1W/Tg0TfT1YCNy3sAfAi0AHpHAIwIAy89/haYoXig069PgtNzwtTal4Ae1xq6Iq6WH
	8yWBDssPaSQBcFWGol0WAWBD9oru1ZyD8Sgv55Tw4bMX2fnLHnTWp6TYHcgFFvW/ofDW
	PrjWSPW4+JtbhsT39YD8QeeV0UPvW8HWfqG1iGY3jR3RgUFljIxpf1zC5LQ7KIAycOp8
	K1rw==
X-Gm-Message-State: ALoCoQnvy9OLAkF4WktRKfv/KaC53xXcMnUpBSsf32j+yDqeXYJWyj7m2KDa9Mi4AixiMo8mx9H6
X-Received: by 10.194.59.100 with SMTP id y4mr21114048wjq.151.1439205702854;
	Mon, 10 Aug 2015 04:21:42 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	c11sm13292834wib.1.2015.08.10.04.21.41
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 10 Aug 2015 04:21:42 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 10 Aug 2015 12:21:24 +0100
Message-Id: <1e8409b1d3149ca2483e5581c5428e58b6fadefe.1439205232.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1439205232.git.michael.g.wood@intel.com>
References: <cover.1439205232.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439205232.git.michael.g.wood@intel.com>
References: <cover.1439205232.git.michael.g.wood@intel.com>
Subject: [PATCH 01/11] toaster: remove prints from the test code
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
X-List-Received-Date: Mon, 10 Aug 2015 11:21:43 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Removed prints as they make test output harder to understand.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/tests.py | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/toaster/orm/tests.py b/lib/toaster/orm/tests.py
index d4d97ee..df9a2a9 100644
--- a/lib/toaster/orm/tests.py
+++ b/lib/toaster/orm/tests.py
@@ -18,9 +18,6 @@ class LayerSourceVerifyInheritanceSaveLoad(TestCase):
         lils = LayerSource.objects.create(name = "a2", sourcetype = LayerSource.TYPE_LAYERINDEX, apiurl = "")
         imls = LayerSource.objects.create(name = "a3", sourcetype = LayerSource.TYPE_IMPORTED, apiurl = "")
 
-        import pprint
-        pprint.pprint([(x.__class__,vars(x)) for x in LayerSource.objects.all()])
-
         self.assertTrue(True in map(lambda x: isinstance(x, LocalLayerSource), LayerSource.objects.all()))
         self.assertTrue(True in map(lambda x: isinstance(x, LayerIndexLayerSource), LayerSource.objects.all()))
         self.assertTrue(True in map(lambda x: isinstance(x, ImportedLayerSource), LayerSource.objects.all()))
@@ -42,7 +39,6 @@ class LILSUpdateTestCase(TransactionTestCase):
     def test_update(self):
         layer_index_url = os.getenv("TTS_LAYER_INDEX")
         if layer_index_url == None:
-            print "Using layers.openembedded.org for layer index. override with TTS_LAYER_INDEX enviroment variable"
             layer_index_url = "http://layers.openembedded.org/"
 
         lils = LayerSource.objects.create(name = "b1", sourcetype = LayerSource.TYPE_LAYERINDEX, apiurl = layer_index_url + "layerindex/api/")
-- 
2.1.4


