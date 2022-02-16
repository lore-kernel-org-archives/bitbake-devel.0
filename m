Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E78C433F5
	for <webhook@archiver.kernel.org>; Wed, 16 Feb 2022 11:32:06 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.10584.1645011125474752576
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 16 Feb 2022 03:32:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=iGeV9QxU;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id q7so2894428wrc.13
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 16 Feb 2022 03:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0nQL8md43KDy3DnfI2XVd9tLIfVIy83dPdA6nNxZ1vg=;
        b=iGeV9QxUKU5w6TCE1JbCMdeiXrrt216MMHSzlc/HCWR5v+x1y69rCb+Qor5vogYOm6
         8Xi3y2rWb3whnI5E28hXh4EFasCYrmRxAxixVug4MgAPSrank8z4ES2ahuOa7Q/Kz/mU
         h+d8xu0ItoTyrb7gCTfa2uAbbCe4BCfKvb6Iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0nQL8md43KDy3DnfI2XVd9tLIfVIy83dPdA6nNxZ1vg=;
        b=5MoRRhhoRb/oBvSq0+cA1+xuGB7YOvINCid7Eyr3BYVfIk9ugE8ezGCqt8t8sDyM0Y
         LOU/fJHxNKD8+tPiOIoGGiiT8WCeUI2W+B6ichZs/dlamkVDkDJqQgjWyd3XEZd6LORR
         yDloST+4Z0BW9gnOfgT7jxA3wvbBB2S6PAbRaHcY/ciHifazoKjUfJjD8JNlzWW4eQUq
         6tRhUGWoGHqsQCYQ73nSiKUtez8mx3wTjzxyMX2G8YK8BsTeebUXO3ir3CEPhvMjch7q
         ccKuRYot8KUij53JKOQ8trM4nlTdmPVfALBfxs17vNHMmRYLwK7U63vxxefpDeA8VTt4
         pd8A==
X-Gm-Message-State: AOAM530MDGKrhUqKDYBs8LmKKnn85vUJ/nICtVXJBKoGNPQVC/AIocrA
	kGoWZvXJzaGEMiERqD0+Ni6kfRZCCs5zTLzZ
X-Google-Smtp-Source: 
 ABdhPJwSgY1rv589w7LK2ttiOPI6b3lwS+v0WIfcwQ/g0G9NFG8V9IHYdTG8yYNnBCoRW0mkrKinXA==
X-Received: by 2002:a5d:4bc9:0:b0:1e5:a66b:df03 with SMTP id
 l9-20020a5d4bc9000000b001e5a66bdf03mr2036080wrt.610.1645011123398;
        Wed, 16 Feb 2022 03:32:03 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:a680:61af:4a53:1ad3])
        by smtp.gmail.com with ESMTPSA id
 x18sm35476238wrw.17.2022.02.16.03.32.02
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 03:32:02 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 4/5] msg: Add bb.erroronce() to logging
Date: Wed, 16 Feb 2022 11:31:57 +0000
Message-Id: <20220216113158.2899964-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220216113158.2899964-1-richard.purdie@linuxfoundation.org>
References: <20220216113158.2899964-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 16 Feb 2022 11:32:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13354

Similar to the warnonce addition in the previous commit, add a similarly
behaving version for error messages.

Tweak the log filter further rather than adding an additional one.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/__init__.py  |  7 +++++++
 lib/bb/msg.py       | 10 +++++++++-
 lib/bb/ui/knotty.py | 20 ++++++++++----------
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index 4b6ad5cbc8..269f65edce 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -74,6 +74,10 @@ class BBLoggerMixin(object):
     def warnonce(self, msg, *args, **kwargs):
         return self.log(logging.WARNING - 1, msg, *args, **kwargs)
 
+    def erroronce(self, msg, *args, **kwargs):
+        return self.log(logging.ERROR - 1, msg, *args, **kwargs)
+
+
 Logger = logging.getLoggerClass()
 class BBLogger(Logger, BBLoggerMixin):
     def __init__(self, name, *args, **kwargs):
@@ -166,6 +170,9 @@ def warnonce(*args):
 def error(*args, **kwargs):
     mainlogger.error(''.join(args), extra=kwargs)
 
+def erroronce(*args):
+    mainlogger.erroronce(''.join(args))
+
 def fatal(*args, **kwargs):
     mainlogger.critical(''.join(args), extra=kwargs)
     raise BBHandledException()
diff --git a/lib/bb/msg.py b/lib/bb/msg.py
index ae079c4596..c2bd8aaf40 100644
--- a/lib/bb/msg.py
+++ b/lib/bb/msg.py
@@ -30,6 +30,7 @@ class BBLogFormatter(logging.Formatter):
     PLAIN = logging.INFO + 1
     VERBNOTE = logging.INFO + 2
     ERROR = logging.ERROR
+    ERRORONCE = logging.ERROR - 1
     WARNING = logging.WARNING
     WARNONCE = logging.WARNING - 1
     CRITICAL = logging.CRITICAL
@@ -45,6 +46,7 @@ class BBLogFormatter(logging.Formatter):
         WARNING : 'WARNING',
         WARNONCE : 'WARNING',
         ERROR   : 'ERROR',
+        ERRORONCE   : 'ERROR',
         CRITICAL: 'ERROR',
     }
 
@@ -62,6 +64,7 @@ class BBLogFormatter(logging.Formatter):
         WARNING : YELLOW,
         WARNONCE : YELLOW,
         ERROR   : RED,
+        ERRORONCE : RED,
         CRITICAL: RED,
     }
 
@@ -124,9 +127,10 @@ class BBLogFilter(object):
             return True
         return False
 
-class LogFilterWarnOnce(logging.Filter):
+class LogFilterShowOnce(logging.Filter):
     def __init__(self):
         self.seen_warnings = set()
+        self.seen_errors = set()
 
     def filter(self, record):
         msg = record.msg
@@ -134,6 +138,10 @@ class LogFilterWarnOnce(logging.Filter):
             if record.msg in self.seen_warnings:
                 return False
             self.seen_warnings.add(record.msg)
+        if record.levelno == bb.msg.BBLogFormatter.ERRORONCE:
+            if record.msg in self.seen_errors:
+                return False
+            self.seen_errors.add(record.msg)
         return True
 
 class LogFilterGEQLevel(logging.Filter):
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 1c46ec843b..93eb4b56cb 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -418,7 +418,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 "formatter": "BitBake.consoleFormatter",
                 "level": console_loglevel,
                 "stream": "ext://sys.stdout",
-                "filters": ["BitBake.warnonceFilter", "BitBake.stdoutFilter"],
+                "filters": ["BitBake.showonceFilter", "BitBake.stdoutFilter"],
                 ".": {
                     "is_console": True,
                 },
@@ -428,7 +428,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 "formatter": "BitBake.consoleFormatter",
                 "level": loglevel,
                 "stream": "ext://sys.stderr",
-                "filters": ["BitBake.warnonceFilter", "BitBake.stderrFilter"],
+                "filters": ["BitBake.showonceFilter", "BitBake.stderrFilter"],
                 ".": {
                     "is_console": True,
                 },
@@ -443,7 +443,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 "formatter": "BitBake.consoleFormatter",
                 "level": 1,
                 "stream": "ext://sys.stdout",
-                "filters": ["BitBake.warnonceFilter", "BitBake.verbconsoleFilter"],
+                "filters": ["BitBake.showonceFilter", "BitBake.verbconsoleFilter"],
                 ".": {
                     "is_console": True,
                 },
@@ -476,8 +476,8 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 "()": "bb.msg.LogFilterLTLevel",
                 "level": console_loglevel
             },
-            "BitBake.warnonceFilter": {
-                "()": "bb.msg.LogFilterWarnOnce",
+            "BitBake.showonceFilter": {
+                "()": "bb.msg.LogFilterShowOnce",
             },
         },
         "loggers": {
@@ -650,7 +650,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
             if isinstance(event, logging.LogRecord):
                 lastprint = time.time()
                 printinterval = 5000
-                if event.levelno >= bb.msg.BBLogFormatter.ERROR:
+                if event.levelno >= bb.msg.BBLogFormatter.ERRORONCE:
                     errors = errors + 1
                     return_value = 1
                 elif event.levelno == bb.msg.BBLogFormatter.WARNING:
@@ -664,10 +664,10 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                         continue
 
                     # Prefix task messages with recipe/task
-                    if event.taskpid in helper.pidmap and event.levelno != bb.msg.BBLogFormatter.PLAIN and event.levelno != bb.msg.BBLogFormatter.WARNONCE:
+                    if event.taskpid in helper.pidmap and event.levelno not in [bb.msg.BBLogFormatter.PLAIN, bb.msg.BBLogFormatter.WARNONCE, bb.msg.BBLogFormatter.ERRORONCE]:
                         taskinfo = helper.running_tasks[helper.pidmap[event.taskpid]]
                         event.msg = taskinfo['title'] + ': ' + event.msg
-                if hasattr(event, 'fn') and event.levelno != bb.msg.BBLogFormatter.WARNONCE:
+                if hasattr(event, 'fn') and event.levelno not in [bb.msg.BBLogFormatter.WARNONCE, bb.msg.BBLogFormatter.ERRORONCE]:
                     event.msg = event.fn + ': ' + event.msg
                 logging.getLogger(event.name).handle(event)
                 continue
@@ -881,8 +881,8 @@ def main(server, eventHandler, params, tf = TerminalFilter):
             summary += pluralise("\nSummary: There was %s WARNING message.",
                                  "\nSummary: There were %s WARNING messages.", warnings)
         if return_value and errors:
-            summary += pluralise("\nSummary: There was %s ERROR message shown, returning a non-zero exit code.",
-                                 "\nSummary: There were %s ERROR messages shown, returning a non-zero exit code.", errors)
+            summary += pluralise("\nSummary: There was %s ERROR message, returning a non-zero exit code.",
+                                 "\nSummary: There were %s ERROR messages, returning a non-zero exit code.", errors)
         if summary and params.options.quiet == 0:
             print(summary)
 
-- 
2.32.0


