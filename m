Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465DBD58CA7
	for <webhook@archiver.kernel.org>; Sun, 22 Mar 2026 19:35:09 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1877.1774208105448820059
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 22 Mar 2026 12:35:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=MADd5C33;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-1329275-202603221935027edf84201c00020717-giry6m@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202603221935027edf84201c00020717
        for <bitbake-devel@lists.openembedded.org>;
        Sun, 22 Mar 2026 20:35:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ZvsrtByuHhRGhYvFKB/jsVqT3GPrbDYzgxb3raFvR1M=;
 b=MADd5C33eWAgJMQSETxPADK/1ROGsbqhg1lJIQWy4DbP925ejcZsepBC9xgQ5PLjrJXFR3
 kSul56qFCAChK0bzRtxGkTZE3rcujUB9H8TGfJiTALX/zedSh7vcwUrQYTYJOwe9lbcf/4tw
 9OcuwMLwZJ0hZVUOdi+BSsxH8azjwinq/mA5FyOB4eedUVE6kzIpd55Yte1w5UFoNj8yiV9T
 5bsMMWv77FMGIZ43kGeoP2gi359nbcqXpij6lQuLH7LRfsQHGv5vdOfW1egTbcQmSWQ3Hse9
 jLCHRm/19nEgp70ahyYzXWOtUhI5UXSqwOMk0U0ocIbqrXVRYKnDWniw==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH 3/9] tests/setup: cleanup imports
Date: Sun, 22 Mar 2026 20:34:14 +0100
Message-ID: <20260322193440.870120-4-adrian.freihofer@siemens.com>
In-Reply-To: <20260322193440.870120-1-adrian.freihofer@siemens.com>
References: <20260322193440.870120-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 22 Mar 2026 19:35:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19200

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


