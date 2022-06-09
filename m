Return-Path: <mikko.rapeli@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03C5C43334
	for <webhook@archiver.kernel.org>; Thu,  9 Jun 2022 05:56:40 +0000 (UTC)
Received: from mail.kapsi.fi (mail.kapsi.fi [91.232.154.25])
 by mx.groups.io with SMTP id smtpd.web08.7369.1654754190478615908
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Jun 2022 22:56:31 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=none, err=permanent DNS error (domain: lakka.kapsi.fi, ip: 91.232.154.25,
 mailfrom: mcfrisk@lakka.kapsi.fi)
Received: from kapsi.fi ([91.232.154.11] helo=lakka.kapsi.fi)
	by mail.kapsi.fi with esmtps  (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mcfrisk@lakka.kapsi.fi>)
	id 1nzB9f-00E5tf-75; Thu, 09 Jun 2022 08:56:26 +0300
Received: from mcfrisk by lakka.kapsi.fi with local (Exim 4.92)
	(envelope-from <mcfrisk@lakka.kapsi.fi>)
	id 1nzB9e-000Av4-Ax; Thu, 09 Jun 2022 08:56:26 +0300
From: mikko.rapeli@bmw.de
To: bitbake-devel@lists.openembedded.org
Cc: Mikko Rapeli <mikko.rapeli@bmw.de>
Subject: [PATCH] event.py: ignore exceptions from stdout and sterr operations
 in atexit
Date: Thu,  9 Jun 2022 08:56:10 +0300
Message-Id: <20220609055610.29857-1-mikko.rapeli@bmw.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspam-Score: -1.2 (-)
X-Rspam-Report: Action: no action
 Symbol: RCVD_TLS_LAST(0.00)
 Symbol: ARC_NA(0.00)
 Symbol: DMARC_POLICY_SOFTFAIL(0.10)
 Symbol: TO_DN_SOME(0.00)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: R_MISSING_CHARSET(0.50)
 Symbol: MIME_GOOD(-0.10)
 Symbol: RCPT_COUNT_TWO(0.00)
 Symbol: FROM_NO_DN(0.00)
 Symbol: MID_CONTAINS_FROM(1.00)
 Symbol: R_SPF_NA(0.00)
 Symbol: FORGED_SENDER(0.30)
 Symbol: R_DKIM_NA(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: ASN(0.00)
 Symbol: FROM_NEQ_ENVFROM(0.00)
 Symbol: BAYES_HAM(-3.00)
 Symbol: RCVD_COUNT_TWO(0.00)
 Message-ID: 20220609055610.29857-1-mikko.rapeli@bmw.de
X-SA-Exim-Connect-IP: 91.232.154.11
X-SA-Exim-Mail-From: mcfrisk@lakka.kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Jun 2022 05:56:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13743

From: Mikko Rapeli <mikko.rapeli@bmw.de>

When atexit functions run, stdout and stderr operations may fail, e.g.
when output is piped to less but has been exited by the user.
This removes error print from output of "bitbake -e sqlite3 | less"
if user presses "q" before bitbake has finished processing:

[Errno 32] Broken pipeError in atexit._run_exitfuncs:
Traceback (most recent call last):
  File "/home/builder/src/poky/bitbake/lib/bb/event.py", line 135, in print_ui_queue
    sys.stdout.flush()

Signed-off-by: Mikko Rapeli <mikko.rapeli@bmw.de>
---
 bitbake/lib/bb/event.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index df020551e3..97668601a1 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -132,8 +132,14 @@ def print_ui_queue():
     if not _uiready:
         from bb.msg import BBLogFormatter
         # Flush any existing buffered content
-        sys.stdout.flush()
-        sys.stderr.flush()
+        try:
+            sys.stdout.flush()
+        except:
+            pass
+        try:
+            sys.stderr.flush()
+        except:
+            pass
         stdout = logging.StreamHandler(sys.stdout)
         stderr = logging.StreamHandler(sys.stderr)
         formatter = BBLogFormatter("%(levelname)s: %(message)s")
-- 
2.20.1


