Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web08.9804.1612362177261663487
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Feb 2021 06:22:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=s11Iz9Uf;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.172, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f172.google.com with SMTP id g3so14501071plp.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 03 Feb 2021 06:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WAZBJg0IMmpBpaKmcdjVzcUYrcabva8C9N19MkRvsBs=;
        b=s11Iz9UfjDI3uONWAGzqMpgJRMqJGj7vZQ/t/P1BkM2ZBsDEu19LVtLX3eUKZ6GgyV
         14vODxw3l2/QkNeLNyL8Ti3rYt3lYbnQ/X+sm1dVHx6cB/qrLWPwvbSNx8EkHpcci5/L
         ymAwg0QDj9+X0opPwJBb9DxPmIPWpRZtfxj3zj4jY3fFLXQ8EDf4F0YaMdnrQMM+zteq
         PEoz7fzYesJ/ML4KFETleGVgp+yxOPwQQdXEPnuMxzUs0b2KS5CC4TueoUvwksXR+zWW
         A+hTzgMWveKzTpuquZryqUc9moxlfKfk98fDNNHyv0ow07taYbeh25fkDs9o0yb0WELG
         4YsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WAZBJg0IMmpBpaKmcdjVzcUYrcabva8C9N19MkRvsBs=;
        b=EF4a+MEiVp3jGpGrq5S7Zbq7btdLp4lwFtkC2jJHgmsX08hHIlS2BkgGzkLHV8rVh9
         NtUmi94P8rytjw/UMeHugJSXridVay6D0V/wkw4FSpY3dUTLEgOntH718Esf2fsRat2j
         kNiG9YkdMgHJZT3APPZAjBVyNWus4hJu9eRkdS2oHPgYcDMYIsEHm4wAUh4xxirIXVoI
         FwAcGEJp/PSFVW9LzoCkN95DUIfiynBUck3mfqs8aLSfKr7/smC7pVP44gMwgWCi12sT
         sau1WF1wqkgem78PVN542CeBHF16bInTrR3XGr+N2FDwQiVfHy+V07ZkQyQtquFhsFv9
         9yvA==
X-Gm-Message-State: AOAM5335mLhS598J4MlhoRBqwb1vT3WsNjJrn4HpasaqmVyjvncEViO3
	FwCmt3ZLHYV8/e1NUe/Qcu1sdhuqL8ImjYZGJSc=
X-Google-Smtp-Source: ABdhPJyh6f3vxmKJ3Y/A8Jf1GyeHn/PBFLNGQYnSNA470h1ohWL2vlLISn92pLSeuc4JSfogEBDduQ==
X-Received: by 2002:a17:902:f28d:b029:e2:9654:ed31 with SMTP id k13-20020a170902f28db02900e29654ed31mr542596plc.2.1612362176077;
        Wed, 03 Feb 2021 06:22:56 -0800 (PST)
Return-Path: <steve@sakoman.com>
Received: from hexa.router0800d9.com ([72.173.249.164])
        by smtp.gmail.com with ESMTPSA id t129sm2882713pfc.16.2021.02.03.06.22.52
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 06:22:55 -0800 (PST)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 4/4] fetch/git: download LFS content too during do_fetch
Date: Wed,  3 Feb 2021 04:22:09 -1000
Message-Id: <e6812c823cf25b51e7ad5c09c3c153d34c99deee.1612361853.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1612361853.git.steve@sakoman.com>
References: <cover.1612361853.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matt Hoosier <matt.hoosier@garmin.com>

Insert an explicit pass to fetch all blobs needed by Git LFS, during the
fetch() function. This avoids the default behavior of Git LFS to wait
until 'git checkout' to begin downloading the blobs pointed to by LFS records.
Network access is not allowed at that point in the recipe's lifecycle.

[YOCTO #14191]

Signed-off-by: Matt Hoosier <matt.hoosier@garmin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 0efac66043662e7a2027192f50e92e982db2ba1c)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/git.py  | 44 ++++++++++++++++++++++++++++++++++++++++---
 lib/bb/tests/fetch.py | 28 +++++++++++++++++++--------
 2 files changed, 61 insertions(+), 11 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 07064c69..8740e9c0 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -378,6 +378,35 @@ class Git(FetchMethod):
             if missing_rev:
                 raise bb.fetch2.FetchError("Unable to find revision %s even from upstream" % missing_rev)
 
+        if self._contains_lfs(ud, d, ud.clonedir) and self._need_lfs(ud):
+            # Unpack temporary working copy, use it to run 'git checkout' to force pre-fetching
+            # of all LFS blobs needed at the the srcrev.
+            #
+            # It would be nice to just do this inline here by running 'git-lfs fetch'
+            # on the bare clonedir, but that operation requires a working copy on some
+            # releases of Git LFS.
+            tmpdir = tempfile.mkdtemp(dir=d.getVar('DL_DIR'))
+            try:
+                # Do the checkout. This implicitly involves a Git LFS fetch.
+                self.unpack(ud, tmpdir, d)
+
+                # Scoop up a copy of any stuff that Git LFS downloaded. Merge them into
+                # the bare clonedir.
+                #
+                # As this procedure is invoked repeatedly on incremental fetches as
+                # a recipe's SRCREV is bumped throughout its lifetime, this will
+                # result in a gradual accumulation of LFS blobs in <ud.clonedir>/lfs
+                # corresponding to all the blobs reachable from the different revs
+                # fetched across time.
+                #
+                # Only do this if the unpack resulted in a .git/lfs directory being
+                # created; this only happens if at least one blob needed to be
+                # downloaded.
+                if os.path.exists(os.path.join(tmpdir, "git", ".git", "lfs")):
+                    runfetchcmd("tar -cf - lfs | tar -xf - -C %s" % ud.clonedir, d, workdir="%s/git/.git" % tmpdir)
+            finally:
+                bb.utils.remove(tmpdir, recurse=True)
+
     def build_mirror_data(self, ud, d):
         if ud.shallow and ud.write_shallow_tarballs:
             if not os.path.exists(ud.fullshallow):
@@ -473,7 +502,7 @@ class Git(FetchMethod):
         if os.path.exists(destdir):
             bb.utils.prunedir(destdir)
 
-        need_lfs = ud.parm.get("lfs", "1") == "1"
+        need_lfs = self._need_lfs(ud)
 
         if not need_lfs:
             ud.basecmd = "GIT_LFS_SKIP_SMUDGE=1 " + ud.basecmd
@@ -562,6 +591,9 @@ class Git(FetchMethod):
             raise bb.fetch2.FetchError("The command '%s' gave output with more then 1 line unexpectedly, output: '%s'" % (cmd, output))
         return output.split()[0] != "0"
 
+    def _need_lfs(self, ud):
+        return ud.parm.get("lfs", "1") == "1"
+
     def _contains_lfs(self, ud, d, wd):
         """
         Check if the repository has 'lfs' (large file) content
@@ -572,8 +604,14 @@ class Git(FetchMethod):
         else:
             branchname = "master"
 
-        cmd = "%s grep lfs origin/%s:.gitattributes | wc -l" % (
-            ud.basecmd, ud.branches[ud.names[0]])
+        # The bare clonedir doesn't use the remote names; it has the branch immediately.
+        if wd == ud.clonedir:
+            refname = ud.branches[ud.names[0]]
+        else:
+            refname = "origin/%s" % ud.branches[ud.names[0]]
+
+        cmd = "%s grep lfs %s:.gitattributes | wc -l" % (
+            ud.basecmd, refname)
 
         try:
             output = runfetchcmd(cmd, d, quiet=True, workdir=wd)
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 4702c99a..9453c90d 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2046,13 +2046,14 @@ class GitLfsTest(FetcherTest):
             cwd = self.gitdir
         return bb.process.run(cmd, cwd=cwd)[0]
 
-    def fetch(self, uri=None):
+    def fetch(self, uri=None, download=True):
         uris = self.d.getVar('SRC_URI').split()
         uri = uris[0]
         d = self.d
 
         fetcher = bb.fetch2.Fetch(uris, d)
-        fetcher.download()
+        if download:
+            fetcher.download()
         ud = fetcher.ud[uri]
         return fetcher, ud
 
@@ -2062,16 +2063,21 @@ class GitLfsTest(FetcherTest):
         uri = 'git://%s;protocol=file;subdir=${S};lfs=1' % self.srcdir
         self.d.setVar('SRC_URI', uri)
 
-        fetcher, ud = self.fetch()
+        # Careful: suppress initial attempt at downloading until
+        # we know whether git-lfs is installed.
+        fetcher, ud = self.fetch(uri=None, download=False)
         self.assertIsNotNone(ud.method._find_git_lfs)
 
-        # If git-lfs can be found, the unpack should be successful
-        ud.method._find_git_lfs = lambda d: True
-        shutil.rmtree(self.gitdir, ignore_errors=True)
-        fetcher.unpack(self.d.getVar('WORKDIR'))
+        # If git-lfs can be found, the unpack should be successful. Only
+        # attempt this with the real live copy of git-lfs installed.
+        if ud.method._find_git_lfs(self.d):
+            fetcher.download()
+            shutil.rmtree(self.gitdir, ignore_errors=True)
+            fetcher.unpack(self.d.getVar('WORKDIR'))
 
         # If git-lfs cannot be found, the unpack should throw an error
         with self.assertRaises(bb.fetch2.FetchError):
+            fetcher.download()
             ud.method._find_git_lfs = lambda d: False
             shutil.rmtree(self.gitdir, ignore_errors=True)
             fetcher.unpack(self.d.getVar('WORKDIR'))
@@ -2082,10 +2088,16 @@ class GitLfsTest(FetcherTest):
         uri = 'git://%s;protocol=file;subdir=${S};lfs=0' % self.srcdir
         self.d.setVar('SRC_URI', uri)
 
+        # In contrast to test_lfs_enabled(), allow the implicit download
+        # done by self.fetch() to occur here. The point of this test case
+        # is to verify that the fetcher can survive even if the source
+        # repository has Git LFS usage configured.
         fetcher, ud = self.fetch()
         self.assertIsNotNone(ud.method._find_git_lfs)
 
-        # If git-lfs can be found, the unpack should be successful
+        # If git-lfs can be found, the unpack should be successful. A
+        # live copy of git-lfs is not required for this case, so
+        # unconditionally forge its presence.
         ud.method._find_git_lfs = lambda d: True
         shutil.rmtree(self.gitdir, ignore_errors=True)
         fetcher.unpack(self.d.getVar('WORKDIR'))
-- 
2.25.1

