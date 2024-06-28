Return-Path: <ejo@pengutronix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357FEC2BBCA
	for <webhook@archiver.kernel.org>; Fri, 28 Jun 2024 09:27:05 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by mx.groups.io with SMTP id smtpd.web11.13388.1719566816081485402
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Jun 2024 02:26:56 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: pengutronix.de, ip: 185.203.201.7, mailfrom: ejo@pengutronix.de)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ejo@pengutronix.de>)
	id 1sN7sb-00010q-U7; Fri, 28 Jun 2024 11:26:53 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ejo@pengutronix.de>)
	id 1sN7sb-005ZXC-2T; Fri, 28 Jun 2024 11:26:53 +0200
Received: from ejo by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ejo@pengutronix.de>)
	id 1sN7sb-008mo0-04;
	Fri, 28 Jun 2024 11:26:53 +0200
From: =?UTF-8?q?Enrico=20J=C3=B6rns?= <ejo@pengutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: yocto@pengutronix.de
Subject: [PATCH] bitbake-diffsigs: fix handling when finding only a single sigfile
Date: Fri, 28 Jun 2024 11:25:06 +0200
Message-Id: <20240628092506.2089467-1-ejo@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ejo@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: bitbake-devel@lists.openembedded.org
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Jun 2024 09:27:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16381

This fixes the following error when calling 'bitbake-dumpsig' or
'bitbake-diffsigs' when having only a single sigfile available:

| Traceback (most recent call last):
|   File "[..]/poky/bitbake/bin/bitbake-dumpsig", line 171, in <module>
|     files = find_siginfo_task(tinfoil, options.taskargs[0], options.taskargs[1])
|             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
|   File "[..]/poky/bitbake/bin/bitbake-dumpsig", line 83, in find_siginfo_task
|     sig2 = latestsigs[1]
|            ~~~~~~~~~~^^^
| IndexError: list index out of range

Handle this by adding (and returning) the path for the second sigfile
only if one is found. This way it will work for both diffsigs and
dumpsig use case.

The calling argparse code already deals with find_siginfo_task()
returning only a single file.
For 'bitbake-dumpsig' it will just dump the single sigfile, for
'bitbake-diffsigs' it will emit a proper error message again:

| ERROR: Only one matching sigdata file found for the specified task (systemd configure)

Signed-off-by: Enrico Jörns <ejo@pengutronix.de>
---
 bin/bitbake-diffsigs | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/bin/bitbake-diffsigs b/bin/bitbake-diffsigs
index 8202c7862..9d6cb8c94 100755
--- a/bin/bitbake-diffsigs
+++ b/bin/bitbake-diffsigs
@@ -72,16 +72,17 @@ def find_siginfo_task(bbhandler, pn, taskname, sig1=None, sig2=None):
         elif sig2 not in sigfiles:
             logger.error('No sigdata files found matching %s %s with signature %s' % (pn, taskname, sig2))
             sys.exit(1)
+
+        latestfiles = [sigfiles[sig1]['path'], sigfiles[sig2]['path']]
     else:
         sigfiles = find_siginfo(bbhandler, pn, taskname)
         latestsigs = sorted(sigfiles.keys(), key=lambda h: sigfiles[h]['time'])[-2:]
         if not latestsigs:
             logger.error('No sigdata files found matching %s %s' % (pn, taskname))
             sys.exit(1)
-        sig1 = latestsigs[0]
-        sig2 = latestsigs[1]
-
-    latestfiles = [sigfiles[sig1]['path'], sigfiles[sig2]['path']]
+        latestfiles = [sigfiles[latestsigs[0]]['path']]
+        if len(latestsigs) > 1:
+            latestfiles.append(sigfiles[latestsigs[1]]['path'])
 
     return latestfiles
 
-- 
2.39.2


