Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476C1FC97EF
	for <webhook@archiver.kernel.org>; Sun, 29 Mar 2026 18:34:31 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34713.1774809263056144717
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 29 Mar 2026 11:34:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=PWeUFVIj;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1329275-202603291834201dc8a9c48a00020736-gdxpdc@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202603291834201dc8a9c48a00020736
        for <bitbake-devel@lists.openembedded.org>;
        Sun, 29 Mar 2026 20:34:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ZvsrtByuHhRGhYvFKB/jsVqT3GPrbDYzgxb3raFvR1M=;
 b=PWeUFVIj0emmJyMKBcHN6bzB8DyFo1zdGmaDp/Vj2TV/Hby2164vfMghKI+lcAlvPRELOe
 s14dwp2BGwOWmtWdQI08b6QlJUIopRfPdajM69vXPaREmtmi+7m6G4zYB6TJhh2FmpVZW46a
 dif2ipSEgyU4SDVSJXJsjU5XQEzZXBo4Q4NPbDO9eD4/F/apdTrLYTDL9YjCaT1Ae3ccTdbV
 omtSbAISQh1L9Aaq2Fs3hr/vFEaemtgd92nYVXwoX10715wYlukeH1M2uLHITIsaskWiM6+m
 wrlAf6XZGy6SWDRkk57eNlarFJwMtGOubZ6UI9pEIKUmIbdM7MNoBinw==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH v3 07/14] tests/setup: cleanup imports
Date: Sun, 29 Mar 2026 20:32:54 +0200
Message-ID: <20260329183332.1996183-8-adrian.freihofer@siemens.com>
In-Reply-To: <20260329183332.1996183-1-adrian.freihofer@siemens.com>
References: <20260329183332.1996183-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 29 Mar 2026 18:34:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19267

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Add missing top-level imports for os, stat, bb and bb.process and remove
the redundant inline 'import os' and 'import stat' that were inside
individual methods.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 lib/bb/tests/setup.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index a66f05b36..d52a81395 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -5,9 +5,13 @@
 #
 
 from bb.tests.fetch import FetcherTest
-import json
-import hashlib
+import bb
+import bb.process
 import glob
+import hashlib
+import json
+import os
+import stat
 from bb.tests.support.httpserver import HTTPService
 
 class BitbakeSetupTest(FetcherTest):
@@ -208,7 +212,6 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         with open(fullname, 'w') as f:
             f.write(content)
         if script:
-            import stat
             st = os.stat(fullname)
             os.chmod(fullname, st.st_mode | stat.S_IEXEC)
         self.git('add {}'.format(name), cwd=self.testrepopath)
@@ -279,7 +282,6 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
 
     def test_setup(self):
         # unset BBPATH to ensure tests run in isolation from the existing bitbake environment
-        import os
         if 'BBPATH' in os.environ:
             del os.environ['BBPATH']
 
-- 
2.53.0


