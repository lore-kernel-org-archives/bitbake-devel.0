Return-Path: <marius.kriegerowski@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F2AC48BD1
	for <webhook@archiver.kernel.org>; Wed, 13 Apr 2022 15:48:08 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.7049.1649860258113167313
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Apr 2022 07:30:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=PYHcWYw+;
 spf=pass (domain: gmail.com, ip: 209.85.221.44,
 mailfrom: marius.kriegerowski@gmail.com)
Received: by mail-wr1-f44.google.com with SMTP id c10so2932729wrb.1
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Apr 2022 07:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KaXMwrmoE9afGkkWAw7coBLnRDcnpmj+h9hir30ZE0w=;
        b=PYHcWYw++1zrM0K0g5xEAcoEEkVBYrxd14BcYmEKKbOT6YFc93ZIGvpsw15U1nZ35f
         w9kFGe3CUOR7cTe/i35Idj+qP4emGfVPmTpCz4yaC4lyDeOuARYOuaxeEFtfsKda5Ned
         MwjBQXWAgdw0e10R//8cIBML1PrdtGwyjjllyHWIFoMp6Ersd6nZLbmRz4tCY0cTdbRW
         Cg58meV4xdLt739urg8aPZNe97K1PnuI0MX2ejvbkcNtTDHxDZucsBderbOdtNae4X59
         Kic3r5cftjQd8uMLnXRJ2zBnuoz/Sr7GLq46HzAj8THe/MBepesanBsk7xbsoS2yMYD2
         p6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KaXMwrmoE9afGkkWAw7coBLnRDcnpmj+h9hir30ZE0w=;
        b=OZOuXnALV9BS1zJjiXEaeavci8qWLvwpIHUAkMvOc4orr/l9FgkODd8wnj+ux2ajFs
         ROfc+aKBaa7f2m48RLeIaV+RVT4Xk2UT/tTcYs2+jp6tUftabBwDw8EDKDVyXFU7/edp
         RfXbL2BFvSUBtzBN+O1pBH7BmF3/mbprv/elwP95Kq93PqTefYPGS5SJrx3wKTFhpf3z
         A8XgUJf4Rukokzukndo0ISQlx303ZWvSjyO1wONmJQMGtNFb2TWnI+kq6BzOeXyNdToV
         Tsp8KPLnx1cuFsVlIrJb2zr1Tyn/484okJ/lKgGFFhxugQwPQHy7p7cnUaU97UY51KDE
         NEaQ==
X-Gm-Message-State: AOAM531oxCfO2hKivc8ufRcPRzzMsPt9ysn1UozhP4HaGcjqKoTEzh2x
	RLtDaUDLuiP3lfcSd78Lcx8ntB9lVvw=
X-Google-Smtp-Source: 
 ABdhPJxXZQHIFhtU6xcmHpzVubVeq5qckA2WYUYpTwA/Mni46m94+FhopPesz/4o/5iZzy/pr3o0sA==
X-Received: by 2002:adf:fb10:0:b0:207:af88:1eb9 with SMTP id
 c16-20020adffb10000000b00207af881eb9mr6457575wrr.238.1649860256535;
        Wed, 13 Apr 2022 07:30:56 -0700 (PDT)
Received: from localhost.localdomain ([195.201.126.231])
        by smtp.gmail.com with ESMTPSA id
 x16-20020a5d4450000000b00207a459ca80sm10216916wrr.99.2022.04.13.07.30.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 Apr 2022 07:30:55 -0700 (PDT)
From: Marius Kriegerowski <marius.kriegerowski@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Marius Kriegerowski <marius.kriegerowski@gmail.com>
Subject: [PATCH] make bitbake-diffsig PEP8 compliant
Date: Wed, 13 Apr 2022 16:30:53 +0200
Message-Id: <20220413143053.41897-1-marius.kriegerowski@gmail.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Apr 2022 15:48:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13614

This ignores flake8 rules:
  * E402 module level import not at top of file
  * E501 line too long

Signed-off-by: Marius Kriegerowski <marius.kriegerowski@gmail.com>
---
 bitbake/bin/bitbake-diffsigs | 49 ++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 22 deletions(-)

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
2.32.0 (Apple Git-132)


