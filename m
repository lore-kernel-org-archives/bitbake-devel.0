Received: from mail-il1-f196.google.com (mail-il1-f196.google.com [209.85.166.196])
 by mx.groups.io with SMTP id smtpd.web10.3737.1591413352384928342
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jun 2020 20:15:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=RrGfuLKC;
 spf=pass (domain: gmail.com, ip: 209.85.166.196, mailfrom: jpewhacker@gmail.com)
Received: by mail-il1-f196.google.com with SMTP id 9so11528103ilg.12
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Jun 2020 20:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ya3v1vflsiE9Qf3SnzQIfJ//6OnrmhNDq6co80XH178=;
        b=RrGfuLKCP4UEZQjySxnHRd9Oj5IAvlj492hljB/QTdzWH75ZBVxaNnH3Tnv6C2iemw
         2bv+YWLyUGZfH+xdr+C1RnvkvfDa3xmT2gDUBwREIiydVO1xQY7gTeg0dWlFtmUwAGxD
         7iphNYd13wEbEQyLyvRHi5U8H1X6ZrtLpSNS+io5bHn50UPTNCZvBiRvkQEOc4FgEJn6
         3eFDz2LCQZO7ab2ySiOvGXjP9AR8XlxqJjVUTDt5znBvZLN7TngKnJBGT8tNq5MwCXVP
         x+tf+KXWqBYjtRbiw3bxNOAtT7qvI0W4wDi/fkUi9+UKHl6Bf/Zgd7d2Mqs5H5Hik309
         S68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ya3v1vflsiE9Qf3SnzQIfJ//6OnrmhNDq6co80XH178=;
        b=ZhqGatGcjyg7TwZ+jWfmyLx5aN2HktW2xG6eRzBQ9G6hhuIsDqjokfxJ3EM6OMyLYs
         K5jCTZ5OpvNYHjpQCAI6p2OCsrQ71WPw2iHDJJzbFlrne0qbIn2B5WBEWNpCzpEX+rKg
         de0A2qNcGbLcO2FlEG0FwHbV5DX7yDzAA+J9J2KxiME6p90U+tIF45IKqLIdJ/v65xHq
         zYLtcSB7dQEtKdFh9C6DhtrwYj6vdWYo4HpgjnM3O8Ja8ZHhsNm2Wg1a8rdU7VlJGRH5
         zbo/Hxzn6rgdXyKmuW1tc2cMfsWhudsrhckTS26kW6FZU8H25chtcm24FPyD4fT9PHSC
         8nYg==
X-Gm-Message-State: AOAM531FJTSBNCrYg0kzq/5k8BbNgGPTbDziYj9OtDA7xiqo5x3x40xa
	tXPirW0YWZxpr4MB1Zul1kyALQuohcg=
X-Google-Smtp-Source: ABdhPJwZghUHkobXBabhUtIiSz5n9/HsD365cpKRA5O9Rdwm6jd4qd4VQHkit3m43LNsrCigLw4g2g==
X-Received: by 2002:a92:c5c5:: with SMTP id s5mr11395879ilt.85.1591413351562;
        Fri, 05 Jun 2020 20:15:51 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:28:333f:5748:fb55])
        by smtp.gmail.com with ESMTPSA id p9sm2885221ile.87.2020.06.05.20.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 20:15:51 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v5 3/8] bitbake: lib: Add support for Logging Adapters
Date: Fri,  5 Jun 2020 22:15:31 -0500
Message-Id: <20200606031536.15956-4-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200606031536.15956-1-JPEWhacker@gmail.com>
References: <20200605015325.35395-1-JPEWhacker@gmail.com>
 <20200606031536.15956-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Creates a BBLoggingAdapter class that is monkey patched in place of the
logginer.LoggingAdapter. The new adapter is compatible with the BBLogger
class API, allowing adapters to be created for bitbake loggers. A new
BBLoggerMixin class is used to reduce code duplication between the BBLogger
and BBLoggerAdapter classes.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/__init__.py | 42 ++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/__init__.py b/bitbake/lib/bb/__init__.py
index b96466e654..cd53603a47 100644
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
@@ -60,10 +62,42 @@ class BBLogger(Logger):
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
+    if sys.version_info < (3, 6):
+        # These properties were added in Python 3.6. Add them in older versions
+        # for compatibility
+        @property
+        def manager(self):
+            return self.logger.manager
+
+        @manager.setter
+        def manager(self, value):
+            self.logger.manager = value
+
+        @property
+        def name(self):
+            return self.logger.name
+
+        def __repr__(self):
+            logger = self.logger
+            level = getLevelName(logger.getEffectiveLevel())
+            return '<%s %s (%s)>' % (self.__class__.__name__, logger.name, level)
+
+logging.LoggerAdapter = BBLoggerAdapter
+
 logger = logging.getLogger("BitBake")
 logger.addHandler(NullHandler())
 logger.setLevel(logging.DEBUG - 2)
-- 
2.26.2

