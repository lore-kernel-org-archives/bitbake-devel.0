Received: from mail.kapsi.fi (mail.kapsi.fi [91.232.154.25])
 by mx.groups.io with SMTP id smtpd.web10.14170.1595516319214981825
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 Jul 2020 07:58:39 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: lakka.kapsi.fi, ip: 91.232.154.25, mailfrom: mcfrisk@lakka.kapsi.fi)
Received: from kapsi.fi ([2001:67c:1be8::11] helo=lakka.kapsi.fi)
	by mail.kapsi.fi with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.89)
	(envelope-from <mcfrisk@lakka.kapsi.fi>)
	id 1jycg6-0001eQ-7h; Thu, 23 Jul 2020 17:58:35 +0300
Received: from mcfrisk by lakka.kapsi.fi with local (Exim 4.92)
	(envelope-from <mcfrisk@lakka.kapsi.fi>)
	id 1jycg5-0003wp-VW; Thu, 23 Jul 2020 17:58:33 +0300
From: "Mikko Rapeli" <mikko.rapeli@bmw.de>
To: bitbake-devel@lists.openembedded.org
Cc: Mikko Rapeli <mikko.rapeli@bmw.de>
Subject: [PATCH][master|dunfell|zeus] knotty: ignore pipe errors
Date: Thu, 23 Jul 2020 17:58:12 +0300
Message-Id: <20200723145812.14029-1-mikko.rapeli@bmw.de>
X-Mailer: git-send-email 2.20.1
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
 Symbol: NEURAL_HAM(-0.00)
 Symbol: R_SPF_NA(0.00)
 Symbol: FORGED_SENDER(0.30)
 Symbol: R_DKIM_NA(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: ASN(0.00)
 Symbol: FROM_NEQ_ENVFROM(0.00)
 Symbol: BAYES_HAM(-3.00)
 Symbol: RCVD_COUNT_TWO(0.00)
 Message-ID: 20200723145812.14029-1-mikko.rapeli@bmw.de
X-Rspam-Bar: ++
X-SA-Exim-Connect-IP: 2001:67c:1be8::11
X-SA-Exim-Mail-From: mcfrisk@lakka.kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Content-Transfer-Encoding: 8bit

Piping bitbake output to another process like less currently
results in an ugly error if the other end of pipe exits
before bitbake has written all output to it.

For example with "bitbake -e linux-yocto | less" and
pressing q to quit less results in:

Error in atexit._run_exitfuncs:
Traceback (most recent call last):
  File "/home/mcfrisk/src/yocto/poky/bitbake/lib/bb/event.py", line 133, in print_ui_queue
    sys.stdout.flush()
BrokenPipeError: [Errno 32] Broken pipe
Exception ignored in: <_io.TextIOWrapper name='<stdout>' mode='w' encoding='UTF-8'>
BrokenPipeError: [Errno 32] Broken pipe

Fix is to use default signal handler for pipe signal. It's
perfectly normal that on Unix systems the other end of pipe
gets killed before all data is written.

In some cases there seems to also be a loop which results in
a large number of "[Errno 32] Broken pipe" messages printed to
console until knotty process is killed. I think this also
fixes those cases.

This patch applies to master, dunfell and zeus branches.

Signed-off-by: Mikko Rapeli <mikko.rapeli@bmw.de>
---
 bitbake/lib/bb/ui/knotty.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 87e873d644..56ac41d0f9 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -29,6 +29,9 @@ featureSet = [bb.cooker.CookerFeatures.SEND_SANITYEVENTS]
 logger = logging.getLogger("BitBake")
 interactive = sys.stdout.isatty()
 
+# ignore pipe errors since they are normal
+signal.signal(signal.SIGPIPE, signal.SIG_DFL)
+
 class BBProgress(progressbar.ProgressBar):
     def __init__(self, msg, maxval, widgets=None, extrapos=-1, resize_handler=None):
         self.msg = msg
-- 
2.20.1

