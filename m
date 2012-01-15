Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RmN5y-00085E-00
	for bitbake-devel@lists.openembedded.org;
	Sun, 15 Jan 2012 11:13:50 +0100
Received: by opal (Postfix, from userid 111)
	id 5B69910341; Sun, 15 Jan 2012 10:15:11 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120115101511.5B69910341@opal>
Date: Sun, 15 Jan 2012 10:15:11 +0000 (UTC)
From: git@git.openembedded.org
Subject: Paul Eggleton : bitbake/knotty: print task failure summary
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sun, 15 Jan 2012 10:13:50 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: cdf69913f99d28bc7f51067a60257701f952c6cb
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=cdf69913f99d28bc7f51067a60257701f952c6cb

Author: Paul Eggleton <paul.eggleton@linux.intel.com>
Date:   Fri Jan 13 17:01:52 2012 +0000

bitbake/knotty: print task failure summary

Remove the error logged within cooker summarising the list of failed
tasks, and instead print this in the UI (knotty) where it belongs. This
also adds the actual name of the task that failed as well as the
corresponding recipe file that was being shown previously.

In addition, reformat the summary messages more tidily - no extra breaks
between lines and use correct English singular/plurals, with some
allowance for future translation.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/cooker.py    |    4 ----
 lib/bb/ui/knotty.py |   24 ++++++++++++++++++++++--
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 6041410..4197a02 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1065,8 +1065,6 @@ class BBCooker:
             try:
                 retval = rq.execute_runqueue()
             except runqueue.TaskFailure as exc:
-                for fnid in exc.args:
-                    buildlog.error("'%s' failed" % taskdata.fn_index[fnid])
                 failures += len(exc.args)
                 retval = False
             except SystemExit as exc:
@@ -1106,8 +1104,6 @@ class BBCooker:
             try:
                 retval = rq.execute_runqueue()
             except runqueue.TaskFailure as exc:
-                for fnid in exc.args:
-                    buildlog.error("'%s' failed" % taskdata.fn_index[fnid])
                 failures += len(exc.args)
                 retval = False
             except SystemExit as exc:
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 205a8d8..e1d42f7 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -64,6 +64,12 @@ def new_progress(msg, maxval):
     else:
         return NonInteractiveProgress(msg, maxval)
 
+def pluralise(singular, plural, qty):
+    if(qty == 1):
+        return singular % qty
+    else:
+        return plural % qty
+
 def main(server, eventHandler):
 
     # Get values of variables which control our output
@@ -107,6 +113,7 @@ def main(server, eventHandler):
     return_value = 0
     errors = 0
     warnings = 0
+    taskfailures = []
     while True:
         try:
             event = eventHandler.waitEvent(0.25)
@@ -240,6 +247,7 @@ def main(server, eventHandler):
                 continue
 
             if isinstance(event, bb.runqueue.runQueueTaskFailed):
+                taskfailures.append(event.taskstring)
                 logger.error("Task %s (%s) failed with exit code '%s'",
                              event.taskid, event.taskstring, event.exitcode)
                 continue
@@ -272,8 +280,20 @@ def main(server, eventHandler):
                 server.runCommand(["stateShutdown"])
             shutdown = shutdown + 1
             pass
+
+    summary = ""
+    if taskfailures:
+        summary += pluralise("\nSummary: %s task failed:",
+                             "\nSummary: %s tasks failed:", len(taskfailures))
+        for failure in taskfailures:
+            summary += "\n  %s" % failure
     if warnings:
-        print("Summary: There were %s WARNING messages shown.\n" % warnings)
+        summary += pluralise("\nSummary: There was %s WARNING message shown.",
+                             "\nSummary: There were %s WARNING messages shown.", warnings)
     if return_value:
-        print("Summary: There were %s ERROR messages shown, returning a non-zero exit code.\n" % errors)
+        summary += pluralise("\nSummary: There was %s ERROR message shown, returning a non-zero exit code.",
+                             "\nSummary: There were %s ERROR messages shown, returning a non-zero exit code.", errors)
+    if summary:
+        print(summary)
+
     return return_value



