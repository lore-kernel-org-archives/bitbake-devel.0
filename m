Return-Path: <jpewhacker@gmail.com>
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com
	[209.85.166.194])
	by mail.openembedded.org (Postfix) with ESMTP id E362561B71
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Mar 2020 16:34:08 +0000 (UTC)
Received: by mail-il1-f194.google.com with SMTP id a6so9256664ilc.4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Mar 2020 09:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=64HOYy97PAcD3VPqpAMnC5c2zNLwk0P06Zpatec0ElE=;
	b=kJ1phDQEi6g452/v0p4Uguz8hbaF4KGoMQU8m4zTeCwNAPgx8eOtIkZOcVkMqRBeri
	pIA0/k7QwWyghlbpTYwNH2Rvw4usIZNxMo+ALl64ne78B86+Y02bKnWlDIwzhSBlXVsZ
	+5ith/TuW2whg9heOoIm3ixklffKU458skt0jEcbmM9K614DUlD2VFvWXW2IHvARoC4g
	2rHqyGAZuZVjn18uiynf3Rbewe35oi1JtXk9VH9vCFW7JGT4jcfPWWLDNtNRcL542KAO
	qaxrEfxXQwX3V17laRmY5kTXEmlhDioWig+xbib0CzutJHxElYPvMjleXgokFsUIFIfB
	lOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=64HOYy97PAcD3VPqpAMnC5c2zNLwk0P06Zpatec0ElE=;
	b=qple0F+WqEZNwtlXCiqHSQ4vmitl2fPpxVoxDs3jVvH+S3ViXR6HiSTHtpbBLngG1b
	E8U/cTAoMA/AV/ICLXaEzdI+Lpm1SyxEc8E48jI8ZL3/sUt53R34ATbg6gko4r6wXecP
	pFTBh11RfuJDMCqYtkfvYk5Ivo2B+RBgHqUMWLxIdt2G0sMDej68RVn4EplU86ih3o/V
	SH3RxnnmItukjOiuzb63BQEB2fRa+SMdWwE4eii2K9z5VtqaSviwp9GfKmR0hgFY0PFu
	fvhPUZMELZPlSNYBwga1XLTf3sqgxmmpTPL91+ojCBS0X9RsEmNZtiwzkA23nPCwVYpJ
	r7fQ==
X-Gm-Message-State: ANhLgQ2b+DGrUs94cw5itTPaZqxH6XI/mJEGMfzR8l9qnGem+qEWq7V6
	6AgerJqH/JUCfwht3vihOgvtTCP6CW8=
X-Google-Smtp-Source: ADFU+vuuJOSQ0JLP/QQ+rRcwNMqaPDZuBYPXx6jDfAJa3YfPJ8iR5ibLkgVUt3AcUv076ZhV7zjnwg==
X-Received: by 2002:a05:6e02:685:: with SMTP id
	o5mr4709979ils.86.1583771648648; 
	Mon, 09 Mar 2020 09:34:08 -0700 (PDT)
Received: from OLA-8C37N23.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	q1sm15049593ile.71.2020.03.09.09.34.07
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 09 Mar 2020 09:34:08 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Mar 2020 11:33:48 -0500
Message-Id: <20200309163353.15362-11-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309163353.15362-1-JPEWhacker@gmail.com>
References: <20200309163353.15362-1-JPEWhacker@gmail.com>
Cc: docs@lists.yoctoproject.org
Subject: [PATCH 10/15] bitbake: knotty: Setup logs with config helper
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
X-List-Received-Date: Mon, 09 Mar 2020 16:34:09 -0000

Sets up logging in knotty to use python's structured logging config and
the bb.msg.setLoggingConfig() helper to setup logging. This allows the
user to specify additional logging mechanism in a config file with
BB_LOGCONFIG

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/ui/knotty.py | 134 ++++++++++++++++++++++++++----------
 1 file changed, 96 insertions(+), 38 deletions(-)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index d5dce7172a..386f27876d 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -370,7 +370,11 @@ def _log_settings_from_server(server, observe_only):
     if error:
         logger.error("Unable to get the value of BB_CONSOLELOG variable: %s" % error)
         raise BaseException(error)
-    return includelogs, loglines, consolelogfile
+    logconfigfile, error = server.runCommand([cmd, "BB_LOGCONFIG"])
+    if error:
+        logger.error("Unable to get the value of BB_LOGCONFIG variable: %s" % error)
+        raise BaseException(error)
+    return includelogs, loglines, consolelogfile, logconfigfile
 
 _evt_list = [ "bb.runqueue.runQueueExitWait", "bb.event.LogExecTTY", "logging.LogRecord",
               "bb.build.TaskFailed", "bb.build.TaskBase", "bb.event.ParseStarted",
@@ -387,7 +391,87 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     if not params.observe_only:
         params.updateToServer(server, os.environ.copy())
 
-    includelogs, loglines, consolelogfile = _log_settings_from_server(server, params.observe_only)
+    includelogs, loglines, consolelogfile, logconfigfile = _log_settings_from_server(server, params.observe_only)
+
+    loglevel, _ = bb.msg.constructLogOptions()
+
+    if params.options.quiet == 0:
+        console_loglevel = loglevel
+    elif params.options.quiet > 2:
+        console_loglevel = bb.msg.BBLogFormatter.ERROR
+    else:
+        console_loglevel = bb.msg.BBLogFormatter.WARNING
+
+    logconfig = {
+        "version": 1,
+        "handlers": {
+            "BitBake.console": {
+                "class": "logging.StreamHandler",
+                "formatter": "BitBake.consoleFormatter",
+                "level": console_loglevel,
+                "stream": "ext://sys.stdout",
+                "filters": ["BitBake.stdoutFilter"],
+            },
+            "BitBake.errconsole": {
+                "class": "logging.StreamHandler",
+                "formatter": "BitBake.consoleFormatter",
+                "level": loglevel,
+                "stream": "ext://sys.stderr",
+                "filters": ["BitBake.stderrFilter"],
+            },
+        },
+        "formatters": {
+            # This format instance will get color output enabled by the
+            # terminal
+            "BitBake.consoleFormatter" : {
+                "()": "bb.msg.BBLogFormatter",
+                "format": "%(levelname)s: %(message)s"
+            },
+            # The file log requires a separate instance so that it doesn't get
+            # color enabled
+            "BitBake.logfileFormatter": {
+                "()": "bb.msg.BBLogFormatter",
+                "format": "%(levelname)s: %(message)s"
+            }
+        },
+        "filters": {
+            "BitBake.stdoutFilter": {
+                "()": "bb.msg.LogFilterLTLevel",
+                "level": "ERROR"
+            },
+            "BitBake.stderrFilter": {
+                "()": "bb.msg.LogFilterGEQLevel",
+                "level": "ERROR"
+            }
+        },
+        "loggers": {
+            "BitBake": {
+                "level": loglevel,
+                "handlers": ["BitBake.console", "BitBake.errconsole"],
+            }
+        },
+        "disable_existing_loggers": False
+    }
+
+    # Enable the console log file if enabled
+    if consolelogfile and not params.options.show_environment and not params.options.show_versions:
+        logconfig["handlers"]["BitBake.consolelog"] ={
+            "class": "logging.FileHandler",
+            "formatter": "BitBake.logfileFormatter",
+            "level": "INFO",
+            "filename": consolelogfile,
+        }
+        logconfig["loggers"]["BitBake"]["handlers"].append("BitBake.consolelog")
+
+        bb.utils.mkdirhier(os.path.dirname(consolelogfile))
+        loglink = os.path.join(os.path.dirname(consolelogfile), 'console-latest.log')
+        bb.utils.remove(loglink)
+        try:
+           os.symlink(os.path.basename(consolelogfile), loglink)
+        except OSError:
+           pass
+
+    bb.msg.setLoggingConfig(logconfig, logconfigfile)
 
     if sys.stdin.isatty() and sys.stdout.isatty():
         log_exec_tty = True
@@ -396,23 +480,16 @@ def main(server, eventHandler, params, tf = TerminalFilter):
 
     helper = uihelper.BBUIHelper()
 
-    console = logging.StreamHandler(sys.stdout)
-    errconsole = logging.StreamHandler(sys.stderr)
-    format_str = "%(levelname)s: %(message)s"
-    format = bb.msg.BBLogFormatter(format_str)
-    if params.options.quiet == 0:
-        forcelevel = None
-    elif params.options.quiet > 2:
-        forcelevel = bb.msg.BBLogFormatter.ERROR
-    else:
-        forcelevel = bb.msg.BBLogFormatter.WARNING
-    bb.msg.addDefaultlogFilter(console, bb.msg.BBLogFilterStdOut, forcelevel)
-    bb.msg.addDefaultlogFilter(errconsole, bb.msg.BBLogFilterStdErr)
-    console.setFormatter(format)
-    errconsole.setFormatter(format)
-    if not bb.msg.has_console_handler(logger):
-        logger.addHandler(console)
-        logger.addHandler(errconsole)
+    # Look for the specially designated handlers which need to be passed to the
+    # terminal handler
+    console = None
+    errconsole = None
+    for h in logger.handlers:
+        name = getattr(h, '_name', None)
+        if name == 'BitBake.console':
+            console = h
+        elif name == 'BitBake.errconsole':
+            errconsole = h
 
     bb.utils.set_process_name("KnottyUI")
 
@@ -420,21 +497,6 @@ def main(server, eventHandler, params, tf = TerminalFilter):
         server.terminateServer()
         return
 
-    consolelog = None
-    if consolelogfile and not params.options.show_environment and not params.options.show_versions:
-        bb.utils.mkdirhier(os.path.dirname(consolelogfile))
-        conlogformat = bb.msg.BBLogFormatter(format_str)
-        consolelog = logging.FileHandler(consolelogfile)
-        bb.msg.addDefaultlogFilter(consolelog)
-        consolelog.setFormatter(conlogformat)
-        logger.addHandler(consolelog)
-        loglink = os.path.join(os.path.dirname(consolelogfile), 'console-latest.log')
-        bb.utils.remove(loglink)
-        try:
-           os.symlink(os.path.basename(consolelogfile), loglink)
-        except OSError:
-           pass
-
     llevel, debug_domains = bb.msg.constructLogOptions()
     server.runCommand(["setEventMask", server.getEventHandle(), llevel, debug_domains, _evt_list])
 
@@ -761,8 +823,4 @@ def main(server, eventHandler, params, tf = TerminalFilter):
         if e.errno == errno.EPIPE:
             pass
 
-    if consolelog:
-        logger.removeHandler(consolelog)
-        consolelog.close()
-
     return return_value
-- 
2.17.1


