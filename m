Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.11611.1599132270716379519
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Sep 2020 04:24:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WRjg7/JW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id x14so2765465wrl.12
        for <bitbake-devel@lists.openembedded.org>; Thu, 03 Sep 2020 04:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q4l4KfZrz1Le393KK6GeQX1Sgm4pwWWE9xe0Z5Gv3Q4=;
        b=WRjg7/JWC6AscoRz6NJ3eq3ZXz99E4RpXSbgx1tmrxcz+NtUybUAZ3FYmqz6Eks3qo
         JpGGIE5eEyb5+QbdE8dz0F+FSi+5i6UDcOGESaPWZ7YlEUVuKF8RX/3OwpDXl8sbmHLb
         CMV2FH19QJk8e7WEOHCrqD/72f+oipfkPVcXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q4l4KfZrz1Le393KK6GeQX1Sgm4pwWWE9xe0Z5Gv3Q4=;
        b=K765SqsmXBqS1RlK7IDfu+BsAIamcAzFLUGuUyrzd5cBeaqhoNtwyB0GHz/18zj1PF
         6C4/EOZvyKhiD29WAvjiEyJma9r4RLrqaxndgNqTlpcVZ+a0cWL4QcMiQ37flbOJQvtO
         cKbEEPZIlIrPVJOYx9nC0VRS5C+gnE0y0CdvV+wa/NOf+dOTZQSAI2ZxAShQEBcZDKlW
         tQjPfX2745aXXl4DOjH4Tb6Xkqx3H1hrBZMC3HjmOOMAwXM1c7UFfCA0Pm2fXh6li4MY
         Eih3XWkolKU+pGSwyPmh9QGkb/pIbQVnkEgiXdGFn48RhHU+5YaH3OF7U455auoCmJRk
         AWRg==
X-Gm-Message-State: AOAM533NbbH/Her1eDrT/fwh2SpGXFloImpnGKv76sYI+nfvOLs3aSgq
	DusVcPhr6+9PY1NKIY1Il5XjQZVTb8QdKQ==
X-Google-Smtp-Source: ABdhPJwQzyZxhP2XZRtfkmNG+HCBN67ohls0/PxGK0hqor0P0MYtwrBUSCzzlFQxC1HFOJxP73stDA==
X-Received: by 2002:a5d:43cf:: with SMTP id v15mr1954058wrr.269.1599132268648;
        Thu, 03 Sep 2020 04:24:28 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.f.d.f.5.0.6.0.0.2.6.1.6.b.c.7.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:7cb6:1620:605:fdfd])
        by smtp.gmail.com with ESMTPSA id f1sm3974013wrt.20.2020.09.03.04.24.27
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 04:24:28 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/3] cooker/cookerdata: Use BBHandledException, not sys.exit()
Date: Thu,  3 Sep 2020 12:24:25 +0100
Message-Id: <20200903112427.1777983-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling sys.exit() in the middle of the code is rather antisocial. We catch
this in various places but we shouldn't have to. In all these cases we have
already sent events explaining to the user what happened. This means the
correct exception is BBHandledException.

The recent startup changes have moved the point a lot of this code gets
called to inside the UI, with memres it would have always been possible
from there anyway. This change makes things much more consistent.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py     |  4 ++--
 lib/bb/cookerdata.py | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index fc017dd19f..a85e3587fd 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -352,7 +352,7 @@ class BBCooker:
                 self.caches_array.append(getattr(module, cache_name))
             except ImportError as exc:
                 logger.critical("Unable to import extra RecipeInfo '%s' from '%s': %s" % (cache_name, module_name, exc))
-                sys.exit("FATAL: Failed to import extra cache class '%s'." % cache_name)
+                raise bb.BBHandledException()
 
         self.databuilder = bb.cookerdata.CookerDataBuilder(self.configuration, False)
         self.databuilder.parseBaseConfiguration()
@@ -1127,7 +1127,7 @@ class BBCooker:
             from bb import shell
         except ImportError:
             parselog.exception("Interactive mode not available")
-            sys.exit(1)
+            raise bb.BBHandledException()
         else:
             shell.start( self )
 
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 190ff3ab82..48953a830b 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -164,7 +164,7 @@ def catch_parse_error(func):
             import traceback
             parselog.critical(traceback.format_exc())
             parselog.critical("Unable to parse %s: %s" % (fn, exc))
-            sys.exit(1)
+            raise bb.BBHandledException()
         except bb.data_smart.ExpansionError as exc:
             import traceback
 
@@ -176,10 +176,10 @@ def catch_parse_error(func):
                 if not fn.startswith(bbdir):
                     break
             parselog.critical("Unable to parse %s" % fn, exc_info=(exc_class, exc, tb))
-            sys.exit(1)
+            raise bb.BBHandledException()
         except bb.parse.ParseError as exc:
             parselog.critical(str(exc))
-            sys.exit(1)
+            raise bb.BBHandledException()
     return wrapped
 
 @catch_parse_error
@@ -355,7 +355,7 @@ class CookerDataBuilder(object):
                 for layer in broken_layers:
                     parselog.critical("   %s", layer)
                 parselog.critical("Please check BBLAYERS in %s" % (layerconf))
-                sys.exit(1)
+                raise bb.BBHandledException()
 
             for layer in layers:
                 parselog.debug(2, "Adding layer %s", layer)
@@ -427,7 +427,7 @@ class CookerDataBuilder(object):
             handlerfn = data.getVarFlag(var, "filename", False)
             if not handlerfn:
                 parselog.critical("Undefined event handler function '%s'" % var)
-                sys.exit(1)
+                raise bb.BBHandledException()
             handlerln = int(data.getVarFlag(var, "lineno", False))
             bb.event.register(var, data.getVar(var, False),  (data.getVarFlag(var, "eventmask") or "").split(), handlerfn, handlerln)
 
-- 
2.25.1

