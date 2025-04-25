Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EF1C369D7
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 10:18:37 +0000 (UTC)
Received: from esa14.hc324-48.eu.iphmx.com (esa14.hc324-48.eu.iphmx.com [207.54.69.24])
 by mx.groups.io with SMTP id smtpd.web11.3610.1745576309708521832
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Apr 2025 03:18:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=hL/Akvxt;
 spf=pass (domain: bmw.de, ip: 207.54.69.24, mailfrom: prvs=2034cd71c=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1745576309; x=1777112309;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HszqEEtIU25DF+u1TOr3ocRV2iQwXzY5EdDxepgtr5Y=;
  b=hL/AkvxtX72qaXzrg3SAdpfjOV5konkysX5DW2VTiIyxq8GILkCkUxD3
   umk7ivHTLiJVQSd5rRBCrKkOqu9NXpJbdf0I4ZSnAV680POtOEgg/9Siu
   6qORKGaG3OWD5GPnczztCY9xcyo3lk5QmrwlhWqsf1bkpRzKpxSU6HeQO
   I=;
X-CSE-ConnectionGUID: kwm46IIMQC2+6BZkovkpdw==
X-CSE-MsgGUID: vPjDojoMSnGFXa1xE83sKQ==
Received: from esagw1.bmwgroup.com (HELO esagw1.muc) ([160.46.252.34]) by
 esa14.hc324-48.eu.iphmx.com with ESMTP/TLS; 25 Apr 2025 12:18:27 +0200
Received: from esabb4.muc ([160.50.100.33])  by esagw1.muc with ESMTP/TLS;
 25 Apr 2025 12:18:27 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb4.muc with ESMTP/TLS; 25 Apr 2025 12:18:27 +0200
Received: from localhost.localdomain (10.30.85.206) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Fri, 25 Apr 2025 12:18:27 +0200
X-CSE-ConnectionGUID: Hn92gVOJS2OSxKZnXnvHXA==
X-CSE-MsgGUID: 8JZ7hJmJTYaMpaan4LN0DA==
X-CSE-ConnectionGUID: l+FpmV+FSj+OBWD81NRaAA==
X-CSE-MsgGUID: eiaVqXtLTI2OoJ/+HG3Vqw==
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: Philip Lorenz <philip.lorenz@bmw.de>, <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH v2 3/8] fetch2: Check for git-lfs existence before using it
Date: Fri, 25 Apr 2025 12:11:50 +0200
Message-ID: <20250425101155.2905972-4-philip.lorenz@bmw.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425101155.2905972-1-philip.lorenz@bmw.de>
References: <20250425101155.2905972-1-philip.lorenz@bmw.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SMUCMP09F.europe.bmw.corp (2a03:1e80:a15:58f::1:2d) To
 smucmp19d.europe.bmw.corp (2a03:1e80:a15:58f::205d)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 25 Apr 2025 10:18:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17559

So far, existence of `git-lfs` was only checked during unpacking. As the
binary is also used in earlier steps also check for its existence there.

Additionally, factor out the LFS existence check into a dedicated
function and call it wherever git-lfs is used for the first time.

Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
---
 lib/bb/fetch2/git.py  | 26 ++++++++++++++++++--------
 lib/bb/tests/fetch.py | 26 ++++++++++----------------
 2 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 39c183927..b32b18797 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -324,6 +324,11 @@ class Git(FetchMethod):
         return False
 
     def lfs_need_update(self, ud, d):
+        if not self._need_lfs(ud):
+            return False
+
+        self._ensure_git_lfs(d, ud)
+
         if self.clonedir_need_update(ud, d):
             return True
 
@@ -507,7 +512,9 @@ class Git(FetchMethod):
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
@@ -740,11 +747,11 @@ class Git(FetchMethod):
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
@@ -807,7 +814,7 @@ class Git(FetchMethod):
         Verifies whether the LFS objects for requested revisions have already been downloaded
         """
         # Bail out early if this repository doesn't use LFS
-        if not self._need_lfs(ud) or not self._contains_lfs(ud, d, wd):
+        if not self._contains_lfs(ud, d, wd):
             return True
 
         # The Git LFS specification specifies ([1]) the LFS folder layout so it should be safe to check for file
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
index f0c628524..a936af6fb 100644
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
@@ -2413,18 +2414,17 @@ class GitLfsTest(FetcherTest):
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
@@ -2433,17 +2433,11 @@ class GitLfsTest(FetcherTest):
         # Careful: suppress initial attempt at downloading
         fetcher, ud = self.fetch(uri=None, download=False)
 
-        # Artificially assert that git-lfs is not installed, so
-        # we can verify a failure to unpack in it's absence.
-        old_find_git_lfs = ud.method._find_git_lfs
-        try:
-            # Even if git-lfs cannot be found, the unpack should be successful
+        # Even if git-lfs cannot be found, the download / unpack should be successful
+        with unittest.mock.patch("shutil.which", return_value=None):
             fetcher.download()
-            ud.method._find_git_lfs = lambda d: False
             shutil.rmtree(self.gitdir, ignore_errors=True)
             fetcher.unpack(self.d.getVar('WORKDIR'))
-        finally:
-            ud.method._find_git_lfs = old_find_git_lfs
 
 class GitURLWithSpacesTest(FetcherTest):
     test_git_urls = {

