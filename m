Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
	[209.85.212.174])
	by mail.openembedded.org (Postfix) with ESMTP id 1525D6E5D0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 17:27:23 +0000 (UTC)
Received: by wicja10 with SMTP id ja10so45690641wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 10:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=CGzSTjKeqThWi2iDxu8or/SvI9uwDavxlNnvG9v4Ab8=;
	b=jaeJpkLfgBQiDghgdenM0cijVjWbkGTuyhrYgOyR5fQhDmffdDcU7JFG4/TALlaKrx
	alWNSP2+vEuTou1uIZc5kwSoczX0A/WRncaz9IuSHqnDaBC+Ml3UuGFSj+T5Jn3v1RKJ
	Us49txh7sVqxoqyvAFIhKLCc7VTEPpQKvdexonqT0qEB9P6/+iLW5wzZKk198ACk0bbB
	dYx5jLukAad+b5nGIs6ekhBvuz/ZGRHnareJ4z2jrEoD1OCS/LVbd/STsxG04zX74Jef
	JePzjyIr/W+g/9qcZHW3SZ3KX9r0Pg+0PqqRqa5ZMT5sNjhC4UfXQj63+oVj3glPU2BP
	b/Ig==
X-Gm-Message-State: ALoCoQmOCN4KV2/gIlSoTdEREaq8THsOQMM/hMH2t+0hOllRi3pT6MOLILe09fZGq2FDMEyXsy2y
X-Received: by 10.180.96.34 with SMTP id dp2mr21521798wib.57.1439227643144;
	Mon, 10 Aug 2015 10:27:23 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	cw8sm30396731wjb.49.2015.08.10.10.27.22
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 10 Aug 2015 10:27:22 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 10 Aug 2015 18:27:08 +0100
Message-Id: <dd3a557b5759abe26b64c22379333c25d83b8708.1439226591.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1439226591.git.michael.g.wood@intel.com>
References: <cover.1439226591.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439226591.git.michael.g.wood@intel.com>
References: <cover.1439226591.git.michael.g.wood@intel.com>
Subject: [PATCH 01/11] toaster: fix test_get_json_call_returns_json test
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
X-List-Received-Date: Mon, 10 Aug 2015 17:27:24 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

This test case used wrong field name.
Fixed by renaming field 'lists' -> 'rows'.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/tests.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 8a59af4..39586e0 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -34,13 +34,13 @@ class AllProjectsViewTestCase(ProvisionedProjectTestCase):
 
         self.assertTrue("error" in data)
         self.assertEqual(data["error"], "ok")
-        self.assertTrue("list" in data)
+        self.assertTrue("rows" in data)
 
-        self.assertTrue(AllProjectsViewTestCase.TEST_PROJECT_NAME in map(lambda x: x["name"], data["list"]))
-        self.assertTrue("id" in data["list"][0])
-        self.assertTrue("projectLayersUrl" in data["list"][0])
-        self.assertTrue("projectPageUrl" in data["list"][0])
-        self.assertTrue("projectBuildsUrl" in data["list"][0])
+        self.assertTrue(AllProjectsViewTestCase.TEST_PROJECT_NAME in map(lambda x: x["name"], data["rows"]))
+        self.assertTrue("id" in data["rows"][0])
+        self.assertTrue("projectLayersUrl" in data["rows"][0])
+        self.assertTrue("projectPageUrl" in data["rows"][0])
+        self.assertTrue("projectBuildsUrl" in data["rows"][0])
 
 class ProvisionedLayersProjectTestCase(ProvisionedProjectTestCase):
     LAYER_NAME = "base-layer"
-- 
2.1.4


