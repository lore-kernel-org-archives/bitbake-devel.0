Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 577EE7327E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 12:58:14 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 15 Jan 2016 04:58:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,299,1449561600"; d="scan'208";a="881987102"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga001.fm.intel.com with ESMTP; 15 Jan 2016 04:58:15 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 6F59F6A4004
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 05:46:11 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jan 2016 13:00:47 +0200
Message-Id: <b1c05d93d5619a5776410ea3e6a8d972cc852967.1452855461.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 04/23] toaster: toastergui: switch projects/ view to ToasterTable
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
X-List-Received-Date: Fri, 15 Jan 2016 12:58:14 -0000

From: Elliot Smith <elliot.smith@intel.com>

Remove the old projects page and replace with the new
ToasterTable-based version.

NB although the projects.html template is no longer required,
it's been left in as there will be changes applied to it for
the new theme. These changes will have to then be transferred
from the projects.html template to projects-toastertable.html.

Similarly, the code for the projects page in views.py has been
retained.

[YOCTO #8738]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/tables.py |  2 +-
 lib/toaster/toastergui/urls.py   |  9 ++-------
 lib/toaster/toastergui/views.py  | 24 ++++++++++++++++++++----
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index cc9b5ae..2e3c8a6 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -638,7 +638,7 @@ class ProjectsTable(ToasterTable):
 
     def __init__(self, *args, **kwargs):
         super(ProjectsTable, self).__init__(*args, **kwargs)
-        self.default_orderby = 'updated'
+        self.default_orderby = '-updated'
         self.title = 'All projects'
         self.static_context_extra['Build'] = Build
 
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index da97a31..b5e9a05 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -74,14 +74,9 @@ urlpatterns = patterns('toastergui.views',
         # project URLs
         url(r'^newproject/$', 'newproject', name='newproject'),
 
-
-        # TODO remove when new toaster table is ready
-        url(r'^projects/$', 'projects', name='all-projects'),
-
-        # TODO move to /projects/ when new toaster table is ready
-        url(r'^projects-new/$',
+        url(r'^projects/$',
             tables.ProjectsTable.as_view(template_name="projects-toastertable.html"),
-            name='all-projects-new'),
+            name='all-projects'),
 
         url(r'^project/(?P<pid>\d+)/$', 'project', name='project'),
         url(r'^project/(?P<pid>\d+)/configuration$', 'projectconf', name='projectconf'),
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 8148623..a79261d 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2990,9 +2990,7 @@ if True:
             }
             return render(request, "unavailable_artifact.html", context)
 
-
-
-
+    """
     @_template_renderer("projects.html")
     def projects(request):
         (pagesize, orderby) = _get_parameters_values(request, 10, 'updated:-')
@@ -3034,7 +3032,24 @@ if True:
         # translate the project's build target strings
         fstypes_map = {};
         for project in project_info:
-            fstypes_map[project.id] = project.get_last_build_extensions()
+            try:
+                targets = Target.objects.filter( build_id = project.get_last_build_id() )
+                comma = "";
+                extensions = "";
+                for t in targets:
+                    if ( not t.is_image ):
+                        continue
+                    tif = Target_Image_File.objects.filter( target_id = t.id )
+                    for i in tif:
+                        s=re.sub('.*tar.bz2', 'tar.bz2', i.file_name)
+                        if s == i.file_name:
+                            s=re.sub('.*\.', '', i.file_name)
+                        if None == re.search(s,extensions):
+                            extensions += comma + s
+                            comma = ", "
+                fstypes_map[project.id]=extensions
+            except (Target.DoesNotExist,IndexError):
+                fstypes_map[project.id]=project.get_last_imgfiles
 
         context = {
                 'mru' : build_mru,
@@ -3092,3 +3107,4 @@ if True:
 
         _set_parameters_values(pagesize, orderby, request)
         return context
+    """
-- 
2.1.4


