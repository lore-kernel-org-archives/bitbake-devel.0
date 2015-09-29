Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
	[209.85.220.52])
	by mail.openembedded.org (Postfix) with ESMTP id E586C77056
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 04:44:05 +0000 (UTC)
Received: by pacex6 with SMTP id ex6so194495381pac.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Sep 2015 21:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=dCPERk8Cpg8YgoI9gbiq4zBNlT86FwgCfDqG0k8Wuys=;
	b=hXGEOTTAby6YITDldNwWL7yvyF7qI455KRMwLwNSAkUPiIRP2GFbWL9GPanT9gwXO9
	m2Rx8x2jtgJKq8/S/8J5Edx+HlBE4SKTpSBhlVsuAEoJCAvG9oXcdcbi3AIpIhOFk6Me
	kVvdTiq3+/s2XYAYAXykybc4igr2xETRMikemHq82ZkFzZqfugvGNbD+b+AGm6SD8gE3
	8yqnggKOjkuvvIjIh6a0LUoRYTdHwlMTAyVy8XVbP8fjD/1n1FavNTGXSIciJYHLjDDc
	aRSvZ0d1yiR/j2X4yeSRgAHyAhr51wySCNsm6ZK/JqMXQ+r/nB3xqEQpYyjC5uo4KI4Q
	yqAQ==
X-Received: by 10.68.137.161 with SMTP id qj1mr30842868pbb.14.1443501846015;
	Mon, 28 Sep 2015 21:44:06 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	g5sm22686368pat.21.2015.09.28.21.44.05
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 28 Sep 2015 21:44:05 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Sep 2015 21:45:23 -0700
Message-Id: <924ee2b247169ac42aa0a6c58673fe5fb37239ff.1443497922.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
References: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
In-Reply-To: <cover.1443497922.git.avery.brian@gmail.com>
References: <cover.1443497922.git.avery.brian@gmail.com>
Subject: [PATCH 13/22] toaster: Add ToasterTables for Image customisation feature
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
X-List-Received-Date: Tue, 29 Sep 2015 04:44:06 -0000

From: Michael Wood <michael.g.wood@intel.com>

- Split up the recipes tables into Image recipes and Software Recipes
- Add CustomImageRecipe table
- Add SelectPackagesTable table
- Add NewCustomImagesTable table

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/tables.py | 222 +++++++++++++++++++++++++++++++++------
 1 file changed, 188 insertions(+), 34 deletions(-)

diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index 70e4b6d..1526d59 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -21,6 +21,7 @@
 
 from toastergui.widgets import ToasterTable
 from orm.models import Recipe, ProjectLayer, Layer_Version, Machine, Project
+from orm.models import CustomImageRecipe, Package
 from django.db.models import Q, Max
 from django.conf.urls import url
 from django.core.urlresolvers import reverse
@@ -310,13 +311,20 @@ class LayerMachinesTable(MachinesTable):
 
 
 class RecipesTable(ToasterTable, ProjectFiltersMixin):
-    """Table of Recipes in Toaster"""
+    """Table of All Recipes in Toaster"""
 
     def __init__(self, *args, **kwargs):
         super(RecipesTable, self).__init__(*args, **kwargs)
         self.empty_state = "Toaster has no recipe information. To generate recipe information you can configure a layer source then run a build."
         self.default_orderby = "name"
 
+    build_col = { 'title' : "Build",
+            'help_text' : "Add or delete recipes to and from your project",
+            'hideable' : False,
+            'filter_name' : "in_current_project",
+            'static_data_name' : "add-del-layers",
+            'static_data_template' : '{% include "recipe_btn.html" %}'}
+
     def get_context_data(self, **kwargs):
         project = Project.objects.get(pk=kwargs['pid'])
         context = super(RecipesTable, self).get_context_data(**kwargs)
@@ -327,17 +335,6 @@ class RecipesTable(ToasterTable, ProjectFiltersMixin):
 
         return context
 
-    def setup_filters(self, *args, **kwargs):
-        project = Project.objects.get(pk=kwargs['pid'])
-        self.project_layers = project.projectlayer_equivalent_set()
-
-        self.add_filter(title="Filter by project recipes",
-                        name="in_current_project",
-                        filter_actions=[
-                            self.make_filter_action("in_project", "Recipes provided by layers added to this project", self.filter_in_project),
-                            self.make_filter_action("not_in_project", "Recipes provided by layers not added to this project", self.filter_not_in_project)
-                        ])
-
 
     def setup_queryset(self, *args, **kwargs):
         prj = Project.objects.get(pk = kwargs['pid'])
@@ -348,12 +345,6 @@ class RecipesTable(ToasterTable, ProjectFiltersMixin):
 
     def setup_columns(self, *args, **kwargs):
 
-        self.add_column(title="Recipe",
-                        help_text="Information about a single piece of software, including where to download the source, configuration options, how to compile the source files and how to package the compiled output",
-                        hideable=False,
-                        orderable=True,
-                        field_name="name")
-
         self.add_column(title="Recipe Version",
                         hidden=True,
                         field_name="version")
@@ -398,18 +389,6 @@ class RecipesTable(ToasterTable, ProjectFiltersMixin):
         self.add_column(title="Revision",
                         field_name="layer_version__get_vcs_reference")
 
-        self.add_column(title="Build",
-                        help_text="Add or delete recipes to and from your project",
-                        hideable=False,
-                        filter_name="in_current_project",
-                        static_data_name="add-del-layers",
-                        static_data_template='{% include "recipe_btn.html" %}')
-
-        project = Project.objects.get(pk=kwargs['pid'])
-        self.add_column(title="Project compatible Layer ID",
-                        displayable = False,
-                        field_name = "projectcompatible_layer",
-                        computation = lambda x: (x.layer_version.get_equivalents_wpriority(project)[0]))
 
 class LayerRecipesTable(RecipesTable):
     """ Smaller version of the Recipes table for use in layer details """
@@ -446,10 +425,185 @@ class LayerRecipesTable(RecipesTable):
                         static_data_name="add-del-layers",
                         static_data_template=build_recipe_template)
 
-class ProjectLayersRecipesTable(RecipesTable):
-    """ Table that lists only recipes available for layers added to the project """
+class CustomImagesTable(ToasterTable):
+    """ Table to display your custom images """
+    def __init__(self, *args, **kwargs):
+        super(CustomImagesTable, self).__init__(*args, **kwargs)
+        self.title = "Custom images"
+
+    def get_context_data(self, **kwargs):
+        context = super(CustomImagesTable, self).get_context_data(**kwargs)
+        project = Project.objects.get(pk=kwargs['pid'])
+        context['project'] = project
+        context['projectlayers'] = map(lambda prjlayer: prjlayer.layercommit.id, ProjectLayer.objects.filter(project=context['project']))
+        return context
+
+    def setup_queryset(self, *args, **kwargs):
+        prj = Project.objects.get(pk = kwargs['pid'])
+        self.queryset = CustomImageRecipe.objects.filter(project=prj)
+        self.queryset = self.queryset.order_by('name')
+
+    def setup_columns(self, *args, **kwargs):
+
+        name_link_template = '''
+        <a href="{% url 'customrecipe' extra.pid data.id %}">
+          {{data.name}}
+        </a>
+        '''
+
+        self.add_column(title="Custom image",
+                        hideable=False,
+                        static_data_name="name",
+                        static_data_template=name_link_template)
+
+        self.add_column(title="Recipe file",
+                        static_data_name='recipe_file',
+                        static_data_template='')
+
+        approx_packages_template = '<a href="#imagedetails">{{data.packages.all|length}}</a>'
+        self.add_column(title="Approx packages",
+                        static_data_name='approx_packages',
+                        static_data_template=approx_packages_template)
+
+
+        build_btn_template = '''<button data-recipe-name="{{data.name}}"
+        class="btn btn-block build-recipe-btn" style="margin-top: 5px;" >
+        Build</button>'''
+
+        self.add_column(title="Build",
+                        hideable=False,
+                        static_data_name='build_custom_img',
+                        static_data_template=build_btn_template)
+
+class ImageRecipesTable(RecipesTable):
+    """ A subset of the recipes table which displayed just image recipes """
+
+    def __init__(self, *args, **kwargs):
+        super(ImageRecipesTable, self).__init__(*args, **kwargs)
+        self.title = "Compatible image recipes"
+
+    def setup_queryset(self, *args, **kwargs):
+        super(ImageRecipesTable, self).setup_queryset(*args, **kwargs)
+
+        self.queryset = self.queryset.filter(is_image=True)
+
+
+    def setup_columns(self, *args, **kwargs):
+        self.add_column(title="Image recipe",
+                        help_text="When you build an image recipe, you get an "
+                                  "image: a root file system you can"
+                                  "deploy to a machine",
+                        hideable=False,
+                        orderable=True,
+                        field_name="name")
+
+        super(ImageRecipesTable, self).setup_columns(*args, **kwargs)
+
+        self.add_column(**RecipesTable.build_col)
+
+
+class NewCustomImagesTable(ImageRecipesTable):
+    """ Table which displays Images recipes which can be customised """
+    def __init__(self, *args, **kwargs):
+        super(NewCustomImagesTable, self).__init__(*args, **kwargs)
+        self.title = "Select the image recipe you want to customise"
 
     def setup_queryset(self, *args, **kwargs):
-        super(ProjectLayersRecipesTable, self).setup_queryset(*args, **kwargs)
+        super(ImageRecipesTable, self).setup_queryset(*args, **kwargs)
+
+        self.queryset = self.queryset.filter(is_image=True)
+
+    def setup_columns(self, *args, **kwargs):
+        self.add_column(title="Image recipe",
+                        help_text="When you build an image recipe, you get an "
+                                  "image: a root file system you can"
+                                  "deploy to a machine",
+                        hideable=False,
+                        orderable=True,
+                        field_name="recipe__name")
+
+        super(ImageRecipesTable, self).setup_columns(*args, **kwargs)
+
+        self.add_column(title="Customise",
+                        hideable=False,
+                        filter_name="in_current_project",
+                        static_data_name="customise-or-add-recipe",
+                        static_data_template='{% include "customise_btn.html" %}')
+
+
+class SoftwareRecipesTable(RecipesTable):
+    """ Displays just the software recipes """
+    def __init__(self, *args, **kwargs):
+        super(SoftwareRecipesTable, self).__init__(*args, **kwargs)
+        self.title = "Compatible software recipes"
+
+    def setup_queryset(self, *args, **kwargs):
+        super(SoftwareRecipesTable, self).setup_queryset(*args, **kwargs)
+
+        self.queryset = self.queryset.filter(is_image=False)
+
+
+    def setup_columns(self, *args, **kwargs):
+        self.add_column(title="Software recipe",
+                        help_text="Information about a single piece of "
+                        "software, including where to download the source, "
+                        "configuration options, how to compile the source "
+                        "files and how to package the compiled output",
+                        hideable=False,
+                        orderable=True,
+                        field_name="name")
+
+        super(SoftwareRecipesTable, self).setup_columns(*args, **kwargs)
+
+        self.add_column(**RecipesTable.build_col)
+
+
+class SelectPackagesTable(ToasterTable):
+    """ Table to display the packages to add and remove from an image """
+
+    def __init__(self, *args, **kwargs):
+        super(SelectPackagesTable, self).__init__(*args, **kwargs)
+        self.title = "Add | Remove packages"
+
+    def setup_queryset(self, *args, **kwargs):
+        cust_recipe = CustomImageRecipe.objects.get(pk=kwargs['recipeid'])
         prj = Project.objects.get(pk = kwargs['pid'])
-        self.queryset = self.queryset.filter(layer_version__in = prj.projectlayer_equivalent_set())
+
+        current_packages = cust_recipe.packages.all()
+
+        # Get all the packages that are in the custom image
+        # Get all the packages built by builds in the current project
+        # but not those ones that are already in the custom image
+        self.queryset = Package.objects.filter(
+                            Q(pk__in=current_packages) |
+                            (Q(build__project=prj) &
+                            ~Q(name__in=current_packages.values_list('name'))))
+
+        self.queryset = self.queryset.order_by('name')
+
+        self.static_context_extra['recipe_id'] = kwargs['recipeid']
+        self.static_context_extra['current_packages'] = \
+                cust_recipe.packages.values_list('pk', flat=True)
+
+    def setup_columns(self, *args, **kwargs):
+        self.add_column(title="Package",
+                        hideable=False,
+                        orderable=True,
+                        field_name="name")
+
+        self.add_column(title="Package Version",
+                        field_name="version")
+
+        self.add_column(title="Approx Size",
+                        orderable=True,
+                        static_data_name="size",
+                        static_data_template="{% load projecttags %} \
+                        {{data.size|filtered_filesizeformat}}")
+        self.add_column(title="summary",
+                        field_name="summary")
+
+        self.add_column(title="Add | Remove",
+                        help_text="Use the add and remove buttons to modify "
+                        "the package content of you custom image",
+                        static_data_name="add_rm_pkg_btn",
+                        static_data_template='{% include "pkg_add_rm_btn.html" %}')
-- 
1.9.1


