Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7659CC433EF
	for <webhook@archiver.kernel.org>; Wed, 16 Feb 2022 11:32:05 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web10.10660.1645011124395446328
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 16 Feb 2022 03:32:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=emWoe5st;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id u1so2918180wrg.11
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 16 Feb 2022 03:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mf9cRxB2jcbipoDLPACEU6B9nlQVyv01TBp2ijmDQiU=;
        b=emWoe5stP09Q++W3V5Dl8s1uYt2GTGlaHQgwi3vNjbQRkjwaVah0PfUX31fwHqsNKV
         pcupYXuFqtd+1HzMDJRLIsGQon95Y1jUmFzEAuAvusYMCsDzF/GUbESyZELWSIEYVYDx
         fPDRZZVnqC7B4FpW4UyMVOVn7lwTn3NsOkN2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mf9cRxB2jcbipoDLPACEU6B9nlQVyv01TBp2ijmDQiU=;
        b=fnbelarT3PU/cv4boOWAS5Cq8Ml2DvSB8WPF8foCzlFYucwipfja0mcUEvD06Nyx82
         WF/fWAx+1mVvEGYbv91/6TYseXIQh8fDYFarsTdkWp1juQW51WNvbwiP9oRd2i5w5Z+9
         qut0Gaky6HaqN26gIfO3VGVKCat+zTEpH8rQKW/XwnGmYeXrUXKZrmz9v7Qn/luJjcSl
         R5pSb0GtHFEPlfYuoOVexny91QWrJ478ywQ/mf+cIRl4Te4oB4iwvSG8KmIG7SgrCW9K
         lU83ERhTQx8/ZNs9GBANe7J6vCVrvDxyvdAdVsgZ/AdCbBnhkPVUK1BA1RbkpqM9wnak
         cuNQ==
X-Gm-Message-State: AOAM531K3VO7jt0eDJjSttPUKkAmf286ugqiRnFEUUH7vk7SesgaRa3C
	ws+Z2Tff+8AlEfMNWGwJSMbsJ6BgJlqDgN10
X-Google-Smtp-Source: 
 ABdhPJwuhMc/z88C3VvJ7cK9cMkci4hI2ut5/MAr8ZES0fpucFQfOCQvb413CnH+EloGOHL1tuTaJw==
X-Received: by 2002:adf:c385:0:b0:1e3:3ac:5b1b with SMTP id
 p5-20020adfc385000000b001e303ac5b1bmr2020529wrf.545.1645011122356;
        Wed, 16 Feb 2022 03:32:02 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:a680:61af:4a53:1ad3])
        by smtp.gmail.com with ESMTPSA id
 x18sm35476238wrw.17.2022.02.16.03.32.01
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 03:32:01 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/5] msg: Add a bb.warnonce() log method
Date: Wed, 16 Feb 2022 11:31:56 +0000
Message-Id: <20220216113158.2899964-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220216113158.2899964-1-richard.purdie@linuxfoundation.org>
References: <20220216113158.2899964-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 16 Feb 2022 11:32:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13353

This adds a log level and logging function call to use it where the
warning will only be displayed once, regardless of how many times the
message is logged.

This has to be done either in the cooker or on the UI side. I've opted
for the UI side since display control is really a UI issue but it uses
a common library filter function to enable it which can be reused
elsewhere.

The knotty message displayed as the build summary is tweaked to
make sense when the numbers won't match since it will still count
the number of times it was logged and this is probably helpful
for debugging in some cases so I've deliberately left it that way.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/__init__.py  |  6 ++++++
 lib/bb/msg.py       | 15 +++++++++++++++
 lib/bb/ui/knotty.py | 17 ++++++++++-------
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index e01b8d5256..4b6ad5cbc8 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -71,6 +71,9 @@ class BBLoggerMixin(object):
     def verbnote(self, msg, *args, **kwargs):
         return self.log(logging.INFO + 2, msg, *args, **kwargs)
 
+    def warnonce(self, msg, *args, **kwargs):
+        return self.log(logging.WARNING - 1, msg, *args, **kwargs)
+
 Logger = logging.getLoggerClass()
 class BBLogger(Logger, BBLoggerMixin):
     def __init__(self, name, *args, **kwargs):
@@ -157,6 +160,9 @@ def verbnote(*args):
 def warn(*args):
     mainlogger.warning(''.join(args))
 
+def warnonce(*args):
+    mainlogger.warnonce(''.join(args))
+
 def error(*args, **kwargs):
     mainlogger.error(''.join(args), extra=kwargs)
 
diff --git a/lib/bb/msg.py b/lib/bb/msg.py
index 291b38ff7f..ae079c4596 100644
--- a/lib/bb/msg.py
+++ b/lib/bb/msg.py
@@ -31,6 +31,7 @@ class BBLogFormatter(logging.Formatter):
     VERBNOTE = logging.INFO + 2
     ERROR = logging.ERROR
     WARNING = logging.WARNING
+    WARNONCE = logging.WARNING - 1
     CRITICAL = logging.CRITICAL
 
     levelnames = {
@@ -42,6 +43,7 @@ class BBLogFormatter(logging.Formatter):
         PLAIN  : '',
         VERBNOTE: 'NOTE',
         WARNING : 'WARNING',
+        WARNONCE : 'WARNING',
         ERROR   : 'ERROR',
         CRITICAL: 'ERROR',
     }
@@ -58,6 +60,7 @@ class BBLogFormatter(logging.Formatter):
         PLAIN   : BASECOLOR,
         VERBNOTE: BASECOLOR,
         WARNING : YELLOW,
+        WARNONCE : YELLOW,
         ERROR   : RED,
         CRITICAL: RED,
     }
@@ -121,6 +124,18 @@ class BBLogFilter(object):
             return True
         return False
 
+class LogFilterWarnOnce(logging.Filter):
+    def __init__(self):
+        self.seen_warnings = set()
+
+    def filter(self, record):
+        msg = record.msg
+        if record.levelno == bb.msg.BBLogFormatter.WARNONCE:
+            if record.msg in self.seen_warnings:
+                return False
+            self.seen_warnings.add(record.msg)
+        return True
+
 class LogFilterGEQLevel(logging.Filter):
     def __init__(self, level):
         self.strlevel = str(level)
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 484545a684..1c46ec843b 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -418,7 +418,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 "formatter": "BitBake.consoleFormatter",
                 "level": console_loglevel,
                 "stream": "ext://sys.stdout",
-                "filters": ["BitBake.stdoutFilter"],
+                "filters": ["BitBake.warnonceFilter", "BitBake.stdoutFilter"],
                 ".": {
                     "is_console": True,
                 },
@@ -428,7 +428,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 "formatter": "BitBake.consoleFormatter",
                 "level": loglevel,
                 "stream": "ext://sys.stderr",
-                "filters": ["BitBake.stderrFilter"],
+                "filters": ["BitBake.warnonceFilter", "BitBake.stderrFilter"],
                 ".": {
                     "is_console": True,
                 },
@@ -443,7 +443,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 "formatter": "BitBake.consoleFormatter",
                 "level": 1,
                 "stream": "ext://sys.stdout",
-                "filters": ["BitBake.verbconsoleFilter"],
+                "filters": ["BitBake.warnonceFilter", "BitBake.verbconsoleFilter"],
                 ".": {
                     "is_console": True,
                 },
@@ -476,6 +476,9 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 "()": "bb.msg.LogFilterLTLevel",
                 "level": console_loglevel
             },
+            "BitBake.warnonceFilter": {
+                "()": "bb.msg.LogFilterWarnOnce",
+            },
         },
         "loggers": {
             "BitBake": {
@@ -661,10 +664,10 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                         continue
 
                     # Prefix task messages with recipe/task
-                    if event.taskpid in helper.pidmap and event.levelno != bb.msg.BBLogFormatter.PLAIN:
+                    if event.taskpid in helper.pidmap and event.levelno != bb.msg.BBLogFormatter.PLAIN and event.levelno != bb.msg.BBLogFormatter.WARNONCE:
                         taskinfo = helper.running_tasks[helper.pidmap[event.taskpid]]
                         event.msg = taskinfo['title'] + ': ' + event.msg
-                if hasattr(event, 'fn'):
+                if hasattr(event, 'fn') and event.levelno != bb.msg.BBLogFormatter.WARNONCE:
                     event.msg = event.fn + ': ' + event.msg
                 logging.getLogger(event.name).handle(event)
                 continue
@@ -875,8 +878,8 @@ def main(server, eventHandler, params, tf = TerminalFilter):
             for failure in taskfailures:
                 summary += "\n  %s" % failure
         if warnings:
-            summary += pluralise("\nSummary: There was %s WARNING message shown.",
-                                 "\nSummary: There were %s WARNING messages shown.", warnings)
+            summary += pluralise("\nSummary: There was %s WARNING message.",
+                                 "\nSummary: There were %s WARNING messages.", warnings)
         if return_value and errors:
             summary += pluralise("\nSummary: There was %s ERROR message shown, returning a non-zero exit code.",
                                  "\nSummary: There were %s ERROR messages shown, returning a non-zero exit code.", errors)
-- 
2.32.0


