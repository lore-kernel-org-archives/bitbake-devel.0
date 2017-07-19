Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 1FEFF781F2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Jul 2017 09:56:42 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 Jul 2017 02:56:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.40,380,1496127600"; d="scan'208";a="880410397"
Received: from gsena-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.48.213])
	by FMSMGA003.fm.intel.com with ESMTP; 19 Jul 2017 02:56:43 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 19 Jul 2017 11:56:00 +0200
Message-Id: <ab2bdac7b2200730b26b7306cfb81211957a5217.1500458081.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1500458081.git.paul.eggleton@linux.intel.com>
References: <cover.1500458081.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 01/12] tinfoil: add internal mode to build_file() function
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
X-List-Received-Date: Wed, 19 Jul 2017 09:56:42 -0000

In OE's devtool we want to repeatedly run build_file() without showing
unnecessary messages and triggering buildhistory for each call.
build_file() is just a wrapper around the buildFile command. Change
the final "hidewarning" parameter of the buildFile command to "internal"
and have this call a new buildFileInternal() function without triggering
any of the normal build events, silencing the normal info messages from
the runqueue ("Executing RunQueue Tasks", "Tasks Summary" etc.) and
avoiding calling parseConfiguration() which we've already done at this
point.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/command.py |  9 ++++++---
 lib/bb/cooker.py  | 34 +++++++++++++++++++++++++---------
 lib/bb/tinfoil.py |  9 ++++++---
 3 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 36891b9..2c8223e 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -543,11 +543,14 @@ class CommandsAsync:
         bfile = params[0]
         task = params[1]
         if len(params) > 2:
-            hidewarning = params[2]
+            internal = params[2]
         else:
-            hidewarning = False
+            internal = False
 
-        command.cooker.buildFile(bfile, task, hidewarning)
+        if internal:
+            command.cooker.buildFileInternal(bfile, task, fireevents=False, quietlog=True)
+        else:
+            command.cooker.buildFile(bfile, task)
     buildFile.needcache = False
 
     def buildTargets(self, command, params):
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index b1311bb..9041594 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1232,21 +1232,27 @@ class BBCooker:
             raise NoSpecificMatch
         return matches[0]
 
-    def buildFile(self, buildfile, task, hidewarning=False):
+    def buildFile(self, buildfile, task):
         """
         Build the file matching regexp buildfile
         """
         bb.event.fire(bb.event.BuildInit(), self.data)
 
-        if not hidewarning:
-            # Too many people use -b because they think it's how you normally
-            # specify a target to be built, so show a warning
-            bb.warn("Buildfile specified, dependencies will not be handled. If this is not what you want, do not use -b / --buildfile.")
+        # Too many people use -b because they think it's how you normally
+        # specify a target to be built, so show a warning
+        bb.warn("Buildfile specified, dependencies will not be handled. If this is not what you want, do not use -b / --buildfile.")
 
         # Parse the configuration here. We need to do it explicitly here since
         # buildFile() doesn't use the cache
         self.parseConfiguration()
 
+        self.buildFileInternal(buildfile, task)
+
+    def buildFileInternal(self, buildfile, task, fireevents=True, quietlog=False):
+        """
+        Build the file matching regexp buildfile
+        """
+
         # If we are told to do the None task then query the default task
         if (task == None):
             task = self.configuration.cmd
@@ -1283,8 +1289,8 @@ class BBCooker:
         # Remove external dependencies
         self.recipecaches[mc].task_deps[fn]['depends'] = {}
         self.recipecaches[mc].deps[fn] = []
-        self.recipecaches[mc].rundeps[fn] = []
-        self.recipecaches[mc].runrecs[fn] = []
+        self.recipecaches[mc].rundeps[fn] = defaultdict(list)
+        self.recipecaches[mc].runrecs[fn] = defaultdict(list)
 
         # Invalidate task for target if force mode active
         if self.configuration.force:
@@ -1296,8 +1302,13 @@ class BBCooker:
         taskdata[mc] = bb.taskdata.TaskData(self.configuration.abort)
         taskdata[mc].add_provider(self.databuilder.mcdata[mc], self.recipecaches[mc], item)
 
+        if quietlog:
+            rqloglevel = bb.runqueue.logger.getEffectiveLevel()
+            bb.runqueue.logger.setLevel(logging.WARNING)
+
         buildname = self.databuilder.mcdata[mc].getVar("BUILDNAME")
-        bb.event.fire(bb.event.BuildStarted(buildname, [item]), self.databuilder.mcdata[mc])
+        if fireevents:
+            bb.event.fire(bb.event.BuildStarted(buildname, [item]), self.databuilder.mcdata[mc])
 
         # Execute the runqueue
         runlist = [[mc, item, task, fn]]
@@ -1324,11 +1335,16 @@ class BBCooker:
                 retval = False
             except SystemExit as exc:
                 self.command.finishAsyncCommand(str(exc))
+                if quietlog:
+                    bb.runqueue.logger.setLevel(rqloglevel)
                 return False
 
             if not retval:
-                bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runtaskentries), buildname, item, failures, interrupted), self.databuilder.mcdata[mc])
+                if fireevents:
+                    bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runtaskentries), buildname, item, failures, interrupted), self.databuilder.mcdata[mc])
                 self.command.finishAsyncCommand(msg)
+                if quietlog:
+                    bb.runqueue.logger.setLevel(rqloglevel)
                 return False
             if retval is True:
                 return True
diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index fb0da62..b45acea 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -415,12 +415,15 @@ class Tinfoil:
         else:
             return None
 
-    def build_file(self, buildfile, task):
+    def build_file(self, buildfile, task, internal=True):
         """
         Runs the specified task for just a single recipe (i.e. no dependencies).
-        This is equivalent to bitbake -b, except no warning will be printed.
+        This is equivalent to bitbake -b, except with the default internal=True
+        no warning about dependencies will be produced, normal info messages
+        from the runqueue will be silenced and BuildInit, BuildStarted and
+        BuildCompleted events will not be fired.
         """
-        return self.run_command('buildFile', buildfile, task, True)
+        return self.run_command('buildFile', buildfile, task, internal)
 
     def shutdown(self):
         if self.server_connection:
-- 
2.9.4


