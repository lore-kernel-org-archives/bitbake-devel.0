Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RJfN9-0004GM-KZ
	for bitbake-devel@lists.openembedded.org;
	Fri, 28 Oct 2011 07:52:55 +0200
Received: by opal (Postfix, from userid 111)
	id D353B10329; Fri, 28 Oct 2011 05:52:29 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111028055229.D353B10329@opal>
Date: Fri, 28 Oct 2011 05:52:29 +0000 (UTC)
From: git@git.openembedded.org
X-Mailman-Approved-At: Tue, 01 Nov 2011 08:48:59 +0100
Subject: Christopher Larson : codeparser: make var_expands actually hold useful information
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
X-List-Received-Date: Fri, 28 Oct 2011 05:52:55 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 8e4e75383e43d6da2c16ec5286186a0d0569b0f8
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=8e4e75383e43d6da2c16ec5286186a0d0569b0f8

Author: Christopher Larson <kergoth@gmail.com>
Date:   Thu Oct 27 22:45:04 2011 -0700

codeparser: make var_expands actually hold useful information

Previously, it was calling var_expands.update() rather than add(), with
a string argument, resulting in adding each character of that string to
the var_expands set, rather than the string itself.

Signed-off-by: Christopher Larson <kergoth@gmail.com>

---

 lib/bb/codeparser.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 83bbb92..0dd9a36 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -227,7 +227,7 @@ class PythonParser():
             elif self.compare_name(self.expands, node.func):
                 if isinstance(node.args[0], ast.Str):
                     self.warn(node.func, node.args[0])
-                    self.var_expands.update(node.args[0].s)
+                    self.var_expands.add(node.args[0].s)
                 elif isinstance(node.args[0], ast.Call) and \
                      self.compare_name(self.getvars, node.args[0].func):
                     pass



