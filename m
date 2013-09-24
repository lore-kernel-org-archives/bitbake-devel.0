Return-Path: <ddalex@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id A47AC6CB9F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:19 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 24 Sep 2013 09:53:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,972,1371106800"; d="scan'208";a="364948535"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by azsmga001.ch.intel.com with ESMTP; 24 Sep 2013 09:53:11 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 0409E562389; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:20 +0100
Message-Id: <7bf2232c7d0930d7e55a923d2db720bd480e1267.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 51/94] bitbake: dsi: fix build stats data gathering
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:21 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We set the default values for build stats to be NULL so
that we can distinguish the value from a legitimate 0.

Also fixing the data gathering since model field semantics
changed - the version is kept on a separate field.

[YOCTO #4967]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py | 2 +-
 bitbake/lib/webhob/orm/models.py     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index 59b6fa3..1d8cb44 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -286,7 +286,7 @@ class BuildInfoHelper(object):
         target = self.internal_state['target']
         machine = self.internal_state['build'].machine.name
         buildname = self.internal_state['build'].build_name
-        package = task_object.recipe.name
+        package = task_object.recipe.name + "-" + task_object.recipe.version.strip(":")
 
         build_stats_path = build_stats_format.format(tmpdir=tmp_dir, target=target,
                                                      machine=machine, buildname=buildname,
diff --git a/bitbake/lib/webhob/orm/models.py b/bitbake/lib/webhob/orm/models.py
index 774cdff..f2cc7d9 100644
--- a/bitbake/lib/webhob/orm/models.py
+++ b/bitbake/lib/webhob/orm/models.py
@@ -84,8 +84,8 @@ class Task(models.Model):
     script_type = models.IntegerField(choices=TASK_CODING, default=CODING_PYTHON)
     line_number = models.IntegerField(default=0)
     py_stack_trace = models.TextField(null=True)
-    disk_io = models.IntegerField(default=0)
-    cpu_usage = models.DecimalField(max_digits=6, decimal_places=2, default=0)
+    disk_io = models.IntegerField(null=True)
+    cpu_usage = models.DecimalField(max_digits=6, decimal_places=2, null=True)
     elapsed_time = models.CharField(max_length=50, default=0)
     errors_no = models.IntegerField(default=0)
     warnings_no = models.IntegerField(default=0)
-- 
1.8.1.2


