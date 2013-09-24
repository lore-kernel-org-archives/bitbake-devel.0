Return-Path: <ddalex@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 92AF26CB1E
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:07 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 24 Sep 2013 09:50:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="400405689"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga001.fm.intel.com with ESMTP; 24 Sep 2013 09:53:07 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id A16F856118C; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:51:46 +0100
Message-Id: <fc38c7d663057cc9830787977175c389fb181e06.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 17/94] bitbake: buildinfohelper: clean-up the imports
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:08 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

As per convention, we do all imports at the beginning of file.

Also, globally set Django settings in the Django interface file.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index e12750e..f7f98d8 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -3,6 +3,11 @@ import sys
 import uuid
 
 
+os.environ.setdefault("DJANGO_SETTINGS_MODULE", "webhob.whbmain.settings")
+
+import webhob.whbmain.settings as whb_django_settings
+from webhob.orm.models import Machine, Build, Task, Recipe, Build_Layer, Layer
+
 class ORMWrapper(object):
     """ This class creates the dictionaries needed to store information in the database
         following the format defined by the Django models. It is also used to save this
@@ -27,7 +32,6 @@ class ORMWrapper(object):
 
     def create_machine_object(self, machine_information):
         # This needs to be imported after we have configured the Django settings file
-        from webhob.orm.models import Machine
 
         machine = Machine.objects.get_or_create(name=machine_information['name'],
                                                 description=machine_information['description'])
@@ -59,7 +63,6 @@ class ORMWrapper(object):
 
     def create_build_object(self, build_info):
         # This needs to be imported after we have configured the Django settings file
-        from webhob.orm.models import Build
 
         build = Build.objects.create(uuid=build_info['uuid'],
                                     target=build_info['target'],
@@ -80,7 +83,6 @@ class ORMWrapper(object):
 
     def update_build_object(self, build_obj, errors, warnings, taskfailures):
         # This needs to be imported after we have configured the Django settings file
-        from webhob.orm.models import Build
 
         outcome = 0
         if errors or taskfailures:
@@ -128,8 +130,6 @@ class ORMWrapper(object):
 
     def create_task_object(self, task_information):
         # This needs to be imported after we have configured the Django settings file
-        from webhob.orm.models import Task
-
         identifier = task_information['recipe'].name + task_information['task_name']
 
         task_object = Task.objects.get_or_create(
@@ -262,7 +262,6 @@ class ORMWrapper(object):
 
     def get_recipe_object(self, event):
         # This needs to be imported after we have configured the Django settings file
-        from webhob.orm.models import Recipe
 
         recipe_information = self.get_recipe_information(event)
 
@@ -305,7 +304,6 @@ class ORMWrapper(object):
 
     def get_build_layer_object(self, event):
         # This needs to be imported after we have configured the Django settings file
-        from webhob.orm.models import Build_Layer
 
         build_layer_information = self.get_build_layer_information(event)
 
@@ -334,7 +332,6 @@ class ORMWrapper(object):
 
     def get_layer_object(self, event):
         # This needs to be imported after we have configured the Django settings file
-        from webhob.orm.models import Layer
 
         layer_information = self.get_layer_information(event)
 
@@ -366,8 +363,6 @@ class BuildInfoHelper(object):
         self.orm_wrapper = ORMWrapper(server)
 
     def configure_django(self):
-        os.environ.setdefault("DJANGO_SETTINGS_MODULE", "webhob.whbmain.settings")
-        import webhob.whbmain.settings as whb_django_settings
         # Add webhob to sys path for importing modules
         sys.path.append(os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(__file__))), 'webhob'))
 
-- 
1.8.1.2


