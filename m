Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by mx.groups.io with SMTP id smtpd.web08.2245.1619407681768603016
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 25 Apr 2021 20:28:02 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 192.55.52.115, mailfrom: anuj.mittal@intel.com)
IronPort-SDR: ksiQ6+uZuHgbRjH3vuSLrkLAtKB1D3uVKn/+I6Pp2qA3kBRl92ddf81Dcoe5/OII+indoMvKec
 3rCxvcovLf9w==
X-IronPort-AV: E=McAfee;i="6200,9189,9965"; a="195828055"
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="195828055"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 20:28:01 -0700
IronPort-SDR: ihzBsPuatowZMoVo25f4aQMN48uJhS/LynY1DKClK5RilQs/PH5n/wj/ruHnxMk9ncvmedY6hw
 iSgfBiuRJjeg==
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="464923225"
Received: from wsan-mobl1.ccr.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.213.45.138])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 20:28:00 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 2/5] bitbake: tests/fetch: fix test execution without .gitconfig
Date: Mon, 26 Apr 2021 11:27:49 +0800
Message-Id: <7a5a162aa4a0226413bf2e223fa066db281cf992.1619407547.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1619407547.git.anuj.mittal@intel.com>
References: <cover.1619407547.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikko Rapeli <mikko.rapeli@bmw.de>

A CI user validating changes does not have any git push rights or
even a .gitconfig file so fix tests so that they run
by setting the user.name and user.email for the repo before
committing changes.

Fixes errors like:

ERROR: test_that_unpack_throws_an_error_when_the_git_clone_nor_shallow_tarball_exist (bb.tests.fetch.GitShallowTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/home/builder/src/base/poky/bitbake/lib/bb/tests/fetch.py", line 2055, in test_that_unpack_throws_an_error_when_the_git_clone_nor_shallow_tarball_exist
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
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 57c0811f1ee19b6619f4840a39e01e3cb98c34c4)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/tests/fetch.py | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index ddf6e9743..c15616815 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -679,6 +679,8 @@ class FetcherLocalTest(FetcherTest):
                                    prefix='gitfetch_localusehead_')
         src_dir = os.path.abspath(src_dir)
         bb.process.run("git init", cwd=src_dir)
+        bb.process.run("git config user.email 'you@example.com'", cwd=src_dir)
+        bb.process.run("git config user.name 'Your Name'", cwd=src_dir)
         bb.process.run("git commit --allow-empty -m'Dummy commit'",
                        cwd=src_dir)
         # Use other branch than master
@@ -705,6 +707,8 @@ class FetcherLocalTest(FetcherTest):
                                    prefix='gitfetch_localusehead_')
         src_dir = os.path.abspath(src_dir)
         bb.process.run("git init", cwd=src_dir)
+        bb.process.run("git config user.email 'you@example.com'", cwd=src_dir)
+        bb.process.run("git config user.name 'Your Name'", cwd=src_dir)
         bb.process.run("git commit --allow-empty -m'Dummy commit'",
                        cwd=src_dir)
         # Use other branch than master
@@ -1390,6 +1394,8 @@ class GitMakeShallowTest(FetcherTest):
         self.gitdir = os.path.join(self.tempdir, 'gitshallow')
         bb.utils.mkdirhier(self.gitdir)
         bb.process.run('git init', cwd=self.gitdir)
+        bb.process.run('git config user.email "you@example.com"', cwd=self.gitdir)
+        bb.process.run('git config user.name "Your Name"', cwd=self.gitdir)
 
     def assertRefs(self, expected_refs):
         actual_refs = self.git(['for-each-ref', '--format=%(refname)']).splitlines()
@@ -1513,6 +1519,8 @@ class GitShallowTest(FetcherTest):
 
         bb.utils.mkdirhier(self.srcdir)
         self.git('init', cwd=self.srcdir)
+        self.git('config user.email "you@example.com"', cwd=self.srcdir)
+        self.git('config user.name "Your Name"', cwd=self.srcdir)
         self.d.setVar('WORKDIR', self.tempdir)
         self.d.setVar('S', self.gitdir)
         self.d.delVar('PREMIRRORS')
@@ -1746,6 +1754,8 @@ class GitShallowTest(FetcherTest):
         smdir = os.path.join(self.tempdir, 'gitsubmodule')
         bb.utils.mkdirhier(smdir)
         self.git('init', cwd=smdir)
+        self.git('config user.email "you@example.com"', cwd=smdir)
+        self.git('config user.name "Your Name"', cwd=smdir)
         # Make this look like it was cloned from a remote...
         self.git('config --add remote.origin.url "%s"' % smdir, cwd=smdir)
         self.git('config --add remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"', cwd=smdir)
@@ -1776,6 +1786,8 @@ class GitShallowTest(FetcherTest):
         smdir = os.path.join(self.tempdir, 'gitsubmodule')
         bb.utils.mkdirhier(smdir)
         self.git('init', cwd=smdir)
+        self.git('config user.email "you@example.com"', cwd=smdir)
+        self.git('config user.name "Your Name"', cwd=smdir)
         # Make this look like it was cloned from a remote...
         self.git('config --add remote.origin.url "%s"' % smdir, cwd=smdir)
         self.git('config --add remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"', cwd=smdir)
@@ -1818,7 +1830,7 @@ class GitShallowTest(FetcherTest):
             self.git('annex init', cwd=self.srcdir)
             open(os.path.join(self.srcdir, 'c'), 'w').close()
             self.git('annex add c', cwd=self.srcdir)
-            self.git('commit -m annex-c -a', cwd=self.srcdir)
+            self.git('commit --author "Foo Bar <foo@bar>" -m annex-c -a', cwd=self.srcdir)
             bb.process.run('chmod u+w -R %s' % os.path.join(self.srcdir, '.git', 'annex'))
 
             uri = 'gitannex://%s;protocol=file;subdir=${S}' % self.srcdir
@@ -2094,6 +2106,8 @@ class GitLfsTest(FetcherTest):
 
         bb.utils.mkdirhier(self.srcdir)
         self.git('init', cwd=self.srcdir)
+        self.git('config user.email "you@example.com"', cwd=self.srcdir)
+        self.git('config user.name "Your Name"', cwd=self.srcdir)
         with open(os.path.join(self.srcdir, '.gitattributes'), 'wt') as attrs:
             attrs.write('*.mp3 filter=lfs -text')
         self.git(['add', '.gitattributes'], cwd=self.srcdir)
-- 
2.30.2

