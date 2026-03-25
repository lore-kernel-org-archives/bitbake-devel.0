Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96307FEA81E
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 07:14:11 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16764.1774422847650445527
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 Mar 2026 00:14:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=bB5s/BDL;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-1329275-20260325071405e1f914f30300020761-aqyr0e@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260325071405e1f914f30300020761
        for <bitbake-devel@lists.openembedded.org>;
        Wed, 25 Mar 2026 08:14:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ZvsrtByuHhRGhYvFKB/jsVqT3GPrbDYzgxb3raFvR1M=;
 b=bB5s/BDLIC94RjeLsf3pUAO/e9/3Pg7Yau5E8XqM5K5DI8fRYsl39rNWk7IOerX6tPjljr
 rEjqHeYmuSk6S8bbKixeXBzWV5+pH5zEsrq/JBVhXHzKTBZSh4Rzb0Nk2BwD9p13NWD787sr
 RlQ6S5OSprvXlLiSocrTwd9fDGSetgLSGpPQMWdjKaX+Tz7v/MiCtflPPAR9k9v9PEVgIsWC
 DPYHaksdu7rNrDFJ32XJCbmSD1jCKCmJQQYhSAdUE4Wl8HhIAQvD+Crws0h/HED5T7YAlwh2
 tESJ72h5Bs9uqpHteihtbPHn0WuxVo4HuGE+r1Q2TCQF1MkfduN7vV/Q==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH v2 05/10] tests/setup: cleanup imports
Date: Wed, 25 Mar 2026 07:51:47 +0100
Message-ID: <20260325071342.47272-6-adrian.freihofer@siemens.com>
In-Reply-To: <20260325071342.47272-1-adrian.freihofer@siemens.com>
References: <20260325071342.47272-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 25 Mar 2026 07:14:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19221

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


