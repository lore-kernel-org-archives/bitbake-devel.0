Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 0B21876988
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 12:58:36 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga104.fm.intel.com with ESMTP; 15 Jan 2016 04:58:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,299,1449561600"; d="scan'208";a="881987256"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga001.fm.intel.com with ESMTP; 15 Jan 2016 04:58:37 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 321CD6A4004
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 05:46:32 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jan 2016 13:01:06 +0200
Message-Id: <b53df3ca03c0679117c070c5251cbe6426d23a35.1452855461.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 23/23] toaster: toastergui: code formatting and clean-up
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
X-List-Received-Date: Fri, 15 Jan 2016 12:58:36 -0000

From: Elliot Smith <elliot.smith@intel.com>

Minor fixes to code formatting and small improvements from
code review.

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/orm/models.py        | 12 +++---------
 lib/toaster/toastergui/tables.py |  4 +++-
 lib/toaster/toastergui/views.py  |  5 ++---
 3 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 3dc4d6d..ac2aa9e 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -477,15 +477,9 @@ class Build(models.Model):
         targets in this build
         """
         targets = self.target_set.all()
-        target_labels = []
-        target_label = None
-
-        for target in targets:
-            target_label = target.target
-            if target.task:
-                target_label = target_label + ':' + target.task
-            target_labels.append(target_label)
-
+        target_labels = [target.target +
+                         (':' + target.task if target.task else '')
+                         for target in targets]
         target_labels.sort()
 
         return target_labels
diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index 2279731..e9f1fdc 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -688,7 +688,9 @@ class ProjectsTable(ToasterTable):
 
         self.queryset = queryset
 
-    # columns: last activity on (updated) - DEFAULT, project (name), release, machine, number of builds, last build outcome, recipe (name),  errors, warnings, image files
+    # columns: last activity on (updated) - DEFAULT, project (name), release,
+    # machine, number of builds, last build outcome, recipe (name),  errors,
+    # warnings, image files
     def setup_columns(self, *args, **kwargs):
         name_template = '''
         {% load project_url_tag %}
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 4f7b50f..59e16b2 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -462,7 +462,7 @@ def builddashboard( request, build_id ):
     for t in tgts:
         elem = { }
         elem[ 'target' ] = t
-        if ( t.is_image ):
+        if t.is_image:
             hasImages = True
         npkg = 0
         pkgsz = 0
@@ -481,8 +481,7 @@ def builddashboard( request, build_id ):
                 ndx = 0;
             f = i.file_name[ ndx + 1: ]
             imageFiles.append({ 'id': i.id, 'path': f, 'size' : i.file_size })
-        if ( t.is_image and
-             (( len( imageFiles ) <= 0 ) or ( len( t.license_manifest_path ) <= 0 ))):
+        if t.is_image and (len(imageFiles) <= 0 or len(t.license_manifest_path) <= 0):
             targetHasNoImages = True
         elem[ 'imageFiles' ] = imageFiles
         elem[ 'targetHasNoImages' ] = targetHasNoImages
-- 
2.1.4


