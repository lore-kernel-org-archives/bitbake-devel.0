Return-Path: <ddalex@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 6472D6D06A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Nov 2013 13:56:32 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 14 Nov 2013 05:56:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,699,1378882800"; d="scan'208";a="433425244"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga002.fm.intel.com with ESMTP; 14 Nov 2013 05:56:33 -0800
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id EF632560398; Thu, 14 Nov 2013 13:56:32 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 14 Nov 2013 13:56:30 +0000
Message-Id: <1384437390-10392-1-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1384426381-7869-2-git-send-email-alexandru.damian@intel.com>
References: <1384426381-7869-2-git-send-email-alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH v2] cooker, toaster: variable definition tracking
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
X-List-Received-Date: Thu, 14 Nov 2013 13:56:32 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

In order to track the file where a configuration
variable was defined, this patch bring these changes:

* a new feature is defined in CookerFeatures, named
BASEDATASTORE_TRACKING. When a UI requests BASEDATASTORE_TRACKING,
the base variable definition are tracked when configuration
is parsed.

* getAllKeysWithFlags now includes variable history in the
data dump

* toaster_ui.py will record the operation, file path
and line number where the variable was changes

* toaster Simple UI will display the file path
and line number for Configuration page

There is a change in the models to accomodate the recording
of variable change history.

[YOCTO #5227]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/cooker.py                                   | 15 ++++++++++++---
 lib/bb/cookerdata.py                               |  1 +
 lib/bb/ui/buildinfohelper.py                       | 14 ++++++++++----
 lib/bb/ui/toasterui.py                             |  2 +-
 lib/toaster/bldviewer/templates/configuration.html |  6 ++++--
 lib/toaster/orm/models.py                          |  6 +++++-
 6 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 0580cd5..4c9067b 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -81,7 +81,7 @@ class SkippedPackage:
 
 
 class CookerFeatures(object):
-    _feature_list = [HOB_EXTRA_CACHES, SEND_DEPENDS_TREE] = range(2)
+    _feature_list = [HOB_EXTRA_CACHES, SEND_DEPENDS_TREE, BASEDATASTORE_TRACKING] = range(3)
 
     def __init__(self):
         self._features=set()
@@ -177,6 +177,9 @@ class BBCooker:
         self.data.disableTracking()
 
     def loadConfigurationData(self):
+        if CookerFeatures.BASEDATASTORE_TRACKING in self.featureset:
+            self.enableDataTracking()
+
         self.initConfigurationData()
         self.databuilder.parseBaseConfiguration()
         self.data = self.databuilder.data
@@ -189,6 +192,10 @@ class BBCooker:
         bb.data.update_data(self.event_data)
         bb.parse.init_parser(self.event_data)
 
+        if CookerFeatures.BASEDATASTORE_TRACKING in self.featureset:
+            self.disableDataTracking()
+
+
     def modifyConfigurationVar(self, var, val, default_file, op):
         if op == "append":
             self.appendConfigurationVar(var, val, default_file)
@@ -320,7 +327,6 @@ class BBCooker:
         open(confpath, 'w').close()
 
     def parseConfiguration(self):
-
         # Set log file verbosity
         verboselogs = bb.utils.to_boolean(self.data.getVar("BB_VERBOSE_LOGS", "0"))
         if verboselogs:
@@ -1175,7 +1181,10 @@ class BBCooker:
             try:
                 v = self.data.getVar(k, True)
                 if not k.startswith("__") and not isinstance(v, bb.data_smart.DataSmart):
-                    dump[k] = { 'v' : v }
+                    dump[k] = {
+    'v' : v ,
+    'history' : self.data.varhistory.variable(k),
+                    }
                     for d in flaglist:
                         dump[k][d] = self.data.getVarFlag(k, d)
             except Exception as e:
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index e640ed0..1cc7bc2 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -127,6 +127,7 @@ class CookerConfiguration(object):
         self.dump_signatures = False
         self.dry_run = False
         self.tracking = False
+        self.server_only = False
 
         self.env = {}
 
diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 2b0298e..863a20e 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -27,8 +27,10 @@ os.environ.setdefault("DJANGO_SETTINGS_MODULE", "toaster.toastermain.settings")
 
 import toaster.toastermain.settings as toaster_django_settings
 from toaster.orm.models import Build, Task, Recipe, Layer_Version, Layer, Target, LogMessage
-from toaster.orm.models import Target_Package, Build_Package, Variable, Build_File
-from toaster.orm.models import Task_Dependency, Build_Package_Dependency, Target_Package_Dependency, Recipe_Dependency
+from toaster.orm.models import Variable, VariableHistory
+from toaster.orm.models import Target_Package, Build_Package, Build_File
+from toaster.orm.models import Task_Dependency, Build_Package_Dependency
+from toaster.orm.models import Target_Package_Dependency, Recipe_Dependency
 from bb.msg import BBLogFormatter as format
 
 class ORMWrapper(object):
@@ -232,11 +234,15 @@ class ORMWrapper(object):
                         desc = vardump[root_var]['doc']
                 if desc is None:
                     desc = ''
-                Variable.objects.create( build = build_obj,
+                variable_obj = Variable.objects.create( build = build_obj,
                     variable_name = k,
                     variable_value = value,
                     description = desc)
-
+                for vh in vardump[k]['history']:
+                    VariableHistory.objects.create( variable = variable_obj,
+                            file_name = vh['file'],
+                            line_number = vh['line'],
+                            operation = vh['op'])
 
 class BuildInfoHelper(object):
     """ This class gathers the build information from the server and sends it
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 6c5b152..d2dba25 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -41,7 +41,7 @@ import sys
 import time
 import xmlrpclib
 
-featureSet = [bb.cooker.CookerFeatures.HOB_EXTRA_CACHES, bb.cooker.CookerFeatures.SEND_DEPENDS_TREE]
+featureSet = [bb.cooker.CookerFeatures.HOB_EXTRA_CACHES, bb.cooker.CookerFeatures.SEND_DEPENDS_TREE, bb.cooker.CookerFeatures.BASEDATASTORE_TRACKING]
 
 logger = logging.getLogger("BitBake")
 interactive = sys.stdout.isatty()
diff --git a/lib/toaster/bldviewer/templates/configuration.html b/lib/toaster/bldviewer/templates/configuration.html
index 052c37c..8db35e0 100644
--- a/lib/toaster/bldviewer/templates/configuration.html
+++ b/lib/toaster/bldviewer/templates/configuration.html
@@ -5,16 +5,18 @@
 
             <tr>
             <th>Name</th>
-            <th>Value</th>
             <th>Description</th>
+            <th>Definition history</th>
+            <th>Value</th>
             </tr>
 
             {% for variable in configuration %}
 
             <tr class="data">
                 <td>{{variable.variable_name}}</td>
-                <td>{{variable.variable_value}}</td>
                 <td>{% if variable.description %}{{variable.description}}{% endif %}</td>
+                <td>{% for vh in variable.variablehistory_set.all %}{{vh.operation}} in {{vh.file_name}}:{{vh.line_number}}<br/>{%endfor%}</td>
+                <td>{{variable.variable_value}}</td>
             {% endfor %}
 
 {% endblock %}
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 53b9e3a..2ae0b51 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -238,11 +238,15 @@ class Variable(models.Model):
     build = models.ForeignKey(Build, related_name='variable_build')
     variable_name = models.CharField(max_length=100)
     variable_value = models.TextField(blank=True)
-    file = models.FilePathField(max_length=255)
     changed = models.BooleanField(default=False)
     human_readable_name = models.CharField(max_length=200)
     description = models.TextField(blank=True)
 
+class VariableHistory(models.Model):
+    variable = models.ForeignKey(Variable)
+    file_name = models.FilePathField(max_length=255)
+    line_number = models.IntegerField(null=True)
+    operation = models.CharField(max_length=16)
 
 class LogMessage(models.Model):
     INFO = 0
-- 
1.8.3.2


