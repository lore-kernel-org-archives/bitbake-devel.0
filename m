Return-Path: <ddalex@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 32AFB6CB8F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:19 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 24 Sep 2013 09:53:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,972,1371106800"; d="scan'208";a="364948483"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by azsmga001.ch.intel.com with ESMTP; 24 Sep 2013 09:53:04 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 8FA875610C5; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:51:40 +0100
Message-Id: <92aa0e5d0233ab5c5dbd3a03b92dd05c97d9a4f7.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 11/94] bitbake: webhob: changes to build information table
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:24 -0000

From: Calin Dragomir <calinx.l.dragomir@intel.com>

It was decided that disk_io and cpu usage information are not very
relevant for a full build, so these fields have been droped from
our models and replaced with output information (image_fstypes field)

Signed-off-by: Calin Dragomir <calinx.l.dragomir@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py              | 6 ++----
 bitbake/lib/webhob/bldviewer/templates/build.html | 6 ++----
 bitbake/lib/webhob/orm/models.py                  | 3 +--
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index 57e404b..e1ebd41 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -47,8 +47,7 @@ class ORMWrapper(object):
         build_info['outcome'] = 0
         build_info['number_of_errors'] = 0
         build_info['number_of_warnings'] = 0
-        build_info['cpu_usage'] = 0
-        build_info['disk_io'] = 0
+        build_info['image_fstypes'] = server.runCommand(["getVariable", "IMAGE_FSTYPES"])[0]
         build_info['cooker_log_path'] = server.runCommand(["getVariable", "BB_CONSOLELOG"])[0]
         build_info['build_name'] = server.runCommand(["getVariable", "BUILDNAME"])[0]
         build_info['bitbake_version'] = server.runCommand(["getVariable", "BB_VERSION"])[0]
@@ -69,8 +68,7 @@ class ORMWrapper(object):
                                     outcome=build_info['outcome'],
                                     errors_no=build_info['number_of_errors'],
                                     warnings_no=build_info['number_of_warnings'],
-                                    cpu_usage=build_info['cpu_usage'],
-                                    disk_io=build_info['disk_io'],
+                                    image_fstypes=build_info['image_fstypes'],
                                     cooker_log_path=build_info['cooker_log_path'],
                                     build_name=build_info['build_name'],
                                     bitbake_version=build_info['bitbake_version'])
diff --git a/bitbake/lib/webhob/bldviewer/templates/build.html b/bitbake/lib/webhob/bldviewer/templates/build.html
index 9a2d412..1b694d6 100644
--- a/bitbake/lib/webhob/bldviewer/templates/build.html
+++ b/bitbake/lib/webhob/bldviewer/templates/build.html
@@ -20,8 +20,7 @@
 			<th>Time</th>
 			<th>Errors</th>
 			<th>Warnings</th>
-			<th>CPU usage</th>
-			<th>Disk I/O</th>
+			<th>Output</th>
 			<th>Log</th>
 			<th>Bitbake Version</th>
 			<th>Build Name</th>
@@ -38,8 +37,7 @@
 			<td>{% time_difference build.started_on build.completed_on %}</td>
 			<td>{{build.errors_no}}</td>
 			<td>{{build.warnings_no}}</td>
-			<td>{{build.cpu_usage}}</td>
-			<td>{{build.disk_io}}</td>
+			<td>{{build.image_fstypes}}</td>
 			<td>{{build.cooker_log_path}}</td>
 			<td>{{build.bitbake_version}}</td>
 			<td>{{build.build_name}}</td>
diff --git a/bitbake/lib/webhob/orm/models.py b/bitbake/lib/webhob/orm/models.py
index 6b8e2fa..f0492db 100644
--- a/bitbake/lib/webhob/orm/models.py
+++ b/bitbake/lib/webhob/orm/models.py
@@ -18,8 +18,7 @@ class Build(models.Model):
     outcome = models.IntegerField(choices=BUILD_OUTCOME)
     errors_no = models.IntegerField()
     warnings_no = models.IntegerField()
-    cpu_usage = models.IntegerField()
-    disk_io = models.DecimalField(max_digits=20, decimal_places=10)
+    image_fstypes = models.CharField(max_length=100)
     cooker_log_path = models.CharField(max_length=500)
     build_name = models.CharField(max_length=100)
     bitbake_version = models.CharField(max_length=50)
-- 
1.8.1.2


