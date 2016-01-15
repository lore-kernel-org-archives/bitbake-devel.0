Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 2198F766EB
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 12:58:29 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 15 Jan 2016 04:58:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,299,1449561600"; d="scan'208";a="891109474"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga002.jf.intel.com with ESMTP; 15 Jan 2016 04:58:30 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 4E5766A4004
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 05:46:26 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jan 2016 13:01:00 +0200
Message-Id: <03ad18513ce3061cab766ef999bb74da116c231d.1452855461.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 17/23] toaster: toastergui: set default visible and hideable columns
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
X-List-Received-Date: Fri, 15 Jan 2016 12:58:29 -0000

From: Elliot Smith <elliot.smith@intel.com>

Incorrect columns were shown by default in the "all builds",
"project builds" and "all projects" pages.

Set the "hidden" property on columns in these tables to hide the
correct columns.

Add a set_column_hidden() method to ToasterTable so that the
"hidden" property can be overridden for the machines column
in the project builds page (it shares a superclass with
all builds).

Make the time column on all builds page hideable.

[YOCTO #8738]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/tables.py  | 23 ++++++++++++++++++++---
 lib/toaster/toastergui/widgets.py | 18 ++++++++++++++++++
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index b7d977e..14077e1 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -812,7 +812,7 @@ class ProjectsTable(ToasterTable):
                                    last project build. If the project has no \
                                    builds, this shows the date the project was \
                                    created.',
-                        hideable=True,
+                        hideable=False,
                         orderable=True,
                         static_data_name='updated',
                         static_data_template=last_activity_on_template)
@@ -836,7 +836,7 @@ class ProjectsTable(ToasterTable):
         self.add_column(title='Number of builds',
                         help_text='The number of builds which have been run \
                                    for the project',
-                        hideable=True,
+                        hideable=False,
                         orderable=False,
                         static_data_name='number_of_builds',
                         static_data_template=number_of_builds_template)
@@ -869,6 +869,7 @@ class ProjectsTable(ToasterTable):
                         help_text='The number of warnings encountered during \
                                    the last project build (if any)',
                         hideable=True,
+                        hidden=True,
                         orderable=False,
                         static_data_name='warnings',
                         static_data_template=warnings_template)
@@ -877,6 +878,7 @@ class ProjectsTable(ToasterTable):
                         help_text='The root file system types produced by \
                                    the last project build',
                         hideable=True,
+                        hidden=True,
                         orderable=False,
                         static_data_name='image_files',
                         static_data_template=image_files_template)
@@ -1076,6 +1078,7 @@ class BuildsTable(ToasterTable):
         self.add_column(title='Started on',
                         help_text='The date and time when the build started',
                         hideable=True,
+                        hidden=True,
                         orderable=True,
                         filter_name='started_on_filter',
                         static_data_name='started_on',
@@ -1116,7 +1119,8 @@ class BuildsTable(ToasterTable):
 
         self.add_column(title='Time',
                         help_text='How long the build took to finish',
-                        hideable=False,
+                        hideable=True,
+                        hidden=True,
                         orderable=False,
                         static_data_name='time',
                         static_data_template=time_template)
@@ -1328,6 +1332,19 @@ class ProjectBuildsTable(BuildsTable):
         # set from the querystring
         self.project_id = None
 
+    def setup_columns(self, *args, **kwargs):
+        """
+        Project builds table doesn't show the machines column by default
+        """
+
+        super(ProjectBuildsTable, self).setup_columns(*args, **kwargs)
+
+        # hide the machine column
+        self.set_column_hidden('Machine', True)
+
+        # allow the machine column to be hidden by the user
+        self.set_column_hideable('Machine', True)
+
     def setup_queryset(self, *args, **kwargs):
         """
         NOTE: self.project_id must be set before calling super(),
diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index d9328d4..d2ef5d3 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -168,6 +168,24 @@ class ToasterTable(TemplateView):
                              'computation': computation,
                             })
 
+    def set_column_hidden(self, title, hidden):
+        """
+        Set the hidden state of the column to the value of hidden
+        """
+        for col in self.columns:
+            if col['title'] == title:
+                col['hidden'] = hidden
+                break
+
+    def set_column_hideable(self, title, hideable):
+        """
+        Set the hideable state of the column to the value of hideable
+        """
+        for col in self.columns:
+            if col['title'] == title:
+                col['hideable'] = hideable
+                break
+
     def render_static_data(self, template, row):
         """Utility function to render the static data template"""
 
-- 
2.1.4


