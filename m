Return-Path: <dburns@seegrid.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F84C25B6B
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 19:08:39 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.web11.79823.1698347312091294108
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Oct 2023 12:08:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@seegrid.com header.s=google header.b=ceGaaDHZ;
 spf=permerror, err=parse error for token &{10 18 _spf.google.com}: parse error for token &{10 18 _netblocks.google.com}: limit exceeded (domain: seegrid.com, ip: 209.85.219.43, mailfrom: dburns@seegrid.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-66d32cc3957so2715046d6.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 26 Oct 2023 12:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=seegrid.com; s=google; t=1698347311; x=1698952111; darn=lists.openembedded.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ueQcMCRxdhJsoWlTGZcIzror17hXvQidsGRMCYym/hE=;
        b=ceGaaDHZReZISNxbeKpMiJEXwcdrIxrAmzeMoM3moka+72O+3OSpHp7G+IKwvPH5wX
         /GoGTMEDhSlm9h4AcSC6/13Dm/pp0JznX5FwhAoOmggXak4uLe0dMMQmpNX2HAOoiyQG
         qXDAlXxDVS/UBfngWLrJiG3N5s2SybFh+i6tI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698347311; x=1698952111;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ueQcMCRxdhJsoWlTGZcIzror17hXvQidsGRMCYym/hE=;
        b=uuHFWwk7H53ZvSqjKTGDPO0hCnzpHBKDaHXH8O6Ktv9j7EcRNJv39LtjWr7ZrbcCOY
         6QI0C/KaqyRQnK7br2RobeOks4ZzULarjoqNCEd7KRoAxaCLK6xk1zrBpdpkoJkhiz0k
         ExwKfEVgXeLm/GzDOwNON2GzeCnr04KxyPThBecKyX7f20iOPRznU8ZAgcUt7Kdc6GCH
         +5zRZMMjx60xQWqaikjqVW6z2Y32IVgILL6rWwuzO+jWaB1wNUyC0B+feoiIhvUG0KRf
         CuuOpFLeFW3C1y61XsDRwOSjM4zOkJtMwS6U0n29Lbcm6C8jsc6Sd0KilYoQPkxFUkbu
         mGlQ==
X-Gm-Message-State: AOJu0YzGtWhQBnRFUR/mParA1QEeTotGl01PC3dWV7IKGVBwz5rpVyF4
	Y9YxNyMSyPhyl9/SxfnO4hQR5kL8jBLK/2l8wsiivNCI0GVSPBSBTDcfQQ==
X-Google-Smtp-Source: AGHT+IGZYNTd1Ha2A3Rp4fzhGVs3fYOrj82aPJrv7syDlWrloxaObEaESupYP0+2PI8iLZnqaRIYrmzVAcy0tf+krEg=
X-Received: by 2002:a05:6214:5691:b0:66d:1012:c16a with SMTP id
 qm17-20020a056214569100b0066d1012c16amr595322qvb.1.1698347310905; Thu, 26 Oct
 2023 12:08:30 -0700 (PDT)
MIME-Version: 1.0
From: Desone Burns <dburns@seegrid.com>
Date: Thu, 26 Oct 2023 15:08:20 -0400
Message-ID: <CAJZje+twx_dTXN-fwJA604NR6ELcensg63VOk1QJVELAGBpgPQ@mail.gmail.com>
Subject: [PATCH v2] bitbake: fetch2: git: Add git-lfs install step
To: bitbake-devel@lists.openembedded.org, Joseph Chafin <jchafin@seegrid.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Oct 2023 19:08:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15298

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
    For local git:// urls to use the current branch HEAD as the
revision for use with
    AUTOREV. Implies nobranch.

+- lfs
+    Enable the checkout to use LFS for large files. This will
download all LFS files
+    in the download step, as the unpack step does not have network access.
+    The default is "1", set lfs=3D0 to skip.
+
 """

 # Copyright (C) 2005 Richard Purdie
@@ -629,6 +634,8 @@ class Git(FetchMethod):
                 raise bb.fetch2.FetchError("Repository %s has LFS
content, install git-lfs on host to download (or set lfs=3D0 to ignore
it)" % (repourl))
             elif not need_lfs:
                 bb.note("Repository %s has LFS content but it is not
being fetched" % (repourl))
+            else:
+                runfetchcmd("%s lfs install" % ud.basecmd, d, workdir=3Dde=
stdir)

         if not ud.nocheckout:
             if subpath:
@@ -688,8 +695,11 @@ class Git(FetchMethod):
         Check if the repository has 'lfs' (large file) content
         """

-        # The bare clonedir doesn't use the remote names; it has the
branch immediately.
-        if wd =3D=3D ud.clonedir:
+        if ud.nobranch:
+            # If no branch is specified, use the current git commit
+            refname =3D self._build_revision(ud, d, ud.names[0])
+        elif wd =3D=3D ud.clonedir:
+            # The bare clonedir doesn't use the remote names; it has
the branch immediately.
             refname =3D ud.branches[ud.names[0]]
         else:
             refname =3D "origin/%s" % ud.branches[ud.names[0]]
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 0e806c0ff7..c7a23407c1 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -2277,7 +2277,7 @@ class GitLfsTest(FetcherTest):

     @skipIfNoGitLFS()
     @skipIfNoNetwork()
-    def test_real_git_lfs_repo_succeeds(self):
+    def test_real_git_lfs_repo_skips(self):
         self.d.setVar('SRC_URI',
"git://gitlab.com/gitlab-examples/lfs.git;protocol=3Dhttps;branch=3Dmaster;=
lfs=3D0")
         f =3D self.get_real_git_lfs_file()
         # This is the actual non-smudged placeholder file on the repo
if git-lfs does not run
@@ -2290,24 +2290,41 @@ class GitLfsTest(FetcherTest):
         with open(f) as fh:
             self.assertEqual(lfs_file, fh.read())

+    @skipIfNoGitLFS()
     def test_lfs_enabled(self):
         import shutil

         uri =3D 'git://%s;protocol=3Dfile;lfs=3D1;branch=3Dmaster' % self.=
srcdir
         self.d.setVar('SRC_URI', uri)

-        # Careful: suppress initial attempt at downloading until
-        # we know whether git-lfs is installed.
-        fetcher, ud =3D self.fetch(uri=3DNone, download=3DFalse)
-        self.assertIsNotNone(ud.method._find_git_lfs)
+        # With git-lfs installed, test that we can fetch and unpack
+        fetcher, ud =3D self.fetch()
+        shutil.rmtree(self.gitdir, ignore_errors=3DTrue)
+        fetcher.unpack(self.d.getVar('WORKDIR'))

-        # If git-lfs can be found, the unpack should be successful. Only
-        # attempt this with the real live copy of git-lfs installed.
-        if ud.method._find_git_lfs(self.d):
-            fetcher.download()
-            shutil.rmtree(self.gitdir, ignore_errors=3DTrue)
-            fetcher.unpack(self.d.getVar('WORKDIR'))
+    @skipIfNoGitLFS()
+    def test_lfs_disabled(self):
+        import shutil
+
+        uri =3D 'git://%s;protocol=3Dfile;lfs=3D0;branch=3Dmaster' % self.=
srcdir
+        self.d.setVar('SRC_URI', uri)

+        # Verify that the fetcher can survive even if the source
+        # repository has Git LFS usage configured.
+        fetcher, ud =3D self.fetch()
+        fetcher.unpack(self.d.getVar('WORKDIR'))
+
+    def test_lfs_enabled_not_installed(self):
+        import shutil
+
+        uri =3D 'git://%s;protocol=3Dfile;lfs=3D1;branch=3Dmaster' % self.=
srcdir
+        self.d.setVar('SRC_URI', uri)
+
+        # Careful: suppress initial attempt at downloading
+        fetcher, ud =3D self.fetch(uri=3DNone, download=3DFalse)
+
+        # Artificially assert that git-lfs is not installed, so
+        # we can verify a failure to unpack in it's absence.
         old_find_git_lfs =3D ud.method._find_git_lfs
         try:
             # If git-lfs cannot be found, the unpack should throw an error
@@ -2319,29 +2336,21 @@ class GitLfsTest(FetcherTest):
         finally:
             ud.method._find_git_lfs =3D old_find_git_lfs

-    def test_lfs_disabled(self):
+    def test_lfs_disabled_not_installed(self):
         import shutil

         uri =3D 'git://%s;protocol=3Dfile;lfs=3D0;branch=3Dmaster' % self.=
srcdir
         self.d.setVar('SRC_URI', uri)

-        # In contrast to test_lfs_enabled(), allow the implicit download
-        # done by self.fetch() to occur here. The point of this test case
-        # is to verify that the fetcher can survive even if the source
-        # repository has Git LFS usage configured.
-        fetcher, ud =3D self.fetch()
-        self.assertIsNotNone(ud.method._find_git_lfs)
+        # Careful: suppress initial attempt at downloading
+        fetcher, ud =3D self.fetch(uri=3DNone, download=3DFalse)

+        # Artificially assert that git-lfs is not installed, so
+        # we can verify a failure to unpack in it's absence.
         old_find_git_lfs =3D ud.method._find_git_lfs
         try:
-            # If git-lfs can be found, the unpack should be successful. A
-            # live copy of git-lfs is not required for this case, so
-            # unconditionally forge its presence.
-            ud.method._find_git_lfs =3D lambda d: True
-            shutil.rmtree(self.gitdir, ignore_errors=3DTrue)
-            fetcher.unpack(self.d.getVar('WORKDIR'))
-            # If git-lfs cannot be found, the unpack should be successful
-
+            # Even if git-lfs cannot be found, the unpack should be succes=
sful
+            fetcher.download()
             ud.method._find_git_lfs =3D lambda d: False
             shutil.rmtree(self.gitdir, ignore_errors=3DTrue)
             fetcher.unpack(self.d.getVar('WORKDIR'))
--=20
2.25.1


--=20
Desone Burns II
Software Engineer III
seegrid.com  =E2=80=A2  412-379-4500
m: 623-258-7361

