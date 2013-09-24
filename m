Return-Path: <ddalex@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 4FC136CB32
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:15 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 24 Sep 2013 09:53:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="298814637"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by AZSMGA002.ch.intel.com with ESMTP; 24 Sep 2013 09:53:12 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 45BA2562963; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:44 +0100
Message-Id: <37c6319babb9bbd2ccf6658aeae460c64daa11f4.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 75/94] bitbake: dsi: save build-time package information
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:16 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Saving the build-time package information in the database.
Slight additions to the ORM model as to record more information.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py | 20 ++++++++++++++++++++
 bitbake/lib/bb/ui/dsi.py             |  5 +++++
 bitbake/lib/webhob/orm/models.py     |  8 ++++++--
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index 0860d2a..06ca703 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -156,6 +156,20 @@ class ORMWrapper(object):
 
         return log_object.save()
 
+
+    def save_build_package_information(self, build_obj, package_info, recipes):
+        bp_object = Build_Package.objects.create( build = build_obj,
+                                       recipe = recipes[package_info['PN']],
+                                       name = package_info['PKG'],
+                                       version = package_info['PKGV'],
+                                       revision = package_info['PKGR'],
+                                       summary = package_info['SUMMARY'],
+                                       description = package_info['DESCRIPTION'],
+                                       section = package_info['SECTION'],
+                                       license = package_info['LICENSE'],
+                                       )
+        return bp_object
+
     def save_build_variables(self, build_obj, vardump):
         for k in vardump:
             if not bool(vardump[k]['func']):
@@ -558,6 +572,12 @@ class BuildInfoHelper(object):
                 dep = _save_a_task(taskdesc1)
                 Task_Dependency.objects.get_or_create( task = target, depends_on = dep )
 
+    def store_build_package_information(self, event):
+        package_info = event.data
+        self.orm_wrapper.save_build_package_information(self.internal_state['build'],
+                            package_info, self.internal_state['recipes'])
+
+
     def store_log_information(self, level, text):
         log_information = {}
         log_information['build'] = self.internal_state['build']
diff --git a/bitbake/lib/bb/ui/dsi.py b/bitbake/lib/bb/ui/dsi.py
index 3284ea2..643e98e 100644
--- a/bitbake/lib/bb/ui/dsi.py
+++ b/bitbake/lib/bb/ui/dsi.py
@@ -489,6 +489,11 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 buildinfohelper.store_layer_info()
                 continue
 
+            if isinstance(event, bb.event.MetadataEvent):
+                if event.type == "SinglePackageInfo":
+                    buildinfohelper.store_build_package_information(event)
+                continue
+
             # ignore
             if isinstance(event, (bb.event.BuildBase,
                                   bb.event.StampUpdate,
diff --git a/bitbake/lib/webhob/orm/models.py b/bitbake/lib/webhob/orm/models.py
index f3d988e..7e57c1d 100644
--- a/bitbake/lib/webhob/orm/models.py
+++ b/bitbake/lib/webhob/orm/models.py
@@ -115,8 +115,12 @@ class Build_Package(models.Model):
     recipe = models.ForeignKey('Recipe', null=True)
     name = models.CharField(max_length=100)
     version = models.CharField(max_length=100, default="")
-    size = models.IntegerField()
-    license = models.CharField(max_length=200, null=True)
+    revision = models.CharField(max_length=32, default="")
+    summary = models.CharField(max_length=200, default="")
+    description = models.CharField(max_length=200, default="")
+    size = models.IntegerField(default=0)
+    section = models.CharField(max_length=80, null=True)
+    license = models.CharField(max_length=80, null=True)
 
 class Build_Package_Dependency(models.Model):
     TYPE_DEPENDS = 0
-- 
1.8.1.2


