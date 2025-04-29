Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD91C369DC
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 08:18:05 +0000 (UTC)
Received: from esa8.hc324-48.eu.iphmx.com (esa8.hc324-48.eu.iphmx.com [207.54.65.242])
 by mx.groups.io with SMTP id smtpd.web11.13072.1745914679924280858
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Apr 2025 01:18:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=At+7Y3bo;
 spf=pass (domain: bmw.de, ip: 207.54.65.242, mailfrom: prvs=207d80f5d=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1745914679; x=1777450679;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ta4KW303dgY6m04ScGAo5B4pqFBGvcMdDMyGs4MWM/o=;
  b=At+7Y3boRLlT8NMQQJPNgIHC3xc58ngxsJ9WZY9KVtKWSKtx+UENg23E
   k6hXG6eTSnEEvETVSe/cy35LJ3mXJWDVkgfhp5+kpdmOwMaqe5s166it2
   UH0O7ieJvxJJUoZSM4i9VUZRzWR6UaK0iMOlyAak9GGNGOC/F9WUk1GtP
   8=;
X-CSE-ConnectionGUID: vzAxsUweRQuOBajErrDHOQ==
X-CSE-MsgGUID: BaRxysb7Rpi1TESt7lxqrw==
Received: from 160.46.252.34.spf.bmwgroup.com (HELO esagw1.muc) ([160.46.252.34]) by
 esa8.hc324-48.eu.iphmx.com with ESMTP/TLS; 29 Apr 2025 10:17:57 +0200
Received: from esabb3.muc ([160.50.100.30])  by esagw1.muc with ESMTP/TLS;
 29 Apr 2025 10:17:57 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb3.muc with ESMTP/TLS; 29 Apr 2025 10:17:57 +0200
Received: from localhost.localdomain (10.30.85.212) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Tue, 29 Apr 2025 10:17:57 +0200
X-CSE-ConnectionGUID: xsz7vaq3TASiPOrVMsEDtA==
X-CSE-MsgGUID: CdA1zMygSO+wD+rhct1jKg==
X-CSE-ConnectionGUID: 7RlI4xICRhq2xDMSz6E8+Q==
X-CSE-MsgGUID: T1TQqzEhTfe5HlMwuNEcfA==
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: Philip Lorenz <philip.lorenz@bmw.de>, <mathieu.dubois-briand@bootlin.com>,
	<richard.purdie@linuxfoundation.org>
Subject: [PATCH v4 3/8] fetch2: Check for git-lfs existence before using it
Date: Tue, 29 Apr 2025 10:11:19 +0200
Message-ID: <20250429081124.3695505-4-philip.lorenz@bmw.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429081124.3695505-1-philip.lorenz@bmw.de>
References: <20250429081124.3695505-1-philip.lorenz@bmw.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: smucmp09b.europe.bmw.corp (2a03:1e80:a15:58f::203f) To
 smucmp19d.europe.bmw.corp (2a03:1e80:a15:58f::205d)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Apr 2025 08:18:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17582

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
V3 -> V4:
* Move "lfs enabled but git-lfs not installed during unpack" into a
  dedicated test case (which can be skipped) to avoid test failures
  when the host doesn't have git-lfs which is needed for test case
  preparation
---
 lib/bb/fetch2/git.py  | 26 ++++++++++-----
 lib/bb/tests/fetch.py | 73 +++++++++++++++++++++++++++++--------------
 2 files changed, 68 insertions(+), 31 deletions(-)

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
index f0c628524..c77725190 100644
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
@@ -2406,6 +2413,21 @@ class GitLfsTest(FetcherTest):
         fetcher, ud = self.fetch()
         fetcher.unpack(self.d.getVar('WORKDIR'))
 
+    @skipIfNoGitLFS()
+    def test_lfs_enabled_not_installed_during_unpack(self):
+        uri = 'git://%s;protocol=file;lfs=1;branch=master' % self.srcdir
+        self.d.setVar('SRC_URI', uri)
+
+        # Careful: suppress initial attempt at downloading
+        fetcher, ud = self.fetch(uri=None, download=False)
+
+        fetcher.download()
+        # If git-lfs cannot be found, the unpack should throw an error
+        with self.assertRaises(bb.fetch2.FetchError):
+            with unittest.mock.patch("shutil.which", return_value=None):
+                shutil.rmtree(self.gitdir, ignore_errors=True)
+                fetcher.unpack(self.d.getVar('WORKDIR'))
+
     def test_lfs_enabled_not_installed(self):
         uri = 'git://%s;protocol=file;lfs=1;branch=master' % self.srcdir
         self.d.setVar('SRC_URI', uri)
@@ -2413,18 +2435,10 @@ class GitLfsTest(FetcherTest):
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
-                shutil.rmtree(self.gitdir, ignore_errors=True)
-                fetcher.unpack(self.d.getVar('WORKDIR'))
-        finally:
-            ud.method._find_git_lfs = old_find_git_lfs
 
     def test_lfs_disabled_not_installed(self):
         uri = 'git://%s;protocol=file;lfs=0;branch=master' % self.srcdir
@@ -2433,17 +2447,30 @@ class GitLfsTest(FetcherTest):
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

