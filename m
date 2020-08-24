Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.1085.1598288019687779863
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Aug 2020 09:53:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=d17ADAdg;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id g75so8830436wme.4
        for <bitbake-devel@lists.openembedded.org>; Mon, 24 Aug 2020 09:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VM2XjzY12RoWU500wngoN6bD+8iImHFGEvIupHTgVU8=;
        b=d17ADAdgeziAqLJl0jr1bn6ctV5aibUJMmg5wxJUJh00TO5LuCHUGPAFWXYEb1fZ1Q
         6CACvYKxSaACbeSiRwm59VDEwz+N1Q1Mv0exfdhcxR47ZmyxVDT/FJ1cSuOU6JI0UpZO
         n4y+yuy72D+B3nDIdbQxiLf79Jd0LrvSbFO7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VM2XjzY12RoWU500wngoN6bD+8iImHFGEvIupHTgVU8=;
        b=JoKmqfqlFHHgkCHtt/+N1ShAtk9by9LrdyRwlTonoPzailAQ4OO/f/PSKYSHXHEpjT
         U3LRbZcnpweo9HQwC7vFvKd5qSxpidFH1vEQb68rSf7UmAwSXZCNE6TCC1W4GkaAhoB0
         lFAvYRi+33W1qVR2xPrEEaUVaxaTO/QUJoCBxhxc1gaARuRX8fF8ALoPCCiVkwwBfqdF
         dAvBY30RnK/UNLodyXbKXNkqdnr4lb1fGDjYm9C+b1dWAAqPa5q3gSxicBBCEuMi0E8+
         72XM011DlMJeG1pvQ+1xpCZj+j4UXqod3ZHfRxtsSdZ9b3PF9sqZEK4aOYzPO3/KsPA4
         QFKA==
X-Gm-Message-State: AOAM532nbLvkapuyfIZyBLZeceCIqQZVTh/aE7zb8dY+oTNxS7+NQ4EF
	BbuPDECduqV0BV0qDCFPQeRHpxxJYmUR5PoE
X-Google-Smtp-Source: ABdhPJxD0GOuyLDheG679u2UyMyseYpcBA1IQ6Xu7ZsPTYQmJD3JPwJoiehCBuz/phzeJNoxx2CotA==
X-Received: by 2002:a7b:ce8c:: with SMTP id q12mr163428wmj.189.1598288017675;
        Mon, 24 Aug 2020 09:53:37 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.d.0.9.8.0.3.8.5.d.6.d.5.a.5.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:45a5:d6d5:8308:90dd])
        by smtp.gmail.com with ESMTPSA id f19sm182127wmh.44.2020.08.24.09.53.37
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 09:53:37 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 07/10] main/server/process: Drop configuration object passing
Date: Mon, 24 Aug 2020 17:53:28 +0100
Message-Id: <20200824165331.1373725-7-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824165331.1373725-1-richard.purdie@linuxfoundation.org>
References: <20200824165331.1373725-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first thing the UIs do is update the server config from the UI. We
can just rely upon that and start the server with a standard config,
removing the need to pass the confusing configuration object around
as well as configParams, which contains a similar copy of some of the
data.

This makes memory resident bitbake work the same way as the normal
mode, removing the opportunity for some class of bugs.

The xmlrpcinterface and server_timeout values are passed in at server
startup time now and there no longer a second option in the
configuration which is effective ignored once the server starts.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py         |  4 ++--
 lib/bb/cookerdata.py     |  9 ---------
 lib/bb/main.py           | 10 ++++------
 lib/bb/server/process.py |  9 +++++----
 lib/bb/tinfoil.py        |  8 +-------
 5 files changed, 12 insertions(+), 28 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 3f9cb75434..99605e5844 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -148,7 +148,7 @@ class BBCooker:
     Manages one bitbake build run
     """
 
-    def __init__(self, configuration, featureSet=None, idleCallBackRegister=None):
+    def __init__(self, featureSet=None, idleCallBackRegister=None):
         self.recipecaches = None
         self.eventlog = None
         self.skiplist = {}
@@ -157,7 +157,7 @@ class BBCooker:
             for f in featureSet:
                 self.featureset.setFeature(f)
 
-        self.configuration = configuration
+        self.configuration = bb.cookerdata.CookerConfiguration()
 
         self.idleCallBackRegister = idleCallBackRegister
 
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 3baa9ade1b..190ff3ab82 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -136,22 +136,13 @@ class CookerConfiguration(object):
         self.build_verbose_stdout = False
         self.dry_run = False
         self.tracking = False
-        self.xmlrpcinterface = []
-        self.server_timeout = None
         self.writeeventlog = False
-        self.server_only = False
         self.limited_deps = False
         self.runall = []
         self.runonly = []
 
         self.env = {}
 
-    def setConfigParameters(self, parameters):
-        for key in self.__dict__.keys():
-            if key in parameters.options.__dict__:
-                setattr(self, key, parameters.options.__dict__[key])
-        self.env = parameters.environment.copy()
-
     def __getstate__(self):
         state = {}
         for key in self.__dict__.keys():
diff --git a/lib/bb/main.py b/lib/bb/main.py
index e483cce1ae..7990195eac 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -344,8 +344,6 @@ def bitbake_main(configParams, configuration):
     except:
         pass
 
-    configuration.setConfigParameters(configParams)
-
     if configParams.server_only and configParams.remote_server:
             raise BBMainException("FATAL: The '--server-only' option conflicts with %s.\n" %
                                   ("the BBSERVER environment variable" if "BBSERVER" in os.environ \
@@ -363,7 +361,7 @@ def bitbake_main(configParams, configuration):
     bb.msg.init_msgconfig(configParams.verbose, configParams.debug,
                           configParams.debug_domains)
 
-    server_connection, ui_module = setup_bitbake(configParams, configuration)
+    server_connection, ui_module = setup_bitbake(configParams)
     # No server connection
     if server_connection is None:
         if configParams.status_only:
@@ -390,7 +388,7 @@ def bitbake_main(configParams, configuration):
 
     return 1
 
-def setup_bitbake(configParams, configuration, extrafeatures=None):
+def setup_bitbake(configParams, extrafeatures=None):
     # Ensure logging messages get sent to the UI as events
     handler = bb.event.LogHandler()
     if not configParams.status_only:
@@ -431,11 +429,11 @@ def setup_bitbake(configParams, configuration, extrafeatures=None):
                         logger.info("bitbake server is not running.")
                         lock.close()
                         return None, None
-                    # we start a server with a given configuration
+                    # we start a server with a given featureset
                     logger.info("Starting bitbake server...")
                     # Clear the event queue since we already displayed messages
                     bb.event.ui_queue = []
-                    server = bb.server.process.BitBakeServer(lock, sockname, configuration, featureset)
+                    server = bb.server.process.BitBakeServer(lock, sockname, featureset, configParams.server_timeout, configParams.xmlrpcinterface)
 
                 else:
                     logger.info("Reconnecting to bitbake server...")
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 8f5abb32bf..03cdde04ee 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -394,9 +394,10 @@ class BitBakeServer(object):
     start_log_format = '--- Starting bitbake server pid %s at %s ---'
     start_log_datetime_format = '%Y-%m-%d %H:%M:%S.%f'
 
-    def __init__(self, lock, sockname, configuration, featureset):
+    def __init__(self, lock, sockname, featureset, server_timeout, xmlrpcinterface):
 
-        self.configuration = configuration
+        self.server_timeout = server_timeout
+        self.xmlrpcinterface = xmlrpcinterface
         self.featureset = featureset
         self.sockname = sockname
         self.bitbake_lock = lock
@@ -476,11 +477,11 @@ class BitBakeServer(object):
                 os.chdir(cwd)
             sock.listen(1)
 
-            server = ProcessServer(self.bitbake_lock, sock, self.sockname, self.configuration.server_timeout, self.configuration.xmlrpcinterface)
+            server = ProcessServer(self.bitbake_lock, sock, self.sockname, self.server_timeout, self.xmlrpcinterface)
             os.close(self.readypipe)
             writer = ConnectionWriter(self.readypipein)
             try:
-                self.cooker = bb.cooker.BBCooker(self.configuration, self.featureset, server.register_idle_function)
+                self.cooker = bb.cooker.BBCooker(self.featureset, server.register_idle_function)
             except bb.BBHandledException:
                 return None
             writer.send("r")
diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index dccbe0ebb5..e19d9cff04 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -22,7 +22,6 @@ import bb.taskdata
 import bb.utils
 import bb.command
 import bb.remotedata
-from bb.cookerdata import CookerConfiguration
 from bb.main import setup_bitbake, BitBakeConfigParameters
 import bb.fetch2
 
@@ -381,18 +380,13 @@ class Tinfoil:
         if not config_params:
             config_params = TinfoilConfigParameters(config_only=config_only, quiet=quiet)
 
-        cookerconfig = CookerConfiguration()
-        cookerconfig.setConfigParameters(config_params)
-
         if not config_only:
             # Disable local loggers because the UI module is going to set up its own
             for handler in self.localhandlers:
                 self.logger.handlers.remove(handler)
             self.localhandlers = []
 
-        self.server_connection, ui_module = setup_bitbake(config_params,
-                            cookerconfig,
-                            extrafeatures)
+        self.server_connection, ui_module = setup_bitbake(config_params, extrafeatures)
 
         self.ui_module = ui_module
 
-- 
2.25.1

