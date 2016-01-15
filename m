Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id AB5747327E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 12:58:13 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga104.fm.intel.com with ESMTP; 15 Jan 2016 04:58:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,299,1449561600"; d="scan'208";a="893808808"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga002.fm.intel.com with ESMTP; 15 Jan 2016 04:58:14 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 5373D6A4004
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 05:46:10 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jan 2016 13:00:46 +0200
Message-Id: <0afddadd4685cdcb83aefde0669931f612634630.1452855461.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 03/23] toaster: check inferred file suffixes against list of known types
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
X-List-Received-Date: Fri, 15 Jan 2016 12:58:13 -0000

From: Elliot Smith <elliot.smith@intel.com>

The algorithm for finding the suffix for image files produced by
the build doesn't reference a list of known file suffixes, so
could be prone to error.

Modify how file suffixes are parsed from the file path so that
they are compared against a list of known types; if this fails,
use the part of the basename of the file path after the first
'.' character.

Also rationalise the places in the views code where we
extract the file name extensions for builds, so they both use
the same algorithm (before, the same code was duplicated in
two places).

[YOCTO #8417]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/orm/models.py        | 68 ++++++++++++++++++++++++++++++++++++++--
 lib/toaster/toastergui/tables.py |  8 ++---
 lib/toaster/toastergui/views.py  | 38 +++-------------------
 3 files changed, 73 insertions(+), 41 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 7e0cf96..b7975ef 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -29,6 +29,9 @@ from django.core import validators
 from django.conf import settings
 import django.db.models.signals
 
+import os.path
+import re
+
 import logging
 logger = logging.getLogger("toaster")
 
@@ -234,6 +237,14 @@ class Project(models.Model):
         except (Build.DoesNotExist,IndexError):
             return( "not_found" )
 
+    def get_last_build_extensions(self):
+        """
+        Get list of file name extensions for images produced by the most
+        recent build
+        """
+        last_build = Build.objects.get(pk = self.get_last_build_id())
+        return last_build.get_image_file_extensions()
+
     def get_last_imgfiles(self):
         build_id = self.get_last_build_id
         if (-1 == build_id):
@@ -376,6 +387,57 @@ class Build(models.Model):
             eta += ((eta - self.started_on)*(100-completeper))/completeper
         return eta
 
+    def get_image_file_extensions(self):
+        """
+        Get list of file name extensions for images produced by this build
+        """
+        targets = Target.objects.filter(build_id = self.id)
+        extensions = []
+
+        # pattern to match against file path for building extension string
+        pattern = re.compile('\.([^\.]+?)$')
+
+        for target in targets:
+            if (not target.is_image):
+                continue
+
+            target_image_files = Target_Image_File.objects.filter(target_id = target.id)
+
+            for target_image_file in target_image_files:
+                file_name = os.path.basename(target_image_file.file_name)
+                suffix = ''
+
+                continue_matching = True
+
+                # incrementally extract the suffix from the file path,
+                # checking it against the list of valid suffixes at each
+                # step; if the path is stripped of all potential suffix
+                # parts without matching a valid suffix, this returns all
+                # characters after the first '.' in the file name
+                while continue_matching:
+                    matches = pattern.search(file_name)
+
+                    if None == matches:
+                        continue_matching = False
+                        suffix = re.sub('^\.', '', suffix)
+                        continue
+                    else:
+                        suffix = matches.group(1) + suffix
+
+                    if suffix in Target_Image_File.SUFFIXES:
+                        continue_matching = False
+                        continue
+                    else:
+                        # reduce the file name and try to find the next
+                        # segment from the path which might be part
+                        # of the suffix
+                        file_name = re.sub('.' + matches.group(1), '', file_name)
+                        suffix = '.' + suffix
+
+                if not suffix in extensions:
+                    extensions.append(suffix)
+
+        return ', '.join(extensions)
 
     def get_sorted_target_list(self):
         tgts = Target.objects.filter(build_id = self.id).order_by( 'target' );
@@ -418,7 +480,7 @@ class Build(models.Model):
             return self.get_outcome_text()
 
     def __str__(self):
-        return "%s %s %s" % (self.id, self.project, ",".join([t.target for t in self.target_set.all()]))
+        return "%d %s %s" % (self.id, self.project, ",".join([t.target for t in self.target_set.all()]))
 
 
 # an Artifact is anything that results from a Build, and may be of interest to the user, and is not stored elsewhere
@@ -609,7 +671,7 @@ class Task(models.Model):
     sstate_text  = property(get_sstate_text)
 
     def __unicode__(self):
-        return "%s(%s) %s:%s" % (self.pk, self.build.pk, self.recipe.name, self.task_name)
+        return "%d(%d) %s:%s" % (self.pk, self.build.pk, self.recipe.name, self.task_name)
 
     class Meta:
         ordering = ('order', 'recipe' ,)
@@ -1265,7 +1327,7 @@ class Layer_Version(models.Model):
         return sorted(result, key=lambda x: x.layer.name)
 
     def __unicode__(self):
-        return "%s %s (VCS %s, Project %s)" % (self.pk, str(self.layer), self.get_vcs_reference(), self.build.project if self.build is not None else "No project")
+        return "%d %s (VCS %s, Project %s)" % (self.pk, str(self.layer), self.get_vcs_reference(), self.build.project if self.build is not None else "No project")
 
     class Meta:
         unique_together = ("layer_source", "up_id")
diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index e5cab48..cc9b5ae 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -661,7 +661,7 @@ class ProjectsTable(ToasterTable):
 
         self.queryset = queryset
 
-    # columns: last activity on (updated) - DEFAULT, project (name), release, machine, number of builds, last build outcome, recipe (name), errors, warnings, image files
+    # columns: last activity on (updated) - DEFAULT, project (name), release, machine, number of builds, last build outcome, recipe (name),  errors, warnings, image files
     def setup_columns(self, *args, **kwargs):
         name_template = '''
         {% load project_url_tag %}
@@ -767,10 +767,9 @@ class ProjectsTable(ToasterTable):
         '''
 
         image_files_template = '''
-        {% load projecttags %}
         {% if data.get_number_of_builds > 0 and data.get_last_outcome == extra.Build.SUCCEEDED %}
           <a href="{% url "builddashboard" data.get_last_build_id %}#images">
-            {{fstypes | get_dict_value:data.id}}
+            {{data.get_last_build_extensions}}
           </a>
         {% endif %}
         '''
@@ -848,7 +847,8 @@ class ProjectsTable(ToasterTable):
                         static_data_template=warnings_template)
 
         self.add_column(title='Image files',
-                        help_text='',
+                        help_text='The root file system types produced by \
+                                   the last project build',
                         hideable=True,
                         orderable=False,
                         static_data_name='image_files',
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 4cd7afd..8148623 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2008,23 +2008,10 @@ if True:
         context_date,today_begin,yesterday_begin = _add_daterange_context(queryset_all, request, {'started_on','completed_on'})
 
         # set up list of fstypes for each build
-        fstypes_map = {};
+        fstypes_map = {}
+
         for build in build_info:
-            targets = Target.objects.filter( build_id = build.id )
-            comma = "";
-            extensions = "";
-            for t in targets:
-                if ( not t.is_image ):
-                    continue
-                tif = Target_Image_File.objects.filter( target_id = t.id )
-                for i in tif:
-                    s=re.sub('.*tar.bz2', 'tar.bz2', i.file_name)
-                    if s == i.file_name:
-                        s=re.sub('.*\.', '', i.file_name)
-                    if None == re.search(s,extensions):
-                        extensions += comma + s
-                        comma = ", "
-            fstypes_map[build.id]=extensions
+            fstypes_map[build.id] = build.get_image_file_extensions()
 
         # send the data to the template
         context = {
@@ -3047,24 +3034,7 @@ if True:
         # translate the project's build target strings
         fstypes_map = {};
         for project in project_info:
-            try:
-                targets = Target.objects.filter( build_id = project.get_last_build_id() )
-                comma = "";
-                extensions = "";
-                for t in targets:
-                    if ( not t.is_image ):
-                        continue
-                    tif = Target_Image_File.objects.filter( target_id = t.id )
-                    for i in tif:
-                        s=re.sub('.*tar.bz2', 'tar.bz2', i.file_name)
-                        if s == i.file_name:
-                            s=re.sub('.*\.', '', i.file_name)
-                        if None == re.search(s,extensions):
-                            extensions += comma + s
-                            comma = ", "
-                fstypes_map[project.id]=extensions
-            except (Target.DoesNotExist,IndexError):
-                fstypes_map[project.id]=project.get_last_imgfiles
+            fstypes_map[project.id] = project.get_last_build_extensions()
 
         context = {
                 'mru' : build_mru,
-- 
2.1.4


