Received: from mga14.intel.com (mga14.intel.com [])
 by mx.groups.io with SMTP id smtpd.web11.2273.1619407679873857581
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 25 Apr 2021 20:28:03 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=fail (domain: intel.com, ip: <nil>, mailfrom: anuj.mittal@intel.com)
IronPort-SDR: VAppJtPRBfb7NiuMrz7YNjyGfVkCTn6gZBHz8qDbCZC+vSs7F2EDAHQPH1qlGwljJ1Tqidz8+7
 FlJLkw5CrPsg==
X-IronPort-AV: E=McAfee;i="6200,9189,9965"; a="195828058"
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="195828058"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 20:28:03 -0700
IronPort-SDR: eOaZZ9TSEeEi7qzYMhmFIiC25dfAt834URZervpWQm/+BM9M7iF0aIoTpLV3cBvLg1I+X0FVZv
 dGTXcxMKiKmw==
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="464923235"
Received: from wsan-mobl1.ccr.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.213.45.138])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 20:28:01 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 3/5] bitbake: tests/fetch: remove write protected files too
Date: Mon, 26 Apr 2021 11:27:50 +0800
Message-Id: <9a271a4f4dc87ecb7c36956d7e0f0643727524fe.1619407547.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1619407547.git.anuj.mittal@intel.com>
References: <cover.1619407547.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikko Rapeli <mikko.rapeli@bmw.de>

For some reason several git-annex files in Debian 10 buster
are read-only and removing them with "rm -rf" fails.

Fixes test failures like:

$ bitbake-selftest
...
rm: cannot remove '/tmp/tmpwmfn4w64/download/git2/tmp.tmpwmfn4w64.gitsource/annex/objects/f87/4d5/SHA256E-s0--e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855/SHA256E-s0--e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855': Permission denied
rm: cannot remove '/tmp/tmpwmfn4w64/download/git2/tmp.tmpwmfn4w64.gitsource/annex/objects/f87/4d5/SHA256E-s0--e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855/SHA256E-s0--e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855': Permission denied
EE..................................ssss.sssssssssssssss.sssss.......................................................................................................
======================================================================
ERROR: test_shallow_annex (bb.tests.fetch.GitShallowTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/home/builder/src/base/poky/bitbake/lib/bb/tests/fetch.py", line 1773, in test_shallow_annex
    fetcher, ud = self.fetch_shallow(uri)
  File "/home/builder/src/base/poky/bitbake/lib/bb/tests/fetch.py", line 1541, in fetch_shallow
    bb.utils.remove(ud.clonedir, recurse=True)
  File "/home/builder/src/base/poky/bitbake/lib/bb/utils.py", line 700, in remove
    subprocess.check_call(cmd + ['rm', '-rf'] + glob.glob(path))
  File "/usr/lib/python3.7/subprocess.py", line 347, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['rm', '-rf', '/tmp/tmpwmfn4w64/download/git2/tmp.tmpwmfn4w64.gitsource']' returned non-zero exit status 1.

Also, one "chmod" call was failing since the .git/annex subdirectory doesn't exist so just chmod
the whole temporary directory which should cover any directory name differences between
different git-annex versions. Fixes tests failing after chmod call:

Running 'export PSEUDO_DISABLED=1; unset _PYTHON_SYSCONFIGDATA_NAME; chmod u+w -R /tmp/tmpwmfn4w64/git//.git/annex' in /tmp/tmpwmfn4w64/git/

Signed-off-by: Mikko Rapeli <mikko.rapeli@bmw.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 7729ef2983c72867e99fad82d671069ba5cb32b2)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/tests/fetch.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index c15616815..b921a952e 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -390,6 +390,7 @@ class FetcherTest(unittest.TestCase):
         if os.environ.get("BB_TMPDIR_NOCLEAN") == "yes":
             print("Not cleaning up %s. Please remove manually." % self.tempdir)
         else:
+            bb.process.run('chmod u+rw -R %s' % self.tempdir)
             bb.utils.prunedir(self.tempdir)
 
 class MirrorUriTest(FetcherTest):
@@ -1602,6 +1603,7 @@ class GitShallowTest(FetcherTest):
 
         # fetch and unpack, from the shallow tarball
         bb.utils.remove(self.gitdir, recurse=True)
+        bb.process.run('chmod u+w -R "%s"' % ud.clonedir)
         bb.utils.remove(ud.clonedir, recurse=True)
         bb.utils.remove(ud.clonedir.replace('gitsource', 'gitsubmodule'), recurse=True)
 
@@ -1831,7 +1833,7 @@ class GitShallowTest(FetcherTest):
             open(os.path.join(self.srcdir, 'c'), 'w').close()
             self.git('annex add c', cwd=self.srcdir)
             self.git('commit --author "Foo Bar <foo@bar>" -m annex-c -a', cwd=self.srcdir)
-            bb.process.run('chmod u+w -R %s' % os.path.join(self.srcdir, '.git', 'annex'))
+            bb.process.run('chmod u+w -R %s' % self.srcdir)
 
             uri = 'gitannex://%s;protocol=file;subdir=${S}' % self.srcdir
             fetcher, ud = self.fetch_shallow(uri)
-- 
2.30.2

