Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web12.1028.1598288019319399434
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Aug 2020 09:53:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=UXyDQOrC;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id t2so8858102wma.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 24 Aug 2020 09:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QpyavB0y4b9ntP7yMCkOZo9LNUxxCd9GuOlwnRX1iYY=;
        b=UXyDQOrCU1jHman4ndT1zh6RekAY2CcxKtbqLg9uOqCZHSIcXEkHz5DB2DKvnDCA3E
         EYcLliL39KtjgZLW66jXcsTHXpgcEUmwlefwvfIVzjd3+xl5JwIQFY6RX4z3LsBp7X3Y
         xc4PgZg7ZV0pu0Mp2ma5aPWMWn3mxOOaciLd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QpyavB0y4b9ntP7yMCkOZo9LNUxxCd9GuOlwnRX1iYY=;
        b=RTms53nhNIia5ipeERNy7eWSN96275RKeokwh3BpQsPO12FoanoICFI51Q75saNAam
         FQx5IozDhXz7ssZ11MLsUBaCiwRVi9BaGXrwaMXeC+fe6cfLvNh49zGOlXfKb6NEzyTT
         Cgufa9jo6whK6V8uuzo+V4yX65WaO8eGRpKYDlWmVstBDkHiFeT0apiwezN2MyVVALP/
         53KZnQbSH8RhIj9QNgA0bMG48OgeX25y3wurqcYSgDs0ClP/T1c26USQEJX55pg/FTpC
         rwbHSFyLjC0Lb3gXv12JWbxID07264CRwo2JXBh2mMpoPJjIQDmmQ4LwP7e6uvFSZbhI
         NzsA==
X-Gm-Message-State: AOAM533YTfW2xT26P4zaxQ77XS7CBDQ4sHtKvjHv+2EP/CnBxPsC296J
	GNk/XFXYwlGtCr/yvgprQevDtnj5AWJFX0po
X-Google-Smtp-Source: ABdhPJyWoGrjJQQc159Jj3DhE7aYz6bMC0iuqEQEw1d+eCQ/uGU57fo0pxA0+IQ8O5VWm7RXAqdkSA==
X-Received: by 2002:a05:600c:2189:: with SMTP id e9mr162573wme.171.1598288013176;
        Mon, 24 Aug 2020 09:53:33 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.d.0.9.8.0.3.8.5.d.6.d.5.a.5.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:45a5:d6d5:8308:90dd])
        by smtp.gmail.com with ESMTPSA id f19sm182127wmh.44.2020.08.24.09.53.32
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 09:53:32 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 01/10] build/msg: Cleanup verbose option handling
Date: Mon, 24 Aug 2020 17:53:22 +0100
Message-Id: <20200824165331.1373725-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The levels of indirection to set these verbose logging options is rather
crazy. This attempts to turn things into two specific options with
much more specific meanings. For now its all still controlled by the
commandline verbose option and should funciton as previously, with
the addition that the BB_VERBOSE_LOGS option can now be task specific.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-worker   | 4 ++--
 lib/bb/build.py      | 7 +++++--
 lib/bb/cooker.py     | 5 -----
 lib/bb/cookerdata.py | 7 ++++++-
 lib/bb/msg.py        | 6 ------
 lib/bb/runqueue.py   | 4 ++--
 6 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 97cc0fd60f..9334f11fb8 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -413,9 +413,9 @@ class BitbakeWorker(object):
 
     def handle_workerdata(self, data):
         self.workerdata = pickle.loads(data)
+        bb.build.verboseShellLogging = self.workerdata["build_verbose_shell"]
+        bb.build.verboseStdoutLogging = self.workerdata["build_verbose_stdout"]
         bb.msg.loggerDefaultLogLevel = self.workerdata["logdefaultlevel"]
-        bb.msg.loggerDefaultVerbose = self.workerdata["logdefaultverbose"]
-        bb.msg.loggerVerboseLogs = self.workerdata["logdefaultverboselogs"]
         bb.msg.loggerDefaultDomains = self.workerdata["logdefaultdomain"]
         for mc in self.databuilder.mcdata:
             self.databuilder.mcdata[mc].setVar("PRSERV_HOST", self.workerdata["prhost"])
diff --git a/lib/bb/build.py b/lib/bb/build.py
index 94f9cb371c..974d2ff065 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -29,6 +29,9 @@ from bb import data, event, utils
 bblogger = logging.getLogger('BitBake')
 logger = logging.getLogger('BitBake.Build')
 
+verboseShellLogging = False
+verboseStdoutLogging = False
+
 __mtime_cache = {}
 
 def cached_mtime_noerror(f):
@@ -413,7 +416,7 @@ def exec_func_shell(func, d, runfile, cwd=None):
 
         bb.data.emit_func(func, script, d)
 
-        if bb.msg.loggerVerboseLogs:
+        if verboseShellLogging or bb.utils.to_boolean(d.getVar("BB_VERBOSE_LOGS", False)):
             script.write("set -x\n")
         if cwd:
             script.write("cd '%s'\n" % cwd)
@@ -433,7 +436,7 @@ exit $ret
         if fakerootcmd:
             cmd = [fakerootcmd, runfile]
 
-    if bb.msg.loggerDefaultVerbose:
+    if verboseStdoutLogging:
         logfile = LogTee(logger, StdoutNoopContextManager())
     else:
         logfile = StdoutNoopContextManager()
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 33452e7b93..57caf38c2a 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -413,11 +413,6 @@ class BBCooker:
             self.data.disableTracking()
 
     def parseConfiguration(self):
-        # Set log file verbosity
-        verboselogs = bb.utils.to_boolean(self.data.getVar("BB_VERBOSE_LOGS", False))
-        if verboselogs:
-            bb.msg.loggerVerboseLogs = True
-
         # Change nice level if we're asked to
         nice = self.data.getVar("BB_NICE_LEVEL")
         if nice:
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index b86e7d446b..6bf411bcd2 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -58,11 +58,14 @@ class ConfigParameters(object):
     def updateToServer(self, server, environment):
         options = {}
         for o in ["abort", "force", "invalidate_stamp",
-                  "verbose", "debug", "dry_run", "dump_signatures",
+                  "debug", "dry_run", "dump_signatures",
                   "debug_domains", "extra_assume_provided", "profile",
                   "prefile", "postfile", "server_timeout"]:
             options[o] = getattr(self.options, o)
 
+        options['build_verbose_shell'] = self.options.verbose
+        options['build_verbose_stdout'] = self.options.verbose
+
         ret, error = server.runCommand(["updateConfig", options, environment, sys.argv])
         if error:
             raise Exception("Unable to update the server configuration with local parameters: %s" % error)
@@ -125,6 +128,8 @@ class CookerConfiguration(object):
         self.skipsetscene = False
         self.invalidate_stamp = False
         self.dump_signatures = []
+        self.build_verbose_shell = False
+        self.build_verbose_stdout = False
         self.dry_run = False
         self.tracking = False
         self.xmlrpcinterface = []
diff --git a/lib/bb/msg.py b/lib/bb/msg.py
index 2d88c4e72d..1b1a23bb50 100644
--- a/lib/bb/msg.py
+++ b/lib/bb/msg.py
@@ -146,18 +146,12 @@ class LogFilterLTLevel(logging.Filter):
 #
 
 loggerDefaultLogLevel = BBLogFormatter.NOTE
-loggerDefaultVerbose = False
-loggerVerboseLogs = False
 loggerDefaultDomains = {}
 
 def init_msgconfig(verbose, debug, debug_domains=None):
     """
     Set default verbosity and debug levels config the logger
     """
-    bb.msg.loggerDefaultVerbose = verbose
-    if verbose:
-        bb.msg.loggerVerboseLogs = True
-
     if debug:
         bb.msg.loggerDefaultLogLevel = BBLogFormatter.DEBUG - debug + 1
     elif verbose:
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 02a261e30c..6370ce50a1 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1263,8 +1263,8 @@ class RunQueue:
             "fakerootnoenv" : self.rqdata.dataCaches[mc].fakerootnoenv,
             "sigdata" : bb.parse.siggen.get_taskdata(),
             "logdefaultlevel" : bb.msg.loggerDefaultLogLevel,
-            "logdefaultverbose" : bb.msg.loggerDefaultVerbose,
-            "logdefaultverboselogs" : bb.msg.loggerVerboseLogs,
+            "build_verbose_shell" : self.cooker.configuration.build_verbose_shell,
+            "build_verbose_stdout" : self.cooker.configuration.build_verbose_stdout,
             "logdefaultdomain" : bb.msg.loggerDefaultDomains,
             "prhost" : self.cooker.prhost,
             "buildname" : self.cfgData.getVar("BUILDNAME"),
-- 
2.25.1

