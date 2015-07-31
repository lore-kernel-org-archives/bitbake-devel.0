Return-Path: <kergoth@gmail.com>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
	[209.85.220.51])
	by mail.openembedded.org (Postfix) with ESMTP id 91FEE765AB
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 17:31:50 +0000 (UTC)
Received: by pabkd10 with SMTP id kd10so44110835pab.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 10:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=qMsIaGFu/A2jB7NrhwBztPexRkzHI/U5UrN79eo5TPM=;
	b=Cjkp8wC6PQL58jvhHI8UpWb9hX/NmFAo3CcpYoyyIagKRuoQy/xCXDtdAECINywbWs
	Xwj8sQc1GDqHiKkelgsIfmufHNkbhpb0JQktYgo12ADWHypAMZqwAgSb4nxKFbFfkUhf
	clxRdbygd41paPb/OfHp5iqqvp7r4HaL+59X5J2xs3Zsx+Jn5Ot/9pKz/uQoWD9Kv1rH
	WFj5qY24bcNVU0uz/sHT525mC4uzNVtCtnvCYEQf8QARu9hVN59LlwC20N4b8QsCF/ml
	cnL6ZSYhwM4o1CY/nkG0qwRCCZWv2eDyJA9gp0b4dSXZML96/jfwbKy6v3eh0bsQ+OYu
	OygQ==
X-Received: by 10.66.197.234 with SMTP id ix10mr9060388pac.152.1438363911274; 
	Fri, 31 Jul 2015 10:31:51 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	de2sm8805005pdb.15.2015.07.31.10.31.49
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 31 Jul 2015 10:31:50 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 Jul 2015 10:31:33 -0700
Message-Id: <1438363893-11812-1-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 2.2.1
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH] bb.build: let addtask undo a deltask
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
X-List-Received-Date: Fri, 31 Jul 2015 17:31:54 -0000

From: Christopher Larson <chris_larson@mentor.com>

While we're in that part of the code, also fix 'not foo in bar' to 'foo not in
bar', as is preferred in python.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/build.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 764163f..866056b 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -736,9 +736,14 @@ def addtask(task, before, after, d):
     if task[:3] != "do_":
         task = "do_" + task
 
+    deltasks = d.getVar('__BBDELTASKS', False)
+    if deltasks and task in deltasks:
+        deltasks.remove(task)
+        d.setVar('__BBDELTASKS', deltasks)
+
     d.setVarFlag(task, "task", 1)
     bbtasks = d.getVar('__BBTASKS', False) or []
-    if not task in bbtasks:
+    if task not in bbtasks:
         bbtasks.append(task)
     d.setVar('__BBTASKS', bbtasks)
 
@@ -761,7 +766,7 @@ def deltask(task, d):
         task = "do_" + task
 
     bbtasks = d.getVar('__BBDELTASKS', False) or []
-    if not task in bbtasks:
+    if task not in bbtasks:
         bbtasks.append(task)
     d.setVar('__BBDELTASKS', bbtasks)
 
-- 
2.2.1


