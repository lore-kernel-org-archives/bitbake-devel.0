Return-Path: <tomasz.meresinski@comarch.pl>
Received: from odzwierny1.comarch.com (odzwierny1.comarch.com [217.74.69.9])
	by mail.openembedded.org (Postfix) with ESMTP id 49F7278BF0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Oct 2018 17:19:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	authenticated as tomasz.meresinski@comarch.com
	by odzwierny1.comarch.com with esmtpsa (TLSv1:AES256-SHA:256)(ComArch
	ESMTP) id 1gHAa0-000BL7-0n; Mon, 29 Oct 2018 17:39:52 +0100
From: =?UTF-8?q?Tomasz=20Meresi=C5=84ski?= <tomasz.meresinski@comarch.pl>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 29 Oct 2018 17:39:33 +0100
Message-Id: <20181029163933.26646-4-tomasz.meresinski@comarch.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181029163933.26646-1-tomasz.meresinski@comarch.pl>
References: <20181029163933.26646-1-tomasz.meresinski@comarch.pl>
MIME-Version: 1.0
X-CA-Antivirus: Scanned by ComArch Antivirus on odzwierny1.comarch.com
X-CA-Is-Spam: No
Cc: =?UTF-8?q?Tomasz=20Meresi=C5=84ski?= <tomasz.meresinski@comarch.com>,
	=?UTF-8?q?Tomasz=20Meresi=C5=84ski?= <tomasz.meresinski@comarch.pl>
Subject: [PATCH 3/3] ui/json: Add JSON UI
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
X-List-Received-Date: Mon, 29 Oct 2018 17:19:16 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Knotty UI output is difficult to parse correctly in other apps.
Add JSON UI that print to stdout all events as JSON.
This will make it easier to integrate bitbake with other systems.

Signed-off-by: Tomasz Meresiński <tomasz.meresinski@comarch.com>
---
 lib/bb/ui/json.py | 275 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 275 insertions(+)
 create mode 100644 lib/bb/ui/json.py

diff --git a/lib/bb/ui/json.py b/lib/bb/ui/json.py
new file mode 100644
index 00000000..069dcb4f
--- /dev/null
+++ b/lib/bb/ui/json.py
@@ -0,0 +1,275 @@
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# Bitbake Json UI
+#
+# Copyright (C) 2018 Tomasz Meresiński
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
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
+    bb.event.StampUpdate: lambda event: {
+        "stampPrefix": event.stampPrefix,
+        "targets": event.targets,
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
+        "package": event.package,
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
+    bb.runqueue.sceneQueueComplete: lambda event: {
+        "stats": event.stats,
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
+        for (event_type, callback) in json_types.items():
+            if isinstance(event, event_type):
+                result.update(callback(event))
+
+        if len(result) > 0:
+            #We handled that type
+            result["type"] = generate_type(event)
+            return result
+
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
2.17.1


