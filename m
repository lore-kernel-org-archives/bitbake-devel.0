Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA7CC04FFE
	for <webhook@archiver.kernel.org>; Mon, 29 Apr 2024 20:14:40 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web10.32482.1714421671449035644
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Apr 2024 13:14:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=mHVpA4YE;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9C4FC20007;
	Mon, 29 Apr 2024 20:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714421669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A4H02KuFgkkWy+56xbW5//7dIiLLkpHSXOkgl650G/w=;
	b=mHVpA4YEV6/hlxV/bt608yYTJTy2vriei9pg5H0EEwsxZYc986bV32/teQ5F0CWoDe4yVL
	Uyi2VDAmDMXTZT2IaAqhcDi3NCiALpmD1l0WQVXwDTzdveLUsqqIbqZUx+F+LDq9Xw8leh
	uKdCnXZj+nSpY39l0kYTQAzuo82w6mFWjPvBPl6BQY1mai/ZEREV2jR1CcWoMY9Ob0d0B1
	F9/SoUBtDR5/YMdNDRv2+xB0Lyf2KeKH3y6NYKCaiyOUzYdGWdcj19OUc65fXXRjfPwsWP
	3uKUr/B49o2b6GJAd/9eZdtIH0P5Dw/tCl4OfXJiB2AJLQOx2MUXNLcIdUzfPw==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v5 2/5] prserv: move code from __init__ to bitbake-prserv
Date: Mon, 29 Apr 2024 22:14:15 +0200
Message-Id: <20240429201418.657042-3-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429201418.657042-1-michael.opdenacker@bootlin.com>
References: <20240429201418.657042-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 29 Apr 2024 20:14:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16151

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

This script was the only user of this code.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Tim Orling <ticotimo@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 bin/bitbake-prserv     |  9 ++++++++-
 lib/prserv/__init__.py | 13 -------------
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/bin/bitbake-prserv b/bin/bitbake-prserv
index ad0a069401..920663a1d8 100755
--- a/bin/bitbake-prserv
+++ b/bin/bitbake-prserv
@@ -21,6 +21,13 @@ VERSION = "1.1.0"
 PRHOST_DEFAULT="0.0.0.0"
 PRPORT_DEFAULT=8585
 
+def init_logger(logfile, loglevel):
+    numeric_level = getattr(logging, loglevel.upper(), None)
+    if not isinstance(numeric_level, int):
+        raise ValueError("Invalid log level: %s" % loglevel)
+    FORMAT = "%(asctime)-15s %(message)s"
+    logging.basicConfig(level=numeric_level, filename=logfile, format=FORMAT)
+
 def main():
     parser = argparse.ArgumentParser(
         description="BitBake PR Server. Version=%s" % VERSION,
@@ -72,7 +79,7 @@ def main():
     )
 
     args = parser.parse_args()
-    prserv.init_logger(os.path.abspath(args.log), args.loglevel)
+    init_logger(os.path.abspath(args.log), args.loglevel)
 
     if args.start:
         ret=prserv.serv.start_daemon(args.file, args.host, args.port, os.path.abspath(args.log), args.read_only)
diff --git a/lib/prserv/__init__.py b/lib/prserv/__init__.py
index 0e0aa34d0e..94658b815d 100644
--- a/lib/prserv/__init__.py
+++ b/lib/prserv/__init__.py
@@ -5,16 +5,3 @@
 #
 
 __version__ = "1.0.0"
-
-import os, time
-import sys, logging
-
-def init_logger(logfile, loglevel):
-    numeric_level = getattr(logging, loglevel.upper(), None)
-    if not isinstance(numeric_level, int):
-        raise ValueError("Invalid log level: %s" % loglevel)
-    FORMAT = "%(asctime)-15s %(message)s"
-    logging.basicConfig(level=numeric_level, filename=logfile, format=FORMAT)
-
-class NotFoundError(Exception):
-    pass
-- 
2.34.1


