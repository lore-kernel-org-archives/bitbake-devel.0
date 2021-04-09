Received: from mail.kapsi.fi (mail.kapsi.fi [91.232.154.25])
 by mx.groups.io with SMTP id smtpd.web09.9751.1617977185904701882
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Apr 2021 07:06:26 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: lakka.kapsi.fi, ip: 91.232.154.25, mailfrom: mcfrisk@lakka.kapsi.fi)
Received: from kapsi.fi ([2001:67c:1be8::11] helo=lakka.kapsi.fi)
	by mail.kapsi.fi with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.89)
	(envelope-from <mcfrisk@lakka.kapsi.fi>)
	id 1lUrmB-0007DF-5y; Fri, 09 Apr 2021 17:06:24 +0300
Received: from mcfrisk by lakka.kapsi.fi with local (Exim 4.92)
	(envelope-from <mcfrisk@lakka.kapsi.fi>)
	id 1lUrmB-0002s9-4S; Fri, 09 Apr 2021 17:06:23 +0300
From: "Mikko Rapeli" <mikko.rapeli@bmw.de>
To: bitbake-devel@lists.openembedded.org
Cc: Mikko Rapeli <mikko.rapeli@bmw.de>
Subject: [PATCH 2/2] bitbake: tests/fetch: remove write protected files too
Date: Fri,  9 Apr 2021 17:06:03 +0300
Message-Id: <20210409140603.9017-2-mikko.rapeli@bmw.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210409140603.9017-1-mikko.rapeli@bmw.de>
References: <20210409140603.9017-1-mikko.rapeli@bmw.de>
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
 Message-ID: 20210409140603.9017-2-mikko.rapeli@bmw.de
X-SA-Exim-Connect-IP: 2001:67c:1be8::11
X-SA-Exim-Mail-From: mcfrisk@lakka.kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Content-Transfer-Encoding: 8bit

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
---
 bitbake/lib/bb/tests/fetch.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index c156168151..b921a952e4 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
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
2.20.1

