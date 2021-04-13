Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web09.468.1618326394856814354
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Apr 2021 08:06:36 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: siemens.com, ip: 194.138.37.39, mailfrom: henning.schild@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 13DF6Wo5012254
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Apr 2021 17:06:32 +0200
Received: from localhost.localdomain ([167.87.48.83])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 13DF2rM3021528;
	Tue, 13 Apr 2021 17:02:54 +0200
From: henning.schild@siemens.com
To: bitbake-devel@lists.openembedded.org
Cc: isar-users@googlegroups.com,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        Cedric Hombourger <Cedric_Hombourger@mentor.com>,
        Chris Larson <Chris_Larson@mentor.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v2 2/3] tests/fetch: deduplicate local git testing code
Date: Tue, 13 Apr 2021 17:02:50 +0200
Message-Id: <20210413150251.1969-2-henning.schild@siemens.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210413150251.1969-1-henning.schild@siemens.com>
References: <20210413150251.1969-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Purely cosmetic change that probably improves the code.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 lib/bb/tests/fetch.py | 33 +++++++--------------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index ddf6e97439b5..76797473db8a 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -673,7 +673,7 @@ class FetcherLocalTest(FetcherTest):
         with self.assertRaises(bb.fetch2.UnpackError):
             self.fetchUnpack(['file://a;subdir=/bin/sh'])
 
-    def test_local_gitfetch_usehead(self):
+    def dummyGitTest(self, suffix):
         # Create dummy local Git repo
         src_dir = tempfile.mkdtemp(dir=self.tempdir,
                                    prefix='gitfetch_localusehead_')
@@ -690,7 +690,7 @@ class FetcherLocalTest(FetcherTest):
 
         # Fetch and check revision
         self.d.setVar("SRCREV", "AUTOINC")
-        url = "git://" + src_dir + ";protocol=file;usehead=1"
+        url = "git://" + src_dir + ";protocol=file;" + suffix
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
@@ -699,31 +699,12 @@ class FetcherLocalTest(FetcherTest):
         unpack_rev = stdout[0].strip()
         self.assertEqual(orig_rev, unpack_rev)
 
-    def test_local_gitfetch_usehead_withname(self):
-        # Create dummy local Git repo
-        src_dir = tempfile.mkdtemp(dir=self.tempdir,
-                                   prefix='gitfetch_localusehead_')
-        src_dir = os.path.abspath(src_dir)
-        bb.process.run("git init", cwd=src_dir)
-        bb.process.run("git commit --allow-empty -m'Dummy commit'",
-                       cwd=src_dir)
-        # Use other branch than master
-        bb.process.run("git checkout -b my-devel", cwd=src_dir)
-        bb.process.run("git commit --allow-empty -m'Dummy commit 2'",
-                       cwd=src_dir)
-        stdout = bb.process.run("git rev-parse HEAD", cwd=src_dir)
-        orig_rev = stdout[0].strip()
 
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
+    def test_local_gitfetch_usehead(self):
+        self.dummyGitTest("usehead=1")
+
+    def test_local_gitfetch_usehead_withname(self):
+        self.dummyGitTest("usehead=1;name=newName")
 
 class FetcherNoNetworkTest(FetcherTest):
     def setUp(self):
-- 
2.26.3

