Return-Path: <ddalex@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id B9D4E6CAC8
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:18 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 24 Sep 2013 09:53:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="298814638"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by AZSMGA002.ch.intel.com with ESMTP; 24 Sep 2013 09:53:13 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 57BFD562C3C; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:51 +0100
Message-Id: <416e99b9a37b0c709e02c4f1eee6e4a66bded35f.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 82/94] bitbake: dsi: add build package dependency recording
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:19 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Adding code to store all types of package dependencies
that a build time package can have.

Added code to visualise the dependency listing in
the Simple interface.

Addded code to record content size for the
build time packages.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py               | 33 ++++++++++++++++++++++
 .../lib/webhob/bldviewer/templates/bpackage.html   | 13 +++++++--
 bitbake/lib/webhob/orm/models.py                   | 16 ++++++++---
 3 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index cf947da..30aa098 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -166,6 +166,7 @@ class ORMWrapper(object):
                                        revision = package_info['PKGR'],
                                        summary = package_info['SUMMARY'],
                                        description = package_info['DESCRIPTION'],
+                                       size = package_info['PKGSIZE'],
                                        section = package_info['SECTION'],
                                        license = package_info['LICENSE'],
                                        )
@@ -177,6 +178,38 @@ class ORMWrapper(object):
                                         size = size )
             del files[bp_object.name]
 
+        # save soft dependency information
+        if package_info['RDEPENDS'] is not None:
+            for p in package_info['RDEPENDS'].split(" "):
+                if not p.startswith("("):
+                    Build_Package_Dependency.objects.get_or_create( package = bp_object,
+                        depends_on = p, dep_type = Build_Package_Dependency.TYPE_RDEPENDS)
+        if package_info['RDEPENDS'] is not None:
+            for p in package_info['RPROVIDES'].split(" "):
+                if not p.startswith("("):
+                    Build_Package_Dependency.objects.get_or_create( package = bp_object,
+                        depends_on = p, dep_type = Build_Package_Dependency.TYPE_RPROVIDES)
+        if package_info['RDEPENDS'] is not None:
+            for p in package_info['RRECOMMENDS'].split(" "):
+                if not p.startswith("("):
+                    Build_Package_Dependency.objects.get_or_create( package = bp_object,
+                        depends_on = p, dep_type = Build_Package_Dependency.TYPE_RRECOMMENDS)
+        if package_info['RDEPENDS'] is not None:
+            for p in package_info['RSUGGESTS'].split(" "):
+                if not p.startswith("("):
+                    Build_Package_Dependency.objects.get_or_create( package = bp_object,
+                        depends_on = p, dep_type = Build_Package_Dependency.TYPE_RSUGGESTS)
+        if package_info['RDEPENDS'] is not None:
+            for p in package_info['RREPLACES'].split(" "):
+                if not p.startswith("("):
+                    Build_Package_Dependency.objects.get_or_create( package = bp_object,
+                        depends_on = p, dep_type = Build_Package_Dependency.TYPE_RREPLACES)
+        if package_info['RDEPENDS'] is not None:
+            for p in package_info['RCONFLICTS'].split(" "):
+                if not p.startswith("("):
+                    Build_Package_Dependency.objects.get_or_create( package = bp_object,
+                        depends_on = p, dep_type = Build_Package_Dependency.TYPE_RCONFLICTS)
+
         return bp_object
 
     def save_build_variables(self, build_obj, vardump):
diff --git a/bitbake/lib/webhob/bldviewer/templates/bpackage.html b/bitbake/lib/webhob/bldviewer/templates/bpackage.html
index 91e5f6f..46a256c 100644
--- a/bitbake/lib/webhob/bldviewer/templates/bpackage.html
+++ b/bitbake/lib/webhob/bldviewer/templates/bpackage.html
@@ -13,7 +13,9 @@
             <th>Summary</th>
             <th>Section</th>
             <th>Description</th>
+            <th>Size</th>
             <th>License</th>
+            <th>Dependencies List (all)</th>
             </tr>
 
             {% for package in packages %}
@@ -22,12 +24,19 @@
                 <td><a name="#{{package.name}}" href="/simple/build/{{build.pk}}/package/{{package.pk}}/files/">{{package.name}} ({{package.filelist_bpackage.count}} files)</a></td>
                 <td>{{package.version}}-{{package.revision}}</td>
                 <td><a href="/simple/layerversions/{{package.recipe.layer_version_id}}/recipes/#{{package.recipe.name}}">{{package.recipe.name}}</a>{{package.package_name}}</a></td>
-                
+
             <td>{{package.summary}}</td>
             <td>{{package.section}}</td>
             <td>{{package.description}}</td>
+            <td>{{package.size}}</td>
             <td>{{package.license}}</td>
-
+            <td>
+        <div style="height: 3em">
+            {% for bpd in package.bpackage_dependencies_package.all %}
+                {{bpd.dep_type}}: {{bpd.depends_on}} <br/>
+            {% endfor %}
+        </div>
+            </td>
             {% endfor %}
 
     {% endif %}
diff --git a/bitbake/lib/webhob/orm/models.py b/bitbake/lib/webhob/orm/models.py
index 7ce0d1f..2018020 100644
--- a/bitbake/lib/webhob/orm/models.py
+++ b/bitbake/lib/webhob/orm/models.py
@@ -123,14 +123,22 @@ class Build_Package(models.Model):
     license = models.CharField(max_length=80, null=True)
 
 class Build_Package_Dependency(models.Model):
-    TYPE_DEPENDS = 0
-    TYPE_RDEPENDS = 1
+    TYPE_RDEPENDS = 0
+    TYPE_RPROVIDES = 1
+    TYPE_RRECOMMENDS = 2
+    TYPE_RSUGGESTS = 3
+    TYPE_RREPLACES = 4
+    TYPE_RCONFLICTS = 5
     DEPENDS_TYPE = (
-        (TYPE_DEPENDS, "depends"),
         (TYPE_RDEPENDS, "rdepends"),
+        (TYPE_RPROVIDES, "rprovides"),
+        (TYPE_RRECOMMENDS, "rrecommends"),
+        (TYPE_RSUGGESTS, "rsuggests"),
+        (TYPE_RREPLACES, "rreplaces"),
+        (TYPE_RCONFLICTS, "rconflicts"),
     )
     package = models.ForeignKey(Build_Package, related_name='bpackage_dependencies_package')
-    depends_on = models.ForeignKey(Build_Package, related_name='bpackage_dependencies_depends')
+    depends_on = models.CharField(max_length=100)   # soft dependency
     dep_type = models.IntegerField(choices=DEPENDS_TYPE)
 
 
-- 
1.8.1.2


