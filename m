Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA90C43217
	for <webhook@archiver.kernel.org>; Sat, 29 Jan 2022 02:29:45 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web11.1501.1643423382962218181
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Jan 2022 18:29:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=SQkIBaFT;
 spf=pass (domain: axis.com, ip: 195.60.68.18,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1643423384;
  x=1674959384;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=VyjO7n14+956zHjTUI0lo0DNdKDZTBAjN+z1x4yuNBs=;
  b=SQkIBaFTKClOPIgjl2dstvTzZsfkHO5dA432w9B1Xy5WHloAcy12qt/9
   VBEJ6A3LePTgmdjvtwl0qDUaAl0sY19ddjrH+6qESv3qIxoSZiN3yvV+Q
   vuwqFEWf8N5TBuYemjwl9piWP9mZJlGNCUmxqvQZhad6okWB0LD4/g0kW
   3AhP/2bVdrWXVLUAk0Oe37eJFnMAZvYc6n95Ars5t1TWc/G2FnL7LrlFI
   Ugm8wPKWMOpzx6S/HxCo8sDWXJjwN606+AoHbeJufs63nAPFZxfX2Qp+Y
   hENHrJCbCvcXU6Thk+3CZqtNBy05NUJSykTL77SKFrnKVd73Q0rsEEpgq
   A==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 4/9] tests/fetch: Improve the verbose messages for skipped
 tests
Date: Sat, 29 Jan 2022 03:29:34 +0100
Message-ID: <20220129022939.19329-4-pkj@axis.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20220129022939.19329-1-pkj@axis.com>
References: <20220129022939.19329-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 29 Jan 2022 02:29:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13297

This changes:

  test_foo .. skipped 'Network tests being skipped'
  test_foo .. skipped 'npm not installed, tests being skipped'

to:

  test_foo .. skipped 'network test'
  test_foo .. skipped 'npm not installed'

to avoid double "skipped" in the output.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/tests/fetch.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index c654662c02..5cccdf6ef4 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -18,7 +18,7 @@ from bb.tests.support.httpserver import HTTPService
 
 def skipIfNoNetwork():
     if os.environ.get("BB_SKIP_NETTESTS") == "yes":
-        return unittest.skip("Network tests being skipped")
+        return unittest.skip("network test")
     return lambda f: f
 
 class URITest(unittest.TestCase):
@@ -2301,7 +2301,7 @@ class NPMTest(FetcherTest):
     def skipIfNoNpm():
         import shutil
         if not shutil.which('npm'):
-            return unittest.skip('npm not installed, tests being skipped')
+            return unittest.skip('npm not installed')
         return lambda f: f
 
     @skipIfNoNpm()

