Return-Path: <ola.x.nilsson@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id F258878F72
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Oct 2019 09:07:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id C6696182F4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Oct 2019 11:07:07 +0200 (CEST)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id zye0rLXjCmHQ for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Oct 2019 11:07:06 +0200 (CEST)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
	by bastet.se.axis.com (Postfix) with ESMTPS id 0F5941831E
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Oct 2019 11:07:06 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8621F1E077
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Oct 2019 11:07:05 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 798231E076
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Oct 2019 11:07:05 +0200 (CEST)
Received: from seth.se.axis.com (unknown [10.0.2.172])
	by boulder03.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Oct 2019 11:07:05 +0200 (CEST)
Received: from lnxolani1.se.axis.com (lnxolani1.se.axis.com [10.88.130.9])
	by seth.se.axis.com (Postfix) with ESMTP id 6D48B1A95
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Oct 2019 11:07:05 +0200 (CEST)
Received: by lnxolani1.se.axis.com (Postfix, from userid 20853)
	id 655E640AA1; Mon, 21 Oct 2019 11:07:05 +0200 (CEST)
From: Ola x Nilsson <ola.x.nilsson@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 21 Oct 2019 11:07:05 +0200
Message-Id: <20191021090705.31214-2-olani@axis.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191021090705.31214-1-olani@axis.com>
References: <20191021090705.31214-1-olani@axis.com>
X-TM-AS-GCONF: 00
Subject: [PATCH 2/2] bitbake: ConfHandler: Use with to manage filehandle lifetime
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
X-List-Received-Date: Mon, 21 Oct 2019 09:07:07 -0000

Signed-off-by: Ola x Nilsson <olani@axis.com>
---
 lib/bb/parse/parse_py/ConfHandler.py | 44 ++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index 2e84b913..af64d344 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -119,30 +119,30 @@ def handle(fn, data, include):
         oldfile = data.getVar('FILE', False)
 
     abs_fn = resolve_file(fn, data)
-    f = open(abs_fn, 'r')
+    with open(abs_fn, 'r') as f:
 
-    statements = ast.StatementGroup()
-    lineno = 0
-    while True:
-        lineno = lineno + 1
-        s = f.readline()
-        if not s:
-            break
-        w = s.strip()
-        # skip empty lines
-        if not w:
-            continue
-        s = s.rstrip()
-        while s[-1] == '\\':
-            s2 = f.readline().rstrip()
+        statements = ast.StatementGroup()
+        lineno = 0
+        while True:
             lineno = lineno + 1
-            if (not s2 or s2 and s2[0] != "#") and s[0] == "#" :
-                bb.fatal("There is a confusing multiline, partially commented expression on line %s of file %s (%s).\nPlease clarify whether this is all a comment or should be parsed." % (lineno, fn, s))
-            s = s[:-1] + s2
-        # skip comments
-        if s[0] == '#':
-            continue
-        feeder(lineno, s, abs_fn, statements)
+            s = f.readline()
+            if not s:
+                break
+            w = s.strip()
+            # skip empty lines
+            if not w:
+                continue
+            s = s.rstrip()
+            while s[-1] == '\\':
+                s2 = f.readline().rstrip()
+                lineno = lineno + 1
+                if (not s2 or s2 and s2[0] != "#") and s[0] == "#" :
+                    bb.fatal("There is a confusing multiline, partially commented expression on line %s of file %s (%s).\nPlease clarify whether this is all a comment or should be parsed." % (lineno, fn, s))
+                s = s[:-1] + s2
+            # skip comments
+            if s[0] == '#':
+                continue
+            feeder(lineno, s, abs_fn, statements)
 
     # DONE WITH PARSING... time to evaluate
     data.setVar('FILE', abs_fn)
-- 
2.11.0


