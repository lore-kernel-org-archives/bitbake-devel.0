Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A97C61DD6
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 08:10:35 +0000 (UTC)
Received: from esa3.hc324-48.eu.iphmx.com (esa3.hc324-48.eu.iphmx.com [207.54.68.121])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7406.1788336625337257354
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Sep 2026 01:10:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=G93NitN6;
 spf=permerror, err=parse error for token &{10 18 256wvd6dc.spf.checkpoint-spf.com}: parse error for token &{10 18 %{ir}.256wvd6dc.spf.checkpoint-spf.com}: invalid domain name (domain: bmw.de, ip: 207.54.68.121, mailfrom: prvs=698d5dd81=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1788336629; x=1819872629;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1hQtiCXKow7/gUIiZhi/xs5rH9Qf0jLEV3sSLSRi5Mo=;
  b=G93NitN6Qy7H/bAuRPn8UR3wYxq+bX4n2pPyyDsa7cmG+ws5W36JqsIO
   ZFp3UrhkgyDtSNVV6PB66QKO4ZI7Xf4kf8qN9JqMG6OJxMk4PlkiEh/wP
   NId9SzjcN1slEq2mXddn6KHct5tSDzUZXxlgItnwek97h2DDLnMq/PG3L
   A=;
X-CSE-ConnectionGUID: pfykY4FqRBimM7QOmHiFog==
X-CSE-MsgGUID: WgwpZwKOQ/CGR8tMScZxBw==
Received: from esagw2.bmwgroup.com (HELO esagw2.muc) ([160.46.252.38]) by
 esa3.hc324-48.eu.iphmx.com with ESMTP/TLS; 02 Sep 2026 10:10:27 +0200
Received: from unknown (HELO esabb4.muc) ([10.31.187.135]) by esagw2.muc with
 ESMTP/TLS; 02 Sep 2026 10:10:23 +0200
Received: from smucmp21a.bmwgroup.net (HELO smucmp21a.europe.bmw.corp)
 ([10.100.172.92]) by esabb4.muc with ESMTP/TLS; 02 Sep 2026 10:10:24 +0200
Received: from marvin-ws (10.30.85.214) by smucmp21a.europe.bmw.corp
 (2a03:1e80:a01:524::1:44) with Microsoft SMTP Server (version=TLS;
 Wed, 2 Sep 2026 10:10:23 +0200
X-CSE-ConnectionGUID: 9mo7u60PSi6GS1gDskAJpQ==
X-CSE-MsgGUID: t82oqK1eSN2ugHbC5fmsAQ==
X-CSE-ConnectionGUID: CGwwHVgJSom1Rf3hwH3kFQ==
X-CSE-MsgGUID: 2SPrwnMvRR+SbFIOKsLPQg==
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: Philip Lorenz <philip.lorenz@bmw.de>
Subject: [PATCH] fetch2: Raise on git lfs fetch failures
Date: Wed, 2 Sep 2026 10:10:12 +0200
Message-ID: <20260902081012.793563-1-philip.lorenz@bmw.de>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: smucmp15e.europe.bmw.corp (2a03:1e80:a15:58f::1:61) To
 smucmp21a.europe.bmw.corp (2a03:1e80:a01:524::1:44)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 02 Sep 2026 08:10:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20146

LFS fetching can fail and ignoring this will lead to an incomplete
download cache (which in turn will lead to errors when smudging the LFS
files during `unpack`). Avoid this by removing the exception silencing
code.

In addition, this change disables smudging during worktree creation so
LFS related errors are now raised during the execution of `git lfs
fetch` rather than during worktree creation.

LFS fetching is only performed on repositories which are considered LFS
enabled and can be disabled by parametrizing the repository URL with
`lfs=0`.

Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
---
 lib/bb/fetch2/git.py  | 28 ++++++++++++++--------------
 lib/bb/tests/fetch.py | 15 +++++++++++++++
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 0bb2ea39a..796a54324 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -498,21 +498,21 @@ class Git(FetchMethod):
 
     def lfs_fetch(self, ud, d, clonedir, revision, fetchall=False, progresshandler=None):
         """Helper method for fetching Git LFS data"""
-        try:
-            if self._need_lfs(ud) and self._contains_lfs(ud, d, clonedir) and len(revision):
-                self._ensure_git_lfs(d, ud)
+        if self._need_lfs(ud) and self._contains_lfs(ud, d, clonedir) and len(revision):
+            self._ensure_git_lfs(d, ud)
+
+            # Using worktree with the revision because .lfsconfig may exists
+            worktree_add_cmd = ud.basecmd + ['worktree', 'add', 'wt', revision]
+            # Disable LFS smudging on worktree creation to make it easier
+            # to understand which operation actually failed.
+            runfetchcmd(worktree_add_cmd, d, log=progresshandler, workdir=clonedir, extraenv={'GIT_LFS_SKIP_SMUDGE':'1'})
+            lfs_fetch_cmd = ud.basecmd + ['lfs', 'fetch']
+            if fetchall:
+                lfs_fetch_cmd.append('--all')
+            runfetchcmd(lfs_fetch_cmd, d, log=progresshandler, workdir=(clonedir + "/wt"))
+            worktree_rem_cmd = ud.basecmd + ['worktree', 'remove', '-f', 'wt']
+            runfetchcmd(worktree_rem_cmd, d, log=progresshandler, workdir=clonedir)
 
-                # Using worktree with the revision because .lfsconfig may exists
-                worktree_add_cmd = ud.basecmd + ['worktree', 'add', 'wt', revision]
-                runfetchcmd(worktree_add_cmd, d, log=progresshandler, workdir=clonedir)
-                lfs_fetch_cmd = ud.basecmd + ['lfs', 'fetch']
-                if fetchall:
-                    lfs_fetch_cmd.append('--all')
-                runfetchcmd(lfs_fetch_cmd, d, log=progresshandler, workdir=(clonedir + "/wt"))
-                worktree_rem_cmd = ud.basecmd + ['worktree', 'remove', '-f', 'wt']
-                runfetchcmd(worktree_rem_cmd, d, log=progresshandler, workdir=clonedir)
-        except:
-            logger.warning("Fetching LFS did not succeed.")
 
     @contextmanager
     def create_atomic(self, filename):
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index a1e4b45f8..813d401b6 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2807,6 +2807,21 @@ class GitLfsTest(FetcherTest):
             shutil.rmtree(self.gitdir, ignore_errors=True)
             fetcher.unpack(self.d.getVar('WORKDIR'))
 
+    @skipIfNoGitLFS()
+    def test_lfs_fetch_failure_raises(self):
+        self.commit_file("a.mp3", "version 1")
+
+        uri = 'git://%s;protocol=file;lfs=1;branch=master' % self.srcdir
+        self.d.setVar('SRC_URI', uri)
+
+        # Simulate a fetch failure by removing the .git/lfs/objects directory
+        # from the source repository
+        shutil.rmtree(os.path.join(self.srcdir, ".git", "lfs", "objects"))
+
+        # Test than exception is raised when LFS objects could not be fetched
+        with self.assertRaises(bb.fetch2.FetchError):
+            self.fetch()
+
 class GitURLWithSpacesTest(FetcherTest):
     test_git_urls = {
         "git://tfs-example.org:22/tfs/example%20path/example.git;branch=master" : {
-- 
2.55.0


