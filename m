Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BA7C48292
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 17:16:08 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
 by mx.groups.io with SMTP id smtpd.web10.68842.1707153359903140107
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 05 Feb 2024 09:16:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=At2MDfpR;
 spf=pass (domain: gmail.com, ip: 209.85.208.49, mailfrom: martin.jansa@gmail.com)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56003c97d98so3243338a12.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 05 Feb 2024 09:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707153358; x=1707758158; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QAoLUfniHenGqyjG1hPmgKNnRYVJ67y1lCWDco/jw0A=;
        b=At2MDfpRKzsLaiYie6C9Y3YfspTJFmnzXcmcmmyckzppBJVRjHTQcrEpseREPist+K
         06Gr6Z1cWYAlbJE3tPyaxljTd+HToJBLYOKYGs5T+2ItKT2HMWkituAUP7MTbM/20tTL
         JqOyvYrwuwlX7nVOsIUb+7aug7GUg65lXCdGddG08juvGutfmCdtG++l+4YN+1q10NgT
         ZnNMN2VHCxQQiToCupuXBgXqEgHnJlUh0mWf9OspXvXDwJdleRxUFLsSpHJiLKCnEY0m
         ldf6WmB+iMl0QeGTwe78ZB2OZx9aOXX4W9YPGsMXQPTDOklsQWprx2CvxXOqr7ZMpiPP
         3pDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707153358; x=1707758158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QAoLUfniHenGqyjG1hPmgKNnRYVJ67y1lCWDco/jw0A=;
        b=JjFudSdPU+dE7xQCUUh2803awPbvKFMpeBRog0v1EUYNzJzF2yWx4aDUcuzpgANrgv
         KU7X4zN0VO3FjumnKFRNf1AKNSS86ZKOC+r2yxwxNe42+9ooHnDF4hyuWOMmehA4Oj7G
         0zd8sWE5IlvwXKpLOXxqo43NcqGa0psQglpXzwJktADzZCps/f9XJioCFBeMCMVI9fwR
         +JRlige5TDPJMl23gjALGWqkDQX4r6nL0XFDXeqUH7RfzGT6BF0PyCYhQ3O+XGP59JEe
         ap8ZniKK68nlSfPXICinNTSp0G/bJ3etSeL3CTrwHNy9jZrTxnUg3/sNoGEludHeqDBA
         YicA==
X-Gm-Message-State: AOJu0Yzt0Q5uPShwSycV1ekxnOECr5vS05J+F03O2m1SltmCj+cR/PKv
	kdqgRybrfYIgJey/YXY+JfVH4UAGs/Eg+tKLjK5+qzAxaa+OnsV5vpARCNkL
X-Google-Smtp-Source: AGHT+IGpcLIkkEWLJlxgdYVO583dyc0I4tLdxFOOyIBZHXfZA4BLaJj3xMTBrKgyc5G4dObJ5rm79w==
X-Received: by 2002:aa7:d743:0:b0:55f:d60a:b1ac with SMTP id a3-20020aa7d743000000b0055fd60ab1acmr6282644eds.16.1707153357902;
        Mon, 05 Feb 2024 09:15:57 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id q4-20020a056402248400b005606405866bsm86344eda.58.2024.02.05.09.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:15:57 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [PATCH] tests: fetch.py: use real subversion repository
Date: Mon,  5 Feb 2024 18:15:53 +0100
Message-ID: <20240205171553.446087-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 05 Feb 2024 17:16:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15827

* github no longer provides support for subversion clients:
  https://docs.github.com/en/enterprise-server@3.11/get-started/working-with-subversion-on-github/support-for-subversion-clients
  it was shut down on 2024-01-08:
  https://github.blog/2023-01-20-sunsetting-subversion-support/

  and this test was now failing with:

======================================================================
ERROR: test_external_svn (bb.tests.fetch.SVNTest.test_external_svn)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/OE/layers/bitbake/lib/bb/tests/fetch.py", line 1287, in test_external_svn
    fetcher.download()
  File "/OE/layers/bitbake/lib/bb/fetch2/__init__.py", line 1896, in download
    raise FetchError("Unable to fetch URL from any source.", u)
bb.fetch2.FetchError: Fetcher failure for URL: 'svn:///tmp/bitbake-fetch-zdvedqt_/svnfetch_localrepo_wup8mgn6/project;module=trunk;protocol=file;externals=allowed;rev=2'. Unable to fetch URL from any source.

Stdout:
Fetch svn:///tmp/bitbake-fetch-zdvedqt_/svnfetch_localrepo_wup8mgn6/project;module=trunk;protocol=file;externals=allowed;rev=2
Failed to fetch URL svn:///tmp/bitbake-fetch-zdvedqt_/svnfetch_localrepo_wup8mgn6/project;module=trunk;protocol=file;externals=allowed;rev=2, attempting MIRRORS if available
Fetcher failure: Fetch command export PSEUDO_DISABLED=1; /usr/bin/env svn --non-interactive --trust-server-cert co --no-auth-cache -r 2 file:///tmp/bitbake-fetch-zdvedqt_/svnfetch_localrepo_wup8mgn6/project/trunk@2 trunk failed with exit code 1, output:
A    trunk/README.md
 U   trunk
Checked out revision 2.

svn: warning: W205011: Error handling externals definition for 'trunk/bitbake':
svn: warning: W170013: Unable to connect to a repository at URL 'https://github.com/PhilipHazel/pcre2.git'
svn: E205011: Failure occurred processing one or more externals definitions

  in the rare cases where subversion was still installed on the host
  running bitbake-selftest :).

  to avoid this use still alive repository from https://svn.apache.org/
  and pick something rather small and only the trunk subdirectory which
  is fast to fetch:
  svn co https://svn.apache.org/repos/asf/serf/trunk
  takes just 2 sec here

  adjust expected dir/file to use "protocols/fcgi_buckets.h" instead of
  "trunk/README"

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 lib/bb/tests/fetch.py | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index c7a23407c..41e1d8cf1 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1247,8 +1247,9 @@ class SVNTest(FetcherTest):
                        cwd=repo_dir)
 
         bb.process.run("svn co %s svnfetch_co" % self.repo_url, cwd=self.tempdir)
-        # Github will emulate SVN.  Use this to check if we're downloding...
-        bb.process.run("svn propset svn:externals 'bitbake https://github.com/PhilipHazel/pcre2.git' .",
+        # Github won't emulate SVN anymore (see https://github.blog/2023-01-20-sunsetting-subversion-support/)
+        # Use still accessible svn repo (only trunk to avoid longer downloads)
+        bb.process.run("svn propset svn:externals 'bitbake https://svn.apache.org/repos/asf/serf/trunk' .",
                        cwd=os.path.join(self.tempdir, 'svnfetch_co', 'trunk'))
         bb.process.run("svn commit --non-interactive -m 'Add external'",
                        cwd=os.path.join(self.tempdir, 'svnfetch_co', 'trunk'))
@@ -1276,8 +1277,8 @@ class SVNTest(FetcherTest):
 
         self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'trunk')), msg="Missing trunk")
         self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'trunk', 'README.md')), msg="Missing contents")
-        self.assertFalse(os.path.exists(os.path.join(self.unpackdir, 'trunk/bitbake/trunk')), msg="External dir should NOT exist")
-        self.assertFalse(os.path.exists(os.path.join(self.unpackdir, 'trunk/bitbake/trunk', 'README')), msg="External README should NOT exit")
+        self.assertFalse(os.path.exists(os.path.join(self.unpackdir, 'trunk/bitbake/protocols')), msg="External dir should NOT exist")
+        self.assertFalse(os.path.exists(os.path.join(self.unpackdir, 'trunk/bitbake/protocols', 'fcgi_buckets.h')), msg="External fcgi_buckets.h should NOT exit")
 
     @skipIfNoSvn()
     def test_external_svn(self):
@@ -1290,8 +1291,8 @@ class SVNTest(FetcherTest):
 
         self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'trunk')), msg="Missing trunk")
         self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'trunk', 'README.md')), msg="Missing contents")
-        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'trunk/bitbake/trunk')), msg="External dir should exist")
-        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'trunk/bitbake/trunk', 'README')), msg="External README should exit")
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'trunk/bitbake/protocols')), msg="External dir should exist")
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'trunk/bitbake/protocols', 'fcgi_buckets.h')), msg="External fcgi_buckets.h should exit")
 
 class TrustedNetworksTest(FetcherTest):
     def test_trusted_network(self):
-- 
2.43.0


