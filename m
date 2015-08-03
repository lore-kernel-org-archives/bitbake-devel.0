Return-Path: <kergoth@gmail.com>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
	[209.85.220.51])
	by mail.openembedded.org (Postfix) with ESMTP id 17D5B73D13
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Aug 2015 19:21:03 +0000 (UTC)
Received: by pasy3 with SMTP id y3so21101076pas.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 03 Aug 2015 12:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=trhiq54aeY/egZ3NLfEGM7DF+cyuz/TA2gRRuJTCm50=;
	b=D/WDvgf5I73/zKdfpvLg2KmPlnqiaGnlXKa6/rEZQvXq1ysVzM45YPETMXdsAzpOu6
	aVincX8M95lt7ZxBxqwJ8bWGizB3LOPfih2cPu1ZhQh24j0nhKrVifqNXsswuk7rMai5
	kIVqznuf/7f5u++uOkXYwKdhjymjkJ7Fsb9sNZOHBFaxNqhhmWroKBl/yJelskA/WKxt
	CABCLvpnJmg35GxW58YrsxeqzIiQeJU0RutyLH162mYYKSw7QMHSSRbH+Nebbk7xgyLg
	5vvbOpuUw3b0h6u4T4a9lKi4bICKhd7bp5FZMYqNAIPM0Cw7+7Ku4zjKULRgRXrQF/VZ
	33wg==
X-Received: by 10.66.62.133 with SMTP id y5mr39359280par.8.1438629663766;
	Mon, 03 Aug 2015 12:21:03 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	a5sm18300098pdk.90.2015.08.03.12.21.01
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 03 Aug 2015 12:21:02 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  3 Aug 2015 12:20:43 -0700
Message-Id: <1438629643-28786-1-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 2.2.1
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH] bb.build: delete tasks thoroughly
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
X-List-Received-Date: Mon, 03 Aug 2015 19:21:06 -0000

From: Christopher Larson <chris_larson@mentor.com>

We want addtask to be able to bring back a deleted task, but we don't want its
previous dependencies to come back with it, so rather than marking a task as
deleted and then skipping tasks marked as such, actually delete the task and
its dependency information in deltask.

While we're in that part of the code, also fix a couple 'not foo in bar'
instances to 'foo not in bar', which is preferred in python.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/build.py     | 23 +++++++++++++----------
 lib/bb/parse/ast.py |  3 +--
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 764163f..948c395 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -686,7 +686,7 @@ def stampfile(taskname, d, file_name = None):
     """
     return stamp_internal(taskname, d, file_name)
 
-def add_tasks(tasklist, deltasklist, d):
+def add_tasks(tasklist, d):
     task_deps = d.getVar('_task_deps', False)
     if not task_deps:
         task_deps = {}
@@ -698,9 +698,6 @@ def add_tasks(tasklist, deltasklist, d):
     for task in tasklist:
         task = d.expand(task)
 
-        if task in deltasklist:
-            continue
-
         d.setVarFlag(task, 'task', 1)
 
         if not task in task_deps['tasks']:
@@ -738,7 +735,7 @@ def addtask(task, before, after, d):
 
     d.setVarFlag(task, "task", 1)
     bbtasks = d.getVar('__BBTASKS', False) or []
-    if not task in bbtasks:
+    if task not in bbtasks:
         bbtasks.append(task)
     d.setVar('__BBTASKS', bbtasks)
 
@@ -760,8 +757,14 @@ def deltask(task, d):
     if task[:3] != "do_":
         task = "do_" + task
 
-    bbtasks = d.getVar('__BBDELTASKS', False) or []
-    if not task in bbtasks:
-        bbtasks.append(task)
-    d.setVar('__BBDELTASKS', bbtasks)
-
+    bbtasks = d.getVar('__BBTASKS', False) or []
+    if task in bbtasks:
+        bbtasks.remove(task)
+        d.setVar('__BBTASKS', bbtasks)
+
+    d.delVarFlag(task, 'deps')
+    for bbtask in d.getVar('__BBTASKS', False) or []:
+        deps = d.getVarFlag(bbtask, 'deps') or []
+        if task in deps:
+            deps.remove(task)
+            d.setVarFlag(bbtask, 'deps', deps)
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index bd42bd3..11db180 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -330,8 +330,7 @@ def finalize(fn, d, variant = None):
     bb.data.update_data(d)
 
     tasklist = d.getVar('__BBTASKS', False) or []
-    deltasklist = d.getVar('__BBDELTASKS', False) or []
-    bb.build.add_tasks(tasklist, deltasklist, d)
+    bb.build.add_tasks(tasklist, d)
 
     bb.parse.siggen.finalise(fn, d, variant)
 
-- 
2.2.1


