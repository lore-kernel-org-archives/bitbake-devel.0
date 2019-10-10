Return-Path: <krystian.garlinski@comarch.pl>
X-Greylist: delayed 1729 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 10 Oct 2019 14:32:19 UTC
Received: from odzwierny0.comarch.com (odzwierny0.comarch.com [217.74.69.8])
	by mail.openembedded.org (Postfix) with ESMTP id 2D7FE7F3F6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Oct 2019 14:32:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	authenticated as krystian.garlinski@comarch.com
	by odzwierny0.comarch.com with esmtpsa (TLSv1:AES256-SHA:256)(ComArch
	ESMTP) id 1iIZ2Q-000Dd4-AI; Thu, 10 Oct 2019 16:03:30 +0200
From: =?UTF-8?q?Krystian=20Garli=C5=84ski?= <krystian.garlinski@comarch.pl>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 10 Oct 2019 16:03:21 +0200
Message-Id: <20191010140321.15248-1-krystian.garlinski@comarch.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CA-Antivirus: Scanned by ComArch Antivirus on odzwierny0.comarch.com
X-CA-Is-Spam: No
Cc: =?UTF-8?q?=EF=BF=BCTomasz=20Meresi=C5=84ski?=
	<tomasz.meresinski@comarch.com>
Subject: [PATCH] ui/json: Add JSON UI
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
X-List-Received-Date: Thu, 10 Oct 2019 14:32:19 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Knotty UI output is difficult to parse correctly when trying to integrate
bitbake with different systems. This commit adds JSON UI that prints all
events to stdout as JSON objects, which makes the integration with
external tools and build systems easy.

Signed-off-by: ￼Tomasz Meresiński <tomasz.meresinski@comarch.com>
Signed-off-by: Krystian Garliński <krystian.garlinski@comarch.pl>
---
 lib/bb/ui/json.py | 262 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 262 insertions(+)
 create mode 100644 lib/bb/ui/json.py

diff --git a/lib/bb/ui/json.py b/lib/bb/ui/json.py
new file mode 100644
index 00000000..f9699d95
--- /dev/null
+++ b/lib/bb/ui/json.py
@@ -0,0 +1,262 @@
+#
+# Bitbake JSON UI
+#
+# Prints all events as JSON objects to stdout
+#
+# Copyright (C) 2018-2019 Comarch SA
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+import json
+import logging
+import os
+
+import bb
+
+def generate_type(event):
+    c = event.__class__
+
+    return "{c.__module__}.{c.__name__}".format(c=c)
+
+json_types = {
+    logging.LogRecord: lambda event: {
+        **event.__dict__
+    },
+    bb.event.Event: lambda event: {
+        "pid": event.pid,
+    },
+    bb.event.HeartbeatEvent: lambda event: {
+        "time": event.time,
+    },
+    bb.event.OperationStarted: lambda event: {
+        "msg": event.msg,
+    },
+    bb.event.OperationCompleted: lambda event: {
+        "total": event.total,
+        "msg": event.msg,
+    },
+    bb.event.OperationProgress: lambda event: {
+        "current": event.current,
+        "total": event.total,
+        "msg": event.msg,
+    },
+    bb.event.MultiConfigParsed: lambda event: {
+        "mcdata": event.mcdata,
+    },
+    bb.event.RecipeEvent: lambda event: {
+        "fn": event.fn,
+    },
+    bb.event.RecipeTaskPreProcess: lambda event: {
+        "fn": event.fn,
+        "tasklist": event.tasklist,
+    },
+    bb.event.BuildBase: lambda event: {
+        "pkgs": event.pkgs,
+        "name": event.name,
+        "failures": event.getFailures(),
+    },
+    bb.event.MonitorDiskEvent: lambda event: {
+        "disk_usage": event.disk_usage,
+    },
+    bb.event.DiskUsageSample: lambda sample: {
+        "available_bytes": sample.available_bytes,
+        "free_bytes": sample.free_bytes,
+        "total_bytes": sample.total_bytes,
+    },
+    bb.event.NoProvider: lambda event: {
+        "item": event.getItem(),
+        "isRuntime": event.isRuntime(),
+        "msg": str(event),
+    },
+    bb.event.MultipleProviders: lambda event: {
+        "isRuntime": event.isRuntime(),
+        "item": event.getItem(),
+        "candidates": event.getCandidates(),
+        "msg": str(event),
+    },
+    bb.event.ParseStarted: lambda event: {
+        "total": event.total,
+    },
+    bb.event.ParseCompleted: lambda event: {
+        "cached": event.cached,
+        "parsed": event.parsed,
+        "skipped": event.skipped,
+        "virtuals": event.virtuals,
+        "masked": event.masked,
+        "errors": event.errors,
+        "sofar": event.sofar,
+    },
+    bb.event.CacheLoadStarted: lambda event: {
+        "total": event.total,
+    },
+    bb.event.CacheLoadCompleted: lambda event: {
+        "num_entries": event.num_entries,
+    },
+    bb.event.ReachableStamps: lambda event: {
+        "stamps": event.stamps,
+    },
+    bb.event.LogExecTTY: lambda event: {
+        "msg": event.msg,
+        "prog": event.prog,
+        "sleep_delay": event.sleep_delay,
+        "retries": event.retries,
+    },
+    bb.event.MetadataEvent: lambda event: {
+        "type": event.type,
+    },
+    bb.event.ProcessStarted: lambda event: {
+        "processname": event.processname,
+        "total": event.total,
+    },
+    bb.event.ProcessProgress: lambda event: {
+        "processname": event.processname,
+        "progress": event.progress,
+    },
+    bb.event.ProcessFinished: lambda event: {
+        "processname": event.processname,
+    },
+    bb.event.SanityCheck: lambda event: {
+        "generateevents": event.generateevents,
+    },
+    bb.event.NetworkTest: lambda event: {
+        "generateevents": event.generateevents,
+    },
+    bb.event.FindSigInfoResult: lambda event: {
+        "result": event.result,
+    },
+    bb.build.TaskBase: lambda event: {
+        "taskfile": event.taskfile,
+        "taskname": event.taskname,
+        "logfile": event.logfile,
+        "time": event.time,
+        "task": event.task,
+        "displayName": event.getDisplayName(),
+        "package": event._package,
+    },
+    bb.build.TaskStarted: lambda event: {
+        "taskflags": event.taskflags,
+    },
+    bb.build.TaskFailed: lambda event: {
+        "errprinted": event.errprinted,
+    },
+    bb.build.TaskProgress: lambda event: {
+        "progress": event.progress,
+        "rate": event.rate,
+    },
+    bb.runqueue.runQueueExitWait: lambda event: {
+        "remain": event.remain,
+        "message": event.message,
+    },
+    bb.runqueue.runQueueEvent: lambda event: {
+        "taskid": event.taskid,
+        "taskstring": event.taskstring,
+        "taskname": event.taskname,
+        "taskfile": event.taskfile,
+        "taskhash": event.taskhash,
+        "stats": event.stats,
+    },
+    bb.runqueue.RunQueueStats: lambda stats: {
+        "completed": stats.completed,
+        "skipped": stats.skipped,
+        "failed": stats.failed,
+        "active": stats.active,
+        "total": stats.total,
+    },
+    bb.runqueue.runQueueTaskStarted: lambda event: {
+        "noexec": event.noexec,
+    },
+    bb.runqueue.sceneQueueTaskStarted: lambda event: {
+        "noexec": event.noexec,
+    },
+    bb.runqueue.runQueueTaskFailed: lambda event: {
+        "exitcode": event.exitcode,
+        "msg": str(event),
+    },
+    bb.runqueue.sceneQueueTaskFailed: lambda event: {
+        "exitcode": event.exitcode,
+        "msg": str(event),
+    },
+    bb.runqueue.runQueueTaskSkipped: lambda event: {
+        "reason": event.reason,
+    },
+    bb.command.CommandExit: lambda event: {
+        "exitcode": event.exitcode,
+    },
+    bb.command.CommandFailed: lambda event: {
+        "error": event.error,
+    },
+}
+
+class EventEncoder(json.JSONEncoder):
+    def default(self, event):
+        result = dict()
+
+        if isinstance(event, bb.runqueue.sceneQueueComplete):
+            result["stats"] = event.stats
+        else:
+            for (event_type, callback) in json_types.items():
+                if isinstance(event, event_type):
+                    result.update(callback(event))
+
+        if len(result) > 0:
+            # we've handled that event type
+            result["type"] = generate_type(event)
+            return result
+
+        # unknown event type
+        return json.JSONEncoder.default(self, event)
+
+def main(server, eventHandler, params):
+    # llevel, debug_domains = bb.msg.constructLogOptions()
+    # server.runCommand(["setEventMask", server.getEventHandle(), llevel, debug_domains, _evt_list])
+
+    if not params.observe_only:
+        params.updateToServer(server, os.environ.copy())
+
+    bb.utils.set_process_name("JSON-UI")
+
+    if params.options.remote_server and params.options.kill_server:
+        server.terminateServer()
+        return 0
+
+    if not params.observe_only:
+        params.updateFromServer(server)
+        cmdline = params.parseActions()
+        if not cmdline:
+            #Nothing to do
+            return 0
+
+        if 'msg' in cmdline and cmdline['msg']:
+            record = logging.makeLogRecord({'level': logging.ERROR, 'msg': cmdline['msg']})
+            print(json.dumps(record, cls=EventEncoder), flush=True)
+            return 0
+
+        action = cmdline['action']
+
+        ret, error = server.runCommand(action)
+        if ret != True:
+            error = "Cannot get default commandline"
+
+        if error:
+            record = logging.makeLogRecord({'level': logging.ERROR, 'msg': "Error running command '%s': %s" % (action, error)})
+
+    try:
+        return_value = 0
+        while True:
+            event = eventHandler.waitEvent(None)
+
+            print(json.dumps(event, cls=EventEncoder), flush=True)
+
+            if isinstance(event, bb.command.CommandFailed):
+                return 1
+
+            if isinstance(event, bb.build.TaskFailed):
+                return_value = 1
+
+            if isinstance(event, (bb.command.CommandCompleted, bb.cooker.CookerExit)):
+                return return_value
+
+    except Exception:
+        server.runCommand(["stateForceShutdown"])
+        return 1
-- 
2.20.1


