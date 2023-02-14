Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2105EC64ED8
	for <webhook@archiver.kernel.org>; Tue, 14 Feb 2023 15:29:05 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web10.10122.1676388529746511584
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Feb 2023 07:28:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=tW/PL8VB;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.42, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f42.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so20782747pjq.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 14 Feb 2023 07:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0fUiHwEMeOqlHcPpm+H23tMICC9YYKwKtWnpWghw/ZA=;
        b=tW/PL8VBaP0NPEo+VTrcV0JVxA0ObbV0fp1ely5cvfmgojSBBXvp9M89ZdzMv1ZBCw
         mbmpziCzEpWgb17WFhJCkPw2b/qBbbryVE+RhO3DNRGPL/qC1eC+kFm4kcJ7P3wTsFGv
         xCrA1BygTfh48qSFTtvJFzqV0j7mVNlsWGpfDoZGAEgpoUr0TMF7WNT8l6wMquv5u3FG
         gftjLwwmFb+1dCJUs3bPTDKdkkotB7zyp/pmlW4ZRX41VV4b0YXd8yuFPNQkc+c5pvqB
         czcPnCrRbLUamFUDQrestyQ2y/XcDQpm13y51v28WDYd1i6x1z7FOERcCY5MdMGVVCgu
         3D/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fUiHwEMeOqlHcPpm+H23tMICC9YYKwKtWnpWghw/ZA=;
        b=yntv7xiNE9y4MFiU+VAu+FB1CNcDG5zGf8DEtmanaXRpD9lBpB9szB3FwyriZi9HOs
         m7E2nnVqjSZZd3o4Ii5C2+XKIe2IlmVUs7qluq6Uv7gXvBZ372bLOwjpZ9icd/a9Vsp/
         cBwosz8kmI4XL43w3ur4kwmyl2M7/XmABLeh9csaKHrbWeoIyzC3QrMG3cotqnnqybuZ
         FqiZlZ79aLyLT7UdQwjm+kiA++tx6XFyyHbZ/Uo1i00A46EY3cWLcIKOPgJqYyuK1O6C
         nAw5oMV9KiMLGmR09PMRtz6K5PcbUUInWh+rloUECaDSGoE5/G/pz+O8EMKAX0eY4R1C
         3k8A==
X-Gm-Message-State: AO0yUKUKuOn6NjDQXGXe3SZ2gKev63gJYhQYhDGMsTEsM9Mm1imvX0MD
	tArUtUgR5dWR+LxWxANOMu4YtkibFskXYuGNPB0=
X-Google-Smtp-Source: AK7set9gGA0k9mcQLQuw5YFRgWgyv+WWX/qg+Sc3nJNXsR0uERaJCfNOuc5lFABN7sLLNPJun6zekA==
X-Received: by 2002:a17:90b:33cc:b0:233:d91e:e64a with SMTP id lk12-20020a17090b33cc00b00233d91ee64amr2924791pjb.10.1676388536073;
        Tue, 14 Feb 2023 07:28:56 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id m3-20020a17090a5a4300b00233cde36909sm5624203pji.21.2023.02.14.07.28.55
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 07:28:55 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 3/4] bitbake-diffsigs: Make PEP8 compliant
Date: Tue, 14 Feb 2023 05:28:43 -1000
Message-Id: <60e05043f83c73a34cd154193e5c40d18a3ed3db.1676388410.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1676388410.git.steve@sakoman.com>
References: <cover.1676388410.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Feb 2023 15:29:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14417

From: Marius Kriegerowski <marius.kriegerowski@gmail.com>

This ignores flake8 rules:
  * E402 module level import not at top of file
  * E501 line too long

Signed-off-by: Marius Kriegerowski <marius.kriegerowski@gmail.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit e8b176de448dc387c7a578c92b52aef28591038f)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 bin/bitbake-diffsigs | 49 ++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/bin/bitbake-diffsigs b/bin/bitbake-diffsigs
index cf4cc706..fe0f33ee 100755
--- a/bin/bitbake-diffsigs
+++ b/bin/bitbake-diffsigs
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


