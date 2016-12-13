Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 12B0071C22
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Dec 2016 07:09:00 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga103.fm.intel.com with ESMTP; 12 Dec 2016 23:09:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,340,1477983600"; d="scan'208";a="201961512"
Received: from mauric9x-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.158.7])
	by fmsmga004.fm.intel.com with ESMTP; 12 Dec 2016 23:08:58 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Dec 2016 20:07:12 +1300
Message-Id: <921fb59f1c79344fc527ee4f26aba39d9d4b03e2.1481611138.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1481611138.git.paul.eggleton@linux.intel.com>
References: <cover.1481611138.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 13/15] runqueue: enable setVariable command to affect task execution
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
X-List-Received-Date: Tue, 13 Dec 2016 07:09:00 -0000

Allow the client to set variables with the setVariable command and have
those changes take effect when running tasks. This is accomplished by
collecting changes made by setVariable separately and pass these to the
worker so it can be applied on top of the datastore it creates.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-worker | 12 ++++++++++--
 lib/bb/command.py  |  1 +
 lib/bb/cooker.py   |  1 +
 lib/bb/runqueue.py |  1 +
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 97b32c3..4dbd681 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -136,7 +136,7 @@ def sigterm_handler(signum, frame):
     os.killpg(0, signal.SIGTERM)
     sys.exit()
 
-def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, appends, taskdepdata, quieterrors=False):
+def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, appends, taskdepdata, extraconfigdata, quieterrors=False):
     # We need to setup the environment BEFORE the fork, since
     # a fork() or exec*() activates PSEUDO...
 
@@ -223,6 +223,9 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, append
                 the_data.setVar("BUILDNAME", workerdata["buildname"])
                 the_data.setVar("DATE", workerdata["date"])
                 the_data.setVar("TIME", workerdata["time"])
+                for varname, value in extraconfigdata.items():
+                    the_data.setVar(varname, value)
+
                 bb.parse.siggen.set_taskdata(workerdata["sigdata"])
                 ret = 0
 
@@ -329,6 +332,7 @@ class BitbakeWorker(object):
         self.cookercfg = None
         self.databuilder = None
         self.data = None
+        self.extraconfigdata = None
         self.build_pids = {}
         self.build_pipes = {}
     
@@ -363,6 +367,7 @@ class BitbakeWorker(object):
                     pass
             if len(self.queue):
                 self.handle_item(b"cookerconfig", self.handle_cookercfg)
+                self.handle_item(b"extraconfigdata", self.handle_extraconfigdata)
                 self.handle_item(b"workerdata", self.handle_workerdata)
                 self.handle_item(b"runtask", self.handle_runtask)
                 self.handle_item(b"finishnow", self.handle_finishnow)
@@ -391,6 +396,9 @@ class BitbakeWorker(object):
         self.databuilder.parseBaseConfiguration()
         self.data = self.databuilder.data
 
+    def handle_extraconfigdata(self, data):
+        self.extraconfigdata = pickle.loads(data)
+
     def handle_workerdata(self, data):
         self.workerdata = pickle.loads(data)
         bb.msg.loggerDefaultDebugLevel = self.workerdata["logdefaultdebug"]
@@ -416,7 +424,7 @@ class BitbakeWorker(object):
         fn, task, taskname, quieterrors, appends, taskdepdata = pickle.loads(data)
         workerlog_write("Handling runtask %s %s %s\n" % (task, fn, taskname))
 
-        pid, pipein, pipeout = fork_off_task(self.cookercfg, self.data, self.databuilder, self.workerdata, fn, task, taskname, appends, taskdepdata, quieterrors)
+        pid, pipein, pipeout = fork_off_task(self.cookercfg, self.data, self.databuilder, self.workerdata, fn, task, taskname, appends, taskdepdata, self.extraconfigdata, quieterrors)
 
         self.build_pids[pid] = task
         self.build_pipes[pid] = runQueueWorkerPipe(pipein, pipeout)
diff --git a/lib/bb/command.py b/lib/bb/command.py
index 3b68c1a..5bce796 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -187,6 +187,7 @@ class CommandsSync:
         """
         varname = params[0]
         value = str(params[1])
+        command.cooker.extraconfigdata[varname] = value
         command.cooker.data.setVar(varname, value)
 
     def getSetVariable(self, command, params):
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index a4aaac5..620ff9f 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -358,6 +358,7 @@ class BBCooker:
         self.databuilder.parseBaseConfiguration()
         self.data = self.databuilder.data
         self.data_hash = self.databuilder.data_hash
+        self.extraconfigdata = {}
 
         if consolelog:
             self.data.setVar("BB_CONSOLELOG", consolelog)
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 389df4f..2ad8aad 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1036,6 +1036,7 @@ class RunQueue:
         }
 
         worker.stdin.write(b"<cookerconfig>" + pickle.dumps(self.cooker.configuration) + b"</cookerconfig>")
+        worker.stdin.write(b"<extraconfigdata>" + pickle.dumps(self.cooker.extraconfigdata) + b"</extraconfigdata>")
         worker.stdin.write(b"<workerdata>" + pickle.dumps(workerdata) + b"</workerdata>")
         worker.stdin.flush()
 
-- 
2.5.5


