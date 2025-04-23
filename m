Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0680AC369DF
	for <webhook@archiver.kernel.org>; Wed, 23 Apr 2025 15:25:48 +0000 (UTC)
Received: from esa2.hc324-48.eu.iphmx.com (esa2.hc324-48.eu.iphmx.com [207.54.68.120])
 by mx.groups.io with SMTP id smtpd.web10.11460.1745421943932277681
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Apr 2025 08:25:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=QOxWjzZ1;
 spf=pass (domain: bmw.de, ip: 207.54.68.120, mailfrom: prvs=201e634cf=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1745421947; x=1776957947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7H8mfsXFtiTrtS3gIqtD9P+azsBFgC1jdx7hX2f3eg4=;
  b=QOxWjzZ1XigXe6103mfdpOgSkDm1OzRMVcK0jEwW7aKbFfsLcAVHhWg5
   SnJY/91xDkPzqk9bp98HorQq4CM/aWDD53u75yTlMniNKmVuHbOJMgmXS
   I8mhnMDVGJgUoVc/tGU7Am8+Df63SSEmCwJZ/QQOnqr6w7/OGQZn7qjYm
   k=;
X-CSE-ConnectionGUID: SrCR4j03S/O6p/qXuIVE+w==
X-CSE-MsgGUID: 5frB8O9RQT2sHQC/Kg8+JQ==
Received: from esagw2.bmwgroup.com (HELO esagw2.muc) ([160.46.252.38]) by
 esa2.hc324-48.eu.iphmx.com with ESMTP/TLS; 23 Apr 2025 17:25:42 +0200
Received: from esabb4.muc ([160.50.100.33])  by esagw2.muc with ESMTP/TLS;
 23 Apr 2025 17:25:42 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb4.muc with ESMTP/TLS; 23 Apr 2025 17:25:42 +0200
Received: from localhost.localdomain (10.30.85.210) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Wed, 23 Apr 2025 17:25:41 +0200
X-CSE-ConnectionGUID: ymfSHIsLTu29uPr5/XWhhg==
X-CSE-MsgGUID: HD9SG/mWQNGkCdjxLzGT2Q==
X-CSE-ConnectionGUID: Vy1BgFThQKO1as1uYzNgdw==
X-CSE-MsgGUID: Rri4rFZ2TTCjA562oErLdg==
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: Philip Lorenz <philip.lorenz@bmw.de>
Subject: [PATCH 8/8] tests/fetch: Test gitsm with LFS
Date: Wed, 23 Apr 2025 17:19:01 +0200
Message-ID: <20250423151901.1300944-9-philip.lorenz@bmw.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423151901.1300944-1-philip.lorenz@bmw.de>
References: <20250423151901.1300944-1-philip.lorenz@bmw.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: smucmp15a.europe.bmw.corp (2a03:1e80:a15:58f::1:68) To
 smucmp19d.europe.bmw.corp (2a03:1e80:a15:58f::205d)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Apr 2025 15:25:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17549

Add a test case to verify that the gitsm fetcher properly handles
repositories storing objects with LFS.

The test case verifies that LFS objects are fetched on the initial clone
but also ensures that consecutive updates extend the original clone with
any newly referenced LFS objects.

Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
---
 lib/bb/tests/fetch.py | 94 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 78 insertions(+), 16 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index a936af6fb..70a5eea22 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -20,6 +20,7 @@ import tarfile
 from bb.fetch2 import URI
 from bb.fetch2 import FetchMethod
 import bb
+import bb.utils
 from bb.tests.support.httpserver import HTTPService
 
 def skipIfNoNetwork():
@@ -27,6 +28,18 @@ def skipIfNoNetwork():
         return unittest.skip("network test")
     return lambda f: f
 
+
+@contextlib.contextmanager
+def hide_directory(directory):
+    """Hide the given directory and restore it after the context is left"""
+    temp_name = directory + ".bak"
+    os.rename(directory, temp_name)
+    try:
+        yield
+    finally:
+        os.rename(temp_name, directory)
+
+
 class TestTimeout(Exception):
     # Indicate to pytest that this is not a test suite
     __test__ = False
@@ -2293,12 +2306,18 @@ class GitLfsTest(FetcherTest):
         self.git_init(cwd=self.srcdir)
         self.commit_file('.gitattributes', '*.mp3 filter=lfs -text')
 
-    def commit_file(self, filename, content):
-        with open(os.path.join(self.srcdir, filename), "w") as f:
+    def commit(self, *, cwd=None):
+        cwd = cwd or self.srcdir
+        self.git(["commit", "-m", "Change"], cwd=cwd)
+        return self.git(["rev-parse", "HEAD"], cwd=cwd).strip()
+
+    def commit_file(self, filename, content, *, cwd=None):
+        cwd = cwd or self.srcdir
+
+        with open(os.path.join(cwd, filename), "w") as f:
             f.write(content)
-        self.git(["add", filename], cwd=self.srcdir)
-        self.git(["commit", "-m", "Change"], cwd=self.srcdir)
-        return self.git(["rev-parse", "HEAD"], cwd=self.srcdir).strip()
+        self.git(["add", filename], cwd=cwd)
+        return self.commit(cwd=cwd)
 
     def fetch(self, uri=None, download=True):
         uris = self.d.getVar('SRC_URI').split()
@@ -2318,26 +2337,69 @@ class GitLfsTest(FetcherTest):
         unpacked_lfs_file = os.path.join(self.d.getVar('WORKDIR'), 'git', "Cat_poster_1.jpg")
         return unpacked_lfs_file
 
+    @skipIfNoGitLFS()
+    def test_gitsm_lfs(self):
+        """Test that the gitsm fetcher caches objects stored via LFS"""
+        self.git(["lfs", "install", "--local"], cwd=self.srcdir)
+
+        def fetch_and_verify(revision, filename, content):
+            self.d.setVar('SRCREV', revision)
+            fetcher, ud = self.fetch()
+
+            with hide_directory(submoduledir), hide_directory(self.srcdir):
+                workdir = self.d.getVar('WORKDIR')
+                fetcher.unpack(workdir)
+
+                with open(os.path.join(workdir, "git", filename)) as f:
+                    self.assertEqual(f.read(), content)
+
+        # Create the git repository that will later be used as a submodule
+        submoduledir = self.tempdir + "/submodule"
+        bb.utils.mkdirhier(submoduledir)
+        self.git_init(submoduledir)
+        self.commit_file('.gitattributes', '*.mp3 filter=lfs -text', cwd=submoduledir)
+
+        submodule_commit_1 = self.commit_file("a.mp3", "submodule version 1", cwd=submoduledir)
+        _ = self.commit_file("a.mp3", "submodule version 2", cwd=submoduledir)
+
+        # Add the submodule to the repository at its current HEAD revision
+        self.git(["-c", "protocol.file.allow=always", "submodule", "add", submoduledir, "submodule"],
+                 cwd=self.srcdir)
+        base_commit_1 = self.commit()
+
+        # Let the submodule point at a different revision
+        self.git(["checkout", submodule_commit_1], self.srcdir + "/submodule")
+        self.git(["add", "submodule"], cwd=self.srcdir)
+        base_commit_2 = self.commit()
+
+        # Add a LFS file to the repository
+        base_commit_3 = self.commit_file("a.mp3", "version 1")
+        # Update the added LFS file
+        base_commit_4 = self.commit_file("a.mp3", "version 2")
+
+        self.d.setVar('SRC_URI', "gitsm://%s;protocol=file;lfs=1;branch=master" % self.srcdir)
+
+        # Verify that LFS objects referenced from submodules are fetched and checked out
+        fetch_and_verify(base_commit_1, "submodule/a.mp3", "submodule version 2")
+        # Verify that the repository inside the download cache of a submodile is extended with any
+        # additional LFS objects needed when checking out a different revision.
+        fetch_and_verify(base_commit_2, "submodule/a.mp3", "submodule version 1")
+        # Verify that LFS objects referenced from the base repository are fetched and checked out
+        fetch_and_verify(base_commit_3, "a.mp3", "version 1")
+        # Verify that the cached repository is extended with any additional LFS objects required
+        # when checking out a different revision.
+        fetch_and_verify(base_commit_4, "a.mp3", "version 2")
+
     @skipIfNoGitLFS()
     def test_fetch_lfs_on_srcrev_change(self):
         """Test if fetch downloads missing LFS objects when a different revision within an existing repository is requested"""
         self.git(["lfs", "install", "--local"], cwd=self.srcdir)
 
-        @contextlib.contextmanager
-        def hide_upstream_repository():
-            """Hide the upstream repository to make sure that git lfs cannot pull from it"""
-            temp_name = self.srcdir + ".bak"
-            os.rename(self.srcdir, temp_name)
-            try:
-                yield
-            finally:
-                os.rename(temp_name, self.srcdir)
-
         def fetch_and_verify(revision, filename, content):
             self.d.setVar('SRCREV', revision)
             fetcher, ud = self.fetch()
 
-            with hide_upstream_repository():
+            with hide_directory(self.srcdir):
                 workdir = self.d.getVar('WORKDIR')
                 fetcher.unpack(workdir)
 

