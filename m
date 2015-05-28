Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
	[209.85.212.170])
	by mail.openembedded.org (Postfix) with ESMTP id 2950775692
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 14:16:03 +0000 (UTC)
Received: by wifw1 with SMTP id w1so64081112wif.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 07:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=F5QXtCSD3LvQ+EJTx8/KDN8Q7rFq390vqM6IoUPO4HU=;
	b=OJxwNCcAo1r3yOj79gwyGJaF57ozzVMibc2rdJece0OYmBZpcIy5p/lvNZJitRYqVu
	6n21kzPfbopznM0d2mgAdN1w7PclfB6YGOXohTqQ3x7Kl1L2AFXlJGJN77u6H0FTQqIy
	gcUUjqPpCLPa/fFF/YLhYmV5O7OgI3Ys3Fc83jTTGbQ/0EagBcF6sFr6WrKXV8cGHn0A
	NdwmLHwB+qpjJ9VEFtdqI8LHAubZdtcZH7Ge4f94jvUNSzQUteDbTyVsxbYe20knJC1B
	iis3HQQE+Ws/p6278Zkr2dTTUQ5zNmXfV9KdS+644wGbZAHg22ZVYDfk/Ub0qgvFV1GJ
	fsvw==
X-Gm-Message-State: ALoCoQnHDV5gZ/4WxSSa5wusC4YqESijv7PjSeMFBsIRe+m6Yj643BB+Eayw5SQoHFGgAY9QPEfM
X-Received: by 10.180.105.38 with SMTP id gj6mr16312027wib.90.1432822564182;
	Thu, 28 May 2015 07:16:04 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id a19sm8783823wiv.2.2015.05.28.07.16.02
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 May 2015 07:16:03 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id C38B456124D; Thu, 28 May 2015 15:14:17 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 28 May 2015 15:14:03 +0100
Message-Id: <30d432def8b3d8f90cd3c7bbe196449424c14791.1432822343.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
References: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1432822343.git.alexandru.damian@intel.com>
References: <cover.1432822343.git.alexandru.damian@intel.com>
Subject: [PATCH 09/22] toaster: Port layerdetails to ToasterTables
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
X-List-Received-Date: Thu, 28 May 2015 14:16:03 -0000

From: Michael Wood <michael.g.wood@intel.com>

This ports the layerdetails page to using ToasterTables
Also some whitespace and strict clean ups in the existing layerdetails
js and html template.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/layerdetails.js   |  70 ++-
 lib/toaster/toastergui/static/js/libtoaster.js     |   3 +
 lib/toaster/toastergui/static/js/table.js          |  77 ++-
 lib/toaster/toastergui/tables.py                   |  87 ++-
 lib/toaster/toastergui/templates/layerdetails.html | 594 +++++++--------------
 .../toastergui/templates/toastertable-filter.html  |  18 +
 .../toastergui/templates/toastertable-simple.html  |  26 +-
 lib/toaster/toastergui/templates/toastertable.html |  50 +-
 lib/toaster/toastergui/urls.py                     |   6 +-
 lib/toaster/toastergui/views.py                    |  49 --
 lib/toaster/toastergui/widgets.py                  |  17 +-
 11 files changed, 415 insertions(+), 582 deletions(-)
 create mode 100644 lib/toaster/toastergui/templates/toastertable-filter.html

diff --git a/lib/toaster/toastergui/static/js/layerdetails.js b/lib/toaster/toastergui/static/js/layerdetails.js
index 3c4d632..3746ea2 100644
--- a/lib/toaster/toastergui/static/js/layerdetails.js
+++ b/lib/toaster/toastergui/static/js/layerdetails.js
@@ -1,4 +1,4 @@
-"use strict"
+"use strict";
 
 function layerDetailsPageInit (ctx) {
 
@@ -54,7 +54,7 @@ function layerDetailsPageInit (ctx) {
 
   /* Add dependency layer button click handler */
   layerDepBtn.click(function(){
-    if (currentLayerDepSelection == undefined)
+    if (currentLayerDepSelection === undefined)
       return;
 
     addRemoveDep(currentLayerDepSelection.id, true, function(){
@@ -122,13 +122,6 @@ function layerDetailsPageInit (ctx) {
     });
   });
 
-  $(".build-target-btn").click(function(){
-    /* fire a build */
-    var target = $(this).data('target-name');
-    libtoaster.startABuild(ctx.projectBuildUrl, libtoaster.ctx.projectId, target, null, null);
-    window.location.replace(libtoaster.ctx.projectPageUrl);
-  });
-
   function defaultAddBtnText(){
       var text = " Add the "+ctx.layerVersion.name+" layer to your project";
       addRmLayerBtn.text(text);
@@ -155,9 +148,48 @@ function layerDetailsPageInit (ctx) {
       }
     }
 
-    window.location.hash = "targets";
+    window.location.hash = "recipes";
   }
 
+  $("#recipestable").on('table-done', function(e, total, tableParams){
+    ctx.numTargets = total;
+
+    if (total === 0 && !tableParams.search) {
+      $("#no-recipes-yet").show();
+    } else {
+      $("#no-recipes-yet").hide();
+    }
+
+    $("#targets-tab").removeClass("muted");
+    if (window.location.hash === "#recipes"){
+      /* re run the machinesTabShow to update the text */
+      targetsTabShow();
+    }
+
+    $(".build-target-btn").unbind('click');
+    $(".build-target-btn").click(function(){
+      /* fire a build */
+      var target = $(this).data('target-name');
+      libtoaster.startABuild(ctx.projectBuildUrl, libtoaster.ctx.projectId, target, null, null);
+      window.location.replace(libtoaster.ctx.projectPageUrl);
+    });
+  });
+
+  $("#machinestable").on('table-done', function(e, total, tableParams){
+    ctx.numMachines = total;
+
+    if (total === 0 && !tableParams.search)
+      $("#no-machines-yet").show();
+    else
+      $("#no-machines-yet").hide();
+
+    $("#machines-tab").removeClass("muted");
+    if (window.location.hash === "#machines"){
+      /* re run the machinesTabShow to update the text */
+      machinesTabShow();
+    }
+  });
+
   $("#targets-tab").on('show', targetsTabShow);
 
   function machinesTabShow(){
@@ -187,7 +219,7 @@ function layerDetailsPageInit (ctx) {
   /* Enables the Build target and Select Machine buttons and switches the
    * add/remove button
    */
-  function setLayerInCurrentPrj(added, depsList) {
+  function setLayerInCurrentPrj(added) {
     ctx.layerVersion.inCurrentPrj = added;
 
     if (added){
@@ -224,18 +256,20 @@ function layerDetailsPageInit (ctx) {
     }
   }
 
-  $("#dismiss-alert").click(function(){ $(this).parent().hide() });
+  $("#dismiss-alert").click(function(){
+    $(this).parent().fadeOut();
+  });
 
   /* Add or remove this layer from the project */
   addRmLayerBtn.click(function() {
 
-    var add = ($(this).data('directive') === "add")
+    var add = ($(this).data('directive') === "add");
 
     libtoaster.addRmLayer(ctx.layerVersion, add, function (layersList){
       var alertMsg = $("#alert-msg");
       alertMsg.html(libtoaster.makeLayerAddRmAlertMsg(ctx.layerVersion, layersList, add));
 
-      setLayerInCurrentPrj(add, layersList);
+      setLayerInCurrentPrj(add);
 
       $("#alert-area").show();
     });
@@ -250,9 +284,9 @@ function layerDetailsPageInit (ctx) {
      * from.
      */
     var entryElement = mParent.find("input");
-    if (entryElement.length == 0)
+    if (entryElement.length === 0)
       entryElement = mParent.find("textarea");
-    if (entryElement.length == 0) {
+    if (entryElement.length === 0) {
       console.warn("Could not find element to get data from for this change");
       return;
     }
@@ -293,7 +327,7 @@ function layerDetailsPageInit (ctx) {
 
   /* Disable the change button when we have no data in the input */
   $("dl input, dl textarea").on("input",function() {
-    if ($(this).val().length == 0)
+    if ($(this).val().length === 0)
       $(this).parent().children(".change-btn").attr("disabled", "disabled");
     else
       $(this).parent().children(".change-btn").removeAttr("disabled");
@@ -322,7 +356,7 @@ function layerDetailsPageInit (ctx) {
   });
 
   /* Hide the right column if it contains no information */
-  if ($("dl.item-info").children(':visible').length == 0) {
+  if ($("dl.item-info").children(':visible').length === 0) {
     $("dl.item-info").parent().hide();
   }
 
diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index 1ac26d4..99e1f03 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -216,6 +216,9 @@ var libtoaster = (function (){
       str += "&";
     }
 
+    /* Maintain the current hash */
+    str += window.location.hash;
+
     return str;
   }
 
diff --git a/lib/toaster/toastergui/static/js/table.js b/lib/toaster/toastergui/static/js/table.js
index 97370fd..2e35e38 100644
--- a/lib/toaster/toastergui/static/js/table.js
+++ b/lib/toaster/toastergui/static/js/table.js
@@ -64,10 +64,12 @@ function tableInit(ctx){
 
   function updateTable(tableData) {
     var tableBody = table.children("tbody");
-    var paginationBtns = $('#pagination-'+ctx.tableName);
+    var pagination = $('#pagination-'+ctx.tableName);
+    var paginationBtns = pagination.children('ul');
+    var tableContainer = $("#table-container-"+ctx.tableName);
 
+    tableContainer.css("visibility", "hidden");
     /* To avoid page re-layout flicker when paging set fixed height */
-    table.css("visibility", "hidden");
     table.css("padding-bottom", table.height());
 
     /* Reset table components */
@@ -83,19 +85,30 @@ function tableInit(ctx){
     tableTotal = tableData.total;
 
     if (tableData.total === 0){
-      $("#table-container-"+ctx.tableName).hide();
-      $("#new-search-input-"+ctx.tableName).val(tableParams.search);
-      $("#no-results-"+ctx.tableName).show();
+      tableContainer.hide();
+      /* If we were searching show the new search bar and return */
+      if (tableParams.search){
+        $("#new-search-input-"+ctx.tableName).val(tableParams.search);
+        $("#no-results-"+ctx.tableName).show();
+      }
+      table.trigger("table-done", [tableData.total, tableParams]);
+
       return;
+
+    /* We don't want to clutter the place with the table chrome if there
+     * are only a few results */
+    } else if (tableData.total <= 10 &&
+               !tableParams.filter &&
+               !tableParams.search){
+      $("#table-chrome-"+ctx.tableName).hide();
+      pagination.hide();
     } else {
-      $("#table-container-"+ctx.tableName).show();
+      tableContainer.show();
       $("#no-results-"+ctx.tableName).hide();
     }
 
-
     setupTableChrome(tableData);
 
-
     /* Add table data rows */
     for (var i in tableData.rows){
       var row = $("<tr></tr>");
@@ -137,26 +150,31 @@ function tableInit(ctx){
     var end = tableParams.page + 2;
     var numPages = Math.ceil(tableData.total/tableParams.limit);
 
-    if (tableParams.page < 3)
-      end = 5;
+    if (numPages >  1){
+      if (tableParams.page < 3)
+        end = 5;
 
-    for (var page_i=1; page_i <= numPages;  page_i++){
-      if (page_i >= start && page_i <= end){
-        var btn = $('<li><a href="#" class="page">'+page_i+'</a></li>');
+      for (var page_i=1; page_i <= numPages;  page_i++){
+        if (page_i >= start && page_i <= end){
+          var btn = $('<li><a href="#" class="page">'+page_i+'</a></li>');
 
-        if (page_i === tableParams.page){
-          btn.addClass("active");
-        }
+          if (page_i === tableParams.page){
+            btn.addClass("active");
+          }
 
-        /* Add the click handler */
-        btn.click(pageButtonClicked);
-        paginationBtns.append(btn);
+          /* Add the click handler */
+          btn.click(pageButtonClicked);
+          paginationBtns.append(btn);
+        }
       }
     }
-    table.css("padding-bottom", 0);
+
     loadColumnsPreference();
 
-    $("table").css("visibility", "visible");
+    table.css("padding-bottom", 0);
+    tableContainer.css("visibility", "visible");
+
+    table.trigger("table-done", [tableData.total, tableParams]);
   }
 
   function setupTableChrome(tableData){
@@ -374,9 +392,9 @@ function tableInit(ctx){
         data: params,
         headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
         success: function (filterData) {
-          var filterActionRadios = $('#filter-actions');
+          var filterActionRadios = $('#filter-actions-'+ctx.tableName);
 
-          $('#filter-modal-title').text(filterData.title);
+          $('#filter-modal-title-'+ctx.tableName).text(filterData.title);
 
           filterActionRadios.text("");
 
@@ -404,7 +422,7 @@ function tableInit(ctx){
             filterActionRadios.append(action);
           }
 
-          $('#filter-modal').modal('show');
+          $('#filter-modal-'+ctx.tableName).modal('show');
         }
     });
   }
@@ -417,17 +435,18 @@ function tableInit(ctx){
     e.stopPropagation();
   });
 
-  $(".pagesize").val(tableParams.limit);
+  $(".pagesize-"+ctx.tableName).val(tableParams.limit);
 
   /* page size selector  */
-  $(".pagesize").change(function(){
+  $(".pagesize-"+ctx.tableName).change(function(e){
     tableParams.limit = Number(this.value);
     if ((tableParams.page * tableParams.limit) > tableTotal)
       tableParams.page = 1;
 
     loadData(tableParams);
     /* sync the other selectors on the page */
-    $(".pagesize").val(this.value);
+    $(".pagesize-"+ctx.tableName).val(this.value);
+    e.preventDefault();
   });
 
   $("#search-submit-"+ctx.tableName).click(function(e){
@@ -463,12 +482,12 @@ function tableInit(ctx){
     e.preventDefault();
   });
 
-  $("#clear-filter-btn").click(function(){
+  $("#clear-filter-btn-"+ctx.tableName).click(function(){
     tableParams.filter = null;
     loadData(tableParams);
   });
 
-  $("#filter-modal-form").submit(function(e){
+  $("#filter-modal-form-"+ctx.tableName).submit(function(e){
     e.preventDefault();
 
     tableParams.filter = $(this).find("input[type='radio']:checked").val();
diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index e639583..78a7cb0 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -132,7 +132,6 @@ class LayersTable(ToasterTable):
                         static_data_name="add-del-layers",
                         static_data_template='{% include "layer_btn.html" %}')
 
-
 class MachinesTable(ToasterTable):
     """Table of Machines in Toaster"""
 
@@ -178,8 +177,7 @@ class MachinesTable(ToasterTable):
         self.add_column(title="Machine file",
                         hidden=True,
                         static_data_name="machinefile",
-                        static_data_template=machine_file_template,
-                        field_name="name")
+                        static_data_template=machine_file_template)
 
         self.add_column(title="Select",
                         help_text="Sets the selected machine as the project machine. You can only have one machine per project",
@@ -189,6 +187,33 @@ class MachinesTable(ToasterTable):
                         field_name="layer_version__id")
 
 
+class LayerMachinesTable(MachinesTable):
+    """ Smaller version of the Machines table for use in layer details """
+
+    def __init__(self, *args, **kwargs):
+        MachinesTable.__init__(self)
+
+    def setup_queryset(self, *args, **kwargs):
+        MachinesTable.setup_queryset(self, *args, **kwargs)
+
+        self.queryset = self.queryset.filter(layer_version__pk=int(kwargs['layerid']))
+        self.static_context_extra['in_prj'] = ProjectLayer.objects.filter(Q(project=kwargs['pid']) and Q(layercommit=kwargs['layerid'])).count()
+
+    def setup_columns(self, *args, **kwargs):
+        self.add_column(title="Machine",
+                        hideable=False,
+                        orderable=True,
+                        field_name="name")
+
+        self.add_column(title="Description",
+                        field_name="description")
+
+        select_btn_template = '<a href="{% url "project" extra.pid %}#/machineselect={{data.name}}" class="btn btn-block select-machine-btn" {% if extra.in_prj == 0%}disabled="disabled"{%endif%}>Select machine</a>'
+
+        self.add_column(title="Select machine",
+                        static_data_name="add-del-layers",
+                        static_data_template=select_btn_template)
+
 
 class RecipesTable(ToasterTable):
     """Table of Recipes in Toaster"""
@@ -267,13 +292,57 @@ class RecipesTable(ToasterTable):
                         static_data_name="add-del-layers",
                         static_data_template='{% include "recipe_btn.html" %}')
 
+class LayerRecipesTable(RecipesTable):
+    """ Smaller version of the Machines table for use in layer details """
+
+    def __init__(self, *args, **kwargs):
+        RecipesTable.__init__(self)
+
+    def setup_queryset(self, *args, **kwargs):
+        RecipesTable.setup_queryset(self, *args, **kwargs)
+        self.queryset = self.queryset.filter(layer_version__pk=int(kwargs['layerid']))
+
+        self.static_context_extra['in_prj'] = ProjectLayer.objects.filter(Q(project=kwargs['pid']) and Q(layercommit=kwargs['layerid'])).count()
+
+    def setup_columns(self, *args, **kwargs):
+        self.add_column(title="Recipe",
+                        help_text="Information about a single piece of software, including where to download the source, configuration options, how to compile the source files and how to package the compiled output",
+                        hideable=False,
+                        orderable=True,
+                        field_name="name")
+
+        self.add_column(title="Description",
+                        field_name="get_description_or_summary")
+
+
+        build_recipe_template ='<button class="btn btn-block build-target-btn" data-target-name="{{data.name}}" {%if extra.in_prj == 0 %}disabled="disabled"{%endif%}>Build recipe</button>'
+
+        self.add_column(title="Build recipe",
+                        static_data_name="add-del-layers",
+                        static_data_template=build_recipe_template)
+
+
+
+
+
+
+
+
 # This needs to be staticaly defined here as django reads the url patterns
 # on start up
 urlpatterns = (
-  url(r'^machines/(?P<cmd>\w+)*', MachinesTable.as_view(),
-      name=MachinesTable.__name__.lower()),
-  url(r'^layers/(?P<cmd>\w+)*', LayersTable.as_view(),
-      name=LayersTable.__name__.lower()),
-  url(r'^recipes/(?P<cmd>\w+)*', RecipesTable.as_view(),
-      name=RecipesTable.__name__.lower()),
+    url(r'^machines/(?P<cmd>\w+)*', MachinesTable.as_view(),
+        name=MachinesTable.__name__.lower()),
+    url(r'^layers/(?P<cmd>\w+)*', LayersTable.as_view(),
+        name=LayersTable.__name__.lower()),
+    url(r'^recipes/(?P<cmd>\w+)*', RecipesTable.as_view(),
+        name=RecipesTable.__name__.lower()),
+
+    # layer details tables
+    url(r'^layer/(?P<layerid>\d+)/recipes/(?P<cmd>\w+)*',
+        LayerRecipesTable.as_view(),
+        name=LayerRecipesTable.__name__.lower()),
+    url(r'^layer/(?P<layerid>\d+)/machines/(?P<cmd>\w+)*',
+        LayerMachinesTable.as_view(),
+        name=LayerMachinesTable.__name__.lower()),
 )
diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index 7b62b64..259a59e 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -36,13 +36,15 @@
       projectBuildUrl : "{% url 'xhr_build' %}",
       layerDetailsUrl : "{% url 'base_layerdetails' project.id %}",
       xhrUpdateLayerUrl : "{% url 'xhr_updatelayer' %}",
-      numTargets : {{total_targets}},
-      numMachines: {{machines|length}},
       layerVersion : {
         name : "{{layerversion.layer.name}}",
         id : {{layerversion.id}},
         commit: "{{layerversion.get_vcs_reference}}",
-        inCurrentPrj : {{layer_in_project}},
+      {%if layerversion.id in projectlayers %}
+        inCurrentPrj : true,
+      {% else %}
+        inCurrentPrj : false,
+      {% endif %}
         url : "{% url 'layerdetails' project.id layerversion.id  %}",
         sourceId: {{layerversion.layer_source_id|json}},
       }
@@ -57,437 +59,207 @@
   });
 </script>
 
-  <div class="row-fluid span11">
-      <div class="page-header">
-        <h1>{{layerversion.layer.name}} <small class="commit"
-            {% if layerversion.get_vcs_reference|length > 13 %}
-                data-toggle="tooltip" title="{{layerversion.get_vcs_reference}}"
-            {% endif %}>
-            ({{layerversion.get_vcs_reference|truncatechars:13}})</small></h1>
-      </div>
+<div class="row-fluid span11">
+  <div class="page-header">
+    <h1>{{layerversion.layer.name}} <small class="commit"
+          {% if layerversion.get_vcs_reference|length > 13 %}
+        data-toggle="tooltip" title="{{layerversion.get_vcs_reference}}"
+        {% endif %}>
+        ({{layerversion.get_vcs_reference|truncatechars:13}})</small></h1>
   </div>
+</div>
 
-    <div class="row-fluid span7 tabbable">
-        <div class="alert alert-info lead" id="alert-area" style="display:none">
-          <button type="button" class="close" id="dismiss-alert">&times;</button>
-          <span id="alert-msg"></span>
-        </div>
-        <ul class="nav nav-pills">
-          <li class="active">
-            <a data-toggle="tab" href="#information" id="details-tab">Layer details</a>
-          </li>
-          <li>
-            <a data-toggle="tab" href="#targets" id="targets-tab">Recipes ({{total_targets}})</a>
-          </li>
-          <li>
-            <a data-toggle="tab" href="#machines" id="machines-tab">Machines ({{total_machines}})</a>
-          </li>
-        </ul>
-      <div class="tab-content">
-        <span class="button-place">
-          {% if layer_in_project == 0 %}
-          <button id="add-remove-layer-btn" data-directive="add" class="btn btn-large btn-block">
-            <span class="icon-plus"></span>
-            Add the {{layerversion.layer.name}} layer to your project
-          </button>
-          {% else %}
-          <button id="add-remove-layer-btn" data-directive="remove" class="btn btn-block btn-large btn-danger">
-            <span class="icon-trash"></span>
-            Delete the {{layerversion.layer.name}} layer from your project
-          </button>
-          {% endif %}
-        </span>
+<!-- container for tabs -->
+<div class="row-fluid span7 tabbable">
+  <div class="alert alert-info lead" id="alert-area" style="display:none">
+    <button type="button" class="close" id="dismiss-alert">&times;</button>
+    <span id="alert-msg"></span>
+  </div>
+  <ul class="nav nav-pills">
+    <li class="active">
+      <a data-toggle="tab" href="#information" id="details-tab">Layer details</a>
+    </li>
+    <li>
+      <a data-toggle="tab" href="#recipes" class="muted" id="targets-tab">Recipes (<span class="table-count-recipestable"></span>)</a>
+    </li>
+    <li>
+      <a data-toggle="tab" href="#machines" class="muted" id="machines-tab">Machines (<span class="table-count-machinestable"></span>)</a>
+    </li>
+  </ul>
+  <div class="tab-content">
+    <span class="button-place">
+      {% if layerversion.id not in projectlayers %}
+      <button id="add-remove-layer-btn" data-directive="add" class="btn btn-large btn-block">
+        <span class="icon-plus"></span>
+        Add the {{layerversion.layer.name}} layer to your project
+      </button>
+      {% else %}
+      <button id="add-remove-layer-btn" data-directive="remove" class="btn btn-block btn-large btn-danger">
+        <span class="icon-trash"></span>
+        Delete the {{layerversion.layer.name}} layer from your project
+      </button>
+      {% endif %}
+    </span>
 
-        <!-- layer details pane -->
-        <div id="information" class="tab-pane active">
-          <dl class="dl-horizontal">
-            <dt class="">
-              <i class="icon-question-sign get-help" title="Fetch/clone URL of the repository"></i>
-              Repository URL
+    <!-- layer details pane -->
+    <div id="information" class="tab-pane active">
+      <dl class="dl-horizontal">
+        <dt class="">
+          <i class="icon-question-sign get-help" title="Fetch/clone URL of the repository"></i>
+          Repository URL
+        </dt>
+        <dd>
+          <span class="current-value">{{layerversion.layer.vcs_url}}</span>
+          {% if layerversion.get_vcs_link_url %}
+          <a href="{{layerversion.get_vcs_link_url}}/" class="icon-share get-info" target="_blank"></a>
+          {% endif %}
+          <form id="change-repo-form" class="control-group" style="display:none">
+            <div class="input-append">
+              <input type="text" class="input-xlarge" value="{{layerversion.layer.vcs_url}}">
+                <button data-layer-prop="vcs_url" class="btn change-btn" type="button">Save</button>
+                <a href="#" style="display:none" class="btn btn-link cancel">Cancel</a>
+              </div>
+            </form>
+            <i class="icon-pencil" ></i>
+          </dd>
+          <dt>
+            <i class="icon-question-sign get-help" title="Subdirectory within the repository where the layer is located, if not in the root (usually only used if the repository contains more than one layer)"></i>
+            Repository subdirectory
+          </dt>
+          <dd>
+            <span class="muted" style="display:none">Not set</span>
+            <span class="current-value">{{layerversion.dirpath}}</span>
+            {% if layerversion.get_vcs_dirpath_link_url %}
+            <a href="{{layerversion.get_vcs_dirpath_link_url}}" class="icon-share get-info" target="_blank"></a>
+            {% endif %}
+            <form id="change-subdir-form" style="display:none;">
+              <div class="input-append">
+                <input type="text" value="{{layerversion.dirpath}}">
+                  <button data-layer-prop="dirpath" class="btn change-btn" type="button">Save</button>
+                  <a href="#" style="display:none" class="btn btn-link cancel">Cancel</a>
+                </div>
+              </form>
+              <i id="change-subdir" class="icon-pencil"></i>
+              <span class="icon-trash delete-current-value" data-toggle="tooltip" title="Delete"></span>
+            </dd>
+            <dt>
+              <i class="icon-question-sign get-help" title="The Git branch, tag or commit"></i>
+              Revision
             </dt>
             <dd>
-              <span class="current-value">{{layerversion.layer.vcs_url}}</span>
-              {% if layerversion.get_vcs_link_url %}
-                <a href="{{layerversion.get_vcs_link_url}}/" class="icon-share get-info" target="_blank"></a>
-              {% endif %}
-              <form id="change-repo-form" class="control-group" style="display:none">
+              <span class="current-value">{{layerversion.get_vcs_reference}}</span>
+              <form style="display:none;">
                 <div class="input-append">
-                  <input type="text" class="input-xlarge" value="{{layerversion.layer.vcs_url}}">
-                    <button data-layer-prop="vcs_url" class="btn change-btn" type="button">Save</button>
+                  <input type="text" value="{{layerversion.get_vcs_reference}}">
+                    <button  data-layer-prop="commit" class="btn change-btn" type="button">Save</button>
                     <a href="#" style="display:none" class="btn btn-link cancel">Cancel</a>
                   </div>
                 </form>
-                <i class="icon-pencil" ></i>
+                <i class="icon-pencil"></i>
               </dd>
               <dt>
-                <i class="icon-question-sign get-help" title="Subdirectory within the repository where the layer is located, if not in the root (usually only used if the repository contains more than one layer)"></i>
-                Repository subdirectory
+                <i class="icon-question-sign get-help" title="Other layers this layer depends upon"></i>
+                Layer dependencies
               </dt>
               <dd>
-                <span class="muted" style="display:none">Not set</span>
-                <span class="current-value">{{layerversion.dirpath}}</span>
-                {% if layerversion.get_vcs_dirpath_link_url %}
-                  <a href="{{layerversion.get_vcs_dirpath_link_url}}" class="icon-share get-info" target="_blank"></a>
-                {% endif %}
-                <form id="change-subdir-form" style="display:none;">
-                  <div class="input-append">
-                    <input type="text" value="{{layerversion.dirpath}}">
-                      <button data-layer-prop="dirpath" class="btn change-btn" type="button">Save</button>
-                      <a href="#" style="display:none" class="btn btn-link cancel">Cancel</a>
-                    </div>
-                  </form>
-                  <i id="change-subdir" class="icon-pencil"></i>
-                  <span class="icon-trash delete-current-value" data-toggle="tooltip" title="Delete"></span>
-                </dd>
-                <dt>
-                  <i class="icon-question-sign get-help" title="The Git branch, tag or commit"></i>
-                  Revision
-                </dt>
-                <dd>
-                  <span class="current-value">{{layerversion.get_vcs_reference}}</span>
-                  <form style="display:none;">
-                    <div class="input-append">
-                      <input type="text" value="{{layerversion.get_vcs_reference}}">
-                        <button  data-layer-prop="commit" class="btn change-btn" type="button">Save</button>
-                        <a href="#" style="display:none" class="btn btn-link cancel">Cancel</a>
-                      </div>
-                    </form>
-                    <i class="icon-pencil"></i>
-                  </dd>
-                 <dt>
-                    <i class="icon-question-sign get-help" title="Other layers this layer depends upon"></i>
-                    Layer dependencies
-                  </dt>
-                  <dd>
-                    <ul class="unstyled current-value" id="layer-deps-list">
-                      {% for ld in layerversion.dependencies.all %}
-                      <li data-layer-id="{{ld.depends_on.id}}">
-                        <a data-toggle="tooltip" title="{{ld.depends_on.layer.vcs_url}} | {{ld.depends_on.get_vcs_reference}}" href="{% url 'layerdetails' project.id ld.depends_on.id %}">{{ld.depends_on.layer.name}}</a>
-                        <span class="icon-trash " data-toggle="tooltip" title="Delete"></span>
-                      </li>
-                      {% endfor %}
-                    </ul>
-                    <div class="input-append add-deps">
-                      <input type="text" autocomplete="off" data-minLength="1" data-autocomplete="off"  placeholder="Type a layer name" id="layer-dep-input">
-                        <a class="btn" id="add-layer-dependency-btn" >
-                          Add layer
-                        </a>
-                      </div>
-                      <span class="help-block add-deps">You can only add layers Toaster knows about</span>
-                    </dd>
-                  </dl>
-                </div>
-                <!-- targets tab -->
-                <div id="targets" class="tab-pane">
-                  {% if total_targets == 0 %}
-                  <div class="alert alert-info">
-                    <p>Toaster does not have recipe information for the <strong> {{layerversion.layer.name}} </strong> layer.</p>
-		    <p>Toaster learns about layers when you build them. If this layer provides any recipes, they will be listed here after you build the <strong> {{layerversion.layer.name}} </strong> layer.</p>
-                  </div>
-                  {% else %}
-
-                  <div class="row-fluid">
-
-                  {% if targets.paginator.count == 0 %}
-                  <div class="alert">
-                    <h3>No targets found</h3>
-                  {% endif %}
-
-                {# only show the search form if we have more than 10 results #}
-                  {% if targets.paginator.count > 10 or request.GET.targets_search %}
-                    {% if targets.paginator.count == 0 %}
-                      <form class="input-append">
-                    {% else %}
-                      <form class="navbar-search input-append pull-left">
-                    {% endif %}
-
-                      <input type="text" id="target-search" name="targets_search" placeholder="Search recipes" class="input-xlarge" value="{{request.GET.targets_search}}">
-                        {% if request.GET.targets_search %}
-                        <a class="add-on btn target-search-clear">
-                          <i class="icon-remove"></i>
-                        </a>
-                        {% endif %}
-                        <button type="submit" class="btn">Search</button>
-                        {% if targets.paginator.count == 0 %}
-                            <button type="submit" class="btn btn-link target-search-clear">Show all targets</a>
-                        {% endif %}
-                      </form>
-                    {% endif %}
-
-                    {% if targets.paginator.count == 0 %}
-                      <!-- end alert -->
-                     </div>
-                     <!-- end row-fluid -->
-                     </div>
-                    {% else %}
-
-                    {% if total_targets > 10 %}
-                    <div class="pull-right">
-                      <span class="help-inline" style="padding-top:5px;">Show rows:</span>
-                      <select style="margin-top:5px;margin-bottom:0px;" class="pagesize">
-                        {% with "10 25 50 100 150" as list%}
-                        {% for i in list.split %}
-                        {% if request.session.limit == i %}
-                        <option value="{{i}}" selected>{{i}}</option>
-                        {% else %}
-                        <option value="{{i}}">{{i}}</option>
-                        {% endif %}
-                        {% endfor %}
-                      {% endwith %}
-                    </select>
-                  </div>
-                  {% endif %}
-                </div>
-
-                <table class="table table-bordered table-hover">
-                  <thead>
-                    <tr>
-                      <th>
-                          <i class="icon-question-sign get-help" title="Information about a single piece of software, including where to download the source, configuration options, how to compile the source files and how to package the compiled output"></i>
-                          Recipe
-                          {% if request.GET.targets_search %}
-                            <span class="badge badge-info">{{targets.paginator.count}}</span>
-                          {% endif %}
-                        </th>
-                        <th>
-                          <i class="icon-question-sign get-help" title="The recipe version and revision"></i>
-                          Recipe version
-                        </th>
-                        <th class="span4">Summary</th>
-                        <th class="span2">Build recipe</th>
-                      </tr>
-                    </thead>
-                    <tbody>
-                      {% for target in targets %}
-                      <tr>
-                        <td>
-                          {{target.name}}
-                          {% if target.up_id %}
-                          <a href="{{target.get_layersource_view_url}}" class="icon-share get-info" target="_blank"></a>
-                          {% endif %}
-                        </td>
-                        <td>{{target.version}}</td>
-                        <td>{{target.summary}}</td>
-                        <td><button class="btn btn-block build-target-btn" data-target-name="{{target.name}}" {% if layer_in_project == 0 %}disabled="disabled"{% endif %} >Build recipe</button></td>
-                      </tr>
-                      {% endfor %}
-                    </tbody>
-                  </table>
-
-                  {% if total_targets > 10 %}
-                  <!-- Show pagination controls -->
-                  <div class="pagination">
-                    <ul>
-                      {%if targets.has_previous %}
-                      <li><a href="?tpage={{targets.previous_page_number}}{{request.GET.limit}}#targets">&laquo;</a></li>
-                      {%else%}
-                      <li class="disabled"><a href="#">&laquo;</a></li>
-                      {%endif%}
-                      {% for i in targets.page_range %}
-                      <li {%if i == targets.number %} class="active" {%endif%}><a href="?tpage={{i}}#targets">{{i}}</a></li>
-                      {% endfor %}
-                      {%if targets.has_next%}
-                      <li><a href="?tpage={{targets.next_page_number}}#targets">&raquo;</a></li>
-                      {%else%}
-                      <li class="disabled"><a href="#">&raquo;</a></li>
-                      {%endif%}
-                    </ul>
-                    <div class="pull-right">
-                      <span class="help-inline" style="padding-bottom:10px;">Show rows:</span>
-                      <select class="pagesize">
-                        {% with "10 25 50 100 150" as list%}
-                        {% for i in list.split %}
-                        {% if request.session.limit == i %}
-                        <option value="{{i}}" selected>{{i}}</option>
-                        {% else %}
-                        <option value="{{i}}">{{i}}</option>
-                        {% endif %}
-                        {% endfor %}
-                        {% endwith %}
-                      </select>
-                    </div>
-                  </div>
-                  {% endif %}
-                  {% endif %}
-                  {% endif %}
-                </div>
-
-
-                <div id="machines" class="tab-pane">
-                  {% if total_machines == 0 %}
-                  <div class="alert alert-info">
-                    <p>Toaster does not have machine information for the <strong> {{layerversion.layer.name}} </strong> layer.</p>
-		    <p>Toaster learns about layers when you build them. If this layer provides any machines, they will be listed here after you build the <strong> {{layerversion.layer.name}} </strong> layer.</p>
+                <ul class="unstyled current-value" id="layer-deps-list">
+                  {% for ld in layerversion.dependencies.all %}
+                  <li data-layer-id="{{ld.depends_on.id}}">
+                    <a data-toggle="tooltip" title="{{ld.depends_on.layer.vcs_url}} | {{ld.depends_on.get_vcs_reference}}" href="{% url 'layerdetails' project.id ld.depends_on.id %}">{{ld.depends_on.layer.name}}</a>
+                    <span class="icon-trash " data-toggle="tooltip" title="Delete"></span>
+                  </li>
+                  {% endfor %}
+                </ul>
+                <div class="input-append add-deps">
+                  <input type="text" autocomplete="off" data-minLength="1" data-autocomplete="off"  placeholder="Type a layer name" id="layer-dep-input">
+                    <a class="btn" id="add-layer-dependency-btn" >
+                      Add layer
+                    </a>
                   </div>
-                  {% else %}
-
-                  <div class="row-fluid">
-
-                  {% if machines.paginator.count == 0 %}
-                  <div class="alert">
-                    <h3>No machines found</h3>
-                  {% endif %}
-
-                {# only show the search form if we have more than 10 results #}
-                  {% if machines.paginator.count > 10 or request.GET.machines_search %}
-                    {% if machines.paginator.count == 0 %}
-                      <form class="input-append">
-                    {% else %}
-                      <form class="navbar-search input-append pull-left">
-                    {% endif %}
+                  <span class="help-block add-deps">You can only add layers Toaster knows about</span>
+                </dd>
+              </dl>
+            </div>
+            <!-- end layerdetails tab -->
+            <!-- targets tab -->
+            <div id="recipes" class="tab-pane">
+              <!-- Recipe table -->
+              <div id="no-recipes-yet" class="alert alert-info" style="display:none">
+                <p>Toaster does not have recipe information for the <strong> {{layerversion.layer.name}} </strong> layer.</p>
+                <p>Toaster learns about layers when you build them. If this layer provides any recipes, they will be listed here after you build the <strong> {{layerversion.layer.name}} </strong> layer.</p>
+              </div>
 
-                      <input type="text" id="machine-search" name="machines_search" placeholder="Search machines" class="input-xlarge" value="{{request.GET.machines_search}}">
-                        {% if request.GET.machines_search %}
-                        <a class="add-on btn machine-search-clear">
-                          <i class="icon-remove"></i>
-                        </a>
-                        {% endif %}
-                        <button type="submit" class="btn">Search</button>
-                        {% if machines.paginator.count == 0 %}
-                            <button type="submit" class="btn btn-link machine-search-clear">Show all machines</a>
-                        {% endif %}
-                      </form>
-                    {% endif %}
 
-                    {% if machines.paginator.count == 0 %}
-                      <!-- end alert -->
-                     </div>
-                     <!-- end row-fluid -->
-                     </div>
 
-                    {% else %}
+              {% url 'layerrecipestable' project.id layerversion.id  as xhr_table_url %}
+              {% with "recipestable" as table_name %}
+              {% with "Recipes" as title %}
+              {% include 'toastertable-simple.html' %}
+              {% endwith %}
+              {% endwith %}
+            </div>
 
-                    {% if total_machines > 10 %}
-                    <div class="pull-right">
-                      <span class="help-inline" style="padding-top:5px;">Show rows:</span>
-                      <select style="margin-top:5px;margin-bottom:0px;" class="pagesize">
-                        {% with "10 25 50 100 150" as list%}
-                        {% for i in list.split %}
-                        {% if request.session.limit == i %}
-                        <option value="{{i}}" selected>{{i}}</option>
-                        {% else %}
-                        <option value="{{i}}">{{i}}</option>
-                        {% endif %}
-                        {% endfor %}
-                      {% endwith %}
-                    </select>
-                  </div>
-                  {% endif %}
+            <div id="machines" class="tab-pane">
 
-                </div>
+              <div id="no-machines-yet" class="alert alert-info" style="display:none">
+                <p>Toaster does not have machine information for the <strong> {{layerversion.layer.name}} </strong> layer.</p>
+                <p>Toaster learns about layers when you build them. If this layer provides any machines, they will be listed here after you build the <strong> {{layerversion.layer.name}} </strong> layer.</p>
+              </div>
 
-                <table class="table table-bordered table-hover">
-                  <thead>
-                      <tr>
-                        <th>
-                          <i class="icon-question-sign get-help" title="The machine is the hardware for which you are building"></i>
-                          Machine
-                          {% if request.GET.machines_search %}
-                          <span class="badge badge-info">{{machines.paginator.count}}</span>
-                          {% endif %}
-                        </th>
-                        <th>Description</th>
-                        <th class="span2">Select machine</th>
-                      </tr>
-                    </thead>
-                    <tbody>
-                      {% for machine in machines %}
-                      <tr>
-                        <td>
-                          {{machine.name}}
-                          {% if machine.get_vcs_machine_file_link_url %}
-                          <a href="{{machine.get_vcs_machine_file_link_url}}" target="_blank"><i class="icon-share get-info"></i></a>
-                          {% endif %}
-                        </td>
-                        <td>{{machine.description}}</td>
-                        <td>
-                          <a href="{% url 'project' project.id %}#/machineselect={{machine.name}}" class="btn btn-block select-machine-btn" {% if layer_in_project == 0 %}disabled="disabled"{% endif %}>Select machine</a>
-                      </tr>
-                      {% endfor %}
-                    </tbody>
-                  </table>
 
-                  {% if total_machines > 10 %}
-                  <!-- Show pagination controls -->
-                  <div class="pagination">
-                    <ul>
-                      {%if machines.has_previous %}
-                      <li><a href="?mpage={{machines.previous_page_number}}{{request.GET.limit}}#machines">&laquo;</a></li>
-                      {%else%}
-                      <li class="disabled"><a href="#">&laquo;</a></li>
-                      {%endif%}
-                      {% for i in machines.page_range %}
-                      <li {%if i == machines.number %} class="active" {%endif%}><a href="?mpage={{i}}#machines">{{i}}</a></li>
-                      {% endfor %}
-                      {%if machines.has_next%}
-                      <li><a href="?mpage={{machines.next_page_number}}#machines">&raquo;</a></li>
-                      {%else%}
-                      <li class="disabled"><a href="#">&raquo;</a></li>
-                      {%endif%}
-                    </ul>
-                    <div class="pull-right">
-                      <span class="help-inline" style="padding-bottom:10px;">Show rows:</span>
-                      <select class="pagesize">
-                        {% with "10 25 50 100 150" as list%}
-                        {% for i in list.split %}
-                        {% if request.session.limit == i %}
-                        <option value="{{i}}" selected>{{i}}</option>
-                        {% else %}
-                        <option value="{{i}}">{{i}}</option>
-                        {% endif %}
-                        {% endfor %}
-                        {% endwith %}
-                      </select>
-                    </div>
-                  </div>
-                  {% endif %}
-                  {% endif %}
-                  {% endif %}
-                  </div>
-              </div>
+              <!-- Machines table -->
+              {% url 'layermachinestable' project.id layerversion.id  as xhr_table_url %}
+              {% with "machinestable" as table_name  %}
+              {% with "Machines" as title  %}
+              {% include 'toastertable-simple.html' %}
+              {% endwith %}
+              {% endwith %}
             </div>
-            <div class="row-fluid span4 well">
-              <h2>About {{layerversion.layer.name}}</h2>
-              <dl class="item-info">
+          </div> <!-- end tab content -->
+        </div> <!-- end tabable -->
 
-                <dt>
-                  Summary
-                  <i class="icon-question-sign get-help" title="One-line description of the layer"></i>
-                </dt>
-                <dd>
-                  <span class="muted" style="display:none">Not set</span>
-                  <span class="current-value">{{layerversion.layer.summary|default_if_none:''}}</span>
-                  <form style="display:none; margin-bottom:20px">
-                    <textarea class="span12" rows="2">{% if layerversion.layer.summary %}{{layerversion.layer.summary}}{% endif %}</textarea>
-                    <button class="btn change-btn" data-layer-prop="summary" type="button">Save</button>
-                    <a href="#" class="btn btn-link cancel">Cancel</a>
-                  </form>
-                  <i class="icon-pencil"></i>
-                  <span class="icon-trash delete-current-value" data-toggle="tooltip" title="Delete"></span>
-                </dd>
-                <dt>
-                  Description
-                </dt>
-                <dd>
-                  <span class="muted" style="display:none">Not set</span>
-                  <span class="current-value">{{layerversion.layer.description|default_if_none:''}}</span>
-                  <form style="display:none; margin-bottom:20px">
-                    <textarea class="span12" rows="6">{% if layerversion.layer.description %}{{layerversion.layer.description}}{% endif %}</textarea>
-                    <button class="btn change-btn" data-layer-prop="description" type="button" >Save</button>
-                    <a href="#" class="btn btn-link cancel">Cancel</a>
-                  </form>
-                  <i class="icon-pencil"></i>
-                  <span class="icon-trash delete-current-value" data-toggle="tooltip" title="Delete"></span>
-                </dd>
-                {% if layerversion.layer.up_id %}
-                <dt>Layer index</dt>
-                <dd>
-                  <a href="http://layers.openembedded.org/layerindex/branch/{{layerversion.up_branch.name}}/layer/{{layerversion.layer.name}}"/>layer index link</a>
+        <div class="row-fluid span4 well"> <!-- info side panel -->
+          <h2>About {{layerversion.layer.name}}</h2>
+          <dl class="item-info">
 
-                </dd>
-                {% endif %}
+            <dt>
+              Summary
+              <i class="icon-question-sign get-help" title="One-line description of the layer"></i>
+            </dt>
+            <dd>
+              <span class="muted" style="display:none">Not set</span>
+              <span class="current-value">{{layerversion.layer.summary|default_if_none:''}}</span>
+              <form style="display:none; margin-bottom:20px">
+                <textarea class="span12" rows="2">{% if layerversion.layer.summary %}{{layerversion.layer.summary}}{% endif %}</textarea>
+                <button class="btn change-btn" data-layer-prop="summary" type="button">Save</button>
+                <a href="#" class="btn btn-link cancel">Cancel</a>
+              </form>
+              <i class="icon-pencil"></i>
+              <span class="icon-trash delete-current-value" data-toggle="tooltip" title="Delete"></span>
+            </dd>
+            <dt>
+              Description
+            </dt>
+            <dd>
+              <span class="muted" style="display:none">Not set</span>
+              <span class="current-value">{{layerversion.layer.description|default_if_none:''}}</span>
+              <form style="display:none; margin-bottom:20px">
+                <textarea class="span12" rows="6">{% if layerversion.layer.description %}{{layerversion.layer.description}}{% endif %}</textarea>
+                <button class="btn change-btn" data-layer-prop="description" type="button" >Save</button>
+                <a href="#" class="btn btn-link cancel">Cancel</a>
+              </form>
+              <i class="icon-pencil"></i>
+              <span class="icon-trash delete-current-value" data-toggle="tooltip" title="Delete"></span>
+            </dd>
+            {% if layerversion.layer.up_id %}
+            <dt>Layer index</dt>
+            <dd>
+              <a href="http://layers.openembedded.org/layerindex/branch/{{layerversion.up_branch.name}}/layer/{{layerversion.layer.name}}">layer index link</a>
+
+          </dd>
+          {% endif %}
 
-           </dl>
-         </div>
+        </dl>
+      </div>
 
-{% endblock %}
+      {% endblock %}
diff --git a/lib/toaster/toastergui/templates/toastertable-filter.html b/lib/toaster/toastergui/templates/toastertable-filter.html
new file mode 100644
index 0000000..7c8dc49
--- /dev/null
+++ b/lib/toaster/toastergui/templates/toastertable-filter.html
@@ -0,0 +1,18 @@
+<!-- filter modal -->
+<div id="filter-modal-{{table_name}}" class="modal hide fade" tabindex="-1" role="dialog" aria-hidden="false">
+  <form id="filter-modal-form-{{table_name}}" style="margin-bottom: 0px">
+    <div class="modal-header">
+      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
+      <h3 id="filter-modal-title-{{table_name}}">&nbsp;</h3>
+    </div>
+    <div class="modal-body">
+      <p>Show:</p>
+      <span id="filter-actions-{{table_name}}"></span>
+    </div>
+    <div class="modal-footer">
+      <button class="btn btn-primary" type="submit">Apply</button>
+    </div>
+  </form>
+</div>
+<button id="clear-filter-btn-{{table_name}}" style="display:none"></button>
+<!-- end filter modal -->
diff --git a/lib/toaster/toastergui/templates/toastertable-simple.html b/lib/toaster/toastergui/templates/toastertable-simple.html
index 98cad64..23a7526 100644
--- a/lib/toaster/toastergui/templates/toastertable-simple.html
+++ b/lib/toaster/toastergui/templates/toastertable-simple.html
@@ -24,23 +24,7 @@
   });
 </script>
 
-<!-- filter modal -->
-<div id="filter-modal" class="modal hide fade" tabindex="-1" role="dialog" aria-hidden="false">
-  <form id="filter-modal-form" style="margin-bottom: 0px">
-    <div class="modal-header">
-      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
-      <h3 id="filter-modal-title">&nbsp;</h3>
-    </div>
-    <div class="modal-body">
-      <p>Show:</p>
-      <span id="filter-actions"></span>
-    </div>
-    <div class="modal-footer">
-      <button class="btn btn-primary" type="submit">Apply</button>
-    </div>
-  </form>
-</div>
-<button id="clear-filter-btn" style="display:none"></button>
+{% include 'toastertable-filter.html' %}
 
 <div class="row-fluid" id="no-results-{{table_name}}" style="display:none">
   <div class="alert">
@@ -55,9 +39,7 @@
     </form>
   </div>
 </div>
-
-
-<div id="table-container-{{table_name}}">
+<div id="table-container-{{table_name}}" style="visibility: hidden">
   <!-- control header -->
   <div class="row-fluid" id="table-chrome-{{table_name}}">
       <div class="navbar-search input-append pull-left">
@@ -94,8 +76,8 @@
   </table>
 
   <!-- Pagination controls -->
-  <div class="pagination pagination-centered">
-    <ul id="pagination-{{table_name}}" class="pagination" style="display: block-inline">
+  <div class="pagination pagination-centered" id="pagination-{{table_name}}">
+    <ul class="pagination" style="display: block-inline">
     </ul>
 
     <div class="pull-right">
diff --git a/lib/toaster/toastergui/templates/toastertable.html b/lib/toaster/toastergui/templates/toastertable.html
index 4e6c4ce..5c79ab4 100644
--- a/lib/toaster/toastergui/templates/toastertable.html
+++ b/lib/toaster/toastergui/templates/toastertable.html
@@ -24,37 +24,23 @@
   });
 </script>
 
-<!-- filter modal -->
-<div id="filter-modal" class="modal hide fade" tabindex="-1" role="dialog" aria-hidden="false">
-  <form id="filter-modal-form" style="margin-bottom: 0px">
-    <div class="modal-header">
-      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
-      <h3 id="filter-modal-title">&nbsp;</h3>
-    </div>
-    <div class="modal-body">
-      <p>Show:</p>
-      <span id="filter-actions"></span>
-    </div>
-    <div class="modal-footer">
-      <button class="btn btn-primary" type="submit">Apply</button>
-    </div>
-  </form>
-</div>
-<button id="clear-filter-btn" style="display:none"></button>
+{% include 'toastertable-filter.html' %}
 
-<div class="row-fluid alert" id="no-results-{{table_name}}" style="display:none">
-  <form class="no-results input-append">
-    <input class="input-xxlarge" id="new-search-input-{{table_name}}" name="search" type="text" placeholder="Search {{title|lower}}" value="{{request.GET.search}}"/>
-    <a href="#" class="add-on btn remove-search-btn-{{table_name}}" tabindex="-1">
-      <i class="icon-remove"></i>
-    </a>
-    <button class="btn search-submit-{{table_name}}" >Search</button>
-    <button class="btn btn-link remove-search-btn-{{table_name}}">Show {{title|lower}}
-    </button>
-  </form>
+<div class="row-fluid" id="no-results-{{table_name}}" style="display:none">
+  <div class="alert">
+    <form class="no-results input-append">
+      <input class="input-xxlarge" id="new-search-input-{{table_name}}" name="search" type="text" placeholder="Search {{title|lower}}" value="{{request.GET.search}}"/>
+      <a href="#" class="add-on btn remove-search-btn-{{table_name}}" tabindex="-1">
+        <i class="icon-remove"></i>
+      </a>
+      <button class="btn search-submit-{{table_name}}" >Search</button>
+      <button class="btn btn-link remove-search-btn-{{table_name}}">Show {{title|lower}}
+      </button>
+    </form>
+  </div>
 </div>
 
-<div id="table-container-{{table_name}}">
+<div id="table-container-{{table_name}}" style="visibility: hidden">
   <!-- control header -->
   <div class="navbar" id="table-chrome-{{table_name}}">
     <div class="navbar-inner">
@@ -78,7 +64,7 @@
         <div style="display:inline">
           <span class="divider-vertical"></span>
           <span class="help-inline" style="padding-top:5px;">Show rows:</span>
-          <select style="margin-top:5px;margin-bottom:0px;" class="pagesize">
+          <select style="margin-top:5px;margin-bottom:0px;" class="pagesize-{{table_name}}">
             {% with "10 25 50 100 150" as list%}
             {% for i in list.split %}
             <option value="{{i}}">{{i}}</option>
@@ -99,13 +85,13 @@
   </table>
 
   <!-- Pagination controls -->
-  <div class="pagination pagination-centered">
-    <ul id="pagination-{{table_name}}" class="pagination" style="display: block-inline">
+  <div class="pagination pagination-centered" id="pagination-{{table_name}}">
+    <ul class="pagination" style="display: block-inline">
     </ul>
 
     <div class="pull-right">
       <span class="help-inline" style="padding-top:5px;">Show rows:</span>
-      <select style="margin-top:5px;margin-bottom:0px;" class="pagesize">
+      <select style="margin-top:5px;margin-bottom:0px;" class="pagesize-{{table_name}}">
         {% with "10 25 50 100 150" as list%}
         {% for i in list.split %}
         <option value="{{i}}">{{i}}</option>
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index d0c176b..7a1132f 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -83,7 +83,9 @@ urlpatterns = patterns('toastergui.views',
         url(r'^project/(?P<pid>\d+)/configuration$', 'projectconf', name='projectconf'),
         url(r'^project/(?P<pid>\d+)/builds/$', 'projectbuilds', name='projectbuilds'),
 
-        url(r'^project/(?P<pid>\d+)/layer/(?P<layerid>\d+)$', 'layerdetails', name='layerdetails'),
+        url(r'^project/(?P<pid>\d+)/layer/(?P<layerid>\d+)$',
+            ToasterTemplateView.as_view(template_name='layerdetails.html'),
+            name='layerdetails'),
         url(r'^project/(?P<pid>\d+)/layer/$', lambda x,pid: HttpResponseBadRequest(), name='base_layerdetails'),
 
         # the import layer is a project-specific functionality;
@@ -117,7 +119,7 @@ urlpatterns = patterns('toastergui.views',
         url(r'^xhr_datatypeahead/(?P<pid>\d+)$', 'xhr_datatypeahead', name='xhr_datatypeahead'),
         url(r'^xhr_importlayer/$', 'xhr_importlayer', name='xhr_importlayer'),
         url(r'^xhr_updatelayer/$', 'xhr_updatelayer', name='xhr_updatelayer'),
-        url(r'^xhr_tables/(?P<pid>\d+)/', include('toastergui.tables')),
+        url(r'^xhr_tables/project/(?P<pid>\d+)/', include('toastergui.tables')),
 
         # dashboard for failed build requests
         url(r'^project/(?P<pid>\d+)/buildrequest/(?P<brid>\d+)$', 'buildrequestdetails', name='buildrequestdetails'),
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index d451c3b..f70cf20 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2664,52 +2664,6 @@ if toastermain.settings.MANAGED:
         }
         return render(request, template, context)
 
-
-
-    def layerdetails(request, pid, layerid):
-        template = "layerdetails.html"
-        limit = 10
-
-        if request.GET.has_key("limit"):
-            request.session['limit'] = request.GET['limit']
-
-        if request.session.has_key('limit'):
-            limit = request.session['limit']
-
-        layer_version = Layer_Version.objects.get(pk = layerid)
-
-        targets_query = Recipe.objects.filter(layer_version=layer_version)
-
-        # Targets tab query functionality
-        if request.GET.has_key('targets_search'):
-            targets_query = targets_query.filter(
-                Q(name__icontains=request.GET['targets_search']) |
-                Q(summary__icontains=request.GET['targets_search']))
-
-        targets = _build_page_range(Paginator(targets_query.order_by("name"), limit), request.GET.get('tpage', 1))
-
-        machines_query = Machine.objects.filter(layer_version=layer_version)
-
-        # Machines tab query functionality
-        if request.GET.has_key('machines_search'):
-            machines_query = machines_query.filter(
-                Q(name__icontains=request.GET['machines_search']) |
-                Q(description__icontains=request.GET['machines_search']))
-
-        machines = _build_page_range(Paginator(machines_query.order_by("name"), limit), request.GET.get('mpage', 1))
-
-        context = {
-            'project' : Project.objects.get(pk=pid),
-            'layerversion': layer_version,
-            'layer_in_project' : ProjectLayer.objects.filter(project_id=pid,layercommit=layerid).count(),
-            'machines': machines,
-            'targets': targets,
-            'total_targets': Recipe.objects.filter(layer_version=layer_version).count(),
-
-            'total_machines': Machine.objects.filter(layer_version=layer_version).count(),
-        }
-        return render(request, template, context)
-
     def get_project_configvars_context():
         # Vars managed outside of this view
         vars_managed = {
@@ -3250,9 +3204,6 @@ else:
     def importlayer(request):
         return render(request, 'landing_not_managed.html')
 
-    def layerdetails(request, layerid):
-        return render(request, 'landing_not_managed.html')
-
     def projectconf(request, pid):
         return render(request, 'landing_not_managed.html')
 
diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index 8d44919..b5dfbbc 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -26,7 +26,7 @@ from django.core import serializers
 from django.core.cache import cache
 from django.core.paginator import Paginator, EmptyPage
 from django.db.models import Q
-from orm.models import Project, ProjectLayer
+from orm.models import Project, ProjectLayer, Layer_Version
 from django.template import Context, Template
 from django.core.serializers.json import DjangoJSONEncoder
 from django.core.exceptions import FieldError
@@ -43,9 +43,13 @@ class ToasterTemplateView(TemplateView):
     def get_context_data(self, **kwargs):
       context = super(ToasterTemplateView, self).get_context_data(**kwargs)
       if 'pid' in kwargs:
-        context['project'] = Project.objects.get(pk=kwargs['pid'])
+          context['project'] = Project.objects.get(pk=kwargs['pid'])
+
+          context['projectlayers'] = map(lambda prjlayer: prjlayer.layercommit.id, ProjectLayer.objects.filter(project=context['project']))
+
+      if 'layerid' in kwargs:
+          context['layerversion'] = Layer_Version.objects.get(pk=kwargs['layerid'])
 
-        context['projectlayers'] = map(lambda prjlayer: prjlayer.layercommit.id, ProjectLayer.objects.filter(project=context['project']))
       return context
 
 
@@ -269,13 +273,6 @@ class ToasterTable(View):
             'rows' : [],
         }
 
-        # Flatten all the fields we will need into one list
-        fields = []
-        for col in self.columns:
-            if type(col['field_name']) is list:
-                fields.extend(col['field_name'])
-            else:
-                fields.append(col['field_name'])
 
         try:
             for row in page.object_list:
-- 
1.9.1


