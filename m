Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id ED96175791
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jul 2015 10:40:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t6OAeCJo020828 for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jul 2015 11:40:12 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id LqXYyhmKp0VA for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jul 2015 11:40:12 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t6OAdwmR020776
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jul 2015 11:40:10 +0100
Message-ID: <1437734398.821.150.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 24 Jul 2015 11:39:58 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: [PATCH] data: Clean up datastore accesses and True/False values
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
X-List-Received-Date: Fri, 24 Jul 2015 10:40:20 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

We should use the d.xxxVar syntax rather than the older function style.

Also replace 0/1 with the more pythonic True/False.

No functionality changes.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index 8b21c46..59dca0a 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -84,7 +84,7 @@ def setVar(var, value, d):
     d.setVar(var, value)
 
 
-def getVar(var, d, exp = 0):
+def getVar(var, d, exp = False):
     """Gets the value of a variable"""
     return d.getVar(var, exp)
 
@@ -161,9 +161,9 @@ def expandKeys(alterdata, readdata = None):
     # usefulness of the expand cache
     for key in sorted(todolist):
         ekey = todolist[key]
-        newval = alterdata.getVar(ekey, 0)
+        newval = alterdata.getVar(ekey, False)
         if newval is not None:
-            val = alterdata.getVar(key, 0)
+            val = alterdata.getVar(key, False)
             if val is not None:
                 bb.warn("Variable key %s (%s) replaces original key %s (%s)." % (key, val, ekey, newval))
         alterdata.renameVar(key, ekey)
@@ -174,7 +174,7 @@ def inheritFromOS(d, savedenv, permitted):
     for s in savedenv.keys():
         if s in permitted:
             try:
-                d.setVar(s, getVar(s, savedenv, True), op = 'from env')
+                d.setVar(s, savedenv.getVar(s, True), op = 'from env')
                 if s in exportlist:
                     d.setVarFlag(s, "export", True, op = 'auto env export')
             except TypeError:
@@ -182,39 +182,39 @@ def inheritFromOS(d, savedenv, permitted):
 
 def emit_var(var, o=sys.__stdout__, d = init(), all=False):
     """Emit a variable to be sourced by a shell."""
-    if getVarFlag(var, "python", d):
-        return 0
+    if d.getVarFlag(var, "python"):
+        return False
 
-    export = getVarFlag(var, "export", d)
-    unexport = getVarFlag(var, "unexport", d)
-    func = getVarFlag(var, "func", d)
+    export = d.getVarFlag(var, "export")
+    unexport = d.getVarFlag(var, "unexport")
+    func = d.getVarFlag(var, "func")
     if not all and not export and not unexport and not func:
-        return 0
+        return False
 
     try:
         if all:
-            oval = getVar(var, d, 0)
-        val = getVar(var, d, 1)
+            oval = d.getVar(var, False)
+        val = d.getVar(var, True)
     except (KeyboardInterrupt, bb.build.FuncFailed):
         raise
     except Exception as exc:
         o.write('# expansion of %s threw %s: %s\n' % (var, exc.__class__.__name__, str(exc)))
-        return 0
+        return False
 
     if all:
         d.varhistory.emit(var, oval, val, o)
 
     if (var.find("-") != -1 or var.find(".") != -1 or var.find('{') != -1 or var.find('}') != -1 or var.find('+') != -1) and not all:
-        return 0
+        return False
 
-    varExpanded = expand(var, d)
+    varExpanded = d.expand(var)
 
     if unexport:
         o.write('unset %s\n' % varExpanded)
-        return 0
+        return False
 
     if val is None:
-        return 0
+        return False
 
     val = str(val)
 
@@ -223,7 +223,7 @@ def emit_var(var, o=sys.__stdout__, d = init(), all=False):
         val = val[3:] # Strip off "() "
         o.write("%s() %s\n" % (varExpanded, val))
         o.write("export -f %s\n" % (varExpanded))
-        return 1
+        return True
 
     if func:
         # NOTE: should probably check for unbalanced {} within the var
@@ -239,7 +239,7 @@ def emit_var(var, o=sys.__stdout__, d = init(), all=False):
     alter = re.sub('\n', ' \\\n', alter)
     alter = re.sub('\\$', '\\\\$', alter)
     o.write('%s="%s"\n' % (varExpanded, alter))
-    return 0
+    return False
 
 def emit_env(o=sys.__stdout__, d = init(), all=False):
     """Emits all items in the data store in a format such that it can be sourced by a shell."""
@@ -437,7 +437,7 @@ def generate_dependencies(d):
     return tasklist, deps, values
 
 def inherits_class(klass, d):
-    val = getVar('__inherit_cache', d) or []
+    val = d.getVar('__inherit_cache', False) or []
     needle = os.path.join('classes', '%s.bbclass' % klass)
     for v in val:
         if v.endswith(needle):



