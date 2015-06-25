Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
	[209.85.212.169])
	by mail.openembedded.org (Postfix) with ESMTP id 0A7AB758E1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 10:35:10 +0000 (UTC)
Received: by wicgi11 with SMTP id gi11so71424069wic.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 03:35:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=1S48DLw0466+7b1UDnVpvcm6A+hKaAcuYR5vbqXwy80=;
	b=LDigYnsZMfpfQ7hmlVZb05h1r8BhGmJtAKj+/w3DxY+Mqohf+brgfrz/LXVx6hWUa/
	0K7pYEL8vv/Xj4If+DnmHhf9t8kl6ndRWSIX70rpX93BKjwt9W6XnsTCxMY9nw9VnH1C
	FSEmtdk+udReEcxcJQGyzkTHpbCZ2c4d9j86l+OTzNWoti7QojBqFjFyF1S9U9T/y8bz
	2ym2Gr8axAMVREzWo2c5lgO87x3sdmiMWgFNUYEe0lL8lBQDlJHvN5Afz4tXMZDAsJCx
	KCrQYMAIPWZ2vON3y4jNOtE/p5JZ5t/DWwSfiu2FrAA1Kg+cT8pJYTwpe2dOn+ySwURT
	EvTw==
X-Gm-Message-State: ALoCoQnD8NYzwF7k3Xm7Fl2lT5RwniKEgPy/90IDqY6duXdcVCy57SzUFIUZG9A+48woODM+E/gP
X-Received: by 10.180.75.15 with SMTP id y15mr837347wiv.51.1435228511893;
	Thu, 25 Jun 2015 03:35:11 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	sc16sm7207403wjb.28.2015.06.25.03.35.10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Jun 2015 03:35:11 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id E49F0562B64; Thu, 25 Jun 2015 11:34:01 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Jun 2015 11:33:57 +0100
Message-Id: <04a3e4614aae8ba794a3b8ac9083e723de7ca522.1435228176.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
References: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1435228175.git.alexandru.damian@intel.com>
References: <cover.1435228175.git.alexandru.damian@intel.com>
Subject: [PATCH 20/23] toaster: Restore 'in project' filters to main tables
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
X-List-Received-Date: Thu, 25 Jun 2015 10:35:13 -0000

From: Michael Wood <michael.g.wood@intel.com>

Restores the previously removed filters from recipes, machines and layers
table. These filters allow filtering down the results to just displaying
the current added layers, machines or recipes in the project.

[YOCTO #7851]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/tables.py | 75 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index 43b81a3..146a8dd 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -26,6 +26,24 @@ from django.conf.urls import url
 from django.core.urlresolvers import reverse
 from django.views.generic import TemplateView
 
+
+class ProjectFiltersMixin(object):
+    """Common mixin for recipe, machine in project filters"""
+
+    def filter_in_project(self, count_only=False):
+        query = self.queryset.filter(layer_version__in=self.project_layers)
+        if count_only:
+            return query.count()
+
+        self.queryset = query
+
+    def filter_not_in_project(self, count_only=False):
+        query = self.queryset.exclude(layer_version__in=self.project_layers)
+        if count_only:
+            return query.count()
+
+        self.queryset = query
+
 class LayersTable(ToasterTable):
     """Table of layers in Toaster"""
 
@@ -37,12 +55,40 @@ class LayersTable(ToasterTable):
         context = super(LayersTable, self).get_context_data(**kwargs)
 
         project = Project.objects.get(pk=kwargs['pid'])
+
         context['project'] = project
         context['projectlayers'] = map(lambda prjlayer: prjlayer.layercommit.id, ProjectLayer.objects.filter(project=project))
 
         return context
 
 
+    def setup_filters(self, *args, **kwargs):
+        project = Project.objects.get(pk=kwargs['pid'])
+        self.project_layers = ProjectLayer.objects.filter(project=project)
+
+
+        self.add_filter(title="Filter by project layers",
+                        name="in_current_project",
+                        filter_actions=[
+                            self.make_filter_action("in_project", "Layers added to this project", self.filter_in_project),
+                            self.make_filter_action("not_in_project", "Layers not added to this project", self.filter_not_in_project)
+                        ])
+
+    def filter_in_project(self, count_only=False):
+        query = self.queryset.filter(projectlayer__in=self.project_layers)
+        if count_only:
+            return query.count()
+
+        self.queryset = query
+
+    def filter_not_in_project(self, count_only=False):
+        query = self.queryset.exclude(projectlayer__in=self.project_layers)
+        if count_only:
+            return query.count()
+
+        self.queryset = query
+
+
     def setup_queryset(self, *args, **kwargs):
         prj = Project.objects.get(pk = kwargs['pid'])
         compatible_layers = prj.compatible_layerversions()
@@ -140,6 +186,7 @@ class LayersTable(ToasterTable):
         self.add_column(title="Add | Delete",
                         help_text="Add or delete layers to / from your project",
                         hideable=False,
+                        filter_name="in_current_project",
                         static_data_name="add-del-layers",
                         static_data_template='{% include "layer_btn.html" %}')
 
@@ -169,7 +216,7 @@ class LayerDetails(ToasterTemplateView):
         return context
 
 
-class MachinesTable(ToasterTable):
+class MachinesTable(ToasterTable, ProjectFiltersMixin):
     """Table of Machines in Toaster"""
 
     def __init__(self, *args, **kwargs):
@@ -183,6 +230,16 @@ class MachinesTable(ToasterTable):
         context['projectlayers'] = map(lambda prjlayer: prjlayer.layercommit.id, ProjectLayer.objects.filter(project=context['project']))
         return context
 
+    def setup_filters(self, *args, **kwargs):
+        project = Project.objects.get(pk=kwargs['pid'])
+        self.project_layers = project.projectlayer_equivalent_set()
+
+        self.add_filter(title="Filter by project machines",
+                        name="in_current_project",
+                        filter_actions=[
+                            self.make_filter_action("in_project", "Machines provided by layers added to this project", self.filter_in_project),
+                            self.make_filter_action("not_in_project", "Machines provided by layers not added to this project", self.filter_not_in_project)
+                        ])
 
     def setup_queryset(self, *args, **kwargs):
         prj = Project.objects.get(pk = kwargs['pid'])
@@ -226,6 +283,7 @@ class MachinesTable(ToasterTable):
         self.add_column(title="Select",
                         help_text="Sets the selected machine as the project machine. You can only have one machine per project",
                         hideable=False,
+                        filter_name="in_current_project",
                         static_data_name="add-del-layers",
                         static_data_template='{% include "machine_btn.html" %}')
 
@@ -264,7 +322,7 @@ class LayerMachinesTable(MachinesTable):
                         static_data_template=select_btn_template)
 
 
-class RecipesTable(ToasterTable):
+class RecipesTable(ToasterTable, ProjectFiltersMixin):
     """Table of Recipes in Toaster"""
 
     def __init__(self, *args, **kwargs):
@@ -282,6 +340,17 @@ class RecipesTable(ToasterTable):
 
         return context
 
+    def setup_filters(self, *args, **kwargs):
+        project = Project.objects.get(pk=kwargs['pid'])
+        self.project_layers = project.projectlayer_equivalent_set()
+
+        self.add_filter(title="Filter by project recipes",
+                        name="in_current_project",
+                        filter_actions=[
+                            self.make_filter_action("in_project", "Recipes provided by layers added to this project", self.filter_in_project),
+                            self.make_filter_action("not_in_project", "Recipes provided by layers not added to this project", self.filter_not_in_project)
+                        ])
+
 
     def setup_queryset(self, *args, **kwargs):
         prj = Project.objects.get(pk = kwargs['pid'])
@@ -318,6 +387,7 @@ class RecipesTable(ToasterTable):
 
         self.add_column(title="Recipe file",
                         help_text="Path to the recipe .bb file",
+                        hidden=True,
                         static_data_name="recipe-file",
                         static_data_template=recipe_file_template)
 
@@ -348,6 +418,7 @@ class RecipesTable(ToasterTable):
         self.add_column(title="Build",
                         help_text="Add or delete recipes to and from your project",
                         hideable=False,
+                        filter_name="in_current_project",
                         static_data_name="add-del-layers",
                         static_data_template='{% include "recipe_btn.html" %}')
 
-- 
1.9.1


