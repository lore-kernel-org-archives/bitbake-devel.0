Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web10.2226.1591322016001837347
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Jun 2020 18:53:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=k2d9e5ge;
 spf=pass (domain: gmail.com, ip: 209.85.215.178, mailfrom: jpewhacker@gmail.com)
Received: by mail-pg1-f178.google.com with SMTP id u5so4394790pgn.5
        for <bitbake-devel@lists.openembedded.org>; Thu, 04 Jun 2020 18:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ya3v1vflsiE9Qf3SnzQIfJ//6OnrmhNDq6co80XH178=;
        b=k2d9e5ge1ywJVdG/lKm2OM1d9YL6m04KXhMY79O+J6UN11SGZixFH0Pku+8ykZeFvv
         l1E00YHXyMO4zM/8vYcsRvCFUlI0KyJVYSGL3pt4FwQShndgHwfEggc2ursokdSiXKMq
         HxNzMj3Bl00Z4M6lC4hqHLHN+/qrrN51nt7a9nI9t7i1zgomi1cB7wZNr1LkTN2pOwTe
         vLUfMe0ZHTcr544Q3rpO7k+H2QZbzdX15vuCh0MWry5/7Y88DMiEX6Zso+rxMVAgwYxi
         4x0UYhuYbF3maJUhzqYxL/pNp1DclI1jhlcbGq5faBfeIM69lwHxkY7oKQkFBUI74vc7
         w6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ya3v1vflsiE9Qf3SnzQIfJ//6OnrmhNDq6co80XH178=;
        b=b0yRtHls33L5h8kQuc/BqLQHnpOey7ZFZE4VTg5oCIOVFjvL9PzYzpSCbm7aIoyGr4
         KmD5tafjnloTVZFEOKb3Jk39OQ5gNJ5PvHkALob1uD90EdxbumXM1z8/X7gT6ajHLnQn
         p7x0XAxUQpu424SWZkAb5Fwt0zH7bk/fYWj7I9CWG3Y+ZM3Hx9FhKDIPlq/Liv4gJnOE
         LNgafv6oxW+7jEpCmVpHlTZsELrLvSBu7EDXOKXM948gE+u23IalZsFSZJ2VJGiyPeah
         BAhv6bEh+2dLbo+FOzSi/Y+wM7VnORdT9nWhjt7g5cw5M5DFHGSCnUyzFEAN53UqpxTs
         gp3A==
X-Gm-Message-State: AOAM530pT2LzPcDqeP0hXXbkU/gB3JrcZR03j9RmC74kwlPzCHzbwONQ
	G8fenMHQ9O4OgLN6+18KgS0ECCkir4Q=
X-Google-Smtp-Source: ABdhPJwdNGYKYjyXUe8nYZTYTCM0bflwp0iL2nrPgeL1VcXi98Ee9O513nYGXntcUMy/wgPOoqZNMg==
X-Received: by 2002:a65:4c4c:: with SMTP id l12mr7174798pgr.159.1591322015321;
        Thu, 04 Jun 2020 18:53:35 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:bdc6:d557:64ed:7ccf])
        by smtp.gmail.com with ESMTPSA id x12sm5673516pfo.72.2020.06.04.18.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 18:53:34 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v4 3/8] bitbake: lib: Add support for Logging Adapters
Date: Thu,  4 Jun 2020 20:53:20 -0500
Message-Id: <20200605015325.35395-4-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605015325.35395-1-JPEWhacker@gmail.com>
References: <20200603025405.26885-1-JPEWhacker@gmail.com>
 <20200605015325.35395-1-JPEWhacker@gmail.com>
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

