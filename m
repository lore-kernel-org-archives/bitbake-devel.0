Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.335.1597264987369367122
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Aug 2020 13:43:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=UHLMgR3n;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id k20so3148855wmi.5
        for <bitbake-devel@lists.openembedded.org>; Wed, 12 Aug 2020 13:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IclYcDccH6MHY+bTkFmJHb7E2DWm75fFHs/FzHejYEA=;
        b=UHLMgR3nGQd8ZJh+HFAQX9lcRYXV8hCTnvaEkGBs/UtB0M0TStMPm1InOOZo7eIHZZ
         Yqsw3xyaghzAKaeHvHLcf0q420IOA6HyL+x9LxB+k/LA7O20/2PE9z5lADKAjN6R2G2S
         ZF6Xk2hFxS35JSCPpWU1aNcIjjq7GDtx3gNzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IclYcDccH6MHY+bTkFmJHb7E2DWm75fFHs/FzHejYEA=;
        b=p1tigBJaYu8LHfPd9cVXermW9lCyWNBr1WWQYdK5g4vltothyzxpPZ+gHdepL1u0Ch
         WvhcBJog0lFz7d52ljSk6Sv4yNqQplFgnloNNXz6w2EbOqD46RBv9Z54ANst0hnU+2m4
         grA6SrrOWmPR8EAtlr1UU62x8KrSlWqhV/ElvOcpCbBrwqWPepmAu0oyJE/7k4W86cd4
         5ChyUm52aJXFZb00yapJYlmRDhkvsMxaEe6M3n0/ig49P8R4oXjYHGK7jlNcnUabWL07
         r+laDgvByoAbauszBGSL3fHvowquxP17rlgibQf7oDPIXBk5dYCMZunt/HoPJDJ3QQ8w
         2EWg==
X-Gm-Message-State: AOAM531pY3Qm9BDkBEj3Hwe/CDskZTRXb87sabybg9AnE+Tq7DNkPauj
	c5EeXTSNKkTHjuLdwvh8JmjyjtLShNvuhA==
X-Google-Smtp-Source: ABdhPJyApaadbyswK2vWSsdy6ClDWspe75aiGv1K2axf4gK3Hre1fWn7JJoMKTgoXJ51FEI4KJlRxw==
X-Received: by 2002:a1c:b145:: with SMTP id a66mr1313478wmf.133.1597264985713;
        Wed, 12 Aug 2020 13:43:05 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (9.a.c.c.d.f.6.e.e.7.9.e.9.0.c.e.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:ec09:e97e:e6fd:cca9])
        by smtp.gmail.com with ESMTPSA id p25sm5408479wma.39.2020.08.12.13.43.05
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 13:43:05 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/3] server/process: Simplfy idle callback handler function
Date: Wed, 12 Aug 2020 21:43:03 +0100
Message-Id: <20200812204304.931893-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200812204304.931893-1-richard.purdie@linuxfoundation.org>
References: <20200812204304.931893-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Having the idle callbacks abstracted via the configuration object
makes no sense. Its like this for historical reasons from the
multiple server backends but we don't need this now so simplfy.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/command.py        |  2 +-
 lib/bb/cooker.py         | 10 ++++++----
 lib/bb/cookerdata.py     |  8 +-------
 lib/bb/server/process.py |  3 +--
 4 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 48a7f1a158..4d152ff4c0 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -84,7 +84,7 @@ class Command:
         if command not in CommandsAsync.__dict__:
             return None, "No such command"
         self.currentAsyncCommand = (command, commandline)
-        self.cooker.configuration.server_register_idlecallback(self.cooker.runCommands, self.cooker)
+        self.cooker.idleCallBackRegister(self.cooker.runCommands, self.cooker)
         return True, None
 
     def runAsyncCommand(self):
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index f6abc63487..9123605461 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -148,7 +148,7 @@ class BBCooker:
     Manages one bitbake build run
     """
 
-    def __init__(self, configuration, featureSet=None):
+    def __init__(self, configuration, featureSet=None, idleCallBackRegister=None):
         self.recipecaches = None
         self.skiplist = {}
         self.featureset = CookerFeatures()
@@ -158,6 +158,8 @@ class BBCooker:
 
         self.configuration = configuration
 
+        self.idleCallBackRegister = idleCallBackRegister
+
         bb.debug(1, "BBCooker starting %s" % time.time())
         sys.stdout.flush()
 
@@ -210,7 +212,7 @@ class BBCooker:
             cooker.process_inotify_updates()
             return 1.0
 
-        self.configuration.server_register_idlecallback(_process_inotify_updates, self)
+        self.idleCallBackRegister(_process_inotify_updates, self)
 
         # TOSTOP must not be set or our children will hang when they output
         try:
@@ -1423,7 +1425,7 @@ class BBCooker:
                 return True
             return retval
 
-        self.configuration.server_register_idlecallback(buildFileIdle, rq)
+        self.idleCallBackRegister(buildFileIdle, rq)
 
     def buildTargets(self, targets, task):
         """
@@ -1494,7 +1496,7 @@ class BBCooker:
         if 'universe' in targets:
             rq.rqdata.warn_multi_bb = True
 
-        self.configuration.server_register_idlecallback(buildTargetsIdle, rq)
+        self.idleCallBackRegister(buildTargetsIdle, rq)
 
 
     def getAllKeysWithFlags(self, flaglist):
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 24bf09c56b..b86e7d446b 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -143,16 +143,10 @@ class CookerConfiguration(object):
                 setattr(self, key, parameters.options.__dict__[key])
         self.env = parameters.environment.copy()
 
-    def setServerRegIdleCallback(self, srcb):
-        self.server_register_idlecallback = srcb
-
     def __getstate__(self):
         state = {}
         for key in self.__dict__.keys():
-            if key == "server_register_idlecallback":
-                state[key] = None
-            else:
-                state[key] = getattr(self, key)
+            state[key] = getattr(self, key)
         return state
 
     def __setstate__(self,state):
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index a152b44824..a3ef10753d 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -467,11 +467,10 @@ class BitBakeServer(object):
         sys.stdout.flush()
 
         server = ProcessServer(self.bitbake_lock, self.sock, self.sockname)
-        self.configuration.setServerRegIdleCallback(server.register_idle_function)
         os.close(self.readypipe)
         writer = ConnectionWriter(self.readypipein)
         try:
-            self.cooker = bb.cooker.BBCooker(self.configuration, self.featureset)
+            self.cooker = bb.cooker.BBCooker(self.configuration, self.featureset, server.register_idle_function)
         except bb.BBHandledException:
             return None
         writer.send("r")
-- 
2.25.1

