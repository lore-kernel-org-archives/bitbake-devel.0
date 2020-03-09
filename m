Return-Path: <jpewhacker@gmail.com>
Received: from mail-il1-f195.google.com (mail-il1-f195.google.com
	[209.85.166.195])
	by mail.openembedded.org (Postfix) with ESMTP id DB5B361A29
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Mar 2020 16:33:58 +0000 (UTC)
Received: by mail-il1-f195.google.com with SMTP id b17so9265080iln.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Mar 2020 09:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=9GpDTZg2EdA6OGVyzVkduC6kdcOl8rdgH43I5i9TB5s=;
	b=QtZJnZ1r58kpG1spA7m+enHfa+dhK0za8OMSQHArxzto5LJzvP16bKoHdmzD+f0/If
	MpazwLhMWmvlaZrzAWWSxGK3FY0Jik0CadbWBNqUbVJcrrA8+uPxwBKP6lxg//8E1E+9
	NjxCywjnw8YarCrxQrw23EcE5/1kdNczEZBwer+U3/lM5LW1X56W9GaL/o1e0UozCYVd
	MIYb6op/tgvkk/EKyM3Suwzws5mRsMGfoC97BLRSN+Zd5zMQuMDOxU8KEocu9RNeqhEZ
	8pv/xfSaxJWyhqeYEyU18VmpW4OKLdoPvDQl/jqKVgIDRtGDvFJDXzGkXX8ei4MvNu+o
	MKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=9GpDTZg2EdA6OGVyzVkduC6kdcOl8rdgH43I5i9TB5s=;
	b=T7rCPot1HHFwmlMsrEyK7K5jFqJc5xmna8AK9FUuJA+QS1RlwREJZBKAN0KDA8wpaf
	ww0vXkd53LvMEgCfe7VCo2KjzPN1avLURvLFoYBPn1drBksHog6vERMNzWR+CZJHGPNc
	n+koNQj+V8Klvh04E9P4N3sKBVvBocVAnxipv7DNh5avq9izsDPJqqw3X3Z4Exwx/AF1
	8hySyusUaAUfXMm7V+fn76c+vJSDyXafgA/Y6n+8psgwdCxTwX6Qy87kACG0KhRUf3kF
	MJye46OBDxOgh3+iMyysSk61X9LJag0iS5a1GBJerchV8g+Go8OR05Y22+edVJh4hFNa
	7DCQ==
X-Gm-Message-State: ANhLgQ3r1VCgnIDLpCyc+Odom1PmEAnONoOmlvQWpdmIS9xoivJODjQz
	rzKub5wKwMK18nLpzRFiYhr3fT38ovc=
X-Google-Smtp-Source: ADFU+vstHnbPzbKdsf4/6cOT6WwPIhvwhaawk7AHZXh2aSDTLxIPsec2rmmg9NFphjybYlwO92VIpA==
X-Received: by 2002:a92:35db:: with SMTP id c88mr2416237ilf.187.1583771639745; 
	Mon, 09 Mar 2020 09:33:59 -0700 (PDT)
Received: from OLA-8C37N23.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	q1sm15049593ile.71.2020.03.09.09.33.58
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 09 Mar 2020 09:33:59 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Mar 2020 11:33:41 -0500
Message-Id: <20200309163353.15362-4-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309163353.15362-1-JPEWhacker@gmail.com>
References: <20200309163353.15362-1-JPEWhacker@gmail.com>
Cc: docs@lists.yoctoproject.org
Subject: [PATCH 03/15] bitbake: lib/bb/msg.py: Use log level instead of debug count
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 09 Mar 2020 16:33:59 -0000

Passes around the actual logging level as the default log level variable
instead of the debug count. This makes it easier to deal with logging
levels since the conversion from debug count and verbose flag only has
to occur once when logging is initialized and after that actual log
levels can be used

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/bin/bitbake-worker |  2 +-
 bitbake/lib/bb/__init__.py |  2 +-
 bitbake/lib/bb/msg.py      | 22 +++++++++-------------
 bitbake/lib/bb/runqueue.py |  2 +-
 4 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index 1e641e81c2..fc28a34d8a 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -414,7 +414,7 @@ class BitbakeWorker(object):
 
     def handle_workerdata(self, data):
         self.workerdata = pickle.loads(data)
-        bb.msg.loggerDefaultDebugLevel = self.workerdata["logdefaultdebug"]
+        bb.msg.loggerDefaultLogLevel = self.workerdata["logdefaultlevel"]
         bb.msg.loggerDefaultVerbose = self.workerdata["logdefaultverbose"]
         bb.msg.loggerVerboseLogs = self.workerdata["logdefaultverboselogs"]
         bb.msg.loggerDefaultDomains = self.workerdata["logdefaultdomain"]
diff --git a/bitbake/lib/bb/__init__.py b/bitbake/lib/bb/__init__.py
index acd4af13a8..dc5e91e29a 100644
--- a/bitbake/lib/bb/__init__.py
+++ b/bitbake/lib/bb/__init__.py
@@ -47,7 +47,7 @@ class BBLogger(Logger):
         if not bb.event.worker_pid:
             if self.name in bb.msg.loggerDefaultDomains and loglevel > (bb.msg.loggerDefaultDomains[self.name]):
                 return
-            if level > (bb.msg.loggerDefaultDebugLevel):
+            if loglevel > bb.msg.loggerDefaultLogLevel:
                 return
         return self.log(loglevel, msg, *args, **kwargs)
 
diff --git a/bitbake/lib/bb/msg.py b/bitbake/lib/bb/msg.py
index d1b0e929d4..ea6a9543f7 100644
--- a/bitbake/lib/bb/msg.py
+++ b/bitbake/lib/bb/msg.py
@@ -135,7 +135,7 @@ class BBLogFilterStdOut(BBLogFilter):
 # Message control functions
 #
 
-loggerDefaultDebugLevel = 0
+loggerDefaultLogLevel = BBLogFormatter.NOTE
 loggerDefaultVerbose = False
 loggerVerboseLogs = False
 loggerDefaultDomains = {}
@@ -144,11 +144,17 @@ def init_msgconfig(verbose, debug, debug_domains=None):
     """
     Set default verbosity and debug levels config the logger
     """
-    bb.msg.loggerDefaultDebugLevel = debug
     bb.msg.loggerDefaultVerbose = verbose
     if verbose:
         bb.msg.loggerVerboseLogs = True
 
+    if debug:
+        bb.msg.loggerDefaultLogLevel = BBLogFormatter.DEBUG - debug + 1
+    elif verbose:
+        bb.msg.loggerDefaultLogLevel = BBLogFormatter.VERBOSE
+    else:
+        bb.msg.loggerDefaultLogLevel = BBLogFormatter.NOTE
+
     bb.msg.loggerDefaultDomains = {}
     if debug_domains:
         for (domainarg, iterator) in groupby(debug_domains):
@@ -156,17 +162,7 @@ def init_msgconfig(verbose, debug, debug_domains=None):
             bb.msg.loggerDefaultDomains["BitBake.%s" % domainarg] = logging.DEBUG - dlevel + 1
 
 def constructLogOptions():
-    debug = loggerDefaultDebugLevel
-    verbose = loggerDefaultVerbose
-
-    if debug:
-        level = BBLogFormatter.DEBUG - debug + 1
-    elif verbose:
-        level = BBLogFormatter.VERBOSE
-    else:
-        level = BBLogFormatter.NOTE
-
-    return level, loggerDefaultDomains
+    return loggerDefaultLogLevel, loggerDefaultDomains
 
 def addDefaultlogFilter(handler, cls = BBLogFilter, forcelevel=None):
     level, debug_domains = constructLogOptions()
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 32966b4f7c..4106fa4bc4 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1254,7 +1254,7 @@ class RunQueue:
             "fakerootdirs" : self.rqdata.dataCaches[mc].fakerootdirs,
             "fakerootnoenv" : self.rqdata.dataCaches[mc].fakerootnoenv,
             "sigdata" : bb.parse.siggen.get_taskdata(),
-            "logdefaultdebug" : bb.msg.loggerDefaultDebugLevel,
+            "logdefaultlevel" : bb.msg.loggerDefaultLogLevel,
             "logdefaultverbose" : bb.msg.loggerDefaultVerbose,
             "logdefaultverboselogs" : bb.msg.loggerVerboseLogs,
             "logdefaultdomain" : bb.msg.loggerDefaultDomains,
-- 
2.17.1


