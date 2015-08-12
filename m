Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
	[209.85.212.170])
	by mail.openembedded.org (Postfix) with ESMTP id F2A5E766E8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Aug 2015 11:15:25 +0000 (UTC)
Received: by wicja10 with SMTP id ja10so23031056wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Aug 2015 04:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=7nvl4ncP9RPedJdne1eEJ2VRfvskgbJqVBt54IsCy0k=;
	b=Y94a62sAOpR5EdIjRA7j3irc7r3njEk6nLFv2Em5VrimzI52KKVUnO8O7ZJA/FC8ai
	ncCHwsFA+hrnAAj6Vr4Dlrn6NHCpaaxHjYgLCp1NQGoe7HL+hRXuhl94KbNm5X8+7GcB
	O1s6d0TsyCKYuVhuKJFikM6XRg3WY9GLMjYBZ2E0d470ggdQAvgGkUQAaRnoJub4Vphf
	4QiVA217yPWBKC/HNss3OBcd3YNadOIgDA8qzoWuKjRTq7ihmKyMjSRWOZT2Prq+liHI
	4GiyoGxvLO2MnBAM01Mv199V7xiah5f7bBqNKvenRFtb92cEz1if/kYCRr3NDdBByQp4
	hp8w==
X-Gm-Message-State: ALoCoQk7UocJCaCdjYhMFy6kN+GNjfyHd7HEDVMZonMcgY55Xa2qvYJNuRuTLMEyj7h5gmHrEtBR
X-Received: by 10.194.59.237 with SMTP id c13mr71415812wjr.24.1439378123973;
	Wed, 12 Aug 2015 04:15:23 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id
	by17sm23354229wib.18.2015.08.12.04.15.22
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 12 Aug 2015 04:15:23 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 12 Aug 2015 12:15:11 +0100
Message-Id: <1439378111-7973-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
Cc: Sujith Haridasan <Sujith_Haridasan@mentor.com>
Subject: [PATCH] toastergui: Add tests for xhr_importlayer
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
X-List-Received-Date: Wed, 12 Aug 2015 11:15:27 -0000

From: Sujith H <sujith.h@gmail.com>

Inorder to make sure if layer name which we import is already
available in toaster database, a test case has been included.
This would help user to identify if layer name which has been
provided in the import layer web page already exists or not.

Signed-off-by: Sujith Haridasan <sujith.h@gmail.com>
Signed-off-by: Sujith Haridasan <Sujith_Haridasan@mentor.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/tests.py | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 93a85ac..85e27fe 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -148,3 +148,33 @@ class ViewTests(TestCase):
             # After "typeing" the alpabet we should have result true
             # from each of the urls
             self.assertTrue(results)
+
+    def test_xhr_import_layer(self):
+        """Test xhr_importlayer API"""
+        #Test for importing an already existing layer
+        args = {'vcs_url' : "git://git.example.com/test",
+                'name' : "base-layer",
+                'git_ref': "c12b9596afd236116b25ce26dbe0d793de9dc7ce",
+                'project_id': 1, 'dir_path' : "/path/in/repository"}
+        response = self.client.post(reverse('xhr_importlayer'), args)
+        data = json.loads(response.content)
+        self.assertEqual(response.status_code, 200)
+        self.assertNotEqual(data["error"], "ok")
+
+        #Test to verify import of a layer successful
+        args['name'] = "meta-oe"
+        response = self.client.post(reverse('xhr_importlayer'), args)
+        data = json.loads(response.content)
+        self.assertTrue(data["error"], "ok")
+
+        #Test for html tag in the data
+        args['<'] = "testing html tag"
+        response = self.client.post(reverse('xhr_importlayer'), args)
+        data = json.loads(response.content)
+        self.assertNotEqual(data["error"], "ok")
+
+        #Empty data passed
+        args = {}
+        response = self.client.post(reverse('xhr_importlayer'), args)
+        data = json.loads(response.content)
+        self.assertNotEqual(data["error"], "ok")
-- 
2.1.4


