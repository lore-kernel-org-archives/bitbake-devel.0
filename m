Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web10.48881.1591048193326280570
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2020 14:49:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=Kz00qHKq;
 spf=pass (domain: gmail.com, ip: 209.85.210.176, mailfrom: jpewhacker@gmail.com)
Received: by mail-pf1-f176.google.com with SMTP id w68so3269426pfb.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2020 14:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LFS74GDyyiD79kOgj3nrAjYCB6J2JSP241c4fS/U/+c=;
        b=Kz00qHKqlbga8j7B9hwPNP0gAqeG4RSPvcMOQU1K/7gPS0C4mq3SNwYExzy1N1Z7xZ
         iGSFI24Li39qDkS0iWuBZ1oTtzMqVQBnI0yOGlrdFA2lwv6Ore0AKNY4DkjmB8rlkvE2
         wxtc1K3uAtmXitmPigTVvxMANm+6prYoVzaWZy5ue24L9YTyi9sIRKBZHUUoH75zzrg/
         Bm+vsO0lA+0ENvEDFXCI/bOTDpbQYimn75cEN5M5lC2/weAHxqBCeN4lEEdGUvPtee7L
         EL4wRVMQXuaSwp3KIKWAGo9AU98xGzIgWuvjHNFfPIu1vC0taS+UQkVBZYf6wVl4oI/I
         ieFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LFS74GDyyiD79kOgj3nrAjYCB6J2JSP241c4fS/U/+c=;
        b=oCSda+jRx479/7MX9m3Y7+DLZ64uxVHHyZqZeApVrqInJ84h6/JRFh7/vpFW8IDL5a
         aR4IWQBqu8ov4WMALdKf+IwOeXaT4lvCHoCEibTuiJzussSUiXV4EHu8TjtvTZQ56+yL
         dwoU45TnpQ3xYr4/3oZgaiqAYiFAveJN7IcH+bsyfL92Zt/m2kK0uZOeWEEf0ueGtwLh
         u4U2Tq/bzAsnOa4XqRzLkwkZ9DPighCqLBzq9qASj0rxHA4xIj9XVZfTzsqyLkRwFH8s
         iXjuKwA6a5Xo+TV7EGBXev+3QLDrhMXmSC4N2fqklyK3JBkfdssE4Od2NTjwbMqJW982
         BVbQ==
X-Gm-Message-State: AOAM530DO0w6aeabUDUz6GqVfIKH+k44oQpYyQxvy1bZAL2cIavkqVTA
	n8o59QuifVPN2OnH6DPos17KuCyvmwo=
X-Google-Smtp-Source: ABdhPJx7++Chq9rKwFMaH04JgfuSxrG6tHnAvU/wH1QVlMlgAVrKmQsdL9EdtFRtwrT+5JZjMVFB4Q==
X-Received: by 2002:a63:b146:: with SMTP id g6mr20741519pgp.396.1591048192619;
        Mon, 01 Jun 2020 14:49:52 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:ec76:791a:e792:c8c8])
        by smtp.gmail.com with ESMTPSA id o18sm385458pjp.4.2020.06.01.14.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 14:49:52 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2 3/8] bitbake: lib: Add support for Logging Adapters
Date: Mon,  1 Jun 2020 16:49:40 -0500
Message-Id: <20200601214945.32481-4-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601214945.32481-1-JPEWhacker@gmail.com>
References: <20200601202807.26357-1-JPEWhacker@gmail.com>
 <20200601214945.32481-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.26.2

