Return-Path: <patrick.ohly@intel.com>
Received: from mail-it0-f53.google.com (mail-it0-f53.google.com
	[209.85.214.53])
	by mail.openembedded.org (Postfix) with ESMTP id 186E960670
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 Nov 2016 09:39:20 +0000 (UTC)
Received: by mail-it0-f53.google.com with SMTP id c20so72454822itb.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 Nov 2016 01:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=OzZmPVnT6JMllBA7n6DOd/yx4W0hh70SsUWivcri9nU=;
	b=zKYkbJ/V2v8mkdKI/RilhQRYaT32RZ9VYSQH/i2R1lVctbQgxmTAXSntO+3MtnhBhL
	CfrsykjrSjDZOE+VNVom3iyebJhJbOEBk/phjgxYhK4Igh9Y6+POwc35BSKWfLEdR1gR
	4a+ugUGk8SzPepacTpOnbKpGnxNM1oBiaUVjxsZUeK4lUfJ91ANrAqkUTEMehabm005R
	eryLDqZF15KnqAfnXXN6CLjuTc+hAJfwTHqCWXgI8Mvr/jjm9TJZvfafjdWtnx2HRp5b
	UvPnN9U9tQz5TnqS2rtuYYk5Vb6G09o+D2R5vbOZazSO4gnUc/HeNkgGhZ87oxLsu2D/
	bjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=OzZmPVnT6JMllBA7n6DOd/yx4W0hh70SsUWivcri9nU=;
	b=FGatT9nxvPWwE1qG2KaIhttf/t7VsKMYQUEa0UGnhJVot8x/VMAG4I13EnM/0DQsi1
	fHMT565RG2eYW30jbDF3oTLQsf6E/7ey49x8kkxkU2FRjX0/+Lsm44K59/9HwBaQd+BT
	UmP3Aw6sCPmHbQS3fIG57P/hr3scqdel17AlMZRx1ijFvGKZih4yV0a1TvTyr0gY4mCb
	DCNdljvdLQ50DiI7u9+HXiROI6LkAXimLTtAgtzYa7epsKINoH4Vua0JbZ//h6c00exb
	3dyMjr8aEUhDjLiE0iTn915uNZN5eyVodDhMBNlxmJaPTxc7g3ZWC5ZMd36kP93htWQy
	C+6g==
X-Gm-Message-State: ABUngvdXfWR5+2+GAvMTvsZb32pq7b9FtUPepF4YjE3H5820t+mHL53tZyjby1DsW975Ubjp
X-Received: by 10.36.106.133 with SMTP id l127mr5937953itc.121.1479116362014; 
	Mon, 14 Nov 2016 01:39:22 -0800 (PST)
Received: from pohly-desktop.fritz.box (p5DE8FC67.dip0.t-ipconnect.de.
	[93.232.252.103]) by smtp.gmail.com with ESMTPSA id
	h127sm1500261ioa.41.2016.11.14.01.39.20
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 14 Nov 2016 01:39:21 -0800 (PST)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 14 Nov 2016 10:39:14 +0100
Message-Id: <1479116354-5043-1-git-send-email-patrick.ohly@intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] taskdata.py: improve handling of depends/rdepends
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
X-List-Received-Date: Mon, 14 Nov 2016 09:39:21 -0000

Error handling only caught the cause where a dependency did not have
any colon, but ignored the case where more than one was given. Now
"pn:task:garbage" will raise an error instead of ignoring ":garbage".

The error message had a misplaced line break (?) with the full stop
on the next line. Indenting the explanation with a space might have
been intended and is kept.

split() was called three times instead of just once.

Instead of improving the two instances of the code (one for 'depends',
one for 'rdepends'), the common code is now in a helper function.

Signed-off-by: Patrick Ohly <patrick.ohly@intel.com>
---
 lib/bb/taskdata.py | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/lib/bb/taskdata.py b/lib/bb/taskdata.py
index d8bdbca..1f3b24c 100644
--- a/lib/bb/taskdata.py
+++ b/lib/bb/taskdata.py
@@ -89,6 +89,19 @@ class TaskData:
 
         self.add_extra_deps(fn, dataCache)
 
+        # Common code for dep_name/depends = 'depends'/idepends and 'rdepends'/irdepends
+        def handle_deps(task, dep_name, depends, seen):
+            if dep_name in task_deps and task in task_deps[dep_name]:
+                ids = []
+                for dep in task_deps[dep_name][task].split():
+                    if dep:
+                        parts = dep.split(":")
+                        if len(parts) != 2:
+                            bb.msg.fatal("TaskData", "Error for %s, dependency %s does not contain exactly one ':' character.\n Task '%s' should be specified in the form 'packagename:task'" % (fn, dep, dep_name))
+                        ids.append((parts[0], parts[1]))
+                        seen(parts[0])
+                depends.extend(ids)
+
         for task in task_deps['tasks']:
 
             tid = "%s:%s" % (fn, task)
@@ -105,24 +118,8 @@ class TaskData:
             self.taskentries[tid].tdepends.extend(parentids)
 
             # Touch all intertask dependencies
-            if 'depends' in task_deps and task in task_deps['depends']:
-                ids = []
-                for dep in task_deps['depends'][task].split():
-                    if dep:
-                        if ":" not in dep:
-                            bb.msg.fatal("TaskData", "Error for %s, dependency %s does not contain ':' character\n. Task 'depends' should be specified in the form 'packagename:task'" % (fn, dep))
-                        ids.append(((dep.split(":")[0]), dep.split(":")[1]))
-                        self.seen_build_target(dep.split(":")[0])
-                self.taskentries[tid].idepends.extend(ids)
-            if 'rdepends' in task_deps and task in task_deps['rdepends']:
-                ids = []
-                for dep in task_deps['rdepends'][task].split():
-                    if dep:
-                        if ":" not in dep:
-                            bb.msg.fatal("TaskData", "Error for %s, dependency %s does not contain ':' character\n. Task 'rdepends' should be specified in the form 'packagename:task'" % (fn, dep))
-                        ids.append(((dep.split(":")[0]), dep.split(":")[1]))
-                        self.seen_run_target(dep.split(":")[0])
-                self.taskentries[tid].irdepends.extend(ids)
+            handle_deps(task, 'depends', self.taskentries[tid].idepends, self.seen_build_target)
+            handle_deps(task, 'rdepends', self.taskentries[tid].irdepends, self.seen_run_target)
 
         # Work out build dependencies
         if not fn in self.depids:
-- 
2.1.4


