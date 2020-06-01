Received: from mail-il1-f193.google.com (mail-il1-f193.google.com [209.85.166.193])
 by mx.groups.io with SMTP id smtpd.web10.47065.1591043298578975846
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2020 13:28:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=gopMxjTh;
 spf=pass (domain: gmail.com, ip: 209.85.166.193, mailfrom: jpewhacker@gmail.com)
Received: by mail-il1-f193.google.com with SMTP id a13so5914013ilh.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2020 13:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y02GWTaGo1uxWgG0lfWluAhyAmnAskTyG6AR7+BbhjY=;
        b=gopMxjTho/uojucPoi4QSvdNh3mVv7mbhV4O5wxLRSAYfyD/Qf7D8iEOZqDlx1FJoq
         ALgzsNNhPZh6CIwAOxpkCl0pzeWYQwhq0NGkUbXPa0XLEyWzeexpCfo/jR8p0Ev5tawg
         NDTRea9kdOhe3WrW/tM/CdoA6HVjm97NOvrSnspRFo+lbQqtoxnx9KzLOy/1Y9pN+h9v
         tYt5XNVkTdMpJlNZZlyoZjzDYWJWEIl3y+Ikm+RbWhIhyWRETEWDDlQmXwCUKQZpq7Nj
         2sC1jLbASIo+wWeaWVjJ0UufCcfBGafGx0hJri7FDh8zsDU3ieMc2W03jKiiTpFSK7ik
         14jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y02GWTaGo1uxWgG0lfWluAhyAmnAskTyG6AR7+BbhjY=;
        b=RP2VNLtnee+LeCJaVDj+lhqFi6OCP3EAVxn5zb1vCKUJ6+NuVg/U24+x9PYRv85dD9
         jKmxlAbY7qqFYC0Eh5RE4TEfxiqL61fvClVTWLgvugSTAeBr4wZ7Cm9nJ/ykhG3wZQM/
         54yGN7vb+emJ4nap7fBCALWBufgeeJWrKUXdV958VlJhp33+tFJ8Gh4jS3PpBXTvr2I0
         vXReqHP8KPdK8F47wDW/lF8vSrHlShjxBnD0zZpu6FAf/fBzId8dvElfNvjKtGAEo/TX
         0u0/75FJwKA8TuxdSFpoEQYCVMiILS3s4lOqtmQ+P0uEivnR/hB0bkMdiRQkgDIvVb6p
         tsMQ==
X-Gm-Message-State: AOAM532sKvWIkdY7uKlt+FbE5aph3AblZHsfgCvgMLQIFc0BpATMGfWZ
	KYu2+35JDv34lucS8YGr1KTCkaNJKKE=
X-Google-Smtp-Source: ABdhPJzoIjipdJ4Stq9eh3GHcXsIoLFqTcLLlyImHJIx6Vvmrin0ZA874k1zmlu9Imo7RTU/cYG4iw==
X-Received: by 2002:a92:8d12:: with SMTP id s18mr17087292ild.168.1591043297819;
        Mon, 01 Jun 2020 13:28:17 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:ec76:791a:e792:c8c8])
        by smtp.gmail.com with ESMTPSA id v16sm300705ilo.47.2020.06.01.13.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 13:28:17 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 3/8] bitbake: lib: Add support for Logging Adapters
Date: Mon,  1 Jun 2020 15:28:02 -0500
Message-Id: <20200601202807.26357-4-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601202807.26357-1-JPEWhacker@gmail.com>
References: <20200601202807.26357-1-JPEWhacker@gmail.com>

Creates a BBLoggingAdapter class that is monkey patched in place of the
logginer.LoggingAdapter. The new adapter is compatible with the BBLogger
class API, allowing adapters to be created for bitbake loggers. A new
BBLoggerMixin class is used to reduce code duplication between the BBLogger
and BBLoggerAdapter classes.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/__init__.py | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/__init__.py b/bitbake/lib/bb/__init__.py
index b96466e654..2e2966c3b9 100644
--- a/bitbake/lib/bb/__init__.py
+++ b/bitbake/lib/bb/__init__.py
@@ -35,12 +35,14 @@ class NullHandler(logging.Handler):
     def emit(self, record):
         pass
 
-Logger = logging.getLoggerClass()
-class BBLogger(Logger):
-    def __init__(self, name):
+class BBLoggerMixin(object):
+    def __init__(self, *args, **kwargs):
+        # Does nothing to allow calling super() from derived classes
+        pass
+
+    def setup_bblogger(self, name):
         if name.split(".")[0] == "BitBake":
             self.debug = self.bbdebug
-        Logger.__init__(self, name)
 
     def bbdebug(self, level, msg, *args, **kwargs):
         loglevel = logging.DEBUG - level + 1
@@ -60,10 +62,22 @@ class BBLogger(Logger):
     def verbnote(self, msg, *args, **kwargs):
         return self.log(logging.INFO + 2, msg, *args, **kwargs)
 
+Logger = logging.getLoggerClass()
+class BBLogger(Logger, BBLoggerMixin):
+    def __init__(self, name, *args, **kwargs):
+        self.setup_bblogger(name)
+        super().__init__(name, *args, **kwargs)
 
 logging.raiseExceptions = False
 logging.setLoggerClass(BBLogger)
 
+class BBLoggerAdapter(logging.LoggerAdapter, BBLoggerMixin):
+    def __init__(self, logger, *args, **kwargs):
+        self.setup_bblogger(logger.name)
+        super().__init__(logger, *args, **kwargs)
+
+logging.LoggerAdapter = BBLoggerAdapter
+
 logger = logging.getLogger("BitBake")
 logger.addHandler(NullHandler())
 logger.setLevel(logging.DEBUG - 2)
-- 
2.17.1

