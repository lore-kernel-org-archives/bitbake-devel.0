Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD96C636D6
	for <webhook@archiver.kernel.org>; Wed, 22 Feb 2023 14:51:57 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.10740.1677077516745914984
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Feb 2023 06:51:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=BMggv16l;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id i11so1839747wrp.5
        for <bitbake-devel@lists.openembedded.org>; Wed, 22 Feb 2023 06:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=E/DURse6p7aY02tZcT2PK36/SAmdXQxVYmZlGMNyHgs=;
        b=BMggv16lL/jVREYERiay1LmSuMADDCvJOu7BEoabK1xGnqbYr7WIE+670rFaKJbPeg
         w1GUzHMcMAF0TRLNiuUphmn7R0rhGQ3jNPAGLPwZweAsskGz+vHHQltQTa7evrwKNTYU
         Wznon44oL+ijB0xHcJ30Uc2SvY+lw8kdJ5u/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/DURse6p7aY02tZcT2PK36/SAmdXQxVYmZlGMNyHgs=;
        b=pofB4zzx/+T3rVpJPfxFrmJcy/ULSufUFlEheBetnvFbiqw+sfs4JoKuF2u4yA8HMx
         3igU/KHaKcanO2h3ZvbF4a1yJwNNsHrvYZLMXI8Inuygwb4uqAGxIWOpK5z7823AOreI
         rc9LwgCFdj57CZWZrdbzK5NQVvcm7E65IeQc+04WonhxcZy569DMHNeACnU9TnGkHfaB
         wTapLiVYFV0yLV31RnSiIu+9yDs34HGIQqJIeaJFmcGAIDth9zfH0bIUTOPg+W9ApJIg
         QLBTgduFNH5YkYDhwiwSDWZr7B/QZ+ISRBnSjWd+msmAdPTDR/tFoLeWdb26GJFBBZL0
         Znag==
X-Gm-Message-State: AO0yUKXicTQBo9Ija6N4jhphRzQtagdfpVsvXAklECNVypBoJYGY1Ob5
	OVuM7umWWicWosrcr4lcPLlFin69dtYqobOA
X-Google-Smtp-Source: AK7set9cI5zHlGzefqbg8YMRk7EdohQNJ+dHiip5Vu6tw++ygBwdzZAyCFSsFjeKe18mnkBuKw/Q9g==
X-Received: by 2002:adf:ef8e:0:b0:2c7:83b:9d20 with SMTP id d14-20020adfef8e000000b002c7083b9d20mr3330725wro.34.1677077514856;
        Wed, 22 Feb 2023 06:51:54 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:d5d1:6a95:9b62:17ab])
        by smtp.gmail.com with ESMTPSA id x17-20020adff651000000b002c563b124basm7787058wrp.103.2023.02.22.06.51.54
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 06:51:54 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] event/cooker/runqueue: Add ability to interrupt longer running code
Date: Wed, 22 Feb 2023 14:51:52 +0000
Message-Id: <20230222145153.581307-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Feb 2023 14:51:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14477

Bitbake is now able to understand when a UI wants it to stop the current
processing. There are some long running functions which currently have no
mechanism to interrupt them however.

This patch adds a call, bb.event.check_for_interrupts(d) which can be
placed in long running code and allows an internal state flag within
bitbake to be checked. If set, that flag will trigger an exit.

This means that Ctrl+C can be made to work in a variety of places where
it currently would not.

Long running event handlers in OE-Core can also then benefit from this
new approach with the addition of the function call as well.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py   |  4 ++++
 lib/bb/event.py    | 11 +++++++++++
 lib/bb/runqueue.py | 15 +++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index b673fe10ee..c631ec7e6d 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -345,6 +345,7 @@ class BBCooker:
         elif signum == signal.SIGHUP:
             bb.warn("Cooker received SIGHUP, shutting down...")
         self.state = state.forceshutdown
+        bb.event._should_exit.set()
 
     def setFeatures(self, features):
         # we only accept a new feature set if we're in state initial, so we can reset without problems
@@ -1520,6 +1521,7 @@ class BBCooker:
             msg = None
             interrupted = 0
             if halt or self.state == state.forceshutdown:
+                bb.event._should_exit.set()
                 rq.finish_runqueue(True)
                 msg = "Forced shutdown"
                 interrupted = 2
@@ -1760,6 +1762,7 @@ class BBCooker:
             self.state = state.forceshutdown
         else:
             self.state = state.shutdown
+        bb.event._should_exit.set()
 
         if self.parser:
             self.parser.shutdown(clean=False)
@@ -1770,6 +1773,7 @@ class BBCooker:
             self.parser.shutdown(clean=False)
             self.parser.final_cleanup()
         self.state = state.initial
+        bb.event._should_exit.clear()
 
     def reset(self):
         if hasattr(bb.parse, "siggen"):
diff --git a/lib/bb/event.py b/lib/bb/event.py
index 8b05f93e2f..37cc630c63 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -69,6 +69,7 @@ _eventfilter = None
 _uiready = False
 _thread_lock = threading.Lock()
 _heartbeat_enabled = False
+_should_exit = threading.Event()
 
 def enable_threadlock():
     # Always needed now
@@ -86,6 +87,16 @@ def disable_heartbeat():
     global _heartbeat_enabled
     _heartbeat_enabled = False
 
+#
+# In long running code, this function should be called periodically
+# to check if we should exit due to an interuption (.e.g Ctrl+C from the UI)
+#
+def check_for_interrupts(d):
+    global _should_exit
+    if _should_exit.is_set():
+        bb.warn("Exiting due to interrupt.")
+        raise bb.BBHandledException()
+
 def execute_handler(name, handler, event, d):
     event.data = d
     try:
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index e5bd9311f2..e629ab7e7b 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -655,6 +655,7 @@ class RunQueueData:
 
         self.init_progress_reporter.start()
         self.init_progress_reporter.next_stage()
+        bb.event.check_for_interrupts(self.cooker.data)
 
         # Step A - Work out a list of tasks to run
         #
@@ -803,6 +804,7 @@ class RunQueueData:
         #self.dump_data()
 
         self.init_progress_reporter.next_stage()
+        bb.event.check_for_interrupts(self.cooker.data)
 
         # Resolve recursive 'recrdeptask' dependencies (Part B)
         #
@@ -899,6 +901,7 @@ class RunQueueData:
             self.runtaskentries[tid].depends.difference_update(recursivetasksselfref)
 
         self.init_progress_reporter.next_stage()
+        bb.event.check_for_interrupts(self.cooker.data)
 
         #self.dump_data()
 
@@ -980,6 +983,7 @@ class RunQueueData:
                 mark_active(tid, 1)
 
         self.init_progress_reporter.next_stage()
+        bb.event.check_for_interrupts(self.cooker.data)
 
         # Step C - Prune all inactive tasks
         #
@@ -1019,6 +1023,7 @@ class RunQueueData:
                 bb.msg.fatal("RunQueue", "Could not find any tasks with the tasknames %s to run within the recipes of the taskgraphs of the targets %s" % (str(self.cooker.configuration.runall), str(self.targets)))
 
         self.init_progress_reporter.next_stage()
+        bb.event.check_for_interrupts(self.cooker.data)
 
         # Handle runonly
         if self.cooker.configuration.runonly:
@@ -1059,6 +1064,7 @@ class RunQueueData:
         logger.verbose("Assign Weightings")
 
         self.init_progress_reporter.next_stage()
+        bb.event.check_for_interrupts(self.cooker.data)
 
         # Generate a list of reverse dependencies to ease future calculations
         for tid in self.runtaskentries:
@@ -1066,6 +1072,7 @@ class RunQueueData:
                 self.runtaskentries[dep].revdeps.add(tid)
 
         self.init_progress_reporter.next_stage()
+        bb.event.check_for_interrupts(self.cooker.data)
 
         # Identify tasks at the end of dependency chains
         # Error on circular dependency loops (length two)
@@ -1082,12 +1089,14 @@ class RunQueueData:
         logger.verbose("Compute totals (have %s endpoint(s))", len(endpoints))
 
         self.init_progress_reporter.next_stage()
+        bb.event.check_for_interrupts(self.cooker.data)
 
         # Calculate task weights
         # Check of higher length circular dependencies
         self.runq_weight = self.calculate_task_weights(endpoints)
 
         self.init_progress_reporter.next_stage()
+        bb.event.check_for_interrupts(self.cooker.data)
 
         # Sanity Check - Check for multiple tasks building the same provider
         for mc in self.dataCaches:
@@ -1188,6 +1197,7 @@ class RunQueueData:
 
         self.init_progress_reporter.next_stage()
         self.init_progress_reporter.next_stage()
+        bb.event.check_for_interrupts(self.cooker.data)
 
         # Iterate over the task list looking for tasks with a 'setscene' function
         self.runq_setscene_tids = set()
@@ -1200,6 +1210,7 @@ class RunQueueData:
                 self.runq_setscene_tids.add(tid)
 
         self.init_progress_reporter.next_stage()
+        bb.event.check_for_interrupts(self.cooker.data)
 
         # Invalidate task if force mode active
         if self.cooker.configuration.force:
@@ -1216,6 +1227,7 @@ class RunQueueData:
                     invalidate_task(fn + ":" + st, True)
 
         self.init_progress_reporter.next_stage()
+        bb.event.check_for_interrupts(self.cooker.data)
 
         # Create and print to the logs a virtual/xxxx -> PN (fn) table
         for mc in taskData:
@@ -1228,6 +1240,7 @@ class RunQueueData:
                 bb.parse.siggen.tasks_resolved(virtmap, virtpnmap, self.dataCaches[mc])
 
         self.init_progress_reporter.next_stage()
+        bb.event.check_for_interrupts(self.cooker.data)
 
         bb.parse.siggen.set_setscene_tasks(self.runq_setscene_tids)
 
@@ -1240,6 +1253,7 @@ class RunQueueData:
                     dealtwith.add(tid)
                     todeal.remove(tid)
                     self.prepare_task_hash(tid)
+                bb.event.check_for_interrupts(self.cooker.data)
 
         bb.parse.siggen.writeout_file_checksum_cache()
 
@@ -1483,6 +1497,7 @@ class RunQueue:
         """
 
         retval = True
+        bb.event.check_for_interrupts(self.cooker.data)
 
         if self.state is runQueuePrepare:
             # NOTE: if you add, remove or significantly refactor the stages of this
-- 
2.37.2


