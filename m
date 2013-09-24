Return-Path: <ddalex@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 3F1406CB0A
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:10 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 24 Sep 2013 09:50:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="400405706"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga001.fm.intel.com with ESMTP; 24 Sep 2013 09:53:09 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id CD67F561B67; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:03 +0100
Message-Id: <604ac6de5329767bd00f4c674b1561956e781ea2.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 34/94] bitbake: webhob: determine if a build is an image
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:11 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Adding code to see if a build will generate a image
based on the inheritance of image.bbclass in the recipe
defining the build.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py              | 4 ++++
 bitbake/lib/webhob/bldviewer/templates/build.html | 2 ++
 bitbake/lib/webhob/orm/models.py                  | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index 92f1621..16e69c5 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -328,6 +328,7 @@ class BuildInfoHelper(object):
 
         build_information = self._get_build_information(machine_obj)
         build_information['target'] = ' '.join(event.getPkgs())
+
         build_obj = self.orm_wrapper.create_build_object(build_information)
         self.internal_state['build'] = build_obj
         self.internal_state['target'] = build_information['target']
@@ -422,6 +423,9 @@ class BuildInfoHelper(object):
             recipe_info['file_path'] = file_name
             recipe = self.orm_wrapper.get_update_recipe_object(recipe_info)
             recipe.is_image = True in map(lambda x: x.endswith('image.bbclass'), event._depgraph['pn'][pn]['inherits'])
+            if recipe.is_image and pn == self.internal_state['build'].target:
+                self.internal_state['build'].is_image = True
+                self.internal_state['build'].save()
             self.internal_state['recipes'][pn] = recipe
 
         # save all task information
diff --git a/bitbake/lib/webhob/bldviewer/templates/build.html b/bitbake/lib/webhob/bldviewer/templates/build.html
index 1b694d6..cd257e0 100644
--- a/bitbake/lib/webhob/bldviewer/templates/build.html
+++ b/bitbake/lib/webhob/bldviewer/templates/build.html
@@ -16,6 +16,7 @@
 			<th>Started On</th>
 			<th>Completed On</th>
 			<th>Target</th>
+	        <th>Image ?</th>
 			<th>Machine</th>
 			<th>Time</th>
 			<th>Errors</th>
@@ -33,6 +34,7 @@
 			<td>{{build.started_on}}</td>
 			<td>{{build.completed_on}}</td>
 			<td>{{build.target}}</td>
+	        <td>{{build.is_image}}</td>
 			<td>{{build.machine.name}}</td>
 			<td>{% time_difference build.started_on build.completed_on %}</td>
 			<td>{{build.errors_no}}</td>
diff --git a/bitbake/lib/webhob/orm/models.py b/bitbake/lib/webhob/orm/models.py
index 91b352e..0d6cf15 100644
--- a/bitbake/lib/webhob/orm/models.py
+++ b/bitbake/lib/webhob/orm/models.py
@@ -14,7 +14,7 @@ class Build(models.Model):
 
     uuid = models.CharField(max_length=100, unique=True)
     target = models.CharField(max_length=100)
-    is_image = models.BooleanField()
+    is_image = models.BooleanField(default = False)
     machine = models.ForeignKey('Machine', related_name='build_machine')
     distro = models.CharField(max_length=100)
     distro_version = models.CharField(max_length=100)
-- 
1.8.1.2


