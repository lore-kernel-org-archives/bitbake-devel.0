Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.1086.1598288019832760436
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Aug 2020 09:53:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=XyArmgvM;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id x9so4954749wmi.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 24 Aug 2020 09:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PNv/tjsg+K0Mxs419WRnqx7+YvNs+tfIAf9S0oMtDDA=;
        b=XyArmgvM5SyoH26GEwvMbNnXSLUGlYgjl7iELspNnLaWaqMkKYqBmjAIpTbBN58mDn
         MeCC7wTLfXydHT0I9Sn6I7MtwFty2rFdolYCrbpcxmkY84lMZVHxTQUc4QgiImu0K3y0
         CW4/IM6ZHIiPneEjrzHWT0xjL22/Jhr3hxVTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PNv/tjsg+K0Mxs419WRnqx7+YvNs+tfIAf9S0oMtDDA=;
        b=oVP7rWQh+Z6yfYWRm8woOxsXQpQnqenLPbJa1qYEYAA2uMOxF6BM6R9kpoqrKTl1Qo
         QDB/yJmfA+Somd43ylwO8En0tAPuo/Hd3IQtVmvItW7biBq63TYhIa7iw5RhKW4XzIz9
         IvNe3FV/g89guSi1yxQGpZgUxRxDT+eiZHLsPZ3wVTvgGgKUkBK7pw0wA6HtVhdb9rdv
         qF+Zpw/eoOuAb7vheb0Wihr8vpHs5xAUcCVNApwbsND2ZEK9EZET6rio5q1LPKyc/IoW
         /p6BMEkBiE7nFD5x284kKQABwFN0kaVrSPJ2h2oRtUZfQfYJLqvUT1aB060/Waf6xBfT
         APhg==
X-Gm-Message-State: AOAM530UzhJB6aytJO5oieLg0Sc/QXC4GnQbbn2ntO81Cjn5K7P1Uwwi
	Ea5dPXBavwvQTYQoI5fREUtg7m/T2mlOW6MJ
X-Google-Smtp-Source: ABdhPJwVvrEPjIZDRn12ufl6e4AA6csgYPyhmEI5CpInnaurio3d34w8AK536gC6/GFY5+Zr8yDa4w==
X-Received: by 2002:a1c:ba08:: with SMTP id k8mr187600wmf.49.1598288013923;
        Mon, 24 Aug 2020 09:53:33 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.d.0.9.8.0.3.8.5.d.6.d.5.a.5.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:45a5:d6d5:8308:90dd])
        by smtp.gmail.com with ESMTPSA id f19sm182127wmh.44.2020.08.24.09.53.33
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 09:53:33 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 02/10] cooker/cookerdata/main: Improve loglevel handling
Date: Mon, 24 Aug 2020 17:53:23 +0100
Message-Id: <20200824165331.1373725-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824165331.1373725-1-richard.purdie@linuxfoundation.org>
References: <20200824165331.1373725-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than passing debug/verbose/debug_domains around, pass the
computed output of these. Ensure that the cooker sets the levels
to match the levels currently set in the UI and generally try and
make it easier to understand what the code is doing.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py     |  7 ++++++-
 lib/bb/cookerdata.py | 10 ++++++----
 lib/bb/main.py       |  8 ++++----
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 57caf38c2a..c34de303fb 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -446,7 +446,12 @@ class BBCooker:
                 logger.debug(1, "Marking as dirty due to '%s' option change to '%s'" % (o, options[o]))
                 print("Marking as dirty due to '%s' option change to '%s'" % (o, options[o]))
                 clean = False
-            setattr(self.configuration, o, options[o])
+            if hasattr(self.configuration, o):
+                setattr(self.configuration, o, options[o])
+
+        bb.msg.loggerDefaultLogLevel = self.configuration.default_loglevel
+        bb.msg.loggerDefaultDomains = self.configuration.debug_domains
+
         for k in bb.utils.approved_variables():
             if k in environment and k not in self.configuration.env:
                 logger.debug(1, "Updating new environment variable %s to %s" % (k, environment[k]))
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 6bf411bcd2..f43610e7f8 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -58,13 +58,15 @@ class ConfigParameters(object):
     def updateToServer(self, server, environment):
         options = {}
         for o in ["abort", "force", "invalidate_stamp",
-                  "debug", "dry_run", "dump_signatures",
-                  "debug_domains", "extra_assume_provided", "profile",
+                  "dry_run", "dump_signatures",
+                  "extra_assume_provided", "profile",
                   "prefile", "postfile", "server_timeout"]:
             options[o] = getattr(self.options, o)
 
         options['build_verbose_shell'] = self.options.verbose
         options['build_verbose_stdout'] = self.options.verbose
+        options['default_loglevel'] = bb.msg.loggerDefaultLogLevel
+        options['debug_domains'] = bb.msg.loggerDefaultDomains
 
         ret, error = server.runCommand(["updateConfig", options, environment, sys.argv])
         if error:
@@ -114,11 +116,11 @@ class CookerConfiguration(object):
     """
 
     def __init__(self):
-        self.debug_domains = []
+        self.debug_domains = bb.msg.loggerDefaultDomains
+        self.default_loglevel = bb.msg.loggerDefaultLogLevel
         self.extra_assume_provided = []
         self.prefile = []
         self.postfile = []
-        self.debug = 0
         self.cmd = None
         self.abort = True
         self.force = False
diff --git a/lib/bb/main.py b/lib/bb/main.py
index af2880f8d5..e483cce1ae 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -357,11 +357,11 @@ def bitbake_main(configParams, configuration):
 
     if "BBDEBUG" in os.environ:
         level = int(os.environ["BBDEBUG"])
-        if level > configuration.debug:
-            configuration.debug = level
+        if level > configParams.debug:
+            configParams.debug = level
 
-    bb.msg.init_msgconfig(configParams.verbose, configuration.debug,
-                          configuration.debug_domains)
+    bb.msg.init_msgconfig(configParams.verbose, configParams.debug,
+                          configParams.debug_domains)
 
     server_connection, ui_module = setup_bitbake(configParams, configuration)
     # No server connection
-- 
2.25.1

