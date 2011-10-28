Received: from mail-yw0-f47.google.com ([209.85.213.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1RJnrT-0003P6-5S
	for bitbake-devel@lists.openembedded.org;
	Fri, 28 Oct 2011 16:56:47 +0200
Received: by ywf9 with SMTP id 9so3659470ywf.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Oct 2011 07:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=from:to:subject:date:message-id:x-mailer:in-reply-to:references
	:in-reply-to:references;
	bh=Zlb6BMzreRqhF7M77DWNYbUkiJswWI/kdqLa5am8cEk=;
	b=nZurvzRTRHBXUJ8BEOaG6QaJ9LeDfE68STS+ean+5tw6D60YV/0IXxCxpTQhBifXfa
	XOUUi82geirsNXDeTEo196MsO/WJUuufIxtmO8LOLrodeCBKFz311XmIw1pFN2IA3zyi
	/aepmN04um9S/RfH5QlEQ2cdJtAhhqbN5eFEU=
Received: by 10.150.95.19 with SMTP id s19mr2472394ybb.33.1319813444779;
	Fri, 28 Oct 2011 07:50:44 -0700 (PDT)
Received: from localhost.localdomain (ip24-251-167-38.ph.ph.cox.net.
	[24.251.167.38])
	by mx.google.com with ESMTPS id 4sm25218924ano.9.2011.10.28.07.50.43
	(version=TLSv1/SSLv3 cipher=OTHER);
	Fri, 28 Oct 2011 07:50:43 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Oct 2011 07:50:24 -0700
Message-Id: <bb7e0a13b55afc5f6c8df714b9162db63a16a3e8.1319813177.git.kergoth@gmail.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1319813177.git.kergoth@gmail.com>
References: <cover.1319813177.git.kergoth@gmail.com>
In-Reply-To: <cover.1319813177.git.kergoth@gmail.com>
References: <cover.1319813177.git.kergoth@gmail.com>
Subject: [PATCH 2/2] codeparser: simplify how we compare the called node names
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
X-List-Received-Date: Fri, 28 Oct 2011 14:56:47 -0000

With the previous method, using the compare_name methods, we split the
requested match name by '.', reversed it, then compared them piecemeal
during the node traversal. The new method walks the nodes and hands back
the name of what's being called, and then we check that. This also
consolidates the two different implementations of traversal of the
attribute/name nodes (one in compare_name, one for the execs).

Signed-off-by: Christopher Larson <kergoth@gmail.com>
---
 lib/bb/codeparser.py |   72 ++++++++++++++------------------------------------
 1 files changed, 20 insertions(+), 52 deletions(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 0f3d646..7715613 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -156,40 +156,6 @@ class PythonParser():
     execfuncs = ("bb.build.exec_func", "bb.build.exec_task")
 
     @classmethod
-    def _compare_name(cls, strparts, node):
-        """Given a sequence of strings representing a python name,
-        where the last component is the actual Name and the prior
-        elements are Attribute nodes, determine if the supplied node
-        matches.
-        """
-
-        if not strparts:
-            return True
-
-        current, rest = strparts[0], strparts[1:]
-        if isinstance(node, ast.Attribute):
-            if current == node.attr:
-                return cls._compare_name(rest, node.value)
-        elif isinstance(node, ast.Name):
-            if current == node.id:
-                return True
-        return False
-
-    @classmethod
-    def compare_name(cls, value, node):
-        """Convenience function for the _compare_node method, which
-        can accept a string (which is split by '.' for you), or an
-        iterable of strings, in which case it checks to see if any of
-        them match, similar to isinstance.
-        """
-
-        if isinstance(value, basestring):
-            return cls._compare_name(tuple(reversed(value.split("."))),
-                                        node)
-        else:
-            return any(cls.compare_name(item, node) for item in value)
-
-    @classmethod
     def warn(cls, func, arg):
         """Warn about calls of bitbake APIs which pass a non-literal
         argument for the variable name, as we're not able to track such
@@ -206,39 +172,41 @@ class PythonParser():
                             "not a literal", funcstr, argstr)
 
     def visit_Call(self, node):
-        if self.compare_name(self.getvars, node.func):
+        name = self.called_node_name(node.func)
+        if name in self.getvars:
             if isinstance(node.args[0], ast.Str):
                 self.var_references.add(node.args[0].s)
             else:
                 self.warn(node.func, node.args[0])
-        elif self.compare_name(self.expands, node.func):
+        elif name in self.expands:
             if isinstance(node.args[0], ast.Str):
                 self.warn(node.func, node.args[0])
                 self.var_expands.add(node.args[0].s)
             elif isinstance(node.args[0], ast.Call) and \
-                    self.compare_name(self.getvars, node.args[0].func):
+                 self.called_node_name(node.args[0].func) in self.getvars:
                 pass
             else:
                 self.warn(node.func, node.args[0])
-        elif self.compare_name(self.execfuncs, node.func):
+        elif name in self.execfuncs:
             if isinstance(node.args[0], ast.Str):
                 self.var_execs.add(node.args[0].s)
             else:
                 self.warn(node.func, node.args[0])
-        elif isinstance(node.func, ast.Name):
-            self.execs.add(node.func.id)
-        elif isinstance(node.func, ast.Attribute):
-            # We must have a qualified name.  Therefore we need
-            # to walk the chain of 'Attribute' nodes to determine
-            # the qualification.
-            attr_node = node.func.value
-            identifier = node.func.attr
-            while isinstance(attr_node, ast.Attribute):
-                identifier = attr_node.attr + "." + identifier
-                attr_node = attr_node.value
-            if isinstance(attr_node, ast.Name):
-                identifier = attr_node.id + "." + identifier
-            self.execs.add(identifier)
+        elif name and isinstance(node.func, (ast.Name, ast.Attribute)):
+            self.execs.add(name)
+
+    def called_node_name(self, node):
+        """Given a called node, return its original string form"""
+        components = []
+        while node:
+            if isinstance(node, ast.Attribute):
+                components.append(node.attr)
+                node = node.value
+            elif isinstance(node, ast.Name):
+                components.append(node.id)
+                return '.'.join(reversed(components))
+            else:
+                break
 
     def __init__(self):
         self.var_references = set()
-- 
1.7.7



