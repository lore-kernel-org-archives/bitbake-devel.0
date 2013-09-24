Return-Path: <ddalex@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 3AF9D6CB47
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:13 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 24 Sep 2013 09:53:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="298814567"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by AZSMGA002.ch.intel.com with ESMTP; 24 Sep 2013 09:53:09 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id C5F035618C1; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:00 +0100
Message-Id: <be34511d888dd2efa693f3ee763012e4218573f7.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 31/94] bitbake: webhob: orm change to remove Target
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:14 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Removes the Target dependency as it is replaced
by a field in Build.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/webhob/orm/models.py | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/bitbake/lib/webhob/orm/models.py b/bitbake/lib/webhob/orm/models.py
index 83126d8..e6663a3 100644
--- a/bitbake/lib/webhob/orm/models.py
+++ b/bitbake/lib/webhob/orm/models.py
@@ -14,6 +14,7 @@ class Build(models.Model):
 
     uuid = models.CharField(max_length=100, unique=True)
     target = models.CharField(max_length=100)
+    is_image = models.BooleanField()
     machine = models.ForeignKey('Machine', related_name='build_machine')
     distro = models.CharField(max_length=100)
     distro_version = models.CharField(max_length=100)
@@ -98,24 +99,14 @@ class Task_Dependency(models.Model):
     depends_on = models.ForeignKey(Task, related_name='task_dependencies_depends')
 
 
-class Target(models.Model):
-    build = models.ForeignKey(Build, related_name='target_build')
-    is_image = models.BooleanField()
-
-
 class Artifact(models.Model):
     build = models.ForeignKey(Build, related_name='artifact_build')
-    target = models.ForeignKey(Target, related_name='artifact_target')
     file_name = models.CharField(max_length=100)
     file_size = models.IntegerField()
 
 
-class Package_In_Image(models.Model):
-    package = models.ForeignKey('Package', related_name='package_in_image_package')
-    target = models.ForeignKey(Target, related_name='package_in_image_target')
-
-
 class Package(models.Model):
+    build = models.ForeignKey('Build', related_name='package_build')
     recipe = models.ForeignKey('Recipe', related_name='package_recipe')
     name = models.CharField(max_length=100)
     version = models.CharField(max_length=100)
-- 
1.8.1.2


