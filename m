Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 906E477FF6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jun 2017 20:53:22 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v5RKrOZe003136
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jun 2017 13:53:24 -0700
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.209) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.294.0; Tue, 27 Jun 2017 13:53:23 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 27 Jun 2017 13:44:30 -0700
Message-ID: <9d9090d15151436a5d0860381a017c76ce3ab869.1498595653.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1498595646.git.David.Reyna@windriver.com>
References: <cover.1498595646.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.209]
Subject: [PATCH 3/5] toaster: Add distro selection support
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
X-List-Received-Date: Tue, 27 Jun 2017 20:53:22 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Add the ability to select a distro in the project page,
based on values from the Layer Index. Add a distro selection
page with the add layer feature, based on the add machine
page.

[YOCTO #10632]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/orm/management/commands/lsupdates.py   | 19 +++++
 lib/toaster/orm/migrations/0017_distro_clone.py    | 25 ++++++
 lib/toaster/orm/models.py                          | 31 ++++++++
 lib/toaster/toastergui/api.py                      | 13 +++-
 lib/toaster/toastergui/static/js/projectpage.js    | 73 +++++++++++++++++
 lib/toaster/toastergui/tables.py                   | 91 ++++++++++++++++++++++
 lib/toaster/toastergui/templates/base.html         |  1 +
 .../toastergui/templates/baseprojectpage.html      |  1 +
 lib/toaster/toastergui/templates/distro_btn.html   | 20 +++++
 lib/toaster/toastergui/templates/project.html      | 16 ++++
 lib/toaster/toastergui/typeaheads.py               | 30 +++++++
 lib/toaster/toastergui/urls.py                     |  8 ++
 12 files changed, 325 insertions(+), 3 deletions(-)
 create mode 100644 bitbake/lib/toaster/orm/migrations/0017_distro_clone.py
 create mode 100644 bitbake/lib/toaster/toastergui/templates/distro_btn.html

diff --git a/lib/toaster/orm/management/commands/lsupdates.py b/lib/toaster/orm/management/commands/lsupdates.py
index 90f07c9..0b0d4ff 100644
--- a/lib/toaster/orm/management/commands/lsupdates.py
+++ b/lib/toaster/orm/management/commands/lsupdates.py
@@ -23,6 +23,7 @@ from django.core.management.base import BaseCommand
 
 from orm.models import LayerSource, Layer, Release, Layer_Version
 from orm.models import LayerVersionDependency, Machine, Recipe
+from orm.models import Distro
 
 import os
 import sys
@@ -249,6 +250,24 @@ class Command(BaseCommand):
                                                              depends_on=lvd)
             self.mini_progress("Layer version dependencies", i, total)
 
+        # update Distros
+        logger.info("Fetching distro information")
+        distros_info = _get_json_response(
+            apilinks['distros'] + "?filter=layerbranch__branch__name:%s" %
+            "OR".join(whitelist_branch_names))
+
+        total = len(distros_info)
+        for i, di in enumerate(distros_info):
+            distro, created = Distro.objects.get_or_create(
+                name=di['name'],
+                layer_version=Layer_Version.objects.get(
+                    pk=li_layer_branch_id_to_toaster_lv_id[di['layerbranch']]))
+            distro.up_date = di['updated']
+            distro.name = di['name']
+            distro.description = di['description']
+            distro.save()
+            self.mini_progress("distros", i, total)
+
         # update machines
         logger.info("Fetching machine information")
         machines_info = _get_json_response(
diff --git a/lib/toaster/orm/migrations/0017_distro_clone.py b/lib/toaster/orm/migrations/0017_distro_clone.py
new file mode 100644
index 0000000..d3c5901
--- /dev/null
+++ b/lib/toaster/orm/migrations/0017_distro_clone.py
@@ -0,0 +1,25 @@
+# -*- coding: utf-8 -*-
+from __future__ import unicode_literals
+
+from django.db import migrations, models
+
+class Migration(migrations.Migration):
+
+    dependencies = [
+        ('orm', '0016_clone_progress'),
+    ]
+
+    operations = [
+        migrations.CreateModel(
+            name='Distro',
+            fields=[
+                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
+                ('up_id', models.IntegerField(default=None, null=True)),
+                ('up_date', models.DateTimeField(default=None, null=True)),
+                ('name', models.CharField(max_length=255)),
+                ('description', models.CharField(max_length=255)),
+                ('layer_version', models.ForeignKey(to='orm.Layer_Version')),
+            ],
+        ),
+    ]
+
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 13bd117..5c14727 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -321,6 +321,22 @@ class Project(models.Model):
 
         return queryset
 
+    def get_available_distros(self):
+        """ Returns QuerySet of all Distros which are provided by the
+        Layers currently added to the Project """
+        queryset = Distro.objects.filter(
+            layer_version__in=self.get_project_layer_versions())
+
+        return queryset
+
+    def get_all_compatible_distros(self):
+        """ Returns QuerySet of all the compatible Wind River distros available to the
+        project including ones from Layers not currently added """
+        queryset = Distro.objects.filter(
+            layer_version__in=self.get_all_compatible_layer_versions())
+
+        return queryset
+
     def get_available_recipes(self):
         """ Returns QuerySet of all the recipes that are provided by layers
         added to this project """
@@ -1795,6 +1811,21 @@ def signal_runbuilds():
     except FileNotFoundError:
         logger.info("Stopping existing runbuilds: no current process found")
 
+class Distro(models.Model):
+    search_allowed_fields = ["name", "description", "layer_version__layer__name"]
+    up_date = models.DateTimeField(null = True, default = None)
+
+    layer_version = models.ForeignKey('Layer_Version')
+    name = models.CharField(max_length=255)
+    description = models.CharField(max_length=255)
+
+    def get_vcs_distro_file_link_url(self):
+        path = self.name+'.conf'
+        return self.layer_version.get_vcs_file_link_url(path)
+
+    def __unicode__(self):
+        return "Distro " + self.name + "(" + self.description + ")"
+
 django.db.models.signals.post_save.connect(invalidate_cache)
 django.db.models.signals.post_delete.connect(invalidate_cache)
 django.db.models.signals.m2m_changed.connect(invalidate_cache)
diff --git a/lib/toaster/toastergui/api.py b/lib/toaster/toastergui/api.py
index 5b03550..88d6aa7 100644
--- a/lib/toaster/toastergui/api.py
+++ b/lib/toaster/toastergui/api.py
@@ -874,6 +874,12 @@ class XhrProject(View):
             machinevar.value = request.POST['machineName']
             machinevar.save()
 
+        # Distro name change
+        if 'distroName' in request.POST:
+            distrovar = prj.projectvariable_set.get(name="DISTRO")
+            distrovar.value = request.POST['distroName']
+            distrovar.save()
+
         return JsonResponse({"error": "ok"})
 
     def get(self, request, *args, **kwargs):
@@ -960,10 +966,11 @@ class XhrProject(View):
         except ProjectVariable.DoesNotExist:
             data["machine"] = None
         try:
-            data["distro"] = project.projectvariable_set.get(
-                name="DISTRO").value
+            data["distro"] = {"name":
+                               project.projectvariable_set.get(
+                                   name="DISTRO").value}
         except ProjectVariable.DoesNotExist:
-            data["distro"] = "-- not set yet"
+            data["distro"] = None
 
         data['error'] = "ok"
 
diff --git a/lib/toaster/toastergui/static/js/projectpage.js b/lib/toaster/toastergui/static/js/projectpage.js
index 21adf81..506471e 100644
--- a/lib/toaster/toastergui/static/js/projectpage.js
+++ b/lib/toaster/toastergui/static/js/projectpage.js
@@ -15,6 +15,13 @@ function projectPageInit(ctx) {
   var machineInputForm = $("#machine-input-form");
   var invalidMachineNameHelp = $("#invalid-machine-name-help");
 
+  var distroChangeInput = $("#distro-change-input");
+  var distroChangeBtn = $("#distro-change-btn");
+  var distroForm = $("#select-distro-form");
+  var distroChangeFormToggle = $("#change-distro-toggle");
+  var distroNameTitle = $("#project-distro-name");
+  var distroChangeCancel = $("#cancel-distro-change");
+
   var freqBuildBtn =  $("#freq-build-btn");
   var freqBuildList = $("#freq-build-list");
 
@@ -26,6 +33,7 @@ function projectPageInit(ctx) {
 
   var currentLayerAddSelection;
   var currentMachineAddSelection = "";
+  var currentDistroAddSelection = "";
 
   var urlParams = libtoaster.parseUrlParams();
 
@@ -45,6 +53,17 @@ function projectPageInit(ctx) {
       updateMachineName(prjInfo.machine.name);
     }
 
+    /* If we're receiving a distro set from the url and it's different from
+     * our current distro then activate set machine sequence.
+     */
+    if (urlParams.hasOwnProperty('setDistro') &&
+        urlParams.setDistro !== prjInfo.distro.name){
+        distroChangeInput.val(urlParams.setDistro);
+        distroChangeBtn.click();
+    } else {
+      updateDistroName(prjInfo.distro.name);
+    }
+
    /* Now we're really ready show the page */
     $("#project-page").show();
 
@@ -278,6 +297,60 @@ function projectPageInit(ctx) {
   });
 
 
+  /* Change distro functionality */
+
+  distroChangeFormToggle.click(function(){
+    distroForm.slideDown();
+    distroNameTitle.hide();
+    $(this).hide();
+  });
+
+  distroChangeCancel.click(function(){
+    distroForm.slideUp(function(){
+      distroNameTitle.show();
+      distroChangeFormToggle.show();
+    });
+  });
+
+  function updateDistroName(distroName){
+    distroChangeInput.val(distroName);
+    distroNameTitle.text(distroName);
+  }
+
+  libtoaster.makeTypeahead(distroChangeInput,
+                           libtoaster.ctx.distrosTypeAheadUrl,
+                           { }, function(item){
+    currentDistroAddSelection = item.name;
+    distroChangeBtn.removeAttr("disabled");
+  });
+
+  distroChangeBtn.click(function(e){
+    e.preventDefault();
+    /* We accept any value regardless of typeahead selection or not */
+    if (distroChangeInput.val().length === 0)
+      return;
+
+    currentDistroAddSelection = distroChangeInput.val();
+
+    libtoaster.editCurrentProject(
+      { distroName : currentDistroAddSelection },
+      function(){
+        /* Success machine changed */
+        updateDistroName(currentDistroAddSelection);
+        distroChangeCancel.click();
+
+        /* Show the alert message */
+        var message = $('<span>You have changed the distro to: <strong><span id="notify-machine-name"></span></strong></span>');
+        message.find("#notify-machine-name").text(currentDistroAddSelection);
+        libtoaster.showChangeNotification(message);
+    },
+      function(){
+        /* Failed machine changed */
+        console.warn("Failed to change distro");
+    });
+  });
+
+
   /* Change release functionality */
   function updateProjectRelease(release){
     releaseTitle.text(release.description);
diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index e2d23c1..dca2fa2 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -23,6 +23,7 @@ from toastergui.widgets import ToasterTable
 from orm.models import Recipe, ProjectLayer, Layer_Version, Machine, Project
 from orm.models import CustomImageRecipe, Package, Target, Build, LogMessage, Task
 from orm.models import CustomImagePackage, Package_DependencyManager
+from orm.models import Distro
 from django.db.models import Q, Max, Sum, Count, When, Case, Value, IntegerField
 from django.conf.urls import url
 from django.core.urlresolvers import reverse, resolve
@@ -1536,3 +1537,93 @@ class ProjectBuildsTable(BuildsTable):
             context['build_in_progress_none_completed'] = False
 
         return context
+
+
+class DistrosTable(ToasterTable):
+    """Table of Distros in Toaster"""
+
+    def __init__(self, *args, **kwargs):
+        super(DistrosTable, self).__init__(*args, **kwargs)
+        self.empty_state = "Toaster has no distro information for this project. Sadly, 			   distro information cannot be obtained from builds, so this 				  page will remain empty."
+        self.title = "Compatible Distros"
+        self.default_orderby = "name"
+
+    def get_context_data(self, **kwargs):
+        context = super(DistrosTable, self).get_context_data(**kwargs)
+        context['project'] = Project.objects.get(pk=kwargs['pid'])
+        return context
+
+    def setup_filters(self, *args, **kwargs):
+        project = Project.objects.get(pk=kwargs['pid'])
+
+        in_current_project_filter = TableFilter(
+            "in_current_project",
+            "Filter by project Distros"
+        )
+
+        in_project_action = TableFilterActionToggle(
+            "in_project",
+            "Distro provided by layers added to this project",
+            ProjectFilters.in_project(self.project_layers)
+        )
+
+        not_in_project_action = TableFilterActionToggle(
+            "not_in_project",
+            "Distros provided by layers not added to this project",
+            ProjectFilters.not_in_project(self.project_layers)
+        )
+
+        in_current_project_filter.add_action(in_project_action)
+        in_current_project_filter.add_action(not_in_project_action)
+        self.add_filter(in_current_project_filter)
+
+    def setup_queryset(self, *args, **kwargs):
+        prj = Project.objects.get(pk = kwargs['pid'])
+        self.queryset = prj.get_all_compatible_distros()
+        self.queryset = self.queryset.order_by(self.default_orderby)
+
+        self.static_context_extra['current_layers'] = \
+                self.project_layers = \
+                prj.get_project_layer_versions(pk=True)
+
+    def setup_columns(self, *args, **kwargs):
+
+        self.add_column(title="Distro",
+                        hideable=False,
+                        orderable=True,
+                        field_name="name")
+
+        self.add_column(title="Description",
+                        field_name="description")
+
+        layer_link_template = '''
+        <a href="{% url 'layerdetails' extra.pid data.layer_version.id %}">
+        {{data.layer_version.layer.name}}</a>
+        '''
+
+        self.add_column(title="Layer",
+                        static_data_name="layer_version__layer__name",
+                        static_data_template=layer_link_template,
+                        orderable=True)
+
+        self.add_column(title="Git revision",
+                        help_text="The Git branch, tag or commit. For the layers from the OpenEmbedded layer source, the revision is always the branch compatible with the Yocto Project version you selected for this project",
+                        hidden=True,
+                        field_name="layer_version__get_vcs_reference")
+
+        wrtemplate_file_template = '''<code>conf/machine/{{data.name}}.conf</code>
+        <a href="{{data.get_vcs_machine_file_link_url}}" target="_blank"><span class="glyphicon glyphicon-new-window"></i></a>'''
+
+        self.add_column(title="Distro file",
+                        hidden=True,
+                        static_data_name="templatefile",
+                        static_data_template=wrtemplate_file_template)
+
+
+        self.add_column(title="Select",
+                        help_text="Sets the selected distro to the project",
+                        hideable=False,
+                        filter_name="in_current_project",
+                        static_data_name="add-del-layers",
+                        static_data_template='{% include "distro_btn.html" %}')
+
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index 11c6f91..0fbe17b 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -49,6 +49,7 @@
         recipesTypeAheadUrl: {% url 'xhr_recipestypeahead' project.id as paturl%}{{paturl|json}},
         layersTypeAheadUrl: {% url 'xhr_layerstypeahead' project.id as paturl%}{{paturl|json}},
         machinesTypeAheadUrl: {% url 'xhr_machinestypeahead' project.id as paturl%}{{paturl|json}},
+        distrosTypeAheadUrl: {% url 'xhr_distrostypeahead' project.id as paturl%}{{paturl|json}},
         projectBuildsUrl: {% url 'projectbuilds' project.id as pburl %}{{pburl|json}},
         xhrCustomRecipeUrl : "{% url 'xhr_customrecipe' %}",
         projectId : {{project.id}},
diff --git a/lib/toaster/toastergui/templates/baseprojectpage.html b/lib/toaster/toastergui/templates/baseprojectpage.html
index 8427d25..f2bb2eb 100644
--- a/lib/toaster/toastergui/templates/baseprojectpage.html
+++ b/lib/toaster/toastergui/templates/baseprojectpage.html
@@ -32,6 +32,7 @@ $(document).ready(function(){
       <li><a href="{% url 'projectsoftwarerecipes' project.id %}">Software recipes</a></li>
       <li><a href="{% url 'projectmachines' project.id %}">Machines</a></li>
       <li><a href="{% url 'projectlayers' project.id %}">Layers</a></li>
+      <li><a href="{% url 'projectdistros' project.id %}">Distros</a></li>
       <li class="nav-header">Extra configuration</li>
       <li><a href="{% url 'projectconf' project.id %}">BitBake variables</a></li>
 
diff --git a/lib/toaster/toastergui/templates/distro_btn.html b/lib/toaster/toastergui/templates/distro_btn.html
new file mode 100644
index 0000000..fac7947
--- /dev/null
+++ b/lib/toaster/toastergui/templates/distro_btn.html
@@ -0,0 +1,20 @@
+<a href="{% url 'project' extra.pid %}?setDistro={{data.name}}" class="btn btn-default btn-block layer-exists-{{data.layer_version.id}}"
+    {% if data.layer_version.pk not in extra.current_layers %}
+    style="display:none;"
+    {% endif %}>
+  Set distro</a>
+<a class="btn btn-default btn-block layerbtn layer-add-{{data.layer_version.id}}" data-layer='{
+    "id": {{data.layer_version.id}},
+    "name":  "{{data.layer_version.layer.name}}",
+    "xhrLayerUrl": "{% url "xhr_layer" extra.pid data.pk %}",
+    "layerdetailurl": "{%url 'layerdetails' extra.pid data.layer_version.id %}"
+    }' data-directive="add"
+    {% if data.layer_version.pk in extra.current_layers %}
+    style="display:none;"
+    {% endif %}
+>
+  <span class="glyphicon glyphicon-plus"></span>
+  Add layer
+  <span class="glyphicon glyphicon-question-sign get-help" title="To select this distro, you must first add the {{data.layer_version.layer.name}} layer to your project"></i>
+</a>
+
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index ab7e665..11603d1 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -77,6 +77,22 @@
       </form>
     </div>
 
+    <div class="well well-transparent" id="distro-section">
+      <h3>Distro</h3>
+
+      <p class="lead"><span id="project-distro-name"></span> <span class="glyphicon glyphicon-edit" id="change-distro-toggle"></span></p>
+
+      <form id="select-distro-form" style="display:none;" class="form-inline">
+        <span class="help-block">Distro suggestions come from the Layer Index</a></span>
+        <div class="form-group">
+          <input class="form-control" id="distro-change-input" autocomplete="off" value="" data-provide="typeahead" data-minlength="1" data-autocomplete="off" type="text">
+        </div>
+        <button id="distro-change-btn" class="btn btn-default" type="button">Save</button>
+        <a href="#" id="cancel-distro-change" class="btn btn-link">Cancel</a>
+        <p class="form-link"><a href="{% url 'projectdistros' project.id %}">View compatible distros</a></p>
+      </form>
+    </div>
+
     <div class="well well-transparent">
       <h3>Most built recipes</h3>
 
diff --git a/lib/toaster/toastergui/typeaheads.py b/lib/toaster/toastergui/typeaheads.py
index 58c650f..5aa0f8d 100644
--- a/lib/toaster/toastergui/typeaheads.py
+++ b/lib/toaster/toastergui/typeaheads.py
@@ -100,6 +100,36 @@ class MachinesTypeAhead(ToasterTypeAhead):
         return results
 
 
+class DistrosTypeAhead(ToasterTypeAhead):
+    """ Typeahead for all the distros available in the current project's
+    configuration """
+    def __init__(self):
+        super(DistrosTypeAhead, self).__init__()
+
+    def apply_search(self, search_term, prj, request):
+        distros = prj.get_available_distros()
+        distros = distros.order_by("name")
+
+        primary_results = distros.filter(name__istartswith=search_term)
+        secondary_results = distros.filter(name__icontains=search_term).exclude(pk__in=primary_results)
+        tertiary_results = distros.filter(layer_version__layer__name__icontains=search_term).exclude(pk__in=primary_results).exclude(pk__in=secondary_results)
+
+        results = []
+
+        for distro in list(primary_results) + list(secondary_results) + list(tertiary_results):
+
+            detail = "[ %s ]" % (distro.layer_version.layer.name)
+            needed_fields = {
+                'id' : distro.pk,
+                'name' : distro.name,
+                'detail' : detail,
+            }
+
+            results.append(needed_fields)
+
+        return results
+
+
 class RecipesTypeAhead(ToasterTypeAhead):
     """ Typeahead for all the recipes available in the current project's
     configuration """
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index 1ad79a4..6aebc3f 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -158,6 +158,11 @@ urlpatterns = [
             name=tables.LayerMachinesTable.__name__.lower()),
 
 
+        url(r'^project/(?P<pid>\d+)/distros/$',
+            tables.DistrosTable.as_view(template_name="generic-toastertable-page.html"),
+            name="projectdistros"),
+
+
         url(r'^project/(?P<pid>\d+)/customrecipe/(?P<custrecipeid>\d+)/selectpackages/$',
             tables.SelectPackagesTable.as_view(), name="recipeselectpackages"),
 
@@ -187,6 +192,9 @@ urlpatterns = [
             typeaheads.GitRevisionTypeAhead.as_view(),
             name='xhr_gitrevtypeahead'),
 
+        url(r'^xhr_typeahead/(?P<pid>\d+)/distros$',
+            typeaheads.DistrosTypeAhead.as_view(), name='xhr_distrostypeahead'),
+
         url(r'^xhr_testreleasechange/(?P<pid>\d+)$', views.xhr_testreleasechange,
             name='xhr_testreleasechange'),
         url(r'^xhr_configvaredit/(?P<pid>\d+)$', views.xhr_configvaredit,
-- 
1.9.1


