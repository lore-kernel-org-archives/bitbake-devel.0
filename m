Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE094D5B87C
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 09:48:01 +0000 (UTC)
Received: from esa13.hc324-48.eu.iphmx.com (esa13.hc324-48.eu.iphmx.com [207.54.72.35])
 by mx.groups.io with SMTP id smtpd.web11.11011.1730281678611358903
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Oct 2024 02:48:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=EewkpGyv;
 spf=pass (domain: bmw.de, ip: 207.54.72.35, mailfrom: prvs=026b2e8c7=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1730281681; x=1761817681;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z2Ya6ucPo7upgfx8zy9FezBiq2KlRSIN7rakHRPFcRw=;
  b=EewkpGyv9UxKQZVJXql6ERI8RRL0nFzP2/wGD5K3jHmuWRpbX/2XFY/N
   8Lgt28vsRHP1cxNsU4Fcep7Fw6Ml52YZAD+/tOapfGOfCaYBg9urQJzpP
   Py83DaDBRobBKkT1Lyme+0oMOvUtLMDG4eCGC08+StW0sQRE1/JKHEJKH
   Y=;
X-CSE-ConnectionGUID: 32iDGmuGRoGj3VPr8KZ9kg==
X-CSE-MsgGUID: bRUzpaXeQDazO+yMz77abA==
Received: from esagw5.bmwgroup.com (HELO esagw5.muc) ([160.46.252.46]) by
 esa13.hc324-48.eu.iphmx.com with ESMTP/TLS; 30 Oct 2024 10:48:00 +0100
Received: from esabb2.muc ([160.50.100.34])  by esagw5.muc with ESMTP/TLS;
 30 Oct 2024 10:48:00 +0100
Received: from smucmp10e.bmwgroup.net (HELO SMUCMP10E.europe.bmw.corp) ([10.30.13.87])
 by esabb2.muc with ESMTP/TLS; 30 Oct 2024 10:30:57 +0100
Received: from localhost.localdomain (10.30.85.211) by SMUCMP10E.europe.bmw.corp
 (2a03:1e80:a15:58f::2027) with Microsoft SMTP Server (version=TLS;
 Wed, 30 Oct 2024 10:30:56 +0100
X-CSE-ConnectionGUID: 6N9YhqoWTwa7F9cXxTEarw==
X-CSE-MsgGUID: AyRX12+sQjiLayMjLgOvZQ==
X-CSE-ConnectionGUID: dYNhAhu1QsGGjvktt8z+lA==
X-CSE-MsgGUID: J7CixgGkQxORtGqoRLz39Q==
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: <steve@sakoman.com>, Philip Lorenz <philip.lorenz@bmw.de>
Subject: [2.0][PATCH 1/1] codeparser: Fix handling of string AST nodes with older Python versions
Date: Wed, 30 Oct 2024 10:26:43 +0100
Message-ID: <20241030092643.1598956-2-philip.lorenz@bmw.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030092643.1598956-1-philip.lorenz@bmw.de>
References: <20241030092643.1598956-1-philip.lorenz@bmw.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SMUCMP08H.europe.bmw.corp (2a03:1e80:a15:58f::1:1d) To
 SMUCMP10E.europe.bmw.corp (2a03:1e80:a15:58f::2027)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 09:48:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16743

Commits 4591011449212c8e494ea42348acb2d27a82a51b and
6c19b6cf105ac321ec89da1a876a317020c45ab7 unconditionally changed
codeparser to rely on CPython 3.8 semantics. However, kirkstone
continues to support CPython versions >= 3.6.0 and as such string AST
nodes were no longer correctly identified.

Fix this by continuing to use `ast.Str` for Python versions < 3.8.0 and
only using the new code path for more recent versions. Detecting which
version of the AST API to use seems to be non-trivial so the Python
feature version is used instead.

Instances of this issue can be identified when executing bitbake with
debug logging:

    while parsing MACHINE_ARCH, in call of d.getVar, argument
        ''TUNE_PKGARCH'' is not a string literal

As a consequence of these parsing issues, bitbake may assume that task
inputs haven't changed and as such erroneously reuse sstate objects when
it shouldn't.

Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
---
 lib/bb/codeparser.py | 46 +++++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 6ce0c5182..39dba266c 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -201,6 +201,22 @@ class DummyLogger():
     def flush(self):
         return
 
+
+# Starting with Python 3.8, the ast module exposes all string nodes as a
+# Constant. While earlier versions of the module also have the Constant type
+# those use the Str type to encapsulate strings.
+if sys.version_info < (3, 8):
+    def node_str_value(node):
+        if isinstance(node, ast.Str):
+            return node.s
+        return None
+else:
+    def node_str_value(node):
+        if isinstance(node, ast.Constant) and isinstance(node.value, str):
+            return node.value
+        return None
+
+
 class PythonParser():
     getvars = (".getVar", ".appendVar", ".prependVar", "oe.utils.conditional")
     getvarflags = (".getVarFlag", ".appendVarFlag", ".prependVarFlag")
@@ -225,19 +241,22 @@ class PythonParser():
     def visit_Call(self, node):
         name = self.called_node_name(node.func)
         if name and (name.endswith(self.getvars) or name.endswith(self.getvarflags) or name in self.containsfuncs or name in self.containsanyfuncs):
-            if isinstance(node.args[0], ast.Constant) and isinstance(node.args[0].value, str):
-                varname = node.args[0].value
-                if name in self.containsfuncs and isinstance(node.args[1], ast.Constant):
+            varname = node_str_value(node.args[0])
+            if varname is not None:
+                arg_str_value = None
+                if len(node.args) >= 2:
+                    arg_str_value = node_str_value(node.args[1])
+                if name in self.containsfuncs and arg_str_value is not None:
                     if varname not in self.contains:
                         self.contains[varname] = set()
-                    self.contains[varname].add(node.args[1].value)
-                elif name in self.containsanyfuncs and isinstance(node.args[1], ast.Constant):
+                    self.contains[varname].add(arg_str_value)
+                elif name in self.containsanyfuncs and arg_str_value is not None:
                     if varname not in self.contains:
                         self.contains[varname] = set()
-                    self.contains[varname].update(node.args[1].value.split())
+                    self.contains[varname].update(arg_str_value.split())
                 elif name.endswith(self.getvarflags):
-                    if isinstance(node.args[1], ast.Constant):
-                        self.references.add('%s[%s]' % (varname, node.args[1].value))
+                    if arg_str_value is not None:
+                        self.references.add('%s[%s]' % (varname, arg_str_value))
                     else:
                         self.warn(node.func, node.args[1])
                 else:
@@ -245,10 +264,10 @@ class PythonParser():
             else:
                 self.warn(node.func, node.args[0])
         elif name and name.endswith(".expand"):
-            if isinstance(node.args[0], ast.Constant):
-                value = node.args[0].value
+            arg_str_value = node_str_value(node.args[0])
+            if arg_str_value is not None:
                 d = bb.data.init()
-                parser = d.expandWithRefs(value, self.name)
+                parser = d.expandWithRefs(arg_str_value, self.name)
                 self.references |= parser.references
                 self.execs |= parser.execs
                 for varname in parser.contains:
@@ -256,8 +275,9 @@ class PythonParser():
                         self.contains[varname] = set()
                     self.contains[varname] |= parser.contains[varname]
         elif name in self.execfuncs:
-            if isinstance(node.args[0], ast.Constant):
-                self.var_execs.add(node.args[0].value)
+            arg_str_value = node_str_value(node.args[0])
+            if arg_str_value is not None:
+                self.var_execs.add(arg_str_value)
             else:
                 self.warn(node.func, node.args[0])
         elif name and isinstance(node.func, (ast.Name, ast.Attribute)):
-- 
2.47.0


