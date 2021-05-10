Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
 by mx.groups.io with SMTP id smtpd.web12.32470.1620656206364133825
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 May 2021 07:16:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=sIGhiD5P;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.47, mailfrom: steve@sakoman.com)
Received: by mail-ot1-f47.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so4361754otg.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 10 May 2021 07:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZNBHZHYM/SMcOyZ7WO26UsVq+Z5Gm3hpFoSJLSgMQJ0=;
        b=sIGhiD5PnJD8ikVZrcAwk4bsXJP7QytZGJ0OxxwDn6GmpX6Un5JXwWn9uQAmQjheXe
         F9RZnNQ6OfN9bXQaJqU4wwwNBhf4mze5YtofZNY51oWzW3uZJAXhscLxV0imeI18SxwP
         ++NMgYf0gZTpAFhjiAHNjZVeb8S7ezWKNG5InnGNCkuzbEML1JThyQ/io2JhnqBoGtfg
         Az72Rk51FdVH3F3Q5jFugxHBjZDbMVx/LjkRMVlQRlAkHxdPMcW9nhb/O7eyA1Q8E6eq
         u4rTBO2cFftVDjT9r/r3LubqYW8Akp4piZ/G5A2lz57f37TU94UlJKDD4DFxVqawY8ji
         ajcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZNBHZHYM/SMcOyZ7WO26UsVq+Z5Gm3hpFoSJLSgMQJ0=;
        b=rbWowUcg6hSVDA5zmrv7LOq86c0XSuumrX6EWRXyaFDHhqPMn+Zy8Bc87D7Rve62Op
         a9wbcPRxKx42bfGTxMivhWL05yqdSwDFUotL6wAs4MK0vl1YKx64mzgtxbjH4rqGoJPG
         /sfoCKjJwdCqfmNbm7FmQINrj8MFLiTH6/WTRWgY/dyVsND5/SFNXCxrTq9uV2oPp1O+
         nsWH2gTE9joA5LKO8WFprILI3XuToMjXiAE4a5gDaEcydwan+9SWHJxSXgtLGgMxoNz2
         LYkeh3Lb/JlUJG4TiAnvOvfl/RDPn3q8Pd81jGGBEKjXU9R9C9VEEyaM/+MFD6tN4dFw
         1/YA==
X-Gm-Message-State: AOAM530xrjb7toV9IonO2qyy/jG5PkbA/XR4hoGtZ1oQUNg9d7r9Wwzn
	m2QMe3cvfDjpKmvMRw3vVyuD48xqQ+jhFYvvItc=
X-Google-Smtp-Source: ABdhPJy8yRv0Ki9aB0vLyUl5i+mXxFIRfkvWT94TD90LgRZmzWi1PkqdpvHpvvAFIyImn3+5C/CH6g==
X-Received: by 2002:a9d:3424:: with SMTP id v33mr21116231otb.137.1620656205225;
        Mon, 10 May 2021 07:16:45 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from localhost.localdomain ([172.243.4.16])
        by smtp.gmail.com with ESMTPSA id g106sm2401303otg.77.2021.05.10.07.16.41
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 07:16:44 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 2/4] bitbake: tests/fetch: remove write protected files too
Date: Mon, 10 May 2021 04:15:17 -1000
Message-Id: <5e6e34543938db7ba890a5355aca08e21613037c.1620655927.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620655927.git.steve@sakoman.com>
References: <cover.1620655927.git.steve@sakoman.com>
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
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/tests/fetch.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 9a4f5f11..6300f563 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -371,6 +371,7 @@ class FetcherTest(unittest.TestCase):
         if os.environ.get("BB_TMPDIR_NOCLEAN") == "yes":
             print("Not cleaning up %s. Please remove manually." % self.tempdir)
         else:
+            bb.process.run('chmod u+rw -R %s' % self.tempdir)
             bb.utils.prunedir(self.tempdir)
 
 class MirrorUriTest(FetcherTest):
@@ -1538,6 +1539,7 @@ class GitShallowTest(FetcherTest):
 
         # fetch and unpack, from the shallow tarball
         bb.utils.remove(self.gitdir, recurse=True)
+        bb.process.run('chmod u+w -R "%s"' % ud.clonedir)
         bb.utils.remove(ud.clonedir, recurse=True)
         bb.utils.remove(ud.clonedir.replace('gitsource', 'gitsubmodule'), recurse=True)
 
@@ -1767,7 +1769,7 @@ class GitShallowTest(FetcherTest):
             open(os.path.join(self.srcdir, 'c'), 'w').close()
             self.git('annex add c', cwd=self.srcdir)
             self.git('commit --author "Foo Bar <foo@bar>" -m annex-c -a', cwd=self.srcdir)
-            bb.process.run('chmod u+w -R %s' % os.path.join(self.srcdir, '.git', 'annex'))
+            bb.process.run('chmod u+w -R %s' % self.srcdir)
 
             uri = 'gitannex://%s;protocol=file;subdir=${S}' % self.srcdir
             fetcher, ud = self.fetch_shallow(uri)
-- 
2.25.1

