Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RNphy-0006FV-NL
	for bitbake-devel@lists.openembedded.org;
	Tue, 08 Nov 2011 18:43:38 +0100
Received: by opal (Postfix, from userid 111)
	id 6A34B10334; Tue,  8 Nov 2011 17:37:54 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111108173754.6A34B10334@opal>
Date: Tue,  8 Nov 2011 17:37:54 +0000 (UTC)
From: git@git.openembedded.org
Subject: Christopher Larson : codeparser: drop expand tracking
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
X-List-Received-Date: Tue, 08 Nov 2011 17:43:38 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 405dfe69e6a608826e599ebf2f83ef8cf5083b96
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=405dfe69e6a608826e599ebf2f83ef8cf5083b96

Author: Christopher Larson <chris_larson@mentor.com>
Date:   Fri Oct 28 23:06:18 2011 -0400

codeparser: drop expand tracking

There are two usual cases involving bb.data.expand:

- Calling it with a string literal -- "bb.data.expand('${FOO}/${BAZ}/bleh', d)".
- Calling it on getVar results (legacy) -- "bb.data.expand(bb.data.getVar('FOO', d), d)"

Nothing in any of the usual layers uses it in any other way, and I'm
having trouble coming up with any real use cases beyond this. The first
of the above cases is already tracked, via the expandWithRefs called
on the python code string. The second didn't emit a warning anyway,
since the getVar was already handled.

Given this, I see no reason for us to maintain explicit expansion
tracking. Further, we weren't using its results anyway (the var_expands
member).

Signed-off-by: Christopher Larson <chris_larson@mentor.com>

---

 lib/bb/codeparser.py |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 9a692a0..615fb7d 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -152,7 +152,6 @@ def parser_cache_savemerge(d):
 
 class PythonParser():
     getvars = ("d.getVar", "bb.data.getVar", "data.getVar")
-    expands = ("d.expand", "bb.data.expand", "data.expand")
     execfuncs = ("bb.build.exec_func", "bb.build.exec_task")
 
     def warn(self, func, arg):
@@ -176,15 +175,6 @@ class PythonParser():
                 self.var_references.add(node.args[0].s)
             else:
                 self.warn(node.func, node.args[0])
-        elif name in self.expands:
-            if isinstance(node.args[0], ast.Str):
-                self.warn(node.func, node.args[0])
-                self.var_expands.add(node.args[0].s)
-            elif isinstance(node.args[0], ast.Call) and \
-                 self.called_node_name(node.args[0].func) in self.getvars:
-                pass
-            else:
-                self.warn(node.func, node.args[0])
         elif name in self.execfuncs:
             if isinstance(node.args[0], ast.Str):
                 self.var_execs.add(node.args[0].s)
@@ -210,7 +200,6 @@ class PythonParser():
         self.var_references = set()
         self.var_execs = set()
         self.execs = set()
-        self.var_expands = set()
         self.references = set()
 
         self.unhandled_message = "in call of %s, argument '%s' is not a string literal"



