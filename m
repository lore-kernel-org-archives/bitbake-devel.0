Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41419C369C2
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 14:48:40 +0000 (UTC)
Received: from esa12.hc324-48.eu.iphmx.com (esa12.hc324-48.eu.iphmx.com [207.54.72.34])
 by mx.groups.io with SMTP id smtpd.web11.8200.1745592512885743768
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Apr 2025 07:48:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=plhBqWIz;
 spf=pass (domain: bmw.de, ip: 207.54.72.34, mailfrom: prvs=2034cd71c=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1745592512; x=1777128512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z5C9XnlqCGDX9BtGIuU/uPlGam7LGLqrIGElnpIY7Uc=;
  b=plhBqWIzX0ZAofWIUHLQZvMtBSPe8TwSvIm2qQA0hISJ/mYBEC42Ipp7
   8Mfn7xJOouRH5J0hpU5C0WdBM7aA4RMD4tIrGwFV4+DqA8mU2Qr36fto4
   t1V+LwimzFV6U2g4erSxB1fYr9bXaYfkr/oNkVk/Rds/a26xNwFbGVjK/
   U=;
X-CSE-ConnectionGUID: nfZPIKNWT9CiGQriNIK1Dw==
X-CSE-MsgGUID: XLUtpiGqR4KJ+nUcrsZxLQ==
Received: from esagw1.bmwgroup.com (HELO esagw1.muc) ([160.46.252.34]) by
 esa12.hc324-48.eu.iphmx.com with ESMTP/TLS; 25 Apr 2025 16:48:29 +0200
Received: from esabb2.muc ([160.50.100.34])  by esagw1.muc with ESMTP/TLS;
 25 Apr 2025 16:48:09 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb2.muc with ESMTP/TLS; 25 Apr 2025 16:48:08 +0200
Received: from localhost.localdomain (10.30.85.205) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Fri, 25 Apr 2025 16:48:08 +0200
X-CSE-ConnectionGUID: qwxr2B7RSTmT9mb0l4WXqw==
X-CSE-MsgGUID: 3JIUfPwyQqu2MZQlDD0sQw==
X-CSE-ConnectionGUID: xg5av/cISqCGPfzax1K2uw==
X-CSE-MsgGUID: XGQqAiyrQgS6G0fEYSwjag==
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: Philip Lorenz <philip.lorenz@bmw.de>, <mathieu.dubois-briand@bootlin.com>,
	<richard.purdie@linuxfoundation.org>
Subject: [PATCH v3 8/8] tests/fetch: Test gitsm with LFS
Date: Fri, 25 Apr 2025 16:41:38 +0200
Message-ID: <20250425144138.4089681-9-philip.lorenz@bmw.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425144138.4089681-1-philip.lorenz@bmw.de>
References: <20250425144138.4089681-1-philip.lorenz@bmw.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: smucmp17a.europe.bmw.corp (2a03:1e80:a15:58f::1:3a) To
 smucmp19d.europe.bmw.corp (2a03:1e80:a15:58f::205d)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 25 Apr 2025 14:48:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17577

Add a test case to verify that the gitsm fetcher properly handles
repositories storing objects with LFS.

The test case verifies that LFS objects are fetched on the initial clone
but also ensures that consecutive updates extend the original clone with
any newly referenced LFS objects.

Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
---
V1 -> V2:
* Add testcase for lfs=0
* Fix missing LFS installation in submodules
---
 lib/bb/tests/fetch.py | 122 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 111 insertions(+), 11 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index bedbf2643..e2e22356c 100644
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
@@ -2324,26 +2337,113 @@ class GitLfsTest(FetcherTest):
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
+        self.git(["lfs", "install", "--local"], cwd=submoduledir)
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
+    @skipIfNoGitLFS()
+    def test_gitsm_lfs_disabled(self):
+        """Test that the gitsm fetcher does not use LFS when explicitly disabled"""
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
+                    # Assume that LFS did not perform smudging when the expected content is
+                    # missing.
+                    self.assertNotEqual(f.read(), content)
+
+        # Create the git repository that will later be used as a submodule
+        submoduledir = self.tempdir + "/submodule"
+        bb.utils.mkdirhier(submoduledir)
+        self.git_init(submoduledir)
+        self.git(["lfs", "install", "--local"], cwd=submoduledir)
+        self.commit_file('.gitattributes', '*.mp3 filter=lfs -text', cwd=submoduledir)
+
+        submodule_commit_1 = self.commit_file("a.mp3", "submodule version 1", cwd=submoduledir)
+
+        # Add the submodule to the repository at its current HEAD revision
+        self.git(["-c", "protocol.file.allow=always", "submodule", "add", submoduledir, "submodule"],
+                 cwd=self.srcdir)
+        base_commit_1 = self.commit()
+
+        # Add a LFS file to the repository
+        base_commit_2 = self.commit_file("a.mp3", "version 1")
+
+        self.d.setVar('SRC_URI', "gitsm://%s;protocol=file;lfs=1;branch=master;lfs=0" % self.srcdir)
+
+        # Verify that LFS objects referenced from submodules are not fetched nor checked out
+        fetch_and_verify(base_commit_1, "submodule/a.mp3", "submodule version 1")
+        # Verify that the LFS objects referenced from the base repository are not fetched nor
+        # checked out
+        fetch_and_verify(base_commit_2, "a.mp3", "version 1")
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
 

