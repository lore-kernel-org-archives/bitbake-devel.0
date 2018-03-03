Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 0A48E78A55
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  3 Mar 2018 17:09:06 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w23H95vl025447
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Sat, 3 Mar 2018 17:09:06 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1esAef-0003MF-DI; Sat, 03 Mar 2018 17:09:05 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Sat,  3 Mar 2018 17:09:03 +0000
Message-Id: <1520096944-12868-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: clamav-milter 0.99.3 at dan
X-Virus-Status: Clean
Subject: [PATCH 1/2] parse/ast: Abstract anonymous function execution into a function
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
X-List-Received-Date: Sat, 03 Mar 2018 17:09:07 -0000

This allows us to call this code from other contexts without
duplicating it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/parse/ast.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index dba4540..6690dc5 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -335,6 +335,12 @@ def handleInherit(statements, filename, lineno, m):
     classes = m.group(1)
     statements.append(InheritNode(filename, lineno, classes))
 
+def runAnonFuncs(d):
+    code = []
+    for funcname in d.getVar("__BBANONFUNCS", False) or []:
+        code.append("%s(d)" % funcname)
+    bb.utils.better_exec("\n".join(code), {"d": d})
+
 def finalize(fn, d, variant = None):
     saved_handlers = bb.event.get_handlers().copy()
 
@@ -349,10 +355,7 @@ def finalize(fn, d, variant = None):
     bb.event.fire(bb.event.RecipePreFinalise(fn), d)
 
     bb.data.expandKeys(d)
-    code = []
-    for funcname in d.getVar("__BBANONFUNCS", False) or []:
-        code.append("%s(d)" % funcname)
-    bb.utils.better_exec("\n".join(code), {"d": d})
+    runAnonFuncs(d)
 
     tasklist = d.getVar('__BBTASKS', False) or []
     bb.event.fire(bb.event.RecipeTaskPreProcess(fn, list(tasklist)), d)
-- 
2.7.4


