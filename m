Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BAEC04FFE
	for <webhook@archiver.kernel.org>; Sat, 11 May 2024 11:03:15 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.12402.1715425389061781714
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 11 May 2024 04:03:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=nuV+FkhJ;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 80B64C0003;
	Sat, 11 May 2024 11:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715425387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A4H02KuFgkkWy+56xbW5//7dIiLLkpHSXOkgl650G/w=;
	b=nuV+FkhJmGcj3UJyrTmLroqe9ZbQFgMU8OT7YgAGxPB+jRD3iXyLLkDnj/WifsBqfXohl+
	TX8fh8gnLn3XLyyI9GWG9kPm5aXwB6pKab8j0JLylJ1KbXCXMa65SkF6pmMmLDmJuqNYV8
	Xzq13yMVcFMIQRVsHHTJnmSpayZ/8vR91sqayGlXIUCTJ1ZjKKAOCjTcGBFzp1PH+A5Tqx
	zILQ5Mr1qZmuVn50CNyhJWAkK+OA/onvZIOhTYJIJ5fvq0BGBw0p+uOI97lQLmnJrKRA0G
	9UvoNcJACBawRzOcS0cq8ipFZvjVpXGGhDMkWoxthQ4J2SWSRdT7ipQxAgRiAg==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v7 2/8] prserv: move code from __init__ to bitbake-prserv
Date: Sat, 11 May 2024 16:31:29 +0530
Message-Id: <20240511110135.1887578-3-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240511110135.1887578-1-michael.opdenacker@bootlin.com>
References: <20240511110135.1887578-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 11 May 2024 11:03:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16201

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


