Return-Path: <ddalex@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 9AF1A6CB75
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:12 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 24 Sep 2013 09:50:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="400405780"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga001.fm.intel.com with ESMTP; 24 Sep 2013 09:53:13 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 59E23562CD6; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:52 +0100
Message-Id: <829b1dfe4099a59641b7c068f0457496a94de35b.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 83/94] bitbake: webhob: clean up Machine table
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:13 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Removing the Machine table in the favour of a column
in the Build table since it complicated the queries without
any benefit in reduced data structure.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py              | 26 +++++------------------
 bitbake/lib/webhob/bldviewer/templates/build.html |  2 +-
 bitbake/lib/webhob/orm/models.py                  |  9 ++------
 3 files changed, 8 insertions(+), 29 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index 30aa098..b5c2dc0 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -7,7 +7,7 @@ import re
 os.environ.setdefault("DJANGO_SETTINGS_MODULE", "webhob.whbmain.settings")
 
 import webhob.whbmain.settings as whb_django_settings
-from webhob.orm.models import Machine, Build, Task, Recipe, Layer_Version, Layer, Target, LogMessage
+from webhob.orm.models import Build, Task, Recipe, Layer_Version, Layer, Target, LogMessage
 from webhob.orm.models import Target_Package, Build_Package, Variable, Build_File
 from webhob.orm.models import Task_Dependency, Build_Package_Dependency, Target_Package_Dependency, Recipe_Dependency
 from bb.msg import BBLogFormatter as format
@@ -21,12 +21,6 @@ class ORMWrapper(object):
     def __init__(self):
         pass
 
-    def create_machine_object(self, machine_information):
-
-        machine = Machine.objects.get_or_create(name=machine_information['name'],
-                                                description=machine_information['description'])
-
-        return machine[0]
 
     def create_build_object(self, build_info):
 
@@ -244,13 +238,6 @@ class BuildInfoHelper(object):
     ###################
     ## methods to convert event/external info into objects that the ORM layer uses
 
-    def _get_machine_information(self):
-        machine_info = {}
-        machine_info['name'] = self.server.runCommand(["getVariable", "MACHINE"])[0]
-        machine_info['description'] = 'Not Available'
-        self.internal_state['machine'] = machine_info['name']
-        return machine_info
-
     def _get_layer_dict(self, layer_path):
 
         layer_info = {}
@@ -313,11 +300,11 @@ class BuildInfoHelper(object):
         return "<unknown>"
 
 
-    def _get_build_information(self, machine_obj):
+    def _get_build_information(self):
         build_info = {}
         # Generate an identifier for each new build
 
-        build_info['machine'] = machine_obj
+        build_info['machine'] = self.server.runCommand(["getVariable", "MACHINE"])[0]
         build_info['distro'] = self.server.runCommand(["getVariable", "DISTRO"])[0]
         build_info['distro_version'] = self.server.runCommand(["getVariable", "DISTRO_VERSION"])[0]
         build_info['started_on'] = datetime.datetime.now()
@@ -375,7 +362,7 @@ class BuildInfoHelper(object):
 
         for t in self.internal_state['targets']:
             target = t.target
-            machine = self.internal_state['build'].machine.name
+            machine = self.internal_state['build'].machine
             buildname = self.internal_state['build'].build_name
             package = task_object.recipe.name + "-" + task_object.recipe.version.strip(":")
 
@@ -428,10 +415,7 @@ class BuildInfoHelper(object):
 
     def store_started_build(self, event):
 
-        machine_information = self._get_machine_information()
-        machine_obj = self.orm_wrapper.create_machine_object(machine_information)
-
-        build_information = self._get_build_information(machine_obj)
+        build_information = self._get_build_information()
 
         build_obj = self.orm_wrapper.create_build_object(build_information)
         self.internal_state['build'] = build_obj
diff --git a/bitbake/lib/webhob/bldviewer/templates/build.html b/bitbake/lib/webhob/bldviewer/templates/build.html
index eed81a3..dd0e5c0 100644
--- a/bitbake/lib/webhob/bldviewer/templates/build.html
+++ b/bitbake/lib/webhob/bldviewer/templates/build.html
@@ -29,7 +29,7 @@
             <td>{{build.completed_on}}</td>
             <td>{% for t in build.target_set.all %}<a href="/simple/build/{{build.id}}/target/{{t.id}}">{{t.target}}</a><br/>{% endfor %}</td>
             <td>{% if build.is_image %} <a href="/simple/build/{{build.id}}/package/">{{build.is_image}}</a>{% else %} {{build.is_image}} {% endif %}</td>
-            <td>{{build.machine.name}}</td>
+            <td>{{build.machine}}</td>
             <td>{% time_difference build.started_on build.completed_on %}</td>
             <td>{{build.errors_no}}:{% if  build.errors_no %}{% for error in logs %}{% if error.build == build %}{% if error.level == 2 %}<p>{{error.message}}</p>{% endif %}{% endif %}{% endfor %}{% else %}None{% endif %}</td>
             <td>{{build.warnings_no}}:{% if  build.warnings_no %}{% for warning in logs %}{% if warning.build == build %}{% if warning.level == 1 %}<p>{{warning.message}}</p>{% endif %}{% endif %}{% endfor %}{% else %}None{% endif %}</td>
diff --git a/bitbake/lib/webhob/orm/models.py b/bitbake/lib/webhob/orm/models.py
index 2018020..66cbdc8 100644
--- a/bitbake/lib/webhob/orm/models.py
+++ b/bitbake/lib/webhob/orm/models.py
@@ -13,10 +13,10 @@ class Build(models.Model):
         (IN_PROGRESS, 'In Progress'),
     )
 
-    search_allowed_fields = ['machine__name',
+    search_allowed_fields = ['machine',
                              'cooker_log_path']
 
-    machine = models.ForeignKey('Machine', related_name='build_machine')
+    machine = models.CharField(max_length=100)
     distro = models.CharField(max_length=100)
     distro_version = models.CharField(max_length=100)
     started_on = models.DateTimeField()
@@ -226,11 +226,6 @@ class Variable(models.Model):
     description = models.TextField(null=True)
 
 
-class Machine(models.Model):
-    name = models.CharField(max_length=100)
-    description = models.TextField()
-
-
 class LogMessage(models.Model):
     INFO = 0
     WARNING = 1
-- 
1.8.1.2


