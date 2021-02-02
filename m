Received: from mga06.intel.com (mga06.intel.com [])
 by mx.groups.io with SMTP id smtpd.web10.48180.1612244307043948624
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Feb 2021 21:38:27 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=fail (domain: intel.com, ip: <nil>, mailfrom: anuj.mittal@intel.com)
IronPort-SDR: GCo9FG/1FqVMNQGvg0lar4/Q3HASa0cCJ4BP2SBoQ1iJ2waD6vDWdwRf8sHdWBUnbkR9Ugvv4x
 5Litwq4DHqVw==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="242317834"
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="242317834"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:38:27 -0800
IronPort-SDR: l6+2TXl6y4QOq2KHtmw4AmPz6Md/g61elCDm8r6K5aX+OS856PbXzEpihaf94CbpO8pUQz9J0L
 McC7/sDfRpgw==
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="391296096"
Received: from ajayap1x-mobl1.gar.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.255.184.137])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:38:26 -0800
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [gatesgarth][PATCH 1/1] fetch/git: download LFS content too during do_fetch
Date: Tue,  2 Feb 2021 13:38:19 +0800
Message-Id: <517accf8c333f007bb9baaa12d6009e286ea6a18.1612244174.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612244174.git.anuj.mittal@intel.com>
References: <cover.1612244174.git.anuj.mittal@intel.com>
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
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/fetch2/git.py  | 44 ++++++++++++++++++++++++++++++++++++++++---
 lib/bb/tests/fetch.py | 28 +++++++++++++++++++--------
 2 files changed, 61 insertions(+), 11 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index b97967b48..b59a7cdc8 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -379,6 +379,35 @@ class Git(FetchMethod):
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
@@ -474,7 +503,7 @@ class Git(FetchMethod):
         if os.path.exists(destdir):
             bb.utils.prunedir(destdir)
 
-        need_lfs = ud.parm.get("lfs", "1") == "1"
+        need_lfs = self._need_lfs(ud)
 
         if not need_lfs:
             ud.basecmd = "GIT_LFS_SKIP_SMUDGE=1 " + ud.basecmd
@@ -563,6 +592,9 @@ class Git(FetchMethod):
             raise bb.fetch2.FetchError("The command '%s' gave output with more then 1 line unexpectedly, output: '%s'" % (cmd, output))
         return output.split()[0] != "0"
 
+    def _need_lfs(self, ud):
+        return ud.parm.get("lfs", "1") == "1"
+
     def _contains_lfs(self, ud, d, wd):
         """
         Check if the repository has 'lfs' (large file) content
@@ -573,8 +605,14 @@ class Git(FetchMethod):
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
index da17d7f28..5b70ee810 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2051,13 +2051,14 @@ class GitLfsTest(FetcherTest):
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
 
@@ -2067,16 +2068,21 @@ class GitLfsTest(FetcherTest):
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
@@ -2087,10 +2093,16 @@ class GitLfsTest(FetcherTest):
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
2.29.2

