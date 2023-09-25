Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB4DCE7A8B
	for <webhook@archiver.kernel.org>; Mon, 25 Sep 2023 02:18:47 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web10.52909.1695608318351341141
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 24 Sep 2023 19:18:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=VbHr+BBj;
 spf=pass (domain: axis.com, ip: 195.60.68.17, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1695608318;
  x=1727144318;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yjF8Ce6YQH5QSWUD95AIG6dnX4Ehvqs7mNsN2W2EmYM=;
  b=VbHr+BBjgbhNA70QOICABjBDDy07o91F8souovbgr5GtSfUAU8ysok+q
   +K2HxhTJAj5SPQsJ6fRWTT6n+vARWvm5CzJrV7EUOCNF5I3dKQoTN1vMJ
   /FdFzmZnbnqU0+Dmh12GzMcXiWU6iTvffOYpTXjYcsPbbOD9irWLe0+LX
   zUax9YaDpQeB4t3v/SCQ81bUbIMxBUCIpX2OE4jTw/RVca1BbW+P6BN7O
   oDZn4WGFLs1pLxOMCHDM1pt9X7sgDuo5mIynnLyfHQD3xOAkTuzfmlhqG
   5xJmXv+f5nsSRILdP6P9nwBsM6rBfgULKioJCFXSbWfNMVpHWuH6EbsFc
   g==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCHv3 1/3] tinfoil: Do not fail when logging is disabled and full config is used
Date: Mon, 25 Sep 2023 04:18:31 +0200
Message-ID: <20230925021833.1303449-1-pkj@axis.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Sep 2023 02:18:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15110

If Tinfoil is initialized with setup_logging = False and
Tinfoil.prepare() is called with config_only = False, then it fails
because self.localhandlers is only initialized when
setup_logging = True.

This is seen with, e.g., `bitbake-getvar -q -r busybox MACHINE`:

  Traceback (most recent call last):
    File ".../bitbake/bin/bitbake-getvar", line 41, in <module>
      tinfoil.prepare(quiet=2)
    File ".../bitbake/lib/bb/tinfoil.py", line 390, in prepare
      for handler in self.localhandlers:
  AttributeError: 'Tinfoil' object has no attribute 'localhandlers'.
  Did you mean: 'oldhandlers'?

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

PATCHv2: New in this patch set.
PATCHv3: No change.

 bitbake/lib/bb/tinfoil.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/tinfoil.py b/bitbake/lib/bb/tinfoil.py
index 2200caa54c..dcd3910cc4 100644
--- a/bitbake/lib/bb/tinfoil.py
+++ b/bitbake/lib/bb/tinfoil.py
@@ -325,11 +325,11 @@ class Tinfoil:
         self.recipes_parsed = False
         self.quiet = 0
         self.oldhandlers = self.logger.handlers[:]
+        self.localhandlers = []
         if setup_logging:
             # This is the *client-side* logger, nothing to do with
             # logging messages from the server
             bb.msg.logger_create('BitBake', output)
-            self.localhandlers = []
             for handler in self.logger.handlers:
                 if handler not in self.oldhandlers:
                     self.localhandlers.append(handler)

