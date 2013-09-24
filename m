Return-Path: <ddalex@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 1E3AA6CB82
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:21 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 24 Sep 2013 09:53:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,972,1371106800"; d="scan'208";a="364948553"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by azsmga001.ch.intel.com with ESMTP; 24 Sep 2013 09:53:12 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 346D45628CF; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:37 +0100
Message-Id: <c592a5c9efa95210f483162cf7adc02ab0d86b89.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 68/94] bitbake: dsi: use get vars command to store configuration
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

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Patch to store variable configuration for a build using
the getAllKeysWithFlags command. Only variables that are
not functions are saved.

Minor fixes to the Variable model as to match data we receive.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py | 15 +++++++++++++--
 bitbake/lib/webhob/orm/models.py     |  6 +++---
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index 6f4789c..89d5f15 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -9,7 +9,7 @@ os.environ.setdefault("DJANGO_SETTINGS_MODULE", "webhob.whbmain.settings")
 
 import webhob.whbmain.settings as whb_django_settings
 from webhob.orm.models import Machine, Build, Task, Recipe, Layer_Version, Layer, Package, LogMessage
-from webhob.orm.models import Task_Dependency, Package_Dependency
+from webhob.orm.models import Task_Dependency, Package_Dependency, Variable
 from bb.msg import BBLogFormatter as format
 
 class ORMWrapper(object):
@@ -146,6 +146,15 @@ class ORMWrapper(object):
 
         return log_object.save()
 
+    def save_build_variables(self, build_obj, vardump):
+        for k in vardump:
+            if not bool(vardump[k]['func']):
+                Variable.objects.create( build = build_obj,
+                    variable_name = k,
+                    variable_value = vardump[k]['v'],
+                    description = vardump[k]['doc'])
+
+
 class BuildInfoHelper(object):
     """ This class gathers the build information from the server and sends it
         towards the ORM wrapper for storing in the database
@@ -363,13 +372,15 @@ class BuildInfoHelper(object):
         build_obj = self.orm_wrapper.create_build_object(build_information)
         self.internal_state['build'] = build_obj
         self.internal_state['target'] = build_information['target']
+        # Load layer information for the build
         self.internal_state['layer_versions'] = []
         for layer_object in self.internal_state['layers']:
             layer_version_information = self._get_layer_version_information(layer_object)
             self.internal_state['layer_versions'].append(self.orm_wrapper.get_layer_version_object(layer_version_information))
 
         del self.internal_state['layers']
-
+        # Save build configuration
+        self.orm_wrapper.save_build_variables(build_obj, self.server.runCommand(["getAllKeysWithFlags", ["doc", "func"]])[0])
 
 
     def update_build_information(self, event, errors, warnings, taskfailures):
diff --git a/bitbake/lib/webhob/orm/models.py b/bitbake/lib/webhob/orm/models.py
index f51f53d..1d67e40 100644
--- a/bitbake/lib/webhob/orm/models.py
+++ b/bitbake/lib/webhob/orm/models.py
@@ -161,11 +161,11 @@ class Layer_Version(models.Model):
 class Variable(models.Model):
     build = models.ForeignKey(Build, related_name='variable_build')
     variable_name = models.CharField(max_length=100)
-    variable_value = models.TextField()
+    variable_value = models.TextField(null=True)
     file = models.FilePathField(max_length=255)
-    changed = models.BooleanField()
+    changed = models.BooleanField(default=False)
     human_readable_name = models.CharField(max_length=200)
-    description = models.TextField()
+    description = models.TextField(null=True)
 
 
 class Machine(models.Model):
-- 
1.8.1.2


