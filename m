Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08136C5478C
	for <webhook@archiver.kernel.org>; Tue, 27 Feb 2024 06:18:49 +0000 (UTC)
Received: from esa6.hc324-48.eu.iphmx.com (esa6.hc324-48.eu.iphmx.com [207.54.71.69])
 by mx.groups.io with SMTP id smtpd.web10.6881.1709014723279126649
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Feb 2024 22:18:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=C3FoWSAM;
 spf=pass (domain: bmw.de, ip: 207.54.71.69, mailfrom: prvs=780903e03=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1709014724; x=1740550724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ORJadGx0wC+vJofh4vONIFmNDljvAVjl+Cugkk/ZABE=;
  b=C3FoWSAM878TZakilcfcRAylrQUJ4sFOVmlCRPygTLVuZVYtVV7kKnop
   +lYgRLUWuP6fYHukDPWS+XhcuNbvMpVP/gFwzjv6B2fIpl5bUocBbmojI
   pDWQlpJHI2rwE/9z2Z0GeT/Qx+wnhlsbqZPJhm4Buq3B6lYmJpbsxsGhW
   8=;
X-CSE-ConnectionGUID: FO11hKMqRkWvTDgbSbKTqw==
X-CSE-MsgGUID: tDWjFVVCTIm6A16ukiwjmg==
Received: from esagw2.bmwgroup.com (HELO esagw2.muc) ([160.46.252.38]) by
 esa6.hc324-48.eu.iphmx.com with ESMTP/TLS; 27 Feb 2024 07:18:43 +0100
Received: from esabb6.muc ([160.50.100.50])  by esagw2.muc with ESMTP/TLS;
 27 Feb 2024 07:18:44 +0100
Received: from smucmp10e.bmwgroup.net (HELO SMUCMP10E.europe.bmw.corp) ([10.30.13.87])
 by esabb6.muc with ESMTP/TLS; 27 Feb 2024 07:18:44 +0100
Received: from localhost.localdomain (10.30.85.207) by SMUCMP10E.europe.bmw.corp
 (2a03:1e80:a15:58f::2027) with Microsoft SMTP Server (version=TLS;
 Tue, 27 Feb 2024 07:18:43 +0100
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: Philip Lorenz <philip.lorenz@bmw.de>, Steve Sakoman <steve@sakoman.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [kirkstone][PATCH 3/3] fetch2: Ensure that git LFS objects are available
Date: Tue, 27 Feb 2024 07:18:08 +0100
Message-ID: <20240227061808.3394661-3-philip.lorenz@bmw.de>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227061808.3394661-1-philip.lorenz@bmw.de>
References: <20240227061808.3394661-1-philip.lorenz@bmw.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SMUCMP04G.europe.bmw.corp (2a03:1e80:a15:58f::217e) To
 SMUCMP10E.europe.bmw.corp (2a03:1e80:a15:58f::2027)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Feb 2024 06:18:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15962

The current implementation only performs a git lfs fetch alongside of a
regular git fetch. This causes issues when the downloaded revision is
already part of the fetched repository (e.g. because of moving back in
history or the updated revision already being part of the repository at
the time of the initial clone).

Fix this by explicitly checking whether the required LFS objects are
available in the downloade directory before confirming that a downloaded
repository is up-to-date.

This issue previously went unnoticed as git lfs would silently fetch the
missing objects during the `unpack` task. With network isolation turned
on, this no longer works, and unpacking fails.

(cherry picked from commit cfae1556bf671acec119a6c8bbc4b667a856b9ae)

Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
---
 lib/bb/fetch2/git.py  | 45 ++++++++++++++++++++++++++++++++++++--
 lib/bb/tests/fetch.py | 51 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 90 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 4d6e57ad..9ecc855a 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -307,7 +307,10 @@ class Git(FetchMethod):
         return ud.clonedir
 
     def need_update(self, ud, d):
-        return self.clonedir_need_update(ud, d) or self.shallow_tarball_need_update(ud) or self.tarball_need_update(ud)
+        return self.clonedir_need_update(ud, d) \
+                or self.shallow_tarball_need_update(ud) \
+                or self.tarball_need_update(ud) \
+                or self.lfs_need_update(ud, d)
 
     def clonedir_need_update(self, ud, d):
         if not os.path.exists(ud.clonedir):
@@ -319,6 +322,15 @@ class Git(FetchMethod):
                 return True
         return False
 
+    def lfs_need_update(self, ud, d):
+        if self.clonedir_need_update(ud, d):
+            return True
+
+        for name in ud.names:
+            if not self._lfs_objects_downloaded(ud, d, name, ud.clonedir):
+                return True
+        return False
+
     def clonedir_need_shallow_revs(self, ud, d):
         for rev in ud.shallow_revs:
             try:
@@ -406,7 +418,7 @@ class Git(FetchMethod):
             if missing_rev:
                 raise bb.fetch2.FetchError("Unable to find revision %s even from upstream" % missing_rev)
 
-        if self._contains_lfs(ud, d, ud.clonedir) and self._need_lfs(ud):
+        if self.lfs_need_update(ud, d):
             # Unpack temporary working copy, use it to run 'git checkout' to force pre-fetching
             # of all LFS blobs needed at the srcrev.
             #
@@ -649,6 +661,35 @@ class Git(FetchMethod):
             raise bb.fetch2.FetchError("The command '%s' gave output with more then 1 line unexpectedly, output: '%s'" % (cmd, output))
         return output.split()[0] != "0"
 
+    def _lfs_objects_downloaded(self, ud, d, name, wd):
+        """
+        Verifies whether the LFS objects for requested revisions have already been downloaded
+        """
+        # Bail out early if this repository doesn't use LFS
+        if not self._need_lfs(ud) or not self._contains_lfs(ud, d, wd):
+            return True
+
+        # The Git LFS specification specifies ([1]) the LFS folder layout so it should be safe to check for file
+        # existence.
+        # [1] https://github.com/git-lfs/git-lfs/blob/main/docs/spec.md#intercepting-git
+        cmd = "%s lfs ls-files -l %s" \
+                % (ud.basecmd, ud.revisions[name])
+        output = runfetchcmd(cmd, d, quiet=True, workdir=wd).rstrip()
+        # Do not do any further matching if no objects are managed by LFS
+        if not output:
+            return True
+
+        # Match all lines beginning with the hexadecimal OID
+        oid_regex = re.compile("^(([a-fA-F0-9]{2})([a-fA-F0-9]{2})[A-Fa-f0-9]+)")
+        for line in output.split("\n"):
+            oid = re.search(oid_regex, line)
+            if not oid:
+                bb.warn("git lfs ls-files output '%s' did not match expected format." % line)
+            if not os.path.exists(os.path.join(wd, "lfs", "objects", oid.group(2), oid.group(3), oid.group(1))):
+                return False
+
+        return True
+
     def _need_lfs(self, ud):
         return ud.parm.get("lfs", "1") == "1"
 
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 847a3560..5aa3e464 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -6,6 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
+import contextlib
 import unittest
 import hashlib
 import tempfile
@@ -2182,10 +2183,14 @@ class GitLfsTest(FetcherTest):
 
         bb.utils.mkdirhier(self.srcdir)
         self.git_init(cwd=self.srcdir)
-        with open(os.path.join(self.srcdir, '.gitattributes'), 'wt') as attrs:
-            attrs.write('*.mp3 filter=lfs -text')
-        self.git(['add', '.gitattributes'], cwd=self.srcdir)
-        self.git(['commit', '-m', "attributes", '.gitattributes'], cwd=self.srcdir)
+        self.commit_file('.gitattributes', '*.mp3 filter=lfs -text')
+
+    def commit_file(self, filename, content):
+        with open(os.path.join(self.srcdir, filename), "w") as f:
+            f.write(content)
+        self.git(["add", filename], cwd=self.srcdir)
+        self.git(["commit", "-m", "Change"], cwd=self.srcdir)
+        return self.git(["rev-parse", "HEAD"], cwd=self.srcdir).strip()
 
     def fetch(self, uri=None, download=True):
         uris = self.d.getVar('SRC_URI').split()
@@ -2205,6 +2210,44 @@ class GitLfsTest(FetcherTest):
         unpacked_lfs_file = os.path.join(self.d.getVar('WORKDIR'), 'git', "Cat_poster_1.jpg")
         return unpacked_lfs_file
 
+    @skipIfNoGitLFS()
+    def test_fetch_lfs_on_srcrev_change(self):
+        """Test if fetch downloads missing LFS objects when a different revision within an existing repository is requested"""
+        self.git(["lfs", "install", "--local"], cwd=self.srcdir)
+
+        @contextlib.contextmanager
+        def hide_upstream_repository():
+            """Hide the upstream repository to make sure that git lfs cannot pull from it"""
+            temp_name = self.srcdir + ".bak"
+            os.rename(self.srcdir, temp_name)
+            try:
+                yield
+            finally:
+                os.rename(temp_name, self.srcdir)
+
+        def fetch_and_verify(revision, filename, content):
+            self.d.setVar('SRCREV', revision)
+            fetcher, ud = self.fetch()
+
+            with hide_upstream_repository():
+                workdir = self.d.getVar('WORKDIR')
+                fetcher.unpack(workdir)
+
+                with open(os.path.join(workdir, "git", filename)) as f:
+                    self.assertEqual(f.read(), content)
+
+        commit_1 = self.commit_file("a.mp3", "version 1")
+        commit_2 = self.commit_file("a.mp3", "version 2")
+
+        self.d.setVar('SRC_URI', "git://%s;protocol=file;lfs=1;branch=master" % self.srcdir)
+
+        # Seed the local download folder by fetching the latest commit and verifying that the LFS contents are
+        # available even when the upstream repository disappears.
+        fetch_and_verify(commit_2, "a.mp3", "version 2")
+        # Verify that even when an older revision is fetched, the needed LFS objects are fetched into the download
+        # folder.
+        fetch_and_verify(commit_1, "a.mp3", "version 1")
+
     @skipIfNoGitLFS()
     @skipIfNoNetwork()
     def test_real_git_lfs_repo_succeeds_without_lfs_param(self):
-- 
2.43.2


