Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E29CD1291
	for <webhook@archiver.kernel.org>; Fri, 29 Mar 2024 14:40:28 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.25.1711723225272335395
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 Mar 2024 07:40:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=fc0blRhq;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4DEE7C0005;
	Fri, 29 Mar 2024 14:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711723223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xHnx3AYMKTLPfPEJ1mMEUn5TKsr/3wVscnGR7vucOkI=;
	b=fc0blRhqQaaaQCZrAXsxwvEdhfsQU+JgncPB1VSVIcj+/WquASHCc5qomENugXXWXTNPUL
	oPDtw5aGMGVnVAXK9ynfS8qPS3PUiMPrtOyfAYz/Qn21Zpnil5EAoEfpdgyGwhCNFizc0y
	Xz/oBRXFMNpfsuQFl0W0QFBFiHNX17r4RVjVRT2UWmkd3LpSizJA/QKlLGhFgiWfHsoeAu
	qjaIZ4MkvC5z/9fqfI8KCC/lwetPc2+7Yf1MwfWCDeQilmnKb/oMMrZQ0k09CIzsAl+hhl
	48pzP5ysgukn54/sSb+pOROjNFfk3+2L1uDieVhxANYkDFHfeiflO/OTXSGwGQ==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>
Subject: [PATCH 03/12] bitbake-prserv: replace deprecated optparse by argparse
Date: Fri, 29 Mar 2024 15:39:47 +0100
Message-Id: <20240329143956.1602707-4-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329143956.1602707-1-michael.opdenacker@bootlin.com>
References: <20240329143956.1602707-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Mar 2024 14:40:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16025

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

optparse is deprecated since Python 2.7

Note that this is neither supposed to change the options
supported by bitbake-prserv nor the way they are interpreted.

Note that in the "--help" output, long options are now reported
for example as "--host HOST" instead of "--host=HOST" but
both are equivalent anyway, as they already were with optparse.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Tim Orling <ticotimo@gmail.com>
---
 bin/bitbake-prserv | 82 +++++++++++++++++++++++++++++++---------------
 1 file changed, 55 insertions(+), 27 deletions(-)

diff --git a/bin/bitbake-prserv b/bin/bitbake-prserv
index 8c3808fb20..ad0a069401 100755
--- a/bin/bitbake-prserv
+++ b/bin/bitbake-prserv
@@ -7,7 +7,7 @@
 
 import os
 import sys,logging
-import optparse
+import argparse
 import warnings
 warnings.simplefilter("default")
 
@@ -16,40 +16,68 @@ sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(__file__)), "lib
 import prserv
 import prserv.serv
 
-__version__="1.0.0"
+VERSION = "1.1.0"
 
 PRHOST_DEFAULT="0.0.0.0"
 PRPORT_DEFAULT=8585
 
 def main():
-    parser = optparse.OptionParser(
-        version="Bitbake PR Service Core version %s, %%prog version %s" % (prserv.__version__, __version__),
-        usage = "%prog < --start | --stop > [options]")
+    parser = argparse.ArgumentParser(
+        description="BitBake PR Server. Version=%s" % VERSION,
+        formatter_class=argparse.RawTextHelpFormatter)
 
-    parser.add_option("-f", "--file", help="database filename(default: prserv.sqlite3)", action="store",
-                      dest="dbfile", type="string", default="prserv.sqlite3")
-    parser.add_option("-l", "--log", help="log filename(default: prserv.log)", action="store",
-                      dest="logfile", type="string", default="prserv.log")
-    parser.add_option("--loglevel", help="logging level, i.e. CRITICAL, ERROR, WARNING, INFO, DEBUG",
-                      action = "store", type="string", dest="loglevel", default = "INFO")
-    parser.add_option("--start", help="start daemon",
-                      action="store_true", dest="start")
-    parser.add_option("--stop", help="stop daemon",
-                      action="store_true", dest="stop")
-    parser.add_option("--host", help="ip address to bind", action="store",
-                      dest="host", type="string", default=PRHOST_DEFAULT)
-    parser.add_option("--port", help="port number(default: 8585)", action="store",
-                      dest="port", type="int", default=PRPORT_DEFAULT)
-    parser.add_option("-r", "--read-only", help="open database in read-only mode",
-                      action="store_true")
+    parser.add_argument(
+        "-f",
+        "--file",
+        default="prserv.sqlite3",
+        help="database filename (default: prserv.sqlite3)",
+    )
+    parser.add_argument(
+        "-l",
+        "--log",
+        default="prserv.log",
+        help="log filename(default: prserv.log)",
+    )
+    parser.add_argument(
+        "--loglevel",
+        default="INFO",
+        help="logging level, i.e. CRITICAL, ERROR, WARNING, INFO, DEBUG",
+    )
+    parser.add_argument(
+        "--start",
+        action="store_true",
+        help="start daemon",
+    )
+    parser.add_argument(
+        "--stop",
+        action="store_true",
+        help="stop daemon",
+    )
+    parser.add_argument(
+        "--host",
+        help="ip address to bind",
+        default=PRHOST_DEFAULT,
+    )
+    parser.add_argument(
+        "--port",
+        type=int,
+        default=PRPORT_DEFAULT,
+        help="port number (default: 8585)",
+    )
+    parser.add_argument(
+        "-r",
+        "--read-only",
+        action="store_true",
+        help="open database in read-only mode",
+    )
 
-    options, args = parser.parse_args(sys.argv)
-    prserv.init_logger(os.path.abspath(options.logfile),options.loglevel)
+    args = parser.parse_args()
+    prserv.init_logger(os.path.abspath(args.log), args.loglevel)
 
-    if options.start:
-        ret=prserv.serv.start_daemon(options.dbfile, options.host, options.port,os.path.abspath(options.logfile), options.read_only)
-    elif options.stop:
-        ret=prserv.serv.stop_daemon(options.host, options.port)
+    if args.start:
+        ret=prserv.serv.start_daemon(args.file, args.host, args.port, os.path.abspath(args.log), args.read_only)
+    elif args.stop:
+        ret=prserv.serv.stop_daemon(args.host, args.port)
     else:
         ret=parser.print_help()
     return ret
-- 
2.34.1


