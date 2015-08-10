Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by mail.openembedded.org (Postfix) with ESMTP id 70509768C9
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 17:27:30 +0000 (UTC)
Received: by wicja10 with SMTP id ja10so45694409wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 10:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=WlFQyzXUjwAPtVAK41QUluNROlmXtp5BV86w5mbiGmo=;
	b=HktzU6zDWShSGidgi9oVO4Itx56GszRh4RQb5CF+d8qrji4BOLjJ/nZoT0szaGDast
	ERydJaAD7XhqWe9MREgpbIXojV63DPzfWFX6rihu4rE52GdqrR98ZelFSIlQSqjX/6fH
	awBBwfvDNoOfnOtlq7RBoxU6WSGcncAxRcW3mLJHPNwfwEBxwm1zseWyN2R1hNtfrcOK
	COkPqth8V5ncxKoAvMFu40htKCQzUKVNYdneyE04vYoZajY3AvznDQnfBZ6Og3w8Dh6v
	Wxo9LKqEM1m6DW3M6NQloJIIGdhJYyMGh0m822wtskgvImRQvQ9e+G3XOlkd+LMXU8Xh
	FJtw==
X-Gm-Message-State: ALoCoQkmO4x7yZ3LCe1cJtill2nCZZXDTrpdEmUrRhTFeOiZMvvGVW+g4bZsmAb6/mdXy20knTmY
X-Received: by 10.180.75.78 with SMTP id a14mr26660406wiw.43.1439227650585;
	Mon, 10 Aug 2015 10:27:30 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	cw8sm30396731wjb.49.2015.08.10.10.27.29
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 10 Aug 2015 10:27:29 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 10 Aug 2015 18:27:16 +0100
Message-Id: <b600e83e0a7da0c10e6ed63a606ca34f35c41d5c.1439226591.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <dd3a557b5759abe26b64c22379333c25d83b8708.1439226591.git.michael.g.wood@intel.com>
References: <cover.1439226591.git.michael.g.wood@intel.com>
	<dd3a557b5759abe26b64c22379333c25d83b8708.1439226591.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439226591.git.michael.g.wood@intel.com>
References: <cover.1439226591.git.michael.g.wood@intel.com>
Subject: [PATCH 09/11] toaster: fix test_get_json_call_returns_json again
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
X-List-Received-Date: Mon, 10 Aug 2015 17:27:30 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Fixed this test case again after rebase. Improved it
to check for all returned keys. Previously it was checking
only 3 of them.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/tests.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 723348d..d155849 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -90,9 +90,13 @@ class ViewTests(TestCase):
 
         self.assertTrue(PROJECT_NAME in [x["name"] for x in data["rows"]])
         self.assertTrue("id" in data["rows"][0])
-        self.assertTrue("projectLayersUrl" in data["rows"][0])
-        self.assertTrue("projectPageUrl" in data["rows"][0])
-        self.assertTrue("projectBuildsUrl" in data["rows"][0])
+
+        self.assertEqual(sorted(data["rows"][0]),
+                         ['bitbake_version_id', 'created', 'id',
+                          'layersTypeAheadUrl', 'name', 'projectBuildsUrl',
+                          'projectPageUrl', 'recipesTypeAheadUrl',
+                          'release_id', 'short_description', 'updated',
+                          'user_id'])
 
     def test_typeaheads(self):
         """Test typeahead ReST API"""
-- 
2.1.4


