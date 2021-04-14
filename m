Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web10.9353.1618382621515583966
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Apr 2021 23:43:42 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: siemens.com, ip: 194.138.37.39, mailfrom: henning.schild@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 13E6hd7K020749
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Apr 2021 08:43:39 +0200
Received: from localhost.localdomain ([167.87.7.134])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 13E6WjJv020955;
	Wed, 14 Apr 2021 08:32:45 +0200
From: henning.schild@siemens.com
To: bitbake-devel@lists.openembedded.org
Cc: isar-users@googlegroups.com,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        Cedric Hombourger <Cedric_Hombourger@mentor.com>,
        Chris Larson <Chris_Larson@mentor.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v3 2/3] tests/fetch: deduplicate local git testing code
Date: Wed, 14 Apr 2021 08:32:40 +0200
Message-Id: <20210414063241.18528-2-henning.schild@siemens.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210414063241.18528-1-henning.schild@siemens.com>
References: <20210414063241.18528-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Purely cosmetic change that probably improves the code.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 lib/bb/tests/fetch.py | 34 ++++++----------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index b921a952e493..ab02bc74ac15 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -674,7 +674,7 @@ class FetcherLocalTest(FetcherTest):
         with self.assertRaises(bb.fetch2.UnpackError):
             self.fetchUnpack(['file://a;subdir=/bin/sh'])
 
-    def test_local_gitfetch_usehead(self):
+    def dummyGitTest(self, suffix):
         # Create dummy local Git repo
         src_dir = tempfile.mkdtemp(dir=self.tempdir,
                                    prefix='gitfetch_localusehead_')
@@ -693,7 +693,7 @@ class FetcherLocalTest(FetcherTest):
 
         # Fetch and check revision
         self.d.setVar("SRCREV", "AUTOINC")
-        url = "git://" + src_dir + ";protocol=file;usehead=1"
+        url = "git://" + src_dir + ";protocol=file;" + suffix
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
@@ -702,33 +702,11 @@ class FetcherLocalTest(FetcherTest):
         unpack_rev = stdout[0].strip()
         self.assertEqual(orig_rev, unpack_rev)
 
-    def test_local_gitfetch_usehead_withname(self):
-        # Create dummy local Git repo
-        src_dir = tempfile.mkdtemp(dir=self.tempdir,
-                                   prefix='gitfetch_localusehead_')
-        src_dir = os.path.abspath(src_dir)
-        bb.process.run("git init", cwd=src_dir)
-        bb.process.run("git config user.email 'you@example.com'", cwd=src_dir)
-        bb.process.run("git config user.name 'Your Name'", cwd=src_dir)
-        bb.process.run("git commit --allow-empty -m'Dummy commit'",
-                       cwd=src_dir)
-        # Use other branch than master
-        bb.process.run("git checkout -b my-devel", cwd=src_dir)
-        bb.process.run("git commit --allow-empty -m'Dummy commit 2'",
-                       cwd=src_dir)
-        stdout = bb.process.run("git rev-parse HEAD", cwd=src_dir)
-        orig_rev = stdout[0].strip()
+    def test_local_gitfetch_usehead(self):
+        self.dummyGitTest("usehead=1")
 
-        # Fetch and check revision
-        self.d.setVar("SRCREV", "AUTOINC")
-        url = "git://" + src_dir + ";protocol=file;usehead=1;name=newName"
-        fetcher = bb.fetch.Fetch([url], self.d)
-        fetcher.download()
-        fetcher.unpack(self.unpackdir)
-        stdout = bb.process.run("git rev-parse HEAD",
-                                cwd=os.path.join(self.unpackdir, 'git'))
-        unpack_rev = stdout[0].strip()
-        self.assertEqual(orig_rev, unpack_rev)
+    def test_local_gitfetch_usehead_withname(self):
+        self.dummyGitTest("usehead=1;name=newName")
 
 class FetcherNoNetworkTest(FetcherTest):
     def setUp(self):
-- 
2.26.3

