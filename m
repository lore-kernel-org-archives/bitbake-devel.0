Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 2D7E660D04
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Dec 2013 10:44:41 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rBIAiboo030191 for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Dec 2013 10:44:37 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id cFt1jsVi6fhV for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Dec 2013 10:44:37 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rBIAiYwm030187
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Dec 2013 10:44:35 GMT
Message-ID: <1387363470.6402.22.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 18 Dec 2013 10:44:30 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] ast/BBHandler/build: Add support for removing tasks (deltask)
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
X-List-Received-Date: Wed, 18 Dec 2013 10:44:42 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Back in the depths of time we did support task removal. In the pre
AST days it was nearly impossible to continue supporting it, it wasn't
used so it was dropped. With the modern codebase we can easily now support
deltask and it would be very useful within the metadata since it can
massively simplify dependency trees.

As an example, a core-image-sato had 47703 inter task dependencies before
this patch and a patch to native.bbclass, afterwards with the noexec tasks
deleted, we had 29883. Such a significant simplification is worthwhile
and justifies adding a deltask operation to the system.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 92c45a3..6b39526 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -622,7 +622,7 @@ def stampfile(taskname, d, file_name = None):
     """
     return stamp_internal(taskname, d, file_name)
 
-def add_tasks(tasklist, d):
+def add_tasks(tasklist, deltasklist, d):
     task_deps = d.getVar('_task_deps')
     if not task_deps:
         task_deps = {}
@@ -633,6 +633,10 @@ def add_tasks(tasklist, d):
 
     for task in tasklist:
         task = d.expand(task)
+
+        if task in deltasklist:
+            continue
+
         d.setVarFlag(task, 'task', 1)
 
         if not task in task_deps['tasks']:
diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index d4b8b09..2036cd4 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -259,6 +259,21 @@ class AddTaskNode(AstNode):
                 if var not in existing:
                     data.setVarFlag(entry, "deps", [var] + existing)
 
+class DelTaskNode(AstNode):
+    def __init__(self, filename, lineno, func):
+        AstNode.__init__(self, filename, lineno)
+        self.func = func
+
+    def eval(self, data):
+        var = self.func
+        if self.func[:3] != "do_":
+            var = "do_" + self.func
+
+        bbtasks = data.getVar('__BBDELTASKS') or []
+        if not var in bbtasks:
+            bbtasks.append(var)
+        data.setVar('__BBDELTASKS', bbtasks)
+
 class BBHandlerNode(AstNode):
     def __init__(self, filename, lineno, fns):
         AstNode.__init__(self, filename, lineno)
@@ -309,6 +324,13 @@ def handleAddTask(statements, filename, lineno, m):
 
     statements.append(AddTaskNode(filename, lineno, func, before, after))
 
+def handleDelTask(statements, filename, lineno, m):
+    func = m.group("func")
+    if func is None:
+        return
+
+    statements.append(DelTaskNode(filename, lineno, func))
+
 def handleBBHandlers(statements, filename, lineno, m):
     statements.append(BBHandlerNode(filename, lineno, m.group(1)))
 
@@ -333,7 +355,8 @@ def finalize(fn, d, variant = None):
     bb.data.update_data(d)
 
     tasklist = d.getVar('__BBTASKS') or []
-    bb.build.add_tasks(tasklist, d)
+    deltasklist = d.getVar('__BBDELTASKS') or []
+    bb.build.add_tasks(tasklist, deltasklist, d)
 
     bb.parse.siggen.finalise(fn, d, variant)
 
diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py b/bitbake/lib/bb/parse/parse_py/BBHandler.py
index 7cba649..408890e 100644
--- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
@@ -42,6 +42,7 @@ __func_start_regexp__    = re.compile( r"(((?P<py>python)|(?P<fr>fakeroot))\s*)*
 __inherit_regexp__       = re.compile( r"inherit\s+(.+)" )
 __export_func_regexp__   = re.compile( r"EXPORT_FUNCTIONS\s+(.+)" )
 __addtask_regexp__       = re.compile("addtask\s+(?P<func>\w+)\s*((before\s*(?P<before>((.*(?=after))|(.*))))|(after\s*(?P<after>((.*(?=before))|(.*)))))*")
+__deltask_regexp__       = re.compile("deltask\s+(?P<func>\w+)")
 __addhandler_regexp__    = re.compile( r"addhandler\s+(.+)" )
 __def_regexp__           = re.compile( r"def\s+(\w+).*:" )
 __python_func_regexp__   = re.compile( r"(\s+.*)|(^$)" )
@@ -243,6 +244,11 @@ def feeder(lineno, s, fn, root, statements):
         ast.handleAddTask(statements, fn, lineno, m)
         return
 
+    m = __deltask_regexp__.match(s)
+    if m:
+        ast.handleDelTask(statements, fn, lineno, m)
+        return
+
     m = __addhandler_regexp__.match(s)
     if m:
         ast.handleBBHandlers(statements, fn, lineno, m)



