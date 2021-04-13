Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web12.81.1618326833832128070
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Apr 2021 08:13:55 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: siemens.com, ip: 194.138.37.39, mailfrom: henning.schild@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 13DFDpeq021685
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Apr 2021 17:13:51 +0200
Received: from localhost.localdomain ([167.87.48.83])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 13DF2rM4021528;
	Tue, 13 Apr 2021 17:02:54 +0200
From: henning.schild@siemens.com
To: bitbake-devel@lists.openembedded.org
Cc: isar-users@googlegroups.com,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        Cedric Hombourger <Cedric_Hombourger@mentor.com>,
        Chris Larson <Chris_Larson@mentor.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v2 3/3] tests/fetch: add tests for local and remote "noshared" git fetching
Date: Tue, 13 Apr 2021 17:02:51 +0200
Message-Id: <20210413150251.1969-3-henning.schild@siemens.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210413150251.1969-1-henning.schild@siemens.com>
References: <20210413150251.1969-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 lib/bb/tests/fetch.py | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 76797473db8a..74ba3fda65f5 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -706,6 +706,18 @@ class FetcherLocalTest(FetcherTest):
     def test_local_gitfetch_usehead_withname(self):
         self.dummyGitTest("usehead=1;name=newName")
 
+    def test_local_gitfetch_shared(self):
+        self.dummyGitTest("usehead=1;name=sharedName")
+        alt = os.path.join(self.unpackdir, 'git/.git/objects/info/alternates')
+        self.assertTrue(os.path.exists(alt))
+
+    def test_local_gitfetch_noshared(self):
+        self.d.setVar('BB_GIT_NOSHARED', '1')
+        self.unpackdir += '_noshared'
+        self.dummyGitTest("usehead=1;name=unsharedName")
+        alt = os.path.join(self.unpackdir, 'git/.git/objects/info/alternates')
+        self.assertFalse(os.path.exists(alt))
+
 class FetcherNoNetworkTest(FetcherTest):
     def setUp(self):
         super().setUp()
@@ -2615,3 +2627,29 @@ class NPMTest(FetcherTest):
         fetcher = bb.fetch.Fetch(['npmsw://' + swfile], self.d)
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
+
+class GitSharedTest(FetcherTest):
+    def setUp(self):
+        super(GitSharedTest, self).setUp()
+        self.recipe_url = "git://git.openembedded.org/bitbake"
+        self.d.setVar('SRCREV', '82ea737a0b42a8b53e11c9cde141e9e9c0bd8c40')
+
+    @skipIfNoNetwork()
+    def test_shared_unpack(self):
+        fetcher = bb.fetch.Fetch([self.recipe_url], self.d)
+
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+        alt = os.path.join(self.unpackdir, 'git/.git/objects/info/alternates')
+        self.assertTrue(os.path.exists(alt))
+
+    @skipIfNoNetwork()
+    def test_noshared_unpack(self):
+        self.d.setVar('BB_GIT_NOSHARED', '1')
+        self.unpackdir += '_noshared'
+        fetcher = bb.fetch.Fetch([self.recipe_url], self.d)
+
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+        alt = os.path.join(self.unpackdir, 'git/.git/objects/info/alternates')
+        self.assertFalse(os.path.exists(alt))
-- 
2.26.3

