Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952C7C4321E
	for <webhook@archiver.kernel.org>; Sat, 29 Jan 2022 02:29:46 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web10.1536.1643423385092428832
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Jan 2022 18:29:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=OTAcS9I4;
 spf=pass (domain: axis.com, ip: 195.60.68.17,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1643423385;
  x=1674959385;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=bWLB4sQJDd3F9buonTBUSguvYD928WUqKjVeyXsE4UQ=;
  b=OTAcS9I4PU8ifYMFrQ+knjgS8qSJx+UhbFWVjGVVyek68j6i2Z7rgcEm
   IFrpJudK0TvWbDjYSS6j44xlOKexUhq0+cJFNbYhlZ7sBJc0hL0jJy9dd
   geMwSh1SVSbtWNkbByuOrMuNTWlhTYdkpVtQvTWq8lM7pvEmZjl+qk9gu
   SFXIHGcPEhw5A6L6qiQJNeKG4OjchfMDbVj4yYRBnUMxXxeyb1wIZQsib
   FHeNLvFxn7D9a8CCxHTJc6BgvZ+CUDA/PkW31XrNmxx8J+bMpVjiySX/F
   tKTV3WjDDw27zixVbuVykQr0QJpirulrbukQEyWROSkyd4EfljkvH/sW1
   g==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 6/9] tests/fetch: Only set the Git user name/email if they are
 not already set
Date: Sat, 29 Jan 2022 03:29:36 +0100
Message-ID: <20220129022939.19329-6-pkj@axis.com>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13299

If they are set, assume they are correct.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/tests/fetch.py | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index b1ff2c005f..16a1b6f342 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -402,6 +402,13 @@ class FetcherTest(unittest.TestCase):
             cwd = self.gitdir
         return bb.process.run(cmd, cwd=cwd)[0]
 
+    def git_init(self, cwd=None):
+        self.git('init', cwd=cwd)
+        if not self.git(['config', 'user.email'], cwd=cwd):
+            self.git(['config', 'user.email', 'you@example.com'], cwd=cwd)
+        if not self.git(['config', 'user.name'], cwd=cwd):
+            self.git(['config', 'user.name', 'Your Name'], cwd=cwd)
+
 class MirrorUriTest(FetcherTest):
 
     replaceuris = {
@@ -709,9 +716,7 @@ class FetcherLocalTest(FetcherTest):
         src_dir = tempfile.mkdtemp(dir=self.tempdir,
                                    prefix='gitfetch_localusehead_')
         self.gitdir = os.path.abspath(src_dir)
-        self.git('init')
-        self.git('config user.email "you@example.com"')
-        self.git('config user.name "Your Name"')
+        self.git_init()
         self.git(['commit', '--allow-empty', '-m', 'Dummy commit'])
         # Use other branch than master
         self.git(['checkout', '-b', 'my-devel'])
@@ -1443,9 +1448,7 @@ class GitMakeShallowTest(FetcherTest):
         FetcherTest.setUp(self)
         self.gitdir = os.path.join(self.tempdir, 'gitshallow')
         bb.utils.mkdirhier(self.gitdir)
-        self.git('init')
-        self.git('config user.email "you@example.com"')
-        self.git('config user.name "Your Name"')
+        self.git_init()
 
     def assertRefs(self, expected_refs):
         actual_refs = self.git(['for-each-ref', '--format=%(refname)']).splitlines()
@@ -1561,9 +1564,7 @@ class GitShallowTest(FetcherTest):
         self.srcdir = os.path.join(self.tempdir, 'gitsource')
 
         bb.utils.mkdirhier(self.srcdir)
-        self.git('init', cwd=self.srcdir)
-        self.git('config user.email "you@example.com"', cwd=self.srcdir)
-        self.git('config user.name "Your Name"', cwd=self.srcdir)
+        self.git_init(cwd=self.srcdir)
         self.d.setVar('WORKDIR', self.tempdir)
         self.d.setVar('S', self.gitdir)
         self.d.delVar('PREMIRRORS')
@@ -1788,9 +1789,7 @@ class GitShallowTest(FetcherTest):
 
         smdir = os.path.join(self.tempdir, 'gitsubmodule')
         bb.utils.mkdirhier(smdir)
-        self.git('init', cwd=smdir)
-        self.git('config user.email "you@example.com"', cwd=smdir)
-        self.git('config user.name "Your Name"', cwd=smdir)
+        self.git_init(cwd=smdir)
         # Make this look like it was cloned from a remote...
         self.git('config --add remote.origin.url "%s"' % smdir, cwd=smdir)
         self.git('config --add remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"', cwd=smdir)
@@ -1820,9 +1819,7 @@ class GitShallowTest(FetcherTest):
 
         smdir = os.path.join(self.tempdir, 'gitsubmodule')
         bb.utils.mkdirhier(smdir)
-        self.git('init', cwd=smdir)
-        self.git('config user.email "you@example.com"', cwd=smdir)
-        self.git('config user.name "Your Name"', cwd=smdir)
+        self.git_init(cwd=smdir)
         # Make this look like it was cloned from a remote...
         self.git('config --add remote.origin.url "%s"' % smdir, cwd=smdir)
         self.git('config --add remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"', cwd=smdir)
@@ -2140,9 +2137,7 @@ class GitLfsTest(FetcherTest):
         self.d.setVar('AUTOREV', '${@bb.fetch2.get_autorev(d)}')
 
         bb.utils.mkdirhier(self.srcdir)
-        self.git('init', cwd=self.srcdir)
-        self.git('config user.email "you@example.com"', cwd=self.srcdir)
-        self.git('config user.name "Your Name"', cwd=self.srcdir)
+        self.git_init(cwd=self.srcdir)
         with open(os.path.join(self.srcdir, '.gitattributes'), 'wt') as attrs:
             attrs.write('*.mp3 filter=lfs -text')
         self.git(['add', '.gitattributes'], cwd=self.srcdir)

