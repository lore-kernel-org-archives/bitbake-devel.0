Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E51C43219
	for <webhook@archiver.kernel.org>; Sat, 29 Jan 2022 02:29:46 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web11.1501.1643423382962218181
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Jan 2022 18:29:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=HiVtvZIl;
 spf=pass (domain: axis.com, ip: 195.60.68.18,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1643423385;
  x=1674959385;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=oKoTKm4QNLq+di132Xq4KnfrRHHyvtvw8Cd+B9ydoSM=;
  b=HiVtvZIllVfd/Jdm5OUMhNzW09a2jdCtPx48RkhwwkiDS49EoOuVcx2D
   KEq8RqrDT2U+cU38V+dZjFBI7FYw2dGX2C0+UUrre6EKs7knIF2rj1TJx
   LsZLHYpC2o7zcepZMlL6wditEpR13C/72LEUOoInTv3jGywWUuhjqRZs7
   yw7mRR7nJnnAoz0Z3PjqI+BDco2eJwUQanik/ApAYgOH88yAWvvv+lPgR
   Absa4KGjnaTsyCHUN0j476wnMJP9kBsnA6To0eGzAPgWSWQNSltbGHOmD
   lhGycCtxzAzLHYXumhg8p/7F4vVh9p2GwOP3BgGnnEdXWE9aHf9qD85HV
   Q==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 7/9] tests/fetch: Make test_npm_premirrors work with the
 current fetcher
Date: Sat, 29 Jan 2022 03:29:37 +0100
Message-ID: <20220129022939.19329-7-pkj@axis.com>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13300

There are two totally opposite use cases for how a premirror is
expected to behave in combination with specifying a downloadfilename=
parameter in the SRC_URI. On the one hand there is the expectation
that it works like any other mirror, which means the premirror is
expected to contain a file with the original name specified in the
SRC_URI. On the other hand there is the expectation that one can use
the artefacts downloaded by bitbake in ${DL_DIR} as a premirror, in
which case it is expected to contain a file with the name from the
downloadfilename= parameter.

The latter case has been how downloaded files have been handled until
commit 8a3ff9f3 (fetch2: fix premirror URI when downloadfilename
defined), where the fetcher was changed to store files as per the
first case. This is also when the test_npm_premirrors test case was
modified in commit 5ba191a0 (tests/fetch: add and fix npm tests) to
expect the first case.

The above change was later reverted in commit 96c30007 (fetch2: fix
downloadfilename issue with premirror). However the
test_npm_premirrors test case was not updated to match, and has been
failing ever since. This has probably gone unnoticed because the npm
related test cases require that npm is installed on the host.

This commit updates test_npm_premirrors to expect that premirrors use
the filenames specified by downloadfilename= as this matches the
current fetcher implementation and also is the most likely use case
for premirrors. It also tries to mimic how one typically might setup
the premirror directory by simply copying the download directory.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/tests/fetch.py | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 16a1b6f342..9fb6378fdc 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -2322,15 +2322,24 @@ class NPMTest(FetcherTest):
         ud = fetcher.ud[fetcher.urls[0]]
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
-        # Setup the mirror
-        pkgname = os.path.basename(ud.proxy.urls[0].split(';')[0])
+
+        # Setup the mirror by renaming the download directory
         mirrordir = os.path.join(self.tempdir, 'mirror')
-        bb.utils.mkdirhier(mirrordir)
-        os.replace(ud.localpath, os.path.join(mirrordir, pkgname))
-        self.d.setVar('PREMIRRORS', 'https?$://.*/.* file://%s/' % mirrordir)
+        bb.utils.rename(self.dldir, mirrordir)
+        os.mkdir(self.dldir)
+
+        # Configure the premirror to be used
+        self.d.setVar('PREMIRRORS', 'https?$://.*/.* file://%s/npm2' % mirrordir)
         self.d.setVar('BB_FETCH_PREMIRRORONLY', '1')
+
         # Fetch again
         self.assertFalse(os.path.exists(ud.localpath))
+        # The npm fetcher doesn't handle that the .resolved file disappears
+        # while the fetcher object exists, which it does when we rename the
+        # download directory to "mirror" above. Thus we need a new fetcher to go
+        # with the now empty download directory.
+        fetcher = bb.fetch.Fetch([url], self.d)
+        ud = fetcher.ud[fetcher.urls[0]]
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
 

