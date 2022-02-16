Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8584DC433EF
	for <webhook@archiver.kernel.org>; Wed, 16 Feb 2022 15:47:08 +0000 (UTC)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41])
 by mx.groups.io with SMTP id smtpd.web09.647.1645026427115211845
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 16 Feb 2022 07:47:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=aF8iGH2x;
 spf=pass (domain: gmail.com, ip: 209.85.210.41,
 mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f41.google.com with SMTP id
 j8-20020a056830014800b005ad00ef6d5dso796909otp.0
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 16 Feb 2022 07:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jtCBsn4TeSNdb6ozlyUrHmRshFksdH8VAAqh1SioRps=;
        b=aF8iGH2x35Qac2AvsVmckKnE5asR3kz+1rWFlUBxGwhv6F61kzR+ozzFVD4M5CidJN
         WwL3EAUfyAesIdQg14T9ZOACx+McMJZnE27fN7Hu7E9wZrvhZDQYu04qQEQ/0QynsNYR
         PTB7cZoo/X3V5IfeL8p+x/P/pFJcPeuK7ZenjM2YT61tBPnBdyHojK3kb2gVILivF5Fo
         EVd4/v9w77jwfW46sNXGK4xDKnM5BODARihqVha4qhIqHOgvvqLXvuU0LRvvO1QP2HQL
         kMrd1d5T+ENc2MdzV3wNOzInRbZokkP0nD6Dbd7TGdSRyk7SEj0mVIMVqAJb+cDLN/va
         CgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jtCBsn4TeSNdb6ozlyUrHmRshFksdH8VAAqh1SioRps=;
        b=za5PdRczYiNX8wZ6Z7po6gWW8FrUeMpa75rB3CrlnFkVayzUwfEhxdnfwvD8MqhK2O
         KApRQymVBCmcta15XrHmvOVtCQKD8hQKDNDfjqQH7i7OYz6V5EyTqr7ZZywlIY63/A2a
         TUZ2UybIuvo+ZVV0tOhKL0xGizCp6f4AF50JJcYZL/wcQdAD76QNXJhS9odWUVPbWuQc
         UE+EjTw9patYIHGb5jQBcMPkOuAYaFQlDIFWKyM+1nACBbUp+UJyD+2hmS0oyYMwLmGL
         glAVXCaBYpOTRiTKptEUvOrUmqeFYrCiYfGryi8q7HtmuEZDDlKVIJMYtJlzb1CSjbHt
         BXnw==
X-Gm-Message-State: AOAM532TX++gyh7pysv69TGSgwHen6CldviTqyKelldx+exjxkoBocZE
	hDTN16MQ5atqTa3k4ECR7oVxwUDtE+8=
X-Google-Smtp-Source: 
 ABdhPJyG6g3DUDTsS4b26pgC58rBA1y+rL2+t53cutKuEvmVcquEZ9TY1a17OqY3qJcXtgqJpbkoJw==
X-Received: by 2002:a05:6830:3102:b0:598:ec7b:667d with SMTP id
 b2-20020a056830310200b00598ec7b667dmr1057867ots.308.1645026424957;
        Wed, 16 Feb 2022 07:47:04 -0800 (PST)
Received: from localhost.localdomain ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id
 a128sm2645770oob.17.2022.02.16.07.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 07:47:04 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] bitbake: msg: Add bb.warnonce() and
 bb.erroronce() log methods
Date: Wed, 16 Feb 2022 09:46:46 -0600
Message-Id: <20220216154646.2499980-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 16 Feb 2022 15:47:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13356

From: Richard Purdie <richard.purdie@linuxfoundation.org>

This adds a log level and logging function call to use it where the
warning or error will only be displayed once, regardless of how many
times the message is logged.

This has to be done either in the cooker or on the UI side. I've opted
for the UI side since display control is really a UI issue but it uses
a common library filter function to enable it which can be reused
elsewhere.

The knotty message displayed as the build summary is tweaked to
make sense when the numbers won't match since it will still count
the number of times it was logged and this is probably helpful
for debugging in some cases so I've deliberately left it that way.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/__init__.py  | 13 +++++++++++++
 bitbake/lib/bb/msg.py       | 32 +++++++++++++++++++++++++++++++-
 bitbake/lib/bb/ui/knotty.py | 14 +++++++-------
 3 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/__init__.py b/bitbake/lib/bb/__init__.py
index e01b8d5256..269f65edce 100644
--- a/bitbake/lib/bb/__init__.py
+++ b/bitbake/lib/bb/__init__.py
@@ -71,6 +71,13 @@ class BBLoggerMixin(object):
     def verbnote(self, msg, *args, **kwargs):
         return self.log(logging.INFO + 2, msg, *args, **kwargs)
 
+    def warnonce(self, msg, *args, **kwargs):
+        return self.log(logging.WARNING - 1, msg, *args, **kwargs)
+
+    def erroronce(self, msg, *args, **kwargs):
+        return self.log(logging.ERROR - 1, msg, *args, **kwargs)
+
+
 Logger = logging.getLoggerClass()
 class BBLogger(Logger, BBLoggerMixin):
     def __init__(self, name, *args, **kwargs):
@@ -157,9 +164,15 @@ def verbnote(*args):
 def warn(*args):
     mainlogger.warning(''.join(args))
 
+def warnonce(*args):
+    mainlogger.warnonce(''.join(args))
+
 def error(*args, **kwargs):
     mainlogger.error(''.join(args), extra=kwargs)
 
+def erroronce(*args):
+    mainlogger.erroronce(''.join(args))
+
 def fatal(*args, **kwargs):
     mainlogger.critical(''.join(args), extra=kwargs)
     raise BBHandledException()
diff --git a/bitbake/lib/bb/msg.py b/bitbake/lib/bb/msg.py
index 291b38ff7f..512ec1f5c1 100644
--- a/bitbake/lib/bb/msg.py
+++ b/bitbake/lib/bb/msg.py
@@ -30,7 +30,9 @@ class BBLogFormatter(logging.Formatter):
     PLAIN = logging.INFO + 1
     VERBNOTE = logging.INFO + 2
     ERROR = logging.ERROR
+    ERRORONCE = logging.ERROR - 1
     WARNING = logging.WARNING
+    WARNONCE = logging.WARNING - 1
     CRITICAL = logging.CRITICAL
 
     levelnames = {
@@ -42,7 +44,9 @@ class BBLogFormatter(logging.Formatter):
         PLAIN  : '',
         VERBNOTE: 'NOTE',
         WARNING : 'WARNING',
+        WARNONCE : 'WARNING',
         ERROR   : 'ERROR',
+        ERRORONCE   : 'ERROR',
         CRITICAL: 'ERROR',
     }
 
@@ -58,7 +62,9 @@ class BBLogFormatter(logging.Formatter):
         PLAIN   : BASECOLOR,
         VERBNOTE: BASECOLOR,
         WARNING : YELLOW,
+        WARNONCE : YELLOW,
         ERROR   : RED,
+        ERRORONCE : RED,
         CRITICAL: RED,
     }
 
@@ -121,6 +127,23 @@ class BBLogFilter(object):
             return True
         return False
 
+class LogFilterShowOnce(logging.Filter):
+    def __init__(self):
+        self.seen_warnings = set()
+        self.seen_errors = set()
+
+    def filter(self, record):
+        msg = record.msg
+        if record.levelno == bb.msg.BBLogFormatter.WARNONCE:
+            if record.msg in self.seen_warnings:
+                return False
+            self.seen_warnings.add(record.msg)
+        if record.levelno == bb.msg.BBLogFormatter.ERRORONCE:
+            if record.msg in self.seen_errors:
+                return False
+            self.seen_errors.add(record.msg)
+        return True
+
 class LogFilterGEQLevel(logging.Filter):
     def __init__(self, level):
         self.strlevel = str(level)
@@ -293,10 +316,17 @@ def setLoggingConfig(defaultconfig, userconfigfile=None):
 
     # Convert all level parameters to integers in case users want to use the
     # bitbake defined level names
-    for h in logconfig["handlers"].values():
+    for name, h in logconfig["handlers"].items():
         if "level" in h:
             h["level"] = bb.msg.stringToLevel(h["level"])
 
+        # Every handler needs its own instance of the once filter.
+        once_filter_name = name + ".showonceFilter"
+        logconfig.setdefault("filters", {})[once_filter_name] = {
+            "()": "bb.msg.LogFilterShowOnce",
+        }
+        h.setdefault("filters", []).append(once_filter_name)
+
     for l in logconfig["loggers"].values():
         if "level" in l:
             l["level"] = bb.msg.stringToLevel(l["level"])
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index d6f95fb17d..528b8a0760 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -647,7 +647,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
             if isinstance(event, logging.LogRecord):
                 lastprint = time.time()
                 printinterval = 5000
-                if event.levelno >= bb.msg.BBLogFormatter.ERROR:
+                if event.levelno >= bb.msg.BBLogFormatter.ERRORONCE:
                     errors = errors + 1
                     return_value = 1
                 elif event.levelno == bb.msg.BBLogFormatter.WARNING:
@@ -661,10 +661,10 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                         continue
 
                     # Prefix task messages with recipe/task
-                    if event.taskpid in helper.pidmap and event.levelno != bb.msg.BBLogFormatter.PLAIN:
+                    if event.taskpid in helper.pidmap and event.levelno not in [bb.msg.BBLogFormatter.PLAIN, bb.msg.BBLogFormatter.WARNONCE, bb.msg.BBLogFormatter.ERRORONCE]:
                         taskinfo = helper.running_tasks[helper.pidmap[event.taskpid]]
                         event.msg = taskinfo['title'] + ': ' + event.msg
-                if hasattr(event, 'fn'):
+                if hasattr(event, 'fn') and event.levelno not in [bb.msg.BBLogFormatter.WARNONCE, bb.msg.BBLogFormatter.ERRORONCE]:
                     event.msg = event.fn + ': ' + event.msg
                 logging.getLogger(event.name).handle(event)
                 continue
@@ -875,11 +875,11 @@ def main(server, eventHandler, params, tf = TerminalFilter):
             for failure in taskfailures:
                 summary += "\n  %s" % failure
         if warnings:
-            summary += pluralise("\nSummary: There was %s WARNING message shown.",
-                                 "\nSummary: There were %s WARNING messages shown.", warnings)
+            summary += pluralise("\nSummary: There was %s WARNING message.",
+                                 "\nSummary: There were %s WARNING messages.", warnings)
         if return_value and errors:
-            summary += pluralise("\nSummary: There was %s ERROR message shown, returning a non-zero exit code.",
-                                 "\nSummary: There were %s ERROR messages shown, returning a non-zero exit code.", errors)
+            summary += pluralise("\nSummary: There was %s ERROR message, returning a non-zero exit code.",
+                                 "\nSummary: There were %s ERROR messages, returning a non-zero exit code.", errors)
         if summary and params.options.quiet == 0:
             print(summary)
 
-- 
2.33.0


