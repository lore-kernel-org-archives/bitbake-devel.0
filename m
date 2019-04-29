Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 5F6C57DA05
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Apr 2019 08:12:42 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x3T8Chid019008
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Apr 2019 01:12:43 -0700 (PDT)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.439.0; Mon, 29 Apr 2019 01:12:42 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 29 Apr 2019 16:11:58 +0800
Message-ID: <caa13d807d28103cd498db87ff3eb90d064dfaa5.1556525357.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1556525357.git.liezhi.yang@windriver.com>
References: <cover.1556525357.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH V2 1/3] bitbake: BBHandler: Fix addtask and deltask
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
X-List-Received-Date: Mon, 29 Apr 2019 08:12:42 -0000
Content-Type: text/plain

The following commands are not supported, but they were ignored silently, that
may suprise users:

* addtask task1 task2
  task2 is ignored

* addtask task1 before task2 before task3
  Should be: addtask task1 before task2 task3

* addtask task1 after task2 after task3
  Should be: addtask task1 after task2 task3

* deltask task1 task2
  task2 is ignore

This patch can check and warn for them.

[YOCTO #13282]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/parse/parse_py/BBHandler.py | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py b/bitbake/lib/bb/parse/parse_py/BBHandler.py
index 9dba5f2..314e802 100644
--- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
@@ -42,7 +42,7 @@ __func_start_regexp__    = re.compile(r"(((?P<py>python)|(?P<fr>fakeroot))\s*)*(
 __inherit_regexp__       = re.compile(r"inherit\s+(.+)" )
 __export_func_regexp__   = re.compile(r"EXPORT_FUNCTIONS\s+(.+)" )
 __addtask_regexp__       = re.compile(r"addtask\s+(?P<func>\w+)\s*((before\s*(?P<before>((.*(?=after))|(.*))))|(after\s*(?P<after>((.*(?=before))|(.*)))))*")
-__deltask_regexp__       = re.compile(r"deltask\s+(?P<func>\w+)")
+__deltask_regexp__       = re.compile(r"deltask\s+(?P<func>\w+)(?P<ignores>.*)")
 __addhandler_regexp__    = re.compile(r"addhandler\s+(.+)" )
 __def_regexp__           = re.compile(r"def\s+(\w+).*:" )
 __python_func_regexp__   = re.compile(r"(\s+.*)|(^$)|(^#)" )
@@ -236,11 +236,27 @@ def feeder(lineno, s, fn, root, statements, eof=False):
 
     m = __addtask_regexp__.match(s)
     if m:
+        if len(m.group().split()) == 2:
+            # Check and warn for "addtask task1 task2"
+            m2 = re.match(r"addtask\s+(?P<func>\w+)(?P<ignores>.*)", s)
+            if m2 and m2.group('ignores'):
+                logger.warning('addtask ignored: "%s"' % m2.group('ignores'))
+
+        # Check and warn for "addtask task1 before task2 before task3", the
+        # similar to "after"
+        taskexpression = s.split()
+        for word in ('before', 'after'):
+            if taskexpression.count(word) > 1:
+                logger.warning("addtask contained multiple '%s' keywords, only one is supported" % word)
+
         ast.handleAddTask(statements, fn, lineno, m)
         return
 
     m = __deltask_regexp__.match(s)
     if m:
+        # Check and warn "for deltask task1 task2"
+        if m.group('ignores'):
+            logger.warning('deltask ignored: "%s"' % m.group('ignores'))
         ast.handleDelTask(statements, fn, lineno, m)
         return
 
-- 
2.7.4


