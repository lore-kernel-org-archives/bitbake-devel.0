Return-Path: <ddalex@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id BD19C6D684
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Nov 2013 10:53:40 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 14 Nov 2013 02:53:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,699,1378882800"; d="scan'208";a="433318188"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga002.fm.intel.com with ESMTP; 14 Nov 2013 02:53:03 -0800
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 1B350560479; Thu, 14 Nov 2013 10:53:03 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 14 Nov 2013 10:52:58 +0000
Message-Id: <1384426381-7869-3-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1384426381-7869-1-git-send-email-alexandru.damian@intel.com>
References: <1384426381-7869-1-git-send-email-alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 2/5] toaster: fix tasks showing as NoExec
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
X-List-Received-Date: Thu, 14 Nov 2013 10:53:40 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Tasks without script type information showed by default
as NoExec; this happens for all Prebuild or Covered
tasks, as script type information comes only on TaskStarted
event. Such a default value may drive confusion, as NoExec value
should be reserved for the NoExec-flagged tasks.

This patch adds a new default value named Unknown that will be
used for all tasks that don't have script type information
available.

    [YOCTO #5327]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/orm/models.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 2ae0b51..a3df990 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -74,11 +74,13 @@ class Task(models.Model):
         (SSTATE_RESTORED, 'Restored'), # succesfully restored
     )
 
-    CODING_NOEXEC = 0
-    CODING_PYTHON = 1
-    CODING_SHELL = 2
+    CODING_NA = 0
+    CODING_NOEXEC = 1
+    CODING_PYTHON = 2
+    CODING_SHELL = 3
 
     TASK_CODING = (
+        (CODING_NA, 'N/A'),
         (CODING_NOEXEC, 'NoExec'),
         (CODING_PYTHON, 'Python'),
         (CODING_SHELL, 'Shell'),
@@ -110,7 +112,7 @@ class Task(models.Model):
     task_name = models.CharField(max_length=100)
     source_url = models.FilePathField(max_length=255, blank=True)
     work_directory = models.FilePathField(max_length=255, blank=True)
-    script_type = models.IntegerField(choices=TASK_CODING, default=CODING_NOEXEC)
+    script_type = models.IntegerField(choices=TASK_CODING, default=CODING_NA)
     line_number = models.IntegerField(default=0)
     disk_io = models.IntegerField(null=True)
     cpu_usage = models.DecimalField(max_digits=6, decimal_places=2, null=True)
-- 
1.8.3.2


