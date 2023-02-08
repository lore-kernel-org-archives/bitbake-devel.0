Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6BCC636CC
	for <webhook@archiver.kernel.org>; Wed,  8 Feb 2023 14:34:17 +0000 (UTC)
Received: from mail.kapsi.fi (mail.kapsi.fi [91.232.154.25])
 by mx.groups.io with SMTP id smtpd.web10.7704.1675861189967374286
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Feb 2023 04:59:50 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: lakka.kapsi.fi, ip: 91.232.154.25, mailfrom: mcfrisk@lakka.kapsi.fi)
Received: from kapsi.fi ([2001:67c:1be8::11] helo=lakka.kapsi.fi)
	by mail.kapsi.fi with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mcfrisk@lakka.kapsi.fi>)
	id 1pPk37-007OLN-Ts; Wed, 08 Feb 2023 14:59:46 +0200
Received: from mcfrisk by lakka.kapsi.fi with local (Exim 4.94.2)
	(envelope-from <mcfrisk@lakka.kapsi.fi>)
	id 1pPk37-00GXry-Kz; Wed, 08 Feb 2023 14:59:45 +0200
From: "Mikko Rapeli" <mikko.rapeli@linaro.org>
To: bitbake-devel@lists.openembedded.org
Cc: Marius Kriegerowski <marius.kriegerowski@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [PATCH v2][kirkstone 1/2] bitbake-diffsigs: Make PEP8 compliant
Date: Wed,  8 Feb 2023 14:59:37 +0200
Message-Id: <20230208125938.3943013-1-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Rspam-Score: 0.3 (/)
X-Rspam-Report: Action: no action
 Symbol: FROM_NEQ_ENVFROM(0.00)
 Symbol: ARC_NA(0.00)
 Symbol: DMARC_POLICY_SOFTFAIL(0.10)
 Symbol: BAYES_HAM(-3.00)
 Symbol: FROM_HAS_DN(0.00)
 Symbol: TO_DN_SOME(0.00)
 Symbol: R_MISSING_CHARSET(0.50)
 Symbol: FREEMAIL_ENVRCPT(0.00)
 Symbol: TAGGED_RCPT(0.00)
 Symbol: MIME_GOOD(-0.10)
 Symbol: RCPT_COUNT_FIVE(0.00)
 Symbol: RCVD_TLS_LAST(0.00)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: MID_CONTAINS_FROM(1.00)
 Symbol: R_SPF_NA(0.00)
 Symbol: FORGED_SENDER(0.30)
 Symbol: R_DKIM_NA(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: ASN(0.00)
 Symbol: FREEMAIL_CC(0.00)
 Symbol: SUSPICIOUS_RECIPS(1.50)
 Symbol: RCVD_COUNT_TWO(0.00)
 Message-ID: 20230208125938.3943013-1-mikko.rapeli@linaro.org
X-SA-Exim-Connect-IP: 2001:67c:1be8::11
X-SA-Exim-Mail-From: mcfrisk@lakka.kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 Feb 2023 14:34:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14388

From: Marius Kriegerowski <marius.kriegerowski@gmail.com>

This ignores flake8 rules:
  * E402 module level import not at top of file
  * E501 line too long

(Bitbake rev: e8b176de448dc387c7a578c92b52aef28591038f)

Signed-off-by: Marius Kriegerowski <marius.kriegerowski@gmail.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 bitbake/bin/bitbake-diffsigs | 49 ++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 22 deletions(-)

v2: correct list, removed "bitbake:" subject prefix

v1: sent to openembedded-core list

diff --git a/bitbake/bin/bitbake-diffsigs b/bitbake/bin/bitbake-diffsigs
index cf4cc706a2..fe0f33eea1 100755
--- a/bitbake/bin/bitbake-diffsigs
+++ b/bitbake/bin/bitbake-diffsigs
@@ -11,6 +11,7 @@
 import os
 import sys
 import warnings
+
 warnings.simplefilter("default")
 import argparse
 import logging
@@ -27,6 +28,7 @@ logger = bb.msg.logger_create(myname)
 
 is_dump = myname == 'bitbake-dumpsig'
 
+
 def find_siginfo(tinfoil, pn, taskname, sigs=None):
     result = None
     tinfoil.set_event_mask(['bb.event.FindSigInfoResult',
@@ -52,6 +54,7 @@ def find_siginfo(tinfoil, pn, taskname, sigs=None):
         sys.exit(2)
     return result
 
+
 def find_siginfo_task(bbhandler, pn, taskname, sig1=None, sig2=None):
     """ Find the most recent signature files for the specified PN/task """
 
@@ -63,10 +66,10 @@ def find_siginfo_task(bbhandler, pn, taskname, sig1=None, sig2=None):
         if not sigfiles:
             logger.error('No sigdata files found matching %s %s matching either %s or %s' % (pn, taskname, sig1, sig2))
             sys.exit(1)
-        elif not sig1 in sigfiles:
+        elif sig1 not in sigfiles:
             logger.error('No sigdata files found matching %s %s with signature %s' % (pn, taskname, sig1))
             sys.exit(1)
-        elif not sig2 in sigfiles:
+        elif sig2 not in sigfiles:
             logger.error('No sigdata files found matching %s %s with signature %s' % (pn, taskname, sig2))
             sys.exit(1)
         latestfiles = [sigfiles[sig1], sigfiles[sig2]]
@@ -88,9 +91,9 @@ def recursecb(key, hash1, hash2):
     recout = []
     if not hashfiles:
         recout.append("Unable to find matching sigdata for %s with hashes %s or %s" % (key, hash1, hash2))
-    elif not hash1 in hashfiles:
+    elif hash1 not in hashfiles:
         recout.append("Unable to find matching sigdata for %s with hash %s" % (key, hash1))
-    elif not hash2 in hashfiles:
+    elif hash2 not in hashfiles:
         recout.append("Unable to find matching sigdata for %s with hash %s" % (key, hash2))
     else:
         out2 = bb.siggen.compare_sigfiles(hashfiles[hash1], hashfiles[hash2], recursecb, color=color)
@@ -110,36 +113,36 @@ parser.add_argument('-D', '--debug',
 
 if is_dump:
     parser.add_argument("-t", "--task",
-            help="find the signature data file for the last run of the specified task",
-            action="store", dest="taskargs", nargs=2, metavar=('recipename', 'taskname'))
+                        help="find the signature data file for the last run of the specified task",
+                        action="store", dest="taskargs", nargs=2, metavar=('recipename', 'taskname'))
 
     parser.add_argument("sigdatafile1",
-            help="Signature file to dump. Not used when using -t/--task.",
-            action="store", nargs='?', metavar="sigdatafile")
+                        help="Signature file to dump. Not used when using -t/--task.",
+                        action="store", nargs='?', metavar="sigdatafile")
 else:
     parser.add_argument('-c', '--color',
-            help='Colorize the output (where %(metavar)s is %(choices)s)',
-            choices=['auto', 'always', 'never'], default='auto', metavar='color')
+                        help='Colorize the output (where %(metavar)s is %(choices)s)',
+                        choices=['auto', 'always', 'never'], default='auto', metavar='color')
 
     parser.add_argument('-d', '--dump',
-            help='Dump the last signature data instead of comparing (equivalent to using bitbake-dumpsig)',
-            action='store_true')
+                        help='Dump the last signature data instead of comparing (equivalent to using bitbake-dumpsig)',
+                        action='store_true')
 
     parser.add_argument("-t", "--task",
-            help="find the signature data files for the last two runs of the specified task and compare them",
-            action="store", dest="taskargs", nargs=2, metavar=('recipename', 'taskname'))
+                        help="find the signature data files for the last two runs of the specified task and compare them",
+                        action="store", dest="taskargs", nargs=2, metavar=('recipename', 'taskname'))
 
     parser.add_argument("-s", "--signature",
-            help="With -t/--task, specify the signatures to look for instead of taking the last two",
-            action="store", dest="sigargs", nargs=2, metavar=('fromsig', 'tosig'))
+                        help="With -t/--task, specify the signatures to look for instead of taking the last two",
+                        action="store", dest="sigargs", nargs=2, metavar=('fromsig', 'tosig'))
 
     parser.add_argument("sigdatafile1",
-            help="First signature file to compare (or signature file to dump, if second not specified). Not used when using -t/--task.",
-            action="store", nargs='?')
+                        help="First signature file to compare (or signature file to dump, if second not specified). Not used when using -t/--task.",
+                        action="store", nargs='?')
 
     parser.add_argument("sigdatafile2",
-            help="Second signature file to compare",
-            action="store", nargs='?')
+                        help="Second signature file to compare",
+                        action="store", nargs='?')
 
 options = parser.parse_args()
 if is_dump:
@@ -157,7 +160,8 @@ if options.taskargs:
     with bb.tinfoil.Tinfoil() as tinfoil:
         tinfoil.prepare(config_only=True)
         if not options.dump and options.sigargs:
-            files = find_siginfo_task(tinfoil, options.taskargs[0], options.taskargs[1], options.sigargs[0], options.sigargs[1])
+            files = find_siginfo_task(tinfoil, options.taskargs[0], options.taskargs[1], options.sigargs[0],
+                                      options.sigargs[1])
         else:
             files = find_siginfo_task(tinfoil, options.taskargs[0], options.taskargs[1])
 
@@ -166,7 +170,8 @@ if options.taskargs:
             output = bb.siggen.dump_sigfile(files[-1])
         else:
             if len(files) < 2:
-                logger.error('Only one matching sigdata file found for the specified task (%s %s)' % (options.taskargs[0], options.taskargs[1]))
+                logger.error('Only one matching sigdata file found for the specified task (%s %s)' % (
+                    options.taskargs[0], options.taskargs[1]))
                 sys.exit(1)
 
             # Recurse into signature comparison
-- 
2.34.1


