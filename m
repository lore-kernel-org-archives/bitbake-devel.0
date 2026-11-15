Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5886.1794742429398214231
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 15 Nov 2026 03:33:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=SUHKRXuE;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B8FD01A1671
	for <bitbake-devel@lists.openembedded.org>; Sun, 15 Nov 2026 11:33:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8FDDE60238
	for <bitbake-devel@lists.openembedded.org>; Sun, 15 Nov 2026 11:33:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EEEB911BC16DA;
	Sun, 15 Nov 2026 12:33:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794742427; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ENY4eFKchaKfcmmHu8t7XTkAL9c7O5uNW7L7GzUN2bs=;
	b=SUHKRXuEetwlQeVq8PzkK3KGBVgfpUd30SZ2caJacgQ2PypT2+mQrL3QfkElBd7Jmv0TzR
	0DZdeh6VkAMr8FkIBbZ4A9luCGUYPDJlwy2cyXyXFUCugW/ZI6GYdXG+HohZxS4EAq2tPo
	t8fMvAMEaeiptsnLTr4napvG8tF9nhNEPMsqLE3VnzWXPUl4iwiNDypa0SgVNNPDC8uQpg
	IwIFM7vVhzkZLl3JSSpIsy1eU64S6aPXr+S9ES1tEEcO1S0sCIRSFw6E87Sbn/3cW8D9zm
	Xwc67hrC2E1N1LtQeW+QfU1BMfoVfXSVa8tX9Vr2ZuOZqSgkj+MyVBOJe2MSZw==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Sun, 15 Nov 2026 12:33:40 +0100
Subject: [PATCH RFC v2 2/3] build: Attach a log catcher to tasks and save
 their records
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-mathieu-debug-replay-v4-v2-2-ad7d3c5cc213@bootlin.com>
References: <20261115-mathieu-debug-replay-v4-v2-0-ad7d3c5cc213@bootlin.com>
In-Reply-To: <20261115-mathieu-debug-replay-v4-v2-0-ad7d3c5cc213@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794742425; l=3700;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=pbNU/iTGqEwU3TNXPoIlNy4RAteFe6ntSYdwNrcL34c=;
 b=uevNgUZrFbVUz76R7bZDxYjg0IdYAz+mR2qpr9sgf298Y+wTAtfLePgevCHwrEdxcoq4hE5an
 OsVBIYt2DQBBgXKuHt9TC+yLyIoyKE6gcpJem9Jt41o8rdMeK2sNoyc
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Sun, 15 Nov 2026 11:33:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20437

Every task gets a LogCatcher which records its warnings and errors
during execution. Right after the task body, and before the postfuncs,
the records are written to ${TMPDIR}/logrecords/[mc:<mc>/][<virtual
class>/]<recipe>/logrecords.<task>.json, so records from other recipes
can be bundled too. The sstate packaging postfunc reads the current
task's file to bundle the messages for replay when the task is later
restored from the sstate cache.

Writing the file before the postfuncs makes both the current task's own
record and the files of already finished dependency tasks readable from
the same place.

AI-Generated: Uses opencode (DeepSeek V4 Flash)
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 lib/bb/build.py | 15 +++++++++++++++
 lib/bb/utils.py |  9 +++++++++
 2 files changed, 24 insertions(+)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index b38936fc360c..72f1c7bc72d2 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -21,6 +21,7 @@ import time
 import re
 import stat
 import datetime
+import json
 import bb
 import bb.msg
 import bb.process
@@ -668,6 +669,13 @@ def _exec_task(fn, task, d, quieterr):
         except OSError:
            pass
 
+    # Task log records, for sstate log replay. Written right after the task
+    # body, before the postfuncs, so the sstate packaging postfunc can read them.
+    # Stored under TMPDIR, keyed by multiconfig, virtual class and recipe, so
+    # any sstate task can reach the records of covered tasks from other recipes.
+    logrecords = bb.utils.logrecords_path(localdata, fn, task)
+    bb.utils.remove(logrecords)
+
     prefuncs = localdata.getVarFlag(task, 'prefuncs', expand=True)
     postfuncs = localdata.getVarFlag(task, 'postfuncs', expand=True)
 
@@ -710,6 +718,9 @@ def _exec_task(fn, task, d, quieterr):
     errchk = ErrorCheckHandler()
     bblogger.addHandler(errchk)
 
+    tasklogcatcher = bb.utils.LogCatcher()
+    bblogger.addHandler(tasklogcatcher)
+
     localdata.setVar('BB_LOGFILE', logfn)
     localdata.setVar('BB_RUNTASK', task)
     localdata.setVar('BB_TASK_LOGGER', bblogger)
@@ -723,6 +734,9 @@ def _exec_task(fn, task, d, quieterr):
             for func in (prefuncs or '').split():
                 exec_func(func, localdata)
             exec_func(task, localdata)
+            bb.utils.mkdirhier(os.path.dirname(logrecords))
+            with open(logrecords, 'w') as f:
+                json.dump(tasklogcatcher.records, f)
             for func in (postfuncs or '').split():
                 exec_func(func, localdata)
         finally:
@@ -732,6 +746,7 @@ def _exec_task(fn, task, d, quieterr):
             sys.stderr.flush()
 
             bblogger.removeHandler(handler)
+            bblogger.removeHandler(tasklogcatcher)
 
             # Restore the backup fds
             os.dup2(osi[0], osi[1])
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 4a4e911b0f8a..3728e8b6a02b 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -2150,6 +2150,15 @@ def load_plugins(logger, plugins, pluginpath):
                 plugins.append(plugin)
 
 
+def logrecords_path(d, fn, task):
+    from bb.cache import virtualfn2realfn
+
+    realfn, cls, mc = virtualfn2realfn(fn)
+    mc = "mc:" + mc if mc else ""
+    recipe = os.path.splitext(os.path.basename(realfn))[0]
+    return os.path.join(d.getVar("TMPDIR"), "logrecords", mc, cls, recipe,
+                        "logrecords.%s.json" % task)
+
 class LogCatcher(logging.Handler):
     """Logging handler for collecting logged messages so you can check them later"""
     def __init__(self):

-- 
2.47.3

