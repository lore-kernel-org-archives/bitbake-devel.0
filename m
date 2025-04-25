Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EDCC369D3
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 14:48:20 +0000 (UTC)
Received: from esa12.hc324-48.eu.iphmx.com (esa12.hc324-48.eu.iphmx.com [207.54.72.34])
 by mx.groups.io with SMTP id smtpd.web10.8244.1745592494667551650
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Apr 2025 07:48:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=a9KK4SPX;
 spf=pass (domain: bmw.de, ip: 207.54.72.34, mailfrom: prvs=2034cd71c=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1745592495; x=1777128495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/j75APIQhFeDUrfqzk3Xw2yxRTeyF+vsBIR7Hoz6PAQ=;
  b=a9KK4SPXNEoqZmalHLHJ2ia8jluvwiwMvJeI4Tzav9dx5cGYYEiZPJGe
   PsgNGfhDMvO+Ei7ith246THF9ON2DPsgaxFn7TbDGrCR8m8H78exlm2c0
   mllYbc+DQd3RP9VRyjQtMyrMwtMou7IczrTluJ33Dk0/cAzbTY/glGw4p
   o=;
X-CSE-ConnectionGUID: 5GH7lSQyR/ixbZ6kqRQJAQ==
X-CSE-MsgGUID: 5P0ihFSRSim6YvE5gAzmfg==
Received: from 160.46.252.35.spf.bmwgroup.com.bmwgroup.com (HELO esagw3.muc)
 ([160.46.252.35]) by esa12.hc324-48.eu.iphmx.com with ESMTP/TLS;
 25 Apr 2025 16:48:12 +0200
Received: from esabb3.muc ([160.50.100.30])  by esagw3.muc with ESMTP/TLS;
 25 Apr 2025 16:48:11 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb3.muc with ESMTP/TLS; 25 Apr 2025 16:48:08 +0200
Received: from localhost.localdomain (10.30.85.205) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Fri, 25 Apr 2025 16:48:07 +0200
X-CSE-ConnectionGUID: WI4IooSySqSlvr1uZvB4ZA==
X-CSE-MsgGUID: w8l/XTbqS6eC4l9+wXXLRQ==
X-CSE-ConnectionGUID: JSVMaMLRRdCNv0xU5ZBo8A==
X-CSE-MsgGUID: yfIzuJMFTJS/FpLg2n3CmA==
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: Philip Lorenz <philip.lorenz@bmw.de>, <mathieu.dubois-briand@bootlin.com>,
	<richard.purdie@linuxfoundation.org>
Subject: [PATCH v3 3/8] fetch2: Check for git-lfs existence before using it
Date: Fri, 25 Apr 2025 16:41:33 +0200
Message-ID: <20250425144138.4089681-4-philip.lorenz@bmw.de>
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
 <bitbake-devel@lists.openembedded.org>; Fri, 25 Apr 2025 14:48:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17572

So far, existence of `git-lfs` was only checked during unpacking. As the
binary is also used in earlier steps also check for its existence there.

Additionally, factor out the LFS existence check into a dedicated
function and call it wherever git-lfs is used for the first time.

Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
---
V2 -> V3:
* Only check for git-lfs existence after verifying that repository is
  using it
* Add test case to verify that git-lfs is not required when the
  repository does not have a single LFS filter configured
---
 lib/bb/fetch2/git.py  | 26 ++++++++++++------
 lib/bb/tests/fetch.py | 61 ++++++++++++++++++++++++++++---------------
 2 files changed, 58 insertions(+), 29 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 39c183927..9e5833735 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -324,6 +324,9 @@ class Git(FetchMethod):
         return False
 
     def lfs_need_update(self, ud, d):
+        if not self._need_lfs(ud):
+            return False
+
         if self.clonedir_need_update(ud, d):
             return True
 
@@ -507,7 +510,9 @@ class Git(FetchMethod):
     def lfs_fetch(self, ud, d, clonedir, revision, fetchall=False, progresshandler=None):
         """Helper method for fetching Git LFS data"""
         try:
-            if self._need_lfs(ud) and self._contains_lfs(ud, d, clonedir) and self._find_git_lfs(d) and len(revision):
+            if self._need_lfs(ud) and self._contains_lfs(ud, d, clonedir) and len(revision):
+                self._ensure_git_lfs(d, ud)
+
                 # Using worktree with the revision because .lfsconfig may exists
                 worktree_add_cmd = "%s worktree add wt %s" % (ud.basecmd, revision)
                 runfetchcmd(worktree_add_cmd, d, log=progresshandler, workdir=clonedir)
@@ -740,11 +745,11 @@ class Git(FetchMethod):
         runfetchcmd("%s remote set-url origin %s" % (ud.basecmd, shlex.quote(repourl)), d, workdir=destdir)
 
         if self._contains_lfs(ud, d, destdir):
-            if need_lfs and not self._find_git_lfs(d):
-                raise bb.fetch2.FetchError("Repository %s has LFS content, install git-lfs on host to download (or set lfs=0 to ignore it)" % (repourl))
-            elif not need_lfs:
+            if not need_lfs:
                 bb.note("Repository %s has LFS content but it is not being fetched" % (repourl))
             else:
+                self._ensure_git_lfs(d, ud)
+
                 runfetchcmd("%s lfs install --local" % ud.basecmd, d, workdir=destdir)
 
         if not ud.nocheckout:
@@ -807,9 +812,11 @@ class Git(FetchMethod):
         Verifies whether the LFS objects for requested revisions have already been downloaded
         """
         # Bail out early if this repository doesn't use LFS
-        if not self._need_lfs(ud) or not self._contains_lfs(ud, d, wd):
+        if not self._contains_lfs(ud, d, wd):
             return True
 
+        self._ensure_git_lfs(d, ud)
+
         # The Git LFS specification specifies ([1]) the LFS folder layout so it should be safe to check for file
         # existence.
         # [1] https://github.com/git-lfs/git-lfs/blob/main/docs/spec.md#intercepting-git
@@ -859,11 +866,14 @@ class Git(FetchMethod):
             pass
         return False
 
-    def _find_git_lfs(self, d):
+    def _ensure_git_lfs(self, d, ud):
         """
-        Return True if git-lfs can be found, False otherwise.
+        Ensures that git-lfs is available, raising a FetchError if it isn't.
         """
-        return shutil.which("git-lfs", path=d.getVar('PATH')) is not None
+        if shutil.which("git-lfs", path=d.getVar('PATH')) is None:
+            raise bb.fetch2.FetchError(
+                "Repository %s has LFS content, install git-lfs on host to download (or set lfs=0 "
+                "to ignore it)" % self._get_repo_url(ud))
 
     def _get_repo_url(self, ud):
         """
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index f0c628524..bedbf2643 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -9,6 +9,7 @@
 import contextlib
 import shutil
 import unittest
+import unittest.mock
 import urllib.parse
 import hashlib
 import tempfile
@@ -2292,12 +2293,18 @@ class GitLfsTest(FetcherTest):
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
@@ -2413,18 +2420,17 @@ class GitLfsTest(FetcherTest):
         # Careful: suppress initial attempt at downloading
         fetcher, ud = self.fetch(uri=None, download=False)
 
-        # Artificially assert that git-lfs is not installed, so
-        # we can verify a failure to unpack in it's absence.
-        old_find_git_lfs = ud.method._find_git_lfs
-        try:
-            # If git-lfs cannot be found, the unpack should throw an error
+        # If git-lfs cannot be found, the download should throw an error
+        with unittest.mock.patch("shutil.which", return_value=None):
             with self.assertRaises(bb.fetch2.FetchError):
                 fetcher.download()
-                ud.method._find_git_lfs = lambda d: False
+
+        fetcher.download()
+        # If git-lfs cannot be found, the unpack should throw an error
+        with self.assertRaises(bb.fetch2.FetchError):
+            with unittest.mock.patch("shutil.which", return_value=None):
                 shutil.rmtree(self.gitdir, ignore_errors=True)
                 fetcher.unpack(self.d.getVar('WORKDIR'))
-        finally:
-            ud.method._find_git_lfs = old_find_git_lfs
 
     def test_lfs_disabled_not_installed(self):
         uri = 'git://%s;protocol=file;lfs=0;branch=master' % self.srcdir
@@ -2433,17 +2439,30 @@ class GitLfsTest(FetcherTest):
         # Careful: suppress initial attempt at downloading
         fetcher, ud = self.fetch(uri=None, download=False)
 
-        # Artificially assert that git-lfs is not installed, so
-        # we can verify a failure to unpack in it's absence.
-        old_find_git_lfs = ud.method._find_git_lfs
-        try:
-            # Even if git-lfs cannot be found, the unpack should be successful
+        # Even if git-lfs cannot be found, the download / unpack should be successful
+        with unittest.mock.patch("shutil.which", return_value=None):
+            fetcher.download()
+            shutil.rmtree(self.gitdir, ignore_errors=True)
+            fetcher.unpack(self.d.getVar('WORKDIR'))
+
+    def test_lfs_enabled_not_installed_but_not_needed(self):
+        srcdir = os.path.join(self.tempdir, "emptygit")
+        bb.utils.mkdirhier(srcdir)
+        self.git_init(srcdir)
+        self.commit_file("test", "test content", cwd=srcdir)
+
+        uri = 'git://%s;protocol=file;lfs=1;branch=master' % srcdir
+        self.d.setVar('SRC_URI', uri)
+
+        # Careful: suppress initial attempt at downloading
+        fetcher, ud = self.fetch(uri=None, download=False)
+
+        # It shouldnt't matter that git-lfs cannot be found as the repository configuration does not
+        # specify any LFS filters.
+        with unittest.mock.patch("shutil.which", return_value=None):
             fetcher.download()
-            ud.method._find_git_lfs = lambda d: False
             shutil.rmtree(self.gitdir, ignore_errors=True)
             fetcher.unpack(self.d.getVar('WORKDIR'))
-        finally:
-            ud.method._find_git_lfs = old_find_git_lfs
 
 class GitURLWithSpacesTest(FetcherTest):
     test_git_urls = {

