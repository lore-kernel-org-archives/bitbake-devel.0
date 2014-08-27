Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 8A146617B8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 13:24:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s7RDOuUY032730 for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 14:24:56 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id cM6wTPmf-i6y for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 14:24:56 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s7RDOpG5032726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 14:24:52 +0100
Message-ID: <1409145892.5772.49.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 27 Aug 2014 14:24:52 +0100
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Subject: [PATCH] build/data: Write out more complete python run files
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
X-List-Received-Date: Wed, 27 Aug 2014 13:25:12 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently the output in the python task/function run files is rather
incomplete and effectively useless. This enhances the code to take
advantage of the bitbake's dependency tracking and extend the output to
include dependencies. This makes the files more usable for debugging
purposes. Since this only happens at python function execution time, the
overhead is minimal in the grand scheme of things.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index f2922f3..65cc851 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -227,7 +227,7 @@ def exec_func_python(func, d, runfile, cwd=None):
     code = _functionfmt.format(function=func, body=d.getVar(func, True))
     bb.utils.mkdirhier(os.path.dirname(runfile))
     with open(runfile, 'w') as script:
-        script.write(code)
+        bb.data.emit_func_python(func, script, d)
 
     if cwd:
         try:
diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index 3d776b3..91b1eb1 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -281,6 +281,41 @@ def emit_func(func, o=sys.__stdout__, d = init()):
                newdeps |= set((d.getVarFlag(dep, "vardeps", True) or "").split())
         newdeps -= seen
 
+_functionfmt = """
+def {function}(d):
+{body}"""
+
+def emit_func_python(func, o=sys.__stdout__, d = init()):
+    """Emits all items in the data store in a format such that it can be sourced by a shell."""
+
+    def write_func(func, o, call = False):
+        body = d.getVar(func, True)
+        if not body.startswith("def"):
+            body = _functionfmt.format(function=func, body=body)
+
+        o.write(body.strip() + "\n\n")
+        if call:
+            o.write(func + "(d)" + "\n\n")
+
+    write_func(func, o, True)
+    pp = bb.codeparser.PythonParser(func, logger)
+    pp.parse_python(d.getVar(func, True))
+    newdeps = pp.execs
+    newdeps |= set((d.getVarFlag(func, "vardeps", True) or "").split())
+    seen = set()
+    while newdeps:
+        deps = newdeps
+        seen |= deps
+        newdeps = set()
+        for dep in deps:
+            if d.getVarFlag(dep, "func") and d.getVarFlag(dep, "python"):
+               write_func(dep, o)
+               pp = bb.codeparser.PythonParser(dep, logger)
+               pp.parse_python(d.getVar(dep, True))
+               newdeps |= pp.execs
+               newdeps |= set((d.getVarFlag(dep, "vardeps", True) or "").split())
+        newdeps -= seen
+
 def update_data(d):
     """Performs final steps upon the datastore, including application of overrides"""
     d.finalize(parent = True)



