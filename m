Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RTdaZ-0006AK-8g for bitbake-devel@lists.openembedded.org;
	Thu, 24 Nov 2011 18:59:59 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pAOHrRX1027834
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2011 17:53:27 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 27700-01 for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2011 17:53:23 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pAOHrHcM027828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2011 17:53:18 GMT
Message-ID: <1322157204.10928.12.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 24 Nov 2011 17:53:24 +0000
X-Mailer: Evolution 3.2.1- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] data/siggen: Add vardepvalue mechanism to allow the variable dependency code to be forced to specific values
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
X-List-Received-Date: Thu, 24 Nov 2011 17:59:59 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

We have a problem if we want to inject specific information into the variable
dependency code. There are cases for example where we want a dependency
on the value of X but it doesn't matter how X was constructed or what
dependencies it might have had, we only care about the absolute value.
With the current code, its near enough impossible to do this.

This patch adds such a mechanism so the user can trigger this with code like:

baselib[vardepvalue] = "${baselib}"

It also refactors some of the code so we do variable lookups once
instead of doing this in two different functions.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index 10188f3..7c1533c 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -275,18 +275,21 @@ def update_data(d):
     """Performs final steps upon the datastore, including application of overrides"""
     d.finalize()
 
-def build_dependencies(key, keys, shelldeps, d):
+def build_dependencies(key, keys, shelldeps, vardepvals, d):
     deps = set()
     vardeps = d.getVarFlag(key, "vardeps", True)
     try:
-        if d.getVarFlag(key, "func"):
+        value = d.getVar(key, False)
+        if key in vardepvals:
+           value =  d.getVarFlag(key, "vardepvalue", True)
+        elif d.getVarFlag(key, "func"):
             if d.getVarFlag(key, "python"):
-                parsedvar = d.expandWithRefs(d.getVar(key, False), key)
+                parsedvar = d.expandWithRefs(value, key)
                 parser = bb.codeparser.PythonParser(key, logger)
                 parser.parse_python(parsedvar.value)
                 deps = deps | parser.references
             else:
-                parsedvar = d.expandWithRefs(d.getVar(key, False), key)
+                parsedvar = d.expandWithRefs(value, key)
                 parser = bb.codeparser.ShellParser(key, logger)
                 parser.parse_shell(parsedvar.value)
                 deps = deps | shelldeps
@@ -295,7 +298,7 @@ def build_dependencies(key, keys, shelldeps, d):
             deps = deps | parsedvar.references
             deps = deps | (keys & parser.execs) | (keys & parsedvar.execs)
         else:
-            parser = d.expandWithRefs(d.getVar(key, False), key)
+            parser = d.expandWithRefs(value, key)
             deps |= parser.references
             deps = deps | (keys & parser.execs)
         deps |= set((vardeps or "").split())
@@ -303,7 +306,7 @@ def build_dependencies(key, keys, shelldeps, d):
     except:
         bb.note("Error expanding variable %s" % key)
         raise
-    return deps
+    return deps, value
     #bb.note("Variable %s references %s and calls %s" % (key, str(deps), str(execs)))
     #d.setVarFlag(key, "vardeps", deps)
 
@@ -311,12 +314,14 @@ def generate_dependencies(d):
 
     keys = set(key for key in d.keys() if not key.startswith("__"))
     shelldeps = set(key for key in keys if d.getVarFlag(key, "export") and not d.getVarFlag(key, "unexport"))
+    vardepvals = set(key for key in keys if d.getVarFlag(key, "vardepvalue"))
 
     deps = {}
+    values = {}
 
     tasklist = bb.data.getVar('__BBTASKS', d) or []
     for task in tasklist:
-        deps[task] = build_dependencies(task, keys, shelldeps, d)
+        deps[task], values[task] = build_dependencies(task, keys, shelldeps, vardepvals, d)
         newdeps = deps[task]
         seen = set()
         while newdeps:
@@ -325,11 +330,11 @@ def generate_dependencies(d):
             newdeps = set()
             for dep in nextdeps:
                 if dep not in deps:
-                    deps[dep] = build_dependencies(dep, keys, shelldeps, d)
+                    deps[dep], values[dep] = build_dependencies(dep, keys, shelldeps, vardepvals, d)
                 newdeps |=  deps[dep]
             newdeps -= seen
         #print "For %s: %s" % (task, str(taskdeps[task]))
-    return tasklist, deps
+    return tasklist, deps, values
 
 def inherits_class(klass, d):
     val = getVar('__inherit_cache', d) or []
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 3aa3fe1..91b4160 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -72,11 +72,10 @@ class SignatureGeneratorBasic(SignatureGenerator):
 
     def _build_data(self, fn, d):
 
-        tasklist, gendeps = bb.data.generate_dependencies(d)
+        tasklist, gendeps, lookupcache = bb.data.generate_dependencies(d)
 
         taskdeps = {}
         basehash = {}
-        lookupcache = {}
 
         for task in tasklist:
             data = d.getVar(task, False)




