Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 5597560D04
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Dec 2013 10:45:17 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rBIAjCw4030221 for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Dec 2013 10:45:12 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id a3h5ax6ZunLz for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Dec 2013 10:45:12 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rBIAj75G030218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Dec 2013 10:45:08 GMT
Message-ID: <1387363502.6402.23.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 18 Dec 2013 10:45:02 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] build/ast: Create strong task add/del API in bb.build
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
X-List-Received-Date: Wed, 18 Dec 2013 10:45:17 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently its near impossible to control task addition/deletion from
metadata context. This adds stong add/deltask API to bb.build
which is traditionally where it resided. The rather broken
remove_tasks function was removed, it didn't appear to do anything
useful or have any users.

This allows us to clean up hacks currently in use in metadata and use
standard API for it instead.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 6b39526..1524da0 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -668,9 +668,36 @@ def add_tasks(tasklist, deltasklist, d):
     # don't assume holding a reference
     d.setVar('_task_deps', task_deps)
 
-def remove_task(task, kill, d):
-    """Remove an BB 'task'.
+def addtask(task, before, after, d):
+    if task[:3] != "do_":
+        task = "do_" + task
+
+    d.setVarFlag(task, "task", 1)
+    bbtasks = d.getVar('__BBTASKS') or []
+    if not task in bbtasks:
+        bbtasks.append(task)
+    d.setVar('__BBTASKS', bbtasks)
+
+    existing = d.getVarFlag(task, "deps") or []
+    if after is not None:
+        # set up deps for function
+        for entry in after.split():
+            if entry not in existing:
+                existing.append(entry)
+    d.setVarFlag(task, "deps", existing)
+    if before is not None:
+        # set up things that depend on this func
+        for entry in before.split():
+            existing = d.getVarFlag(entry, "deps") or []
+            if task not in existing:
+                d.setVarFlag(entry, "deps", [task] + existing)
+
+def deltask(task, d):
+    if task[:3] != "do_":
+        task = "do_" + task
+
+    bbtasks = d.getVar('__BBDELTASKS') or []
+    if not task in bbtasks:
+        bbtasks.append(task)
+    d.setVar('__BBDELTASKS', bbtasks)
 
-       If kill is 1, also remove tasks that depend on this task."""
-
-    d.delVarFlag(task, 'task')
diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index 2036cd4..a202053 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -235,29 +235,7 @@ class AddTaskNode(AstNode):
         self.after = after
 
     def eval(self, data):
-        var = self.func
-        if self.func[:3] != "do_":
-            var = "do_" + self.func
-
-        data.setVarFlag(var, "task", 1)
-        bbtasks = data.getVar('__BBTASKS') or []
-        if not var in bbtasks:
-            bbtasks.append(var)
-        data.setVar('__BBTASKS', bbtasks)
-
-        existing = data.getVarFlag(var, "deps") or []
-        if self.after is not None:
-            # set up deps for function
-            for entry in self.after.split():
-                if entry not in existing:
-                    existing.append(entry)
-        data.setVarFlag(var, "deps", existing)
-        if self.before is not None:
-            # set up things that depend on this func
-            for entry in self.before.split():
-                existing = data.getVarFlag(entry, "deps") or []
-                if var not in existing:
-                    data.setVarFlag(entry, "deps", [var] + existing)
+        bb.build.addtask(self.func, self.before, self.after, data)
 
 class DelTaskNode(AstNode):
     def __init__(self, filename, lineno, func):
@@ -265,14 +243,7 @@ class DelTaskNode(AstNode):
         self.func = func
 
     def eval(self, data):
-        var = self.func
-        if self.func[:3] != "do_":
-            var = "do_" + self.func
-
-        bbtasks = data.getVar('__BBDELTASKS') or []
-        if not var in bbtasks:
-            bbtasks.append(var)
-        data.setVar('__BBDELTASKS', bbtasks)
+        bb.build.deltask(self.func, data)
 
 class BBHandlerNode(AstNode):
     def __init__(self, filename, lineno, fns):
--
cgit v0.9.1



