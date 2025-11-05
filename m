Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B12BCCF9F8
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 14:44:37 +0000 (UTC)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11154.1762353874091269983
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Nov 2025 06:44:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gKLPZaFw;
 spf=pass (domain: gmail.com, ip: 209.85.166.41, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-9486d008fdbso34062139f.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 06:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762353873; x=1762958673; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kkqexGM28d34XaPUflMZjufFqvtxTfkySK4iYL17nI4=;
        b=gKLPZaFw8WzPc8FEzmyIVGTk/Pc7UTxtR+2PocfhuIl8XGZkp13fKJES9dZVYG+9NS
         4Erv4mrFraI0k5KU2+ylGDKzFldlKe3DUATLGYx/ZOVK6X0G289554LPquJmpe7aNLxG
         5n44LTi9e/4PkK0VvarArXziRpYorUGwmSD7RxW2G38ktdUC0X4rB8w/qVyAA4BlrFWS
         aP/b0kofCqa8sAqfsGV2cTlZq16YHhFYf2ANcliHFJq1MF5hAcpK717JBuUfdY9YJm/Z
         Cl2XVqwmY8OeHnNM7j1BS0b9VD7wo6Ux6reWXfTjIi+quMfWuNyRdpZJktyAh8x9U1MS
         cJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762353873; x=1762958673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kkqexGM28d34XaPUflMZjufFqvtxTfkySK4iYL17nI4=;
        b=WcTx+vV/IFJ8rd7HtKnqovDXWPV2iGu4+ioq/wWrABRmzKdSnIokiGdAZ/XEpLMd9h
         w7xRxSqKtNlWcEDcjUQmZoouonuWfnO6mlfeZqlMpAnmdEZPib1oygUXjBPQupJrwHs+
         rr1VyCdRtZ3+F4WIVVgbnlIgEtTqNTmkAwJsIc0z+iW9DoCC26kgpi5KZXSGcO2nojXs
         WogZIeSE9HvpcifJcrE/KxJMW+5f0PC7YXH+Jn5OlIHb9Q0axPlM2zUWbr30ZDdCJrHB
         NqhvSIsjQoT3E0WrhBlChNsTH5LTmxXfkRCZEMV+s6wF76FR5wLZrQnKpMI7Cn9sTPBB
         Fy/w==
X-Gm-Message-State: AOJu0YyIXmF/NCkdR5KYcHbxfXM1UwcRn3vvQjWAJgvixjVdMQiizNjG
	DdOgtZR/vEzoJ82URz+V3h7aSOwIUSG4fuTraPFVdu/z3p1uKC3Ih9UFllX8og==
X-Gm-Gg: ASbGncv1FApypahjR+Le8OhkJYCqIS8E50WGwI5ZjnLKNOI66OtwKuKqVesEhTqKRUM
	7HdvYhswBwB/6rK1/CvsDKUusofb+CQ7Ul4xysNZ6LO61TVpNW3DRYK2mLZ2+RWYy8ReWoh0rpk
	kLfMETFeY7EcoWg8PIYg1Z+1siuVxdFIb9JyY9iOt6p8Jtuy5/Xx5zGCvffNeM6QOu3wAfs/mrd
	RXI42mattA4sWsvIR/efHs5pkP0tS4dUiGUeYjvCk0S3BVD2Fee/oBoqbNzg/tXfXFEb4UDuTfP
	KAXdgilyGs2DmT7KwhE4Edy34UDAGZ/Ali90uQgTIrotp6LV2bmbfSRlH3GAKcUUMCbW84dtn95
	uE0nlDyQ8znIftLjI9thZDRshH4Xh+ZzJA3HVd9jQWH2UUGVseBwD0oWVUb8y57AI3nkuz9xydw
	==
X-Google-Smtp-Source: AGHT+IFAZtHRtnFtA5/z1SbliGtFEkiFDXfUpKQHd+AMvUzfOFXINi6Waydkd2V4TqVaJCzxQdbSkA==
X-Received: by 2002:a05:6602:15c7:b0:948:60aa:d6f4 with SMTP id ca18e2360f4ac-948693db71dmr657781139f.8.1762353872969;
        Wed, 05 Nov 2025 06:44:32 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::7c8f])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b72258d720sm2382301173.12.2025.11.05.06.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:44:32 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: randy.macleod@windriver.com,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] knotty: Integrate PSI reporting into the UI
Date: Wed,  5 Nov 2025 07:44:20 -0700
Message-ID: <20251105144420.359338-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 14:44:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18262

Reworks the way that pressure stall information (PSI) is reported in the
UI. This change does a number of things to enable PSI to still be
reported, but less intrusive than a NOTE message each time it changes:
 1) The primary reporting of the PSI to the UI is now done through an
    event.
 2) The knotty UI handles the event and reports which PSI montiors are
    preventing tasks from starting with a line in the status
    footer.
 3) The old logging messages for PSI is moved to it's own logging domain
    (BitBaker.RunQueue.PSI), at verbose level. This allows filtering out
    PSI related events in structured logging configurations
 4) The default config for knotty will report the full PSI messages
    (e.g. the old logging message) to the BB_LOGCONFIG file.

This should providing relevant information in the user in the UI, but
also not flooding the console with PSI messages.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/bb/runqueue.py    | 10 +++++++++-
 lib/bb/ui/knotty.py   | 33 +++++++++++++++++++++++++++++++--
 lib/bb/ui/uihelper.py |  7 +++++++
 3 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 63d4edd89..a880a0d54 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -31,6 +31,7 @@ import time
 bblogger = logging.getLogger("BitBake")
 logger = logging.getLogger("BitBake.RunQueue")
 hashequiv_logger = logging.getLogger("BitBake.RunQueue.HashEquiv")
+psi_logger = logging.getLogger("BitBake.RunQueue.PSI")
 
 __find_sha256__ = re.compile( r'(?i)(?<![a-z0-9])[a-f0-9]{64}(?![a-z0-9])' )
 
@@ -221,7 +222,8 @@ class RunQueueScheduler(object):
             pressure_state = (exceeds_cpu_pressure, exceeds_io_pressure, exceeds_memory_pressure)
             pressure_values = (round(cpu_pressure,1), self.rq.max_cpu_pressure, round(io_pressure,1), self.rq.max_io_pressure, round(memory_pressure,1), self.rq.max_memory_pressure)
             if hasattr(self, "pressure_state") and pressure_state != self.pressure_state:
-                bb.note("Pressure status changed to CPU: %s, IO: %s, Mem: %s (CPU: %s/%s, IO: %s/%s, Mem: %s/%s) - using %s/%s bitbake threads" % (pressure_state + pressure_values + (len(self.rq.runq_running.difference(self.rq.runq_complete)), self.rq.number_tasks)))
+                psi_logger.verbose("Pressure status changed to CPU: %s, IO: %s, Mem: %s (CPU: %s/%s, IO: %s/%s, Mem: %s/%s) - using %s/%s bitbake threads" % (pressure_state + pressure_values + (len(self.rq.runq_running.difference(self.rq.runq_complete)), self.rq.number_tasks)))
+                bb.event.fire(PSIEvent(pressure_state, pressure_values), self.rq.cfgData)
             self.pressure_state = pressure_state
             return (exceeds_cpu_pressure or exceeds_io_pressure or exceeds_memory_pressure)
         elif self.rq.max_loadfactor:
@@ -3307,6 +3309,12 @@ class taskUniHashUpdate(bb.event.Event):
         self.unihash = unihash
         bb.event.Event.__init__(self)
 
+class PSIEvent(bb.event.Event):
+    def __init__(self, pressure_state, pressure_values):
+        super().__init__()
+        self.pressure_state = pressure_state
+        self.pressure_values = pressure_values
+
 class runQueuePipe():
     """
     Abstraction for a pipe between a worker thread and the server
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 00258c80f..8477e4a9c 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -115,6 +115,20 @@ def pluralise(singular, plural, qty):
     else:
         return plural % qty
 
+def get_pressure_message(pressure_state, pressure_values):
+    cpu_pressure, io_pressure, mem_pressure = pressure_state
+    pressure_strs = []
+    if cpu_pressure:
+        pressure_strs.append("CPU pressure (>%sus)" % pressure_values[1])
+    if io_pressure:
+        pressure_strs.append("I/O pressure (>%sus)" % pressure_values[3])
+    if mem_pressure:
+        pressure_strs.append("MEM pressure (>%sus)" % pressure_values[5])
+
+    if not pressure_strs:
+        pressure_strs.append("No pressure")
+
+    return "%s is limiting task startup" % ", ".join(pressure_strs)
 
 class InteractConsoleLogFilter(logging.Filter):
     def __init__(self, tf):
@@ -122,7 +136,7 @@ class InteractConsoleLogFilter(logging.Filter):
         super().__init__()
 
     def filter(self, record):
-        if record.levelno == bb.msg.BBLogFormatter.NOTE and (record.msg.startswith("Running") or record.msg.startswith("recipe ")):
+        if record.levelno == bb.msg.BBLogFormatter.NOTE and (record.msg.startswith("Running") or record.msg.startswith("recipe ") or "limiting task startup" in record.msg):
             return False
         self.tf.clearFooter()
         return True
@@ -320,6 +334,11 @@ class TerminalFilter(object):
                 content += msg + "\n"
                 print(msg, file=self._footer_buf)
 
+                if any(self.helper.pressure_state):
+                    msg = get_pressure_message(self.helper.pressure_state, self.helper.pressure_values)
+                    content += msg + "\n"
+                    print(msg, file=self._footer_buf)
+
             if self.quiet:
                 msg = "Running tasks (%s, %s)" % (scene_tasks, cur_tasks)
             elif not len(activetasks):
@@ -433,7 +452,8 @@ _evt_list = [ "bb.runqueue.runQueueExitWait", "bb.event.LogExecTTY", "logging.Lo
               "bb.event.MultipleProviders", "bb.event.NoProvider", "bb.runqueue.sceneQueueTaskStarted",
               "bb.runqueue.runQueueTaskStarted", "bb.runqueue.runQueueTaskFailed", "bb.runqueue.sceneQueueTaskFailed",
               "bb.event.BuildBase", "bb.build.TaskStarted", "bb.build.TaskSucceeded", "bb.build.TaskFailedSilent",
-              "bb.build.TaskProgress", "bb.event.ProcessStarted", "bb.event.ProcessProgress", "bb.event.ProcessFinished"]
+              "bb.build.TaskProgress", "bb.event.ProcessStarted", "bb.event.ProcessProgress", "bb.event.ProcessFinished",
+              "bb.runqueue.PSIEvent"]
 
 def drain_events_errorhandling(eventHandler):
     # We don't have logging setup, we do need to show any events we see before exiting
@@ -587,6 +607,10 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                     "BitBake.RunQueue.HashEquiv": {
                         "level": "VERBOSE",
                         "handlers": ["BitBake.verbconsolelog"],
+                    },
+                    "BitBake.RunQueue.PSI": {
+                        "level": "VERBOSE",
+                        "handlers": ["BitBake.verbconsolelog"],
                     }
                 }
             })
@@ -904,6 +928,11 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                     parseprogress.finish()
                 parseprogress = None
                 continue
+            if isinstance(event, bb.runqueue.PSIEvent):
+                if params.options.quiet > 1:
+                    continue
+                logger.info(get_pressure_message(event.pressure_state, event.pressure_values))
+                continue
 
             # ignore
             if isinstance(event, (bb.event.BuildBase,
diff --git a/lib/bb/ui/uihelper.py b/lib/bb/ui/uihelper.py
index a22363247..3e077f044 100644
--- a/lib/bb/ui/uihelper.py
+++ b/lib/bb/ui/uihelper.py
@@ -6,6 +6,7 @@
 #
 
 import bb.build
+import bb.runqueue
 import time
 
 class BBUIHelper:
@@ -17,6 +18,8 @@ class BBUIHelper:
         self.pidmap = {}
         self.tasknumber_current = 0
         self.tasknumber_total = 0
+        self.pressure_state = (False, False, False)
+        self.pressure_values = None
 
     def eventHandler(self, event):
         # PIDs are a bad idea as they can be reused before we process all UI events.
@@ -57,6 +60,10 @@ class BBUIHelper:
                 self.running_tasks[self.pidmap[event.pid]]['progress'] = event.progress
                 self.running_tasks[self.pidmap[event.pid]]['rate'] = event.rate
                 self.needUpdate = True
+        elif isinstance(event, bb.runqueue.PSIEvent):
+            self.pressure_state = event.pressure_state
+            self.pressure_values = event.pressure_values
+            self.needUpdate = True
         else:
             return False
         return True
-- 
2.51.1


