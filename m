Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EBFCCFA13
	for <webhook@archiver.kernel.org>; Mon, 10 Nov 2025 15:52:34 +0000 (UTC)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.51298.1762789945284056155
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 Nov 2025 07:52:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=I0tTyw+r;
 spf=pass (domain: gmail.com, ip: 209.85.210.42, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7c281c649ccso1940839a34.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 10 Nov 2025 07:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762789944; x=1763394744; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8a/zLDaRxYjs2+IfFMx3DFfwnOfekQYhN58rBuRq48=;
        b=I0tTyw+r17qbwRtVR6L+V4lPGs7s8j8l5vBHgIxTaNYmJiE3tA6dsXUhHl3EkFOLSn
         fJxxOg+V2hw9NkHV4Q3It7k3aP3Kmr7CTx9Q81ZHp61i4VVzuUZFz4n91ZZ71NDen7Et
         /NXSrFsvASOlBQt3dOUvUITX6SbluwdANM52ZlRiQk73O0+4MIa2u15PDwwnXlUqdHIw
         MwlEXQRxAivC00mc/Iu7iebERCP4i8Pzr5NiqjCoLK+FVlsYCwScF/hx1fpSA3grEZlE
         irCdoZVEc1MB8ocr4BpCJlY2iC8saw1Qsra8MGhcI4sOGonTXv7wKz+iyBhYk2GG5/89
         t9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762789944; x=1763394744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q8a/zLDaRxYjs2+IfFMx3DFfwnOfekQYhN58rBuRq48=;
        b=ixSUOV6GE8EGi4QVVnceUuXhcHpK4lThGw7g1ZzCAO0d/tnu77hvt6uwlSXEaR/FyX
         jXWANP0c5igj5VIbbCMig/0QcneQjpvKPXY9lpAw7eDo1Sx9G27vo+C3Gvvu7dTxN1No
         maZrM+5v3hD7H7p1HKfDO/F6hBHogIb0yhpnpBHLUBv9pgvBcz5ITfrbki5GYbRM1mDp
         msGxzmUh3SAvUJbCwEIJMd8BRpbNgalvhSDemkjn5FVPO36n8X4kS05ZcCT/48VQ2m2n
         SNAkjSLTpdCIwB+LOl343W1zuGYh0BwbwgFQauw74A1sf6Mq+EGFVRe5KrQLFRbJxvIT
         6Fvw==
X-Gm-Message-State: AOJu0Yymx/SRJp2LUhvYnj2sTcL7PaBH3W0Z6BMrBsKwnvIOUOIZJ+Z7
	+BpGtN/DQVb+Uj33ZgyJ+oft5HU0oWR6pvJWHFUKIbvRC89wZ7WfSzFO7fDmIQ==
X-Gm-Gg: ASbGncvTfbyyfNRSL4MJwQH9hB+8G6ulRQ2vavdWxrp2hKMNEuWWzfdakSuv/VD4aFI
	yoJyHsjbzM6whbbq9Ul/LQZHZhHDgGvCc9R7LF7VG1OQlnmgQD4JJOxkbxaZsPP/sZFDQa+RU0o
	akouQnPZ3wL/DQKqfdBjv/DZ337GgJiAlMRYbNjt+t7ej/0Qi3beD/UpTzyWoSXrMY26iOx4jUW
	r8CS5GbKQkoG2RLeMM4aEp5Wi3z9VJaNLDcy4viruKN2JmK4P7oEkzUR3OgW9p+xvsllFFcorQP
	468qVyMIiAqVf8pbm70tiEH9e5BDPOevKaqKX1JfdGp7CMeILK9QaXt6CETaj8U0bNs21zriOJ5
	+WsLpHnClnunDLzYudO+M5Kl/ujwn3dRgbbhvcxRCJd2y1yjrpQI+T9Ta29R4Uhr6/lz8YLNRR+
	P/xvVqPmo+
X-Google-Smtp-Source: AGHT+IHLCvYbF1rgSRcLoADQOgFJ9saMu7G0jFU6lx2/hs1eZBEAEzCSgpHX2v1dZZS/nCqO51fB6w==
X-Received: by 2002:a05:6830:43ac:b0:7c6:ca62:e258 with SMTP id 46e09a7af769-7c6fd7c3d3cmr5886356a34.21.1762789944302;
        Mon, 10 Nov 2025 07:52:24 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::3eb8])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c6f0f0a6dasm5861974a34.5.2025.11.10.07.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 07:52:23 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2] knotty: Integrate PSI reporting into the UI
Date: Mon, 10 Nov 2025 08:52:07 -0700
Message-ID: <20251110155219.2346939-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251105144420.359338-1-JPEWhacker@gmail.com>
References: <20251105144420.359338-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 10 Nov 2025 15:52:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18316

Reworks the way that pressure stall information (PSI) is reported in the
UI. This change does a number of things to enable PSI to still be
reported, but less intrusive than a NOTE message each time it changes:
 1) The primary reporting of the PSI to the UI is now done through an
    event.
 2) The knotty UI handles the event and reports which PSI monitors are
    preventing tasks from starting with a line in the status
    footer.
 3) The old logging messages for PSI is moved to it's own logging domain
    (BitBaker.RunQueue.PSI), at verbose level. This allows filtering out
    PSI related events in structured logging configurations
 4) The default config for knotty will report the full PSI messages
    (e.g. the old logging message) to the BB_LOGCONFIG file.

This should providing relevant information in the user in the UI, but
also not flood the console with PSI messages.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
V2: Fix spelling mistake in the commit message


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


