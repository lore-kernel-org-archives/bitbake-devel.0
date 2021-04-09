Received: from mail.kapsi.fi (mail.kapsi.fi [91.232.154.25])
 by mx.groups.io with SMTP id smtpd.web11.9690.1617977204266708816
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Apr 2021 07:06:44 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: lakka.kapsi.fi, ip: 91.232.154.25, mailfrom: mcfrisk@lakka.kapsi.fi)
Received: from kapsi.fi ([2001:67c:1be8::11] helo=lakka.kapsi.fi)
	by mail.kapsi.fi with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.89)
	(envelope-from <mcfrisk@lakka.kapsi.fi>)
	id 1lUrmT-0007HP-OB; Fri, 09 Apr 2021 17:06:42 +0300
Received: from mcfrisk by lakka.kapsi.fi with local (Exim 4.92)
	(envelope-from <mcfrisk@lakka.kapsi.fi>)
	id 1lUrmT-000387-Mo; Fri, 09 Apr 2021 17:06:41 +0300
From: "Mikko Rapeli" <mikko.rapeli@bmw.de>
To: bitbake-devel@lists.openembedded.org
Cc: Mikko Rapeli <mikko.rapeli@bmw.de>
Subject: [dunfell][PATCH 1/2] bitbake: tests/fetch: fix test execution without .gitconfig
Date: Fri,  9 Apr 2021 17:06:36 +0300
Message-Id: <20210409140637.11778-1-mikko.rapeli@bmw.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Rspam-Score: 2.3 (++)
X-Rspam-Report: Action: no action
 Symbol: RCVD_TLS_LAST(0.00)
 Symbol: ARC_NA(0.00)
 Symbol: DMARC_POLICY_SOFTFAIL(0.10)
 Symbol: FROM_HAS_DN(0.00)
 Symbol: TO_DN_SOME(0.00)
 Symbol: R_MISSING_CHARSET(2.50)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: MIME_GOOD(-0.10)
 Symbol: BROKEN_CONTENT_TYPE(1.50)
 Symbol: RCPT_COUNT_TWO(0.00)
 Symbol: MID_CONTAINS_FROM(1.00)
 Symbol: R_SPF_NA(0.00)
 Symbol: FORGED_SENDER(0.30)
 Symbol: R_DKIM_NA(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: ASN(0.00)
 Symbol: FROM_NEQ_ENVFROM(0.00)
 Symbol: BAYES_HAM(-3.00)
 Symbol: RCVD_COUNT_TWO(0.00)
 Message-ID: 20210409140637.11778-1-mikko.rapeli@bmw.de
X-SA-Exim-Connect-IP: 2001:67c:1be8::11
X-SA-Exim-Mail-From: mcfrisk@lakka.kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Content-Transfer-Encoding: 8bit

A CI user validating changes does not have any git push rights or
even a .gitconfig file so fix tests so that they run
by setting the user.name and user.email for the repo before
committing changes.

Fixes errors like:

ERROR: test_that_unpack_throws_an_error_when_the_git_clone_nor_shallow_tarball_exist (bb.tests.fetch.GitShallowTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/home/builder/src/base/poky/bitbake/lib/bb/tests/fetch.py", line 2055, in test_that_unpack_throws_an_error_when_the_git_clone_no
r_shallow_tarball_exist
    self.add_empty_file('a')
  File "/home/builder/src/base/poky/bitbake/lib/bb/tests/fetch.py", line 1562, in add_empty_file
    self.git(['commit', '-m', msg, path], cwd)
  File "/home/builder/src/base/poky/bitbake/lib/bb/tests/fetch.py", line 1553, in git
    return bb.process.run(cmd, cwd=cwd)[0]
  File "/home/builder/src/base/poky/bitbake/lib/bb/process.py", line 184, in run
    raise ExecutionError(cmd, pipe.returncode, stdout, stderr)
bb.process.ExecutionError: Execution of 'git commit -m a a' failed with exit code 128:

*** Please tell me who you are.

Run

  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"

to set your account's default identity.
Omit --global to set the identity only in this repository.

Signed-off-by: Mikko Rapeli <mikko.rapeli@bmw.de>
---
 bitbake/lib/bb/tests/fetch.py | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 9453c90d2b..9a4f5f11e2 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -845,6 +845,8 @@ class FetcherNetworkTest(FetcherTest):
                                    prefix='gitfetch_localusehead_')
         src_dir = os.path.abspath(src_dir)
         bb.process.run("git init", cwd=src_dir)
+        bb.process.run("git config user.email 'you@example.com'", cwd=src_dir)
+        bb.process.run("git config user.name 'Your Name'", cwd=src_dir)
         bb.process.run("git commit --allow-empty -m'Dummy commit'",
                        cwd=src_dir)
         # Use other branch than master
@@ -1328,6 +1330,8 @@ class GitMakeShallowTest(FetcherTest):
         self.gitdir = os.path.join(self.tempdir, 'gitshallow')
         bb.utils.mkdirhier(self.gitdir)
         bb.process.run('git init', cwd=self.gitdir)
+        bb.process.run('git config user.email "you@example.com"', cwd=self.gitdir)
+        bb.process.run('git config user.name "Your Name"', cwd=self.gitdir)
 
     def assertRefs(self, expected_refs):
         actual_refs = self.git(['for-each-ref', '--format=%(refname)']).splitlines()
@@ -1451,6 +1455,8 @@ class GitShallowTest(FetcherTest):
 
         bb.utils.mkdirhier(self.srcdir)
         self.git('init', cwd=self.srcdir)
+        self.git('config user.email "you@example.com"', cwd=self.srcdir)
+        self.git('config user.name "Your Name"', cwd=self.srcdir)
         self.d.setVar('WORKDIR', self.tempdir)
         self.d.setVar('S', self.gitdir)
         self.d.delVar('PREMIRRORS')
@@ -1684,6 +1690,8 @@ class GitShallowTest(FetcherTest):
         smdir = os.path.join(self.tempdir, 'gitsubmodule')
         bb.utils.mkdirhier(smdir)
         self.git('init', cwd=smdir)
+        self.git('config user.email "you@example.com"', cwd=smdir)
+        self.git('config user.name "Your Name"', cwd=smdir)
         # Make this look like it was cloned from a remote...
         self.git('config --add remote.origin.url "%s"' % smdir, cwd=smdir)
         self.git('config --add remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"', cwd=smdir)
@@ -1714,6 +1722,8 @@ class GitShallowTest(FetcherTest):
         smdir = os.path.join(self.tempdir, 'gitsubmodule')
         bb.utils.mkdirhier(smdir)
         self.git('init', cwd=smdir)
+        self.git('config user.email "you@example.com"', cwd=smdir)
+        self.git('config user.name "Your Name"', cwd=smdir)
         # Make this look like it was cloned from a remote...
         self.git('config --add remote.origin.url "%s"' % smdir, cwd=smdir)
         self.git('config --add remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"', cwd=smdir)
@@ -1756,7 +1766,7 @@ class GitShallowTest(FetcherTest):
             self.git('annex init', cwd=self.srcdir)
             open(os.path.join(self.srcdir, 'c'), 'w').close()
             self.git('annex add c', cwd=self.srcdir)
-            self.git('commit -m annex-c -a', cwd=self.srcdir)
+            self.git('commit --author "Foo Bar <foo@bar>" -m annex-c -a', cwd=self.srcdir)
             bb.process.run('chmod u+w -R %s' % os.path.join(self.srcdir, '.git', 'annex'))
 
             uri = 'gitannex://%s;protocol=file;subdir=${S}' % self.srcdir
@@ -2032,6 +2042,8 @@ class GitLfsTest(FetcherTest):
 
         bb.utils.mkdirhier(self.srcdir)
         self.git('init', cwd=self.srcdir)
+        self.git('config user.email "you@example.com"', cwd=self.srcdir)
+        self.git('config user.name "Your Name"', cwd=self.srcdir)
         with open(os.path.join(self.srcdir, '.gitattributes'), 'wt') as attrs:
             attrs.write('*.mp3 filter=lfs -text')
         self.git(['add', '.gitattributes'], cwd=self.srcdir)
-- 
2.20.1

