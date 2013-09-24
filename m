Return-Path: <ddalex@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 36CD26CB55
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:12 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 24 Sep 2013 09:53:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="382902494"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by orsmga001.jf.intel.com with ESMTP; 24 Sep 2013 09:53:13 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 5023B562BCE; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:48 +0100
Message-Id: <6cd8cf2718d94577eb235e267d62d6420b43c19a.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 79/94] bitbake: dsi: record recipe dependency
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

Add code to record recipe dependencies, for DEPENDS
and RDEPENDS relationships.

Caveat emptor: relationships with ASSUME_PROVIDED
PNs will not be recorded, as they don't have real
recipe objects.

Adds code to the Simple interface to allow visualisation
of the recorded data.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py               | 23 +++++++++++++++++++++-
 bitbake/lib/webhob/bldviewer/templates/recipe.html |  9 +++++++++
 bitbake/lib/webhob/orm/models.py                   | 11 +++++++++--
 3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index 8b0e720..cf947da 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -9,7 +9,7 @@ os.environ.setdefault("DJANGO_SETTINGS_MODULE", "webhob.whbmain.settings")
 import webhob.whbmain.settings as whb_django_settings
 from webhob.orm.models import Machine, Build, Task, Recipe, Layer_Version, Layer, Target, LogMessage
 from webhob.orm.models import Target_Package, Build_Package, Variable, Build_File
-from webhob.orm.models import Task_Dependency, Build_Package_Dependency, Target_Package_Dependency
+from webhob.orm.models import Task_Dependency, Build_Package_Dependency, Target_Package_Dependency, Recipe_Dependency
 from bb.msg import BBLogFormatter as format
 
 class ORMWrapper(object):
@@ -562,6 +562,27 @@ class BuildInfoHelper(object):
                         t.save()
             self.internal_state['recipes'][pn] = recipe
 
+        # save recipe dependency
+        try:
+            # buildtime
+            for recipe in event._depgraph['depends']:
+                target = self.internal_state['recipes'][recipe]
+                for dep in event._depgraph['depends'][recipe]:
+                    dependency = self.internal_state['recipes'][dep]
+                    Recipe_Dependency.objects.get_or_create( recipe = target,
+                            depends_on = dependency, dep_type = Recipe_Dependency.TYPE_DEPENDS)
+
+            # runtime
+            for recipe in event._depgraph['rdepends-pn']:
+                target = self.internal_state['recipes'][recipe]
+                for dep in event._depgraph['rdepends-pn'][recipe]:
+                    dependency = self.internal_state['recipes'][dep]
+                    Recipe_Dependency.objects.get_or_create( recipe = target,
+                            depends_on = dependency, dep_type = Recipe_Dependency.TYPE_RDEPENDS)
+
+        except KeyError:    # we'll not get recipes for key w/ values listed in ASSUME_PROVIDED
+            pass
+
         # save all task information
         def _save_a_task(taskdesc):
             spec = re.split(r'\.', taskdesc);
diff --git a/bitbake/lib/webhob/bldviewer/templates/recipe.html b/bitbake/lib/webhob/bldviewer/templates/recipe.html
index 32fcdb8..e81883f 100644
--- a/bitbake/lib/webhob/bldviewer/templates/recipe.html
+++ b/bitbake/lib/webhob/bldviewer/templates/recipe.html
@@ -22,6 +22,8 @@
             <th>Bugtracker</th>
             <th>Author</th>
             <th>File_path</th>
+            <th style="width: 30em">Recipe Dependency</th>
+
 
         {% for recipe in recipes %}
 
@@ -36,6 +38,13 @@
             <td>{{recipe.bugtracker}}</td>
             <td>{{recipe.author}}</td>
             <td>{{recipe.file_path}}</td>
+            <td>
+        <div style="height: 5em; overflow:auto">
+            {% for rr in recipe.r_dependencies_recipe.all %}
+                <a href="#{{rr.depends_on.name}}">{{rr.depends_on.name}}</a><br/>
+            {% endfor %}
+        </div>
+            </td>
         </tr>
 
         {% endfor %}
diff --git a/bitbake/lib/webhob/orm/models.py b/bitbake/lib/webhob/orm/models.py
index aa368fe..7ce0d1f 100644
--- a/bitbake/lib/webhob/orm/models.py
+++ b/bitbake/lib/webhob/orm/models.py
@@ -184,9 +184,16 @@ class Recipe(models.Model):
 
 
 class Recipe_Dependency(models.Model):
-    recipe = models.ForeignKey(Recipe, related_name='recipe_dependencies_recipe')
-    depends_on = models.ForeignKey(Recipe, related_name='recipe_dependencies_depends')
+    TYPE_DEPENDS = 0
+    TYPE_RDEPENDS = 1
 
+    DEPENDS_TYPE = (
+        (TYPE_DEPENDS, "depends"),
+        (TYPE_RDEPENDS, "rdepends"),
+    )
+    recipe = models.ForeignKey(Recipe, related_name='r_dependencies_recipe')
+    depends_on = models.ForeignKey(Recipe, related_name='r_dependencies_depends')
+    dep_type = models.IntegerField(choices=DEPENDS_TYPE)
 
 class Layer(models.Model):
     name = models.CharField(max_length=100)
-- 
1.8.1.2


