Return-Path: <dburns@seegrid.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23429C4167D
	for <webhook@archiver.kernel.org>; Fri,  3 Nov 2023 15:46:17 +0000 (UTC)
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com [209.85.166.225])
 by mx.groups.io with SMTP id smtpd.web11.56408.1699026375493653243
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Nov 2023 08:46:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@seegrid.com header.s=google header.b=pGPTMyax;
 spf=permerror, err=parse error for token &{10 18 _spf.google.com}: parse error for token &{10 18 _netblocks.google.com}: limit exceeded (domain: seegrid.com, ip: 209.85.166.225, mailfrom: dburns@seegrid.com)
Received: by mail-il1-f225.google.com with SMTP id e9e14a558f8ab-35948f3d2bfso1850595ab.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 08:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=seegrid.com; s=google; t=1699026375; x=1699631175; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mis8ltMGwwYSp7MKI5rGNzObaKInHkutUdT13ET2C74=;
        b=pGPTMyaxoJNxR1blUBFTdM40jtRFw/PF4e8/J9/H1/bND2sH4FPj1Zs45IL8rjeJuY
         NMoHVC2vgzh5N7uSwyPLKSgPhyvRss+F7deG+oCBXHLfhWMDak6U06wuSdg4ueVF9ZJY
         uu+Jj0afqqqC201FTu7aVbfWH+crm9eKrwS+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699026375; x=1699631175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mis8ltMGwwYSp7MKI5rGNzObaKInHkutUdT13ET2C74=;
        b=us1e/ZoXAU2Q5+VP/3KRgT2WKkf8+qBbcEgQoJdop9eFK1iBLEaycp8yhI+T3Nmxza
         e0ZCN11g+csjsNH0NSLAxNBmzZ66LlqvScuELzzbhVoKzTfz4DexKdn6kVkf1w6nqjP4
         1AaMrYxGIIw0g9uzRfZljg8QCWaiBqNlI9XKWzzQfuBP79BxMNW017km/dutDaabvDcD
         U9KM4XKQoOgoBcqAVT0PGYMWLmT8MD0XZUeUIC3i9devulyAJPj7UfwQ1FpptdRtx/8b
         2FrCqWmpvSr70MPdHx1YnzP3XPUvNgfIAYeabXkG6/qXd7lmztfp4hcQG+rIKIQGg97f
         chEQ==
X-Gm-Message-State: AOJu0Yx7UaG2yByrON9uSjvUzo6y7qDZtUJejyPVCgjsXD2ofQOZYINM
	ZiG3KssaqowME3we61w+XtsuMp+hVYKDD1h9kq+eXIpdabqk817aqWkOxw==
X-Google-Smtp-Source: AGHT+IGrCV+7tkQLmiAv/5Lc5rUASMlKQO5lGj7diBMkCQOzBEM3TeDeHiEpstxgxGhdkpyNq9zzh4ELvJGO
X-Received: by 2002:a05:6602:5da:b0:7a6:a005:4984 with SMTP id w26-20020a05660205da00b007a6a0054984mr21391598iox.1.1699026374688;
        Fri, 03 Nov 2023 08:46:14 -0700 (PDT)
Received: from relay1.hq.seegrid.local ([50.205.9.50])
        by smtp-relay.gmail.com with ESMTPS id b7-20020a029a07000000b0042b2b936ad6sm98675jal.72.2023.11.03.08.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 08:46:14 -0700 (PDT)
X-Relaying-Domain: seegrid.com
Received: from dburns-l5550.hsd1.pa.comcast.net (client-107.ovpn.hq.seegrid.lan [192.168.222.107])
	by relay1.hq.seegrid.local (Postfix) with ESMTP id ABFA442003A;
	Fri,  3 Nov 2023 11:46:13 -0400 (EDT)
From: Desone Burns II <dburns@seegrid.com>
To: bitbake-devel@lists.openembedded.org
Cc: jchafin@seegrid.com,
	Desone Burns II <dburns@seegrid.com>
Subject: [PATCH] bitbake: fetch2: git: Update Git-LFS download and tests
Date: Fri,  3 Nov 2023 11:45:49 -0400
Message-Id: <20231103154549.34555-1-dburns@seegrid.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 15:46:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15444

When downloading a Git repository containing an LFS, the Git hooks
are not always initialized correctly to perform the download. This
change updates the Git downloader to run the "git lfs install" command
in order to "smudge" the LFS files. The tests have also been updated
to do checks for situations in which git lfs is not installed, as
the application was required to be installed for any of the tests
to run previously.

The Git LFS functionality was working to some degree previously,
but this change also updates the fetcher to allow LFS downloads for
nobranch SRC_URIs.

Signed-off-by: Desone Burns II <dburns@seegrid.com>
---
 bitbake/lib/bb/fetch2/git.py  | 14 ++++++--
 bitbake/lib/bb/tests/fetch.py | 61 ++++++++++++++++++++---------------
 2 files changed, 47 insertions(+), 28 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 27a0d05144..5fb573a381 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -52,6 +52,11 @@ Supported SRC_URI options are:
    For local git:// urls to use the current branch HEAD as the revision for use with
    AUTOREV. Implies nobranch.
 
+- lfs
+    Enable the checkout to use LFS for large files. This will download all LFS files
+    in the download step, as the unpack step does not have network access.
+    The default is "1", set lfs=0 to skip.
+
 """
 
 # Copyright (C) 2005 Richard Purdie
@@ -629,6 +634,8 @@ class Git(FetchMethod):
                 raise bb.fetch2.FetchError("Repository %s has LFS content, install git-lfs on host to download (or set lfs=0 to ignore it)" % (repourl))
             elif not need_lfs:
                 bb.note("Repository %s has LFS content but it is not being fetched" % (repourl))
+            else:
+                runfetchcmd("%s lfs install" % ud.basecmd, d, workdir=destdir)
 
         if not ud.nocheckout:
             if subpath:
@@ -688,8 +695,11 @@ class Git(FetchMethod):
         Check if the repository has 'lfs' (large file) content
         """
 
-        # The bare clonedir doesn't use the remote names; it has the branch immediately.
-        if wd == ud.clonedir:
+        if ud.nobranch:
+            # If no branch is specified, use the current git commit
+            refname = self._build_revision(ud, d, ud.names[0])
+        elif wd == ud.clonedir:
+            # The bare clonedir doesn't use the remote names; it has the branch immediately.
             refname = ud.branches[ud.names[0]]
         else:
             refname = "origin/%s" % ud.branches[ud.names[0]]
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 0e806c0ff7..c7a23407c1 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -2277,7 +2277,7 @@ class GitLfsTest(FetcherTest):
 
     @skipIfNoGitLFS()
     @skipIfNoNetwork()
-    def test_real_git_lfs_repo_succeeds(self):
+    def test_real_git_lfs_repo_skips(self):
         self.d.setVar('SRC_URI', "git://gitlab.com/gitlab-examples/lfs.git;protocol=https;branch=master;lfs=0")
         f = self.get_real_git_lfs_file()
         # This is the actual non-smudged placeholder file on the repo if git-lfs does not run
@@ -2290,24 +2290,41 @@ class GitLfsTest(FetcherTest):
         with open(f) as fh:
             self.assertEqual(lfs_file, fh.read())
 
+    @skipIfNoGitLFS()
     def test_lfs_enabled(self):
         import shutil
 
         uri = 'git://%s;protocol=file;lfs=1;branch=master' % self.srcdir
         self.d.setVar('SRC_URI', uri)
 
-        # Careful: suppress initial attempt at downloading until
-        # we know whether git-lfs is installed.
-        fetcher, ud = self.fetch(uri=None, download=False)
-        self.assertIsNotNone(ud.method._find_git_lfs)
+        # With git-lfs installed, test that we can fetch and unpack
+        fetcher, ud = self.fetch()
+        shutil.rmtree(self.gitdir, ignore_errors=True)
+        fetcher.unpack(self.d.getVar('WORKDIR'))
 
-        # If git-lfs can be found, the unpack should be successful. Only
-        # attempt this with the real live copy of git-lfs installed.
-        if ud.method._find_git_lfs(self.d):
-            fetcher.download()
-            shutil.rmtree(self.gitdir, ignore_errors=True)
-            fetcher.unpack(self.d.getVar('WORKDIR'))
+    @skipIfNoGitLFS()
+    def test_lfs_disabled(self):
+        import shutil
+
+        uri = 'git://%s;protocol=file;lfs=0;branch=master' % self.srcdir
+        self.d.setVar('SRC_URI', uri)
 
+        # Verify that the fetcher can survive even if the source
+        # repository has Git LFS usage configured.
+        fetcher, ud = self.fetch()
+        fetcher.unpack(self.d.getVar('WORKDIR'))
+
+    def test_lfs_enabled_not_installed(self):
+        import shutil
+
+        uri = 'git://%s;protocol=file;lfs=1;branch=master' % self.srcdir
+        self.d.setVar('SRC_URI', uri)
+
+        # Careful: suppress initial attempt at downloading
+        fetcher, ud = self.fetch(uri=None, download=False)
+
+        # Artificially assert that git-lfs is not installed, so
+        # we can verify a failure to unpack in it's absence.
         old_find_git_lfs = ud.method._find_git_lfs
         try:
             # If git-lfs cannot be found, the unpack should throw an error
@@ -2319,29 +2336,21 @@ class GitLfsTest(FetcherTest):
         finally:
             ud.method._find_git_lfs = old_find_git_lfs
 
-    def test_lfs_disabled(self):
+    def test_lfs_disabled_not_installed(self):
         import shutil
 
         uri = 'git://%s;protocol=file;lfs=0;branch=master' % self.srcdir
         self.d.setVar('SRC_URI', uri)
 
-        # In contrast to test_lfs_enabled(), allow the implicit download
-        # done by self.fetch() to occur here. The point of this test case
-        # is to verify that the fetcher can survive even if the source
-        # repository has Git LFS usage configured.
-        fetcher, ud = self.fetch()
-        self.assertIsNotNone(ud.method._find_git_lfs)
+        # Careful: suppress initial attempt at downloading
+        fetcher, ud = self.fetch(uri=None, download=False)
 
+        # Artificially assert that git-lfs is not installed, so
+        # we can verify a failure to unpack in it's absence.
         old_find_git_lfs = ud.method._find_git_lfs
         try:
-            # If git-lfs can be found, the unpack should be successful. A
-            # live copy of git-lfs is not required for this case, so
-            # unconditionally forge its presence.
-            ud.method._find_git_lfs = lambda d: True
-            shutil.rmtree(self.gitdir, ignore_errors=True)
-            fetcher.unpack(self.d.getVar('WORKDIR'))
-            # If git-lfs cannot be found, the unpack should be successful
-
+            # Even if git-lfs cannot be found, the unpack should be successful
+            fetcher.download()
             ud.method._find_git_lfs = lambda d: False
             shutil.rmtree(self.gitdir, ignore_errors=True)
             fetcher.unpack(self.d.getVar('WORKDIR'))
-- 
2.25.1


