Return-Path: <kergoth@gmail.com>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
	[209.85.192.196])
	by mail.openembedded.org (Postfix) with ESMTP id 8EF546FF60
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 19:52:52 +0000 (UTC)
Received: by mail-pf0-f196.google.com with SMTP id 145so15351710pfz.1
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 12:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=+d5qwHB4kATR8hdiLu+W0yh0bYKNQMgyT8kjDS2QpfM=;
	b=YWD6KD56N6VDPJ/rwAsWr9w7zBD0ska4tfnq9Jer/1IIwpt9LDuNEmFDDMeTbu+m2g
	pHg3zsaEM158ycVD7qnOrFg29JEP73kg7zA2gB6xOmurno+QZ9Z9c9BLPE2W7BMcTtO5
	mHOEDWKsn4zq0UjCxYf1I9N70ZjwlrYQJG1x2hdSdRSosoHQ3X5eAMsU0jBka96AAAH3
	mkXL3cGzRKKLTkV/S6tnRx4t3Wm6JmSNZJe5pel0tshPLFZJms4/U6NhGxc1vpYBcV5o
	4i/BShokUUAg+9Z6UjDphoffnvUCIF4q9tSfcqKuVD6hM5hbB7AQbt48H84pYculYmbL
	O5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=+d5qwHB4kATR8hdiLu+W0yh0bYKNQMgyT8kjDS2QpfM=;
	b=PgA5oG3agrZfHa3zrHMZ/LWrMt0vfHphepvWbhDAfOd95x+R/AjsutdRoC8v84UVWq
	DyU79UI8Hoh3+yrFSO5cbtcdHziX/e0//wgV1uENHYqpuZ0tNwe8xlyuDrdKXhuUR32Q
	oxa/dR/6iOznNPaMZuWXSuKwo38r1MyZB/3Oid2DdmjSIwPSXyuUzr2GKULqGVEr9Qcm
	Ga1Hyx32XwLvnIel0s6Oadg9PzbIiy5Y6/Xqj1GO5RGhr/X1qIWF2xvciTJZ6SkQm9Sb
	wVkH51m35KxcOkoqK6b7iNTvaco8guvHWh/inlcL/JDC0iKFQ2BiVDOSkyLoP/xhKCPf
	c/BQ==
X-Gm-Message-State: AOPr4FUGjxydSqhA6xwqC+s4v2z1vRRTyDThV8url669lKr+iVyTZ8s1zEU4uuFib2nh+A==
X-Received: by 10.98.44.70 with SMTP id s67mr39175193pfs.59.1462045973323;
	Sat, 30 Apr 2016 12:52:53 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	z2sm33247522pfa.90.2016.04.30.12.52.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 30 Apr 2016 12:52:51 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 30 Apr 2016 12:52:45 -0700
Message-Id: <1462045969-14538-1-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 2.8.0
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [master][PATCH] bb.codeparser: track variable flag references
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
X-List-Received-Date: Sat, 30 Apr 2016 19:52:55 -0000

From: Christopher Larson <chris_larson@mentor.com>

Previously we only tracked the flags (minus excluded) of variables we depend
on, but not the flags we use explicitly.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/codeparser.py | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 3ee4d56..2980510 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -191,6 +191,7 @@ class BufferedLogger(Logger):
 
 class PythonParser():
     getvars = (".getVar", ".appendVar", ".prependVar")
+    getvarflags = (".getVarFlag", ".appendVarFlag", ".prependVarFlag")
     containsfuncs = ("bb.utils.contains", "base_contains", "bb.utils.contains_any")
     execfuncs = ("bb.build.exec_func", "bb.build.exec_task")
 
@@ -210,15 +211,20 @@ class PythonParser():
 
     def visit_Call(self, node):
         name = self.called_node_name(node.func)
-        if name and name.endswith(self.getvars) or name in self.containsfuncs:
+        if name and (name.endswith(self.getvars) or name.endswith(self.getvarflags) or name in self.containsfuncs):
             if isinstance(node.args[0], ast.Str):
                 varname = node.args[0].s
                 if name in self.containsfuncs and isinstance(node.args[1], ast.Str):
                     if varname not in self.contains:
                         self.contains[varname] = set()
                     self.contains[varname].add(node.args[1].s)
-                else:                      
-                    self.references.add(node.args[0].s)
+                elif name.endswith(self.getvarflags):
+                    if isinstance(node.args[1], ast.Str):
+                        self.references.add('%s[%s]' % (varname, node.args[1].s))
+                    else:
+                        self.warn(node.func, node.args[1])
+                else:
+                    self.references.add(varname)
             else:
                 self.warn(node.func, node.args[0])
         elif name and name.endswith(".expand"):
-- 
2.8.0


