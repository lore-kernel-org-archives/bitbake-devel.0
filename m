Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BDAC4167E
	for <webhook@archiver.kernel.org>; Sat, 29 Jan 2022 02:29:46 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web09.1520.1643423382741682585
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Jan 2022 18:29:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=e7Us/qLC;
 spf=pass (domain: axis.com, ip: 195.60.68.17,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1643423385;
  x=1674959385;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=RthV/CXPjdf6ciBHxVla9AOATvzEB+Fs8JxB4C83DBQ=;
  b=e7Us/qLCrcY8i81dAVsOHsQ1qWPO3hL91qMEea0ccdkSHxQmI1WvvgZQ
   LTYt8J5KZEEsEWROyMdzXnkvoO6Qv9rYlDBymkSeOhZwyz3LALMXLlOXD
   hwGgA8OlW3pBkS6EikcuoX0oWo/oMZoBTLgOWmhtBkXjpo9Ud9t+bfY7A
   eLYZMudJHqC5Z4YabKj2cXAzWsp0x8yzHPGLkdZ+HBeRhgjwJIwwL9gVI
   K8FuFaOhONtfZZqN63ZnFMiT/blcf5wsD9NAh9XePTkGCjQJ1o7ysexKi
   1XFt9r15IhRE3cpOLgMwNprfwEDpPu6R6yJIXDy6mTcZDLiepZ+pSXpTa
   Q==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 5/9] tests/fetch: Unify how git commands are run
Date: Sat, 29 Jan 2022 03:29:35 +0100
Message-ID: <20220129022939.19329-5-pkj@axis.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20220129022939.19329-1-pkj@axis.com>
References: <20220129022939.19329-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 29 Jan 2022 02:29:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13298

This unifies the three separate implementations of git() from
GitMakeShallowTest, GitShallowTest and GitLfsTest into one
implementation in FetcherTest. It also makes use of this in
FetcherLocalTest and FetcherNetworkTest.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/tests/fetch.py | 73 +++++++++++++----------------------
 1 file changed, 27 insertions(+), 46 deletions(-)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 5cccdf6ef4..b1ff2c005f 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -393,6 +393,15 @@ class FetcherTest(unittest.TestCase):
             bb.process.run('chmod u+rw -R %s' % self.tempdir)
             bb.utils.prunedir(self.tempdir)
 
+    def git(self, cmd, cwd=None):
+        if isinstance(cmd, str):
+            cmd = 'git ' + cmd
+        else:
+            cmd = ['git'] + cmd
+        if cwd is None:
+            cwd = self.gitdir
+        return bb.process.run(cmd, cwd=cwd)[0]
+
 class MirrorUriTest(FetcherTest):
 
     replaceuris = {
@@ -699,28 +708,24 @@ class FetcherLocalTest(FetcherTest):
         # Create dummy local Git repo
         src_dir = tempfile.mkdtemp(dir=self.tempdir,
                                    prefix='gitfetch_localusehead_')
-        src_dir = os.path.abspath(src_dir)
-        bb.process.run("git init", cwd=src_dir)
-        bb.process.run("git config user.email 'you@example.com'", cwd=src_dir)
-        bb.process.run("git config user.name 'Your Name'", cwd=src_dir)
-        bb.process.run("git commit --allow-empty -m'Dummy commit'",
-                       cwd=src_dir)
+        self.gitdir = os.path.abspath(src_dir)
+        self.git('init')
+        self.git('config user.email "you@example.com"')
+        self.git('config user.name "Your Name"')
+        self.git(['commit', '--allow-empty', '-m', 'Dummy commit'])
         # Use other branch than master
-        bb.process.run("git checkout -b my-devel", cwd=src_dir)
-        bb.process.run("git commit --allow-empty -m'Dummy commit 2'",
-                       cwd=src_dir)
-        stdout = bb.process.run("git rev-parse HEAD", cwd=src_dir)
-        orig_rev = stdout[0].strip()
+        self.git(['checkout', '-b', 'my-devel'])
+        self.git(['commit', '--allow-empty', '-m', 'Dummy commit 2'])
+        orig_rev = self.git(['rev-parse', 'HEAD']).strip()
 
         # Fetch and check revision
         self.d.setVar("SRCREV", "AUTOINC")
-        url = "git://" + src_dir + ";protocol=file;" + suffix
+        url = "git://" + self.gitdir + ";protocol=file;" + suffix
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
-        stdout = bb.process.run("git rev-parse HEAD",
-                                cwd=os.path.join(self.unpackdir, 'git'))
-        unpack_rev = stdout[0].strip()
+        unpack_rev = self.git(['rev-parse', 'HEAD'],
+                              cwd=os.path.join(self.unpackdir, 'git')).strip()
         self.assertEqual(orig_rev, unpack_rev)
 
     def test_local_gitfetch_usehead(self):
@@ -920,7 +925,8 @@ class FetcherNetworkTest(FetcherTest):
     def gitfetcher(self, url1, url2):
         def checkrevision(self, fetcher):
             fetcher.unpack(self.unpackdir)
-            revision = bb.process.run("git rev-parse HEAD", shell=True, cwd=self.unpackdir + "/git")[0].strip()
+            revision = self.git(['rev-parse', 'HEAD'],
+                                cwd=os.path.join(self.unpackdir, 'git')).strip()
             self.assertEqual(revision, "270a05b0b4ba0959fe0624d2a4885d7b70426da5")
 
         self.d.setVar("BB_GENERATE_MIRROR_TARBALLS", "1")
@@ -996,7 +1002,7 @@ class FetcherNetworkTest(FetcherTest):
         recipeurl = "git://someserver.org/bitbake"
         self.sourcedir = self.unpackdir.replace("unpacked", "sourcemirror.git")
         os.chdir(self.tempdir)
-        bb.process.run("git clone %s %s 2> /dev/null" % (realurl, self.sourcedir), shell=True)
+        self.git(['clone', realurl, self.sourcedir], cwd=self.tempdir)
         self.d.setVar("PREMIRRORS", "%s git://%s;protocol=file" % (recipeurl, self.sourcedir))
         self.gitfetcher(recipeurl, recipeurl)
 
@@ -1437,9 +1443,9 @@ class GitMakeShallowTest(FetcherTest):
         FetcherTest.setUp(self)
         self.gitdir = os.path.join(self.tempdir, 'gitshallow')
         bb.utils.mkdirhier(self.gitdir)
-        bb.process.run('git init', cwd=self.gitdir)
-        bb.process.run('git config user.email "you@example.com"', cwd=self.gitdir)
-        bb.process.run('git config user.name "Your Name"', cwd=self.gitdir)
+        self.git('init')
+        self.git('config user.email "you@example.com"')
+        self.git('config user.name "Your Name"')
 
     def assertRefs(self, expected_refs):
         actual_refs = self.git(['for-each-ref', '--format=%(refname)']).splitlines()
@@ -1453,13 +1459,6 @@ class GitMakeShallowTest(FetcherTest):
         actual_count = len(revs.splitlines())
         self.assertEqual(expected_count, actual_count, msg='Object count `%d` is not the expected `%d`' % (actual_count, expected_count))
 
-    def git(self, cmd):
-        if isinstance(cmd, str):
-            cmd = 'git ' + cmd
-        else:
-            cmd = ['git'] + cmd
-        return bb.process.run(cmd, cwd=self.gitdir)[0]
-
     def make_shallow(self, args=None):
         if args is None:
             args = ['HEAD']
@@ -1595,15 +1594,6 @@ class GitShallowTest(FetcherTest):
         actual_count = len(revs.splitlines())
         self.assertEqual(expected_count, actual_count, msg='Object count `%d` is not the expected `%d`' % (actual_count, expected_count))
 
-    def git(self, cmd, cwd=None):
-        if isinstance(cmd, str):
-            cmd = 'git ' + cmd
-        else:
-            cmd = ['git'] + cmd
-        if cwd is None:
-            cwd = self.gitdir
-        return bb.process.run(cmd, cwd=cwd)[0]
-
     def add_empty_file(self, path, cwd=None, msg=None):
         if msg is None:
             msg = path
@@ -2140,7 +2130,7 @@ class GitLfsTest(FetcherTest):
 
         self.gitdir = os.path.join(self.tempdir, 'git')
         self.srcdir = os.path.join(self.tempdir, 'gitsource')
-        
+
         self.d.setVar('WORKDIR', self.tempdir)
         self.d.setVar('S', self.gitdir)
         self.d.delVar('PREMIRRORS')
@@ -2158,15 +2148,6 @@ class GitLfsTest(FetcherTest):
         self.git(['add', '.gitattributes'], cwd=self.srcdir)
         self.git(['commit', '-m', "attributes", '.gitattributes'], cwd=self.srcdir)
 
-    def git(self, cmd, cwd=None):
-        if isinstance(cmd, str):
-            cmd = 'git ' + cmd
-        else:
-            cmd = ['git'] + cmd
-        if cwd is None:
-            cwd = self.gitdir
-        return bb.process.run(cmd, cwd=cwd)[0]
-
     def fetch(self, uri=None, download=True):
         uris = self.d.getVar('SRC_URI').split()
         uri = uris[0]

