Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f180.google.com (mail-pd0-f180.google.com
	[209.85.192.180])
	by mail.openembedded.org (Postfix) with ESMTP id 96423732C0
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Feb 2015 18:02:09 +0000 (UTC)
Received: by pdev10 with SMTP id v10so15395018pde.7
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Feb 2015 10:02:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=vYAsccEraNN7bMPKxGhek/AdF2hUoRb9s+ygbqWQ++Q=;
	b=MSfxxHFNpgxcNvypyD8jT0QTjPnrqnQEF3bexqqXbVlFkHPmMtFyXbdP0y1bE6N8l6
	3FdBWhrMD8LW96rAghUCJMS+JTi35oKSALMOvdJh8HlnSNsLxQ5HZ4UjBbl3ErQU4oiu
	inYKOdgdo0IfhjlQuahiQUfdUaQ+mXg88bN4NeJGfQnfo7nEjUZFArkv5DJ/2N33GLTa
	UGurpsiagilCDY/BjEHQeVbw9vEdnGsCdPP5xqm/sOSRYT+FthIx3HCbkTw0O8h4k/yW
	o0VelDBsZuURZnB41/1l91V4IJxH6SyMlN0B9BekoQfYrbPiURsa3jW0Yz7Vc/FKO/Ai
	Nq1w==
X-Gm-Message-State: ALoCoQklp91/I1RAy7kg6Vk44xLJa+/iy5ei1evBse8UjbTakZhWLIaorDNxjzap33uaeTdl9H+G
X-Received: by 10.68.202.98 with SMTP id kh2mr31266601pbc.6.1423504930502;
	Mon, 09 Feb 2015 10:02:10 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	i16sm16948118pbq.70.2015.02.09.10.02.08
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 09 Feb 2015 10:02:09 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 5B9D45661A9; Mon,  9 Feb 2015 18:01:58 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Feb 2015 18:01:44 +0000
Message-Id: <ca4e4ab09ba214363181eeb8ad54ccc716bd65f3.1423504574.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
References: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1423504574.git.alexandru.damian@intel.com>
References: <cover.1423504574.git.alexandru.damian@intel.com>
Subject: [PATCH 14/27] toaster: Add add/select functionality to machines page
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
X-List-Received-Date: Mon, 09 Feb 2015 18:02:09 -0000

From: Michael Wood <michael.g.wood@intel.com>

This feature for the machines page allows the user to add a layer and
it's dependencies to the current project and then if successful select
the machine(s) which become available due to being provided by the
layer.

AlexD merged the changes into the submission queue.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/static/js/machines.js   | 89 +++++++++++++++++++++++
 lib/toaster/toastergui/templates/machines.html | 99 +++++++++++++-------------
 lib/toaster/toastergui/views.py                | 12 ++--
 3 files changed, 146 insertions(+), 54 deletions(-)
 create mode 100644 lib/toaster/toastergui/static/js/machines.js

diff --git a/lib/toaster/toastergui/static/js/machines.js b/lib/toaster/toastergui/static/js/machines.js
new file mode 100644
index 0000000..a3ea43b
--- /dev/null
+++ b/lib/toaster/toastergui/static/js/machines.js
@@ -0,0 +1,89 @@
+"use strict"
+
+function machinesPageInit (ctx) {
+
+
+  function setLayerInCurrentPrj(addLayerBtn, depsList){
+    var alertMsg = $("#alert-msg");
+
+    $(".select-or-add").each(function(){
+      /* If we have added a layer it may also enable other machines so search
+       * for other machines that have that layer and enable them */
+      var selectMachineBtn = $(this).children(".select-machine-btn");
+      var otherAddLayerBtns = $(this).children(".add-layer");
+
+      if (addLayerBtn.data('layer-version-id') ==  selectMachineBtn.data('layer-version-id')) {
+        otherAddLayerBtns.fadeOut(function(){
+          selectMachineBtn.fadeIn();
+        });
+      }
+    });
+
+    /* Reset alert message */
+    alertMsg.text("");
+
+    /* If we have added layer dependencies */
+    if (depsList) {
+      alertMsg.append("You have added <strong>"+(depsList.length+1)+"</strong> layers: <span id=\"layer-affected-name\"></span> and its dependencies ");
+
+        /* Build the layer deps list */
+        depsList.map(function(layer, i){
+          var link = $("<a></a>");
+
+          link.attr("href", layer.layerdetailurl);
+          link.text(layer.name);
+          link.tooltip({title: layer.tooltip});
+
+          if (i != 0)
+            alertMsg.append(", ");
+
+          alertMsg.append(link);
+        });
+    } else {
+      alertMsg.append("You have added <strong>1</strong> layer: <span id=\"layer-affected-name\"></span>");
+    }
+
+    var layerName = addLayerBtn.data('layer-name');
+    alertMsg.children("#layer-affected-name").text(layerName);
+    $("#alert-area").show();
+  }
+
+  /* Add or remove this layer from the project */
+  $(".add-layer").click(function() {
+      var btn = $(this);
+      /* If adding get the deps for this layer */
+      var layer = {
+        id : $(this).data('layer-version-id'),
+        name : $(this).data('layer-name'),
+      };
+
+      libtoaster.getLayerDepsForProject(ctx.xhrDataTypeaheadUrl, ctx.projectId, layer.id, function (data) {
+        /* got result for dependencies */
+        if (data.list.length == 0){
+          var editData = { layerAdd : layer.id };
+          libtoaster.editProject(ctx.xhrEditProjectUrl, ctx.projectId, editData,
+            function() {
+              setLayerInCurrentPrj(btn);
+          });
+          return;
+        } else {
+          /* The add deps will include this layer so no need to add it
+           * separately.
+           */
+          show_layer_deps_modal(ctx.projectId, layer, data.list, null, null, true, function () {
+            /* Success add deps and layer */
+            setLayerInCurrentPrj(btn, data.list);
+            console.log ("TODO SUCCESS");
+          });
+        }
+      }, null);
+  });
+
+  $(".select-machine-btn").click(function(){
+    var data =  { machineName : $(this).data('machine-name') };
+    libtoaster.editProject(ctx.xhrEditProjectUrl, ctx.projectId, data,
+      function (){
+        window.location.replace(ctx.projectPageUrl);
+    }, null);
+  });
+}
diff --git a/lib/toaster/toastergui/templates/machines.html b/lib/toaster/toastergui/templates/machines.html
index e0bda51..c0d4c6c 100644
--- a/lib/toaster/toastergui/templates/machines.html
+++ b/lib/toaster/toastergui/templates/machines.html
@@ -1,62 +1,65 @@
 {% extends "baseprojectpage.html" %}
 {% load projecttags %}
 {% load humanize %}
-
+{% load static %}
 {% block localbreadcrumb %}
 <li>All compatible machines</li>
 {% endblock %}
 
 {% block projectinfomain %}
-                <div class="page-header">
-                    <h1>
-                        All compatible machines
-                        <i class="icon-question-sign get-help heading-help" title="This page lists all the machines compatible with the release selected for this project, which is {{project.release.description}}"></i>
-                     </h1>
-                </div>
-                <!--div class="alert">
-                    <div class="input-append" style="margin-bottom:0px;">
-                        <input class="input-xxlarge" type="text" placeholder="Search targets" value="browser" />
-                        <a class="add-on btn">
-                            <i class="icon-remove"></i>
-                        </a>
-                        <button class="btn" type="button">Search</button>
-                        <a class="btn btn-link" href="#">Show all targets</a>
-                    </div>
-                </div-->
-                <div id="target-added" class="alert alert-info lead" style="display:none;"></div>
-                <div id="target-removed" class="alert alert-info lead" style="display:none;">
-                    <button type="button" class="close" data-dismiss="alert">&times;</button>
-                    <strong>1</strong> target deleted from <a href="project-with-targets.html">your project</a>: <a href="#">meta-aarch64</a>
-                </div>
+<script src="{% static 'js/machines.js' %}"></script>
+<script>
+
+  $(document).ready(function (){
+    var ctx = {
+      projectPageUrl : "{% url 'project' project.id %}",
+      xhrEditProjectUrl : "{% url 'xhr_projectedit' project.id %}",
+      projectId : {{project.id}},
+      xhrDataTypeaheadUrl : "{% url 'xhr_datatypeahead' %}",
+    };
+
+    try {
+      machinesPageInit(ctx);
+    } catch (e) {
+      document.write("Sorry, An error has occurred loading this page");
+      console.warn(e);
+    }
+  });
+</script>
+{% include "layers_dep_modal.html" %}
+<div class="page-header">
+  <h1>
+    All machines
+    <i class="icon-question-sign get-help heading-help" title="This page lists all the machines compatible with Yocto Project 1.7 'Dxxxx' that Toaster knows about. They include community-created targets suitable for use on top of OpenEmbedded Core and any targets you have imported"></i>
+  </h1>
+</div>
 
+<div class="alert alert-info lead" id="alert-area" style="display:none">
+  <button type="button" class="close" id="dismiss-alert" data-dismiss="alert">&times;</button>
+  <span id="alert-msg"></span>
+  <p style="margin-top:10px;"><a href="{% url 'project' project.id %}">Go to project configuration</a></p>
+</div>
 
 {% include "basetable_top.html" %}
-    {% for o in objects %}
-    <tr class="data">
-	<td class="machine">
-		{{o.name}}
-		<a machine="_blank" href="http://layers.openembedded.org/layerindex/branch/master/machines/?q=3g-router-image"><i class="icon-share get-info"></i></a>
-	</td>
-	<td class="description">{{o.description}}</td>
-	<td class="machine-file">
-		<code>{{o.file_path}}</code>
-		<a href="http://github.com/embeddedgeeks/meta-embeddedgeeks/blob/master/machines-core/images/3g-router-image.bb" machine="_blank"><i class="icon-share get-info"></i></a>
-	</td>
-	<td class="layer"><a href="#">{{o.layer_version.layer.name}}</a></td>
-	<td class="source">{{o.layer_source.name}}</td>
-	<td class="branch">{{o.layer_version.commit}}</td>
-	<td class="build">
-		<a id="build-machine" href="project-with-machines.html?machine=3g-router-image" class="btn btn-block" style="display:none;">
-			Build machine
-		</a>
-		<a id="add-layer" href="#" class="btn btn-block nopop" title="1 layer added">
-			<i class="icon-plus"></i>
-			Add layer
-			<i class="icon-question-sign get-help" title="To build this machine, you must first add the meta-embeddedgeeks layer to your project"></i>
-		</a>
-	</td>
-    </tr>
-    {% endfor %}
+{% for o in objects %}
+<tr class="data">
+  <td class="machine">{{o.name}}</td>
+  <td class="description">{{o.description}}</td>
+  <td class="layer"><a href="{%url "layerdetails" o.layer_version.id %}">{{o.layer_version.layer.name}}</a></td>
+  <td class="source">{{o.layer_source.name}}</td>
+  <td class="branch">{{o.layer_version.commit}}</td>
+  <td class="select-or-add">
+    <a href="#" class="btn btn-block select-machine-btn" data-machine-name="{{o.name}}" data-layer-version-id="{{o.layer_version.id}}"
+        {%if o.layer_version.id not in project_layers %}style="display:none" {%endif%}  >Select machine</a>
+    <a  href="#" class="btn btn-block nopop add-layer" data-layer-version-id="{{o.layer_version.id}}" data-layer-name="{{o.layer_version.layer.name}}" {%if o.layer_version.id in project_layers %}style="display:none" {%endif%}
+        >
+      <i class="icon-plus"></i>
+      Add layer
+      <i class="icon-question-sign get-help" title="To build this machine, you must first add the {{o.layer_version.layer.name}} layer to your project"></i>
+    </a>
+  </td>
+</tr>
+{% endfor %}
 
 {% include "basetable_bottom.html" %}
 
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 73a5c7e..641170e 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2770,6 +2770,9 @@ if toastermain.settings.MANAGED:
         return response
 
     def machines(request):
+        if not 'project_id' in request.session:
+            raise Exception("invalid page: cannot show page without a project")
+
         template = "machines.html"
         # define here what parameters the view needs in the GET portion in order to
         # be able to display something.  'count' and 'page' are mandatory for all views
@@ -2785,18 +2788,19 @@ if toastermain.settings.MANAGED:
         (filter_string, search_term, ordering_string) = _search_tuple(request, Machine)
 
         queryset_all = Machine.objects.all()
-#        if 'project_id' in request.session:
-#            queryset_all = queryset_all.filter(Q(layer_version__up_branch__name = Project.objects.get(request.session['project_id']).release.branch_name) | Q(layer_version__build__in = Project.objects.get(request.session['project_id']).build_set.all()))
 
         queryset_with_search = _get_queryset(Machine, queryset_all, None, search_term, ordering_string, '-name')
         queryset = _get_queryset(Machine, queryset_all, filter_string, search_term, ordering_string, '-name')
 
+        project_layers = ProjectLayer.objects.filter(project_id=request.session['project_id']).values_list('layercommit',flat=True)
+
         # retrieve the objects that will be displayed in the table; machines a paginator and gets a page range to display
         machine_info = _build_page_range(Paginator(queryset, request.GET.get('count', 10)),request.GET.get('page', 1))
 
 
         context = {
             'objects' : machine_info,
+            'project_layers' : project_layers,
             'objectname' : "machines",
             'default_orderby' : 'name:+',
             'total_count': queryset_with_search.count(),
@@ -2810,10 +2814,6 @@ if toastermain.settings.MANAGED:
                     'dclass': 'span5',
                     'clclass': 'description',
                 },
-                {   'name': 'Machine file',
-                    'clclass': 'machine-file',
-                    'hidden': 1,
-                },
                 {   'name': 'Layer',
                     'clclass': 'layer',
                 },
-- 
1.9.1


