Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
	[209.85.212.171])
	by mail.openembedded.org (Postfix) with ESMTP id EEDBB73FDA
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 May 2015 11:00:10 +0000 (UTC)
Received: by wizk4 with SMTP id k4so100534019wiz.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 May 2015 04:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=uakfCjJHj1oQJVRtfhVmD3SwoxyV244ZBeMK4u11M5o=;
	b=HuohMRSkQpBvXJbA2ye/i3ZZWXuWzSOwUGvR68L3eIkJcab8DLJgdfEObbWru4MlMQ
	Bv9J7pMJJ6uk6+eHchEQSMdL03dxvjQQnQMx3jsCxPoHdXYS3eFhLbg03PCTqY1aQ50V
	0VIYqYtsHVDELldqzY1rWwJBfg0lyMUMCkazNQjVSHvxWcASxYSPoUAHNbBF78AhK8XT
	m3OfXS/GIL0ZvW/WNvW7Y0801qrlSmETeaZeHCLo7KZApggY7pXHFm7aV5kmnM0c/fLG
	RfbLebnJmzk2M0nU7J1Xx7PPyqjirqrSDAU2RpIm1ECiLKgTOsS84bAVcvGG6lOWRiBI
	Y2pA==
X-Gm-Message-State: ALoCoQlfFA0tJa24rAIKChzLIpPCtSojYa5SGJlvO1lV53M8N9KrbwWcDsb0c5VeAuPo1pvXHdKo
X-Received: by 10.194.122.105 with SMTP id lr9mr19666815wjb.153.1431342011611; 
	Mon, 11 May 2015 04:00:11 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id ha4sm12745279wib.0.2015.05.11.04.00.10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 11 May 2015 04:00:10 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id EF5175604F2; Mon, 11 May 2015 11:58:42 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 11 May 2015 11:58:39 +0100
Message-Id: <c28601a65e4d44bf731d82baf1e1efbdb8deaa56.1431338029.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <7ffd7ba923c85a735e0dad528f1ab9d50073724b.1431338029.git.alexandru.damian@intel.com>
References: <7ffd7ba923c85a735e0dad528f1ab9d50073724b.1431338029.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1431338029.git.alexandru.damian@intel.com>
References: <cover.1431338029.git.alexandru.damian@intel.com>
Subject: [PATCH 08/11] toasterui: URL refactoring
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
X-List-Received-Date: Mon, 11 May 2015 11:00:13 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This is a URL refactoring needed to remove the inadvertent
usage of server-side user session in a REST-style API.
We move the parameters that were stored in the user session
to the URL, making navigation more robust.

This refactoring allows a clean (no 500 HTTP return codes) crawl
of the website following inside links.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 .../toastergui/templates/basetable_top_layers.html |  2 +-
 lib/toaster/toastergui/templates/importlayer.html  |  2 +-
 lib/toaster/toastergui/templates/layerdetails.html |  8 +-
 lib/toaster/toastergui/templates/layers.html       | 14 ++--
 lib/toaster/toastergui/templates/machines.html     |  4 +-
 lib/toaster/toastergui/templates/project.html      | 24 +++---
 lib/toaster/toastergui/templates/targets.html      |  6 +-
 lib/toaster/toastergui/urls.py                     | 21 +++--
 lib/toaster/toastergui/views.py                    | 94 +++++++++-------------
 9 files changed, 80 insertions(+), 95 deletions(-)

diff --git a/lib/toaster/toastergui/templates/basetable_top_layers.html b/lib/toaster/toastergui/templates/basetable_top_layers.html
index bd6e7dd..722091b 100644
--- a/lib/toaster/toastergui/templates/basetable_top_layers.html
+++ b/lib/toaster/toastergui/templates/basetable_top_layers.html
@@ -1,5 +1,5 @@
 {% extends "basetable_top.html" %}
 
 {%block custombuttons %}
-    <a class="btn" href="{% url 'importlayer' %}" style="margin-right:5px;">Import layer</a>
+    <a class="btn" href="{% url 'importlayer' project.id %}" style="margin-right:5px;">Import layer</a>
 {%endblock%}
diff --git a/lib/toaster/toastergui/templates/importlayer.html b/lib/toaster/toastergui/templates/importlayer.html
index ed03b2e..d73c319 100644
--- a/lib/toaster/toastergui/templates/importlayer.html
+++ b/lib/toaster/toastergui/templates/importlayer.html
@@ -14,7 +14,7 @@
                   <script>
                     $(document).ready(function (){
                       var ctx = {
-                        layerDetailsUrl : "{% url 'base_layerdetails' %}",
+                        layerDetailsUrl : "{% url 'base_layerdetails' project.id %}",
                         xhrImportLayerUrl : "{% url 'xhr_importlayer' %}",
                       };
 
diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index 4b27d05..4d892d5 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -3,7 +3,7 @@
 {% load humanize %}
 {% load static %}
 {% block localbreadcrumb %}
-<li><a href="{% url 'layers' %}">All compatible layers</a></li>
+<li><a href="{% url 'all-layers' project.id %}">All compatible layers</a></li>
 <li>
   {{layerversion.layer.name}} ({{layerversion.get_vcs_reference|truncatechars:13}})
 </li>
@@ -17,7 +17,7 @@
   $(document).ready(function (){
     var ctx = {
       projectBuildUrl : "{% url 'xhr_build' %}",
-      layerDetailsUrl : "{% url 'base_layerdetails' %}",
+      layerDetailsUrl : "{% url 'base_layerdetails' project.id %}",
       xhrUpdateLayerUrl : "{% url 'xhr_updatelayer' %}",
       numTargets : {{total_targets}},
       numMachines: {{machines|length}},
@@ -26,7 +26,7 @@
         id : {{layerversion.id}},
         commit: "{{layerversion.get_vcs_reference}}",
         inCurrentPrj : {{layer_in_project}},
-        url : "{% url 'layerdetails' layerversion.id  %}",
+        url : "{% url 'layerdetails' project.id layerversion.id  %}",
         sourceId: {{layerversion.layer_source_id}},
       }
     };
@@ -164,7 +164,7 @@
                       {% for ld in layerversion.dependencies.all %}
                       <span class="current-value">
                       <li data-layer-id="{{ld.depends_on.id}}">
-                        <a data-toggle="tooltip" title="{{ld.depends_on.layer.vcs_url}} | {{ld.depends_on.get_vcs_reference}}" href="{% url 'layerdetails' ld.depends_on.id %}">{{ld.depends_on.layer.name}}</a>
+                        <a data-toggle="tooltip" title="{{ld.depends_on.layer.vcs_url}} | {{ld.depends_on.get_vcs_reference}}" href="{% url 'layerdetails' project.id ld.depends_on.id %}">{{ld.depends_on.layer.name}}</a>
                         <span class="icon-trash " data-toggle="tooltip" title="Delete"></span>
                       </li>
                       </span>
diff --git a/lib/toaster/toastergui/templates/layers.html b/lib/toaster/toastergui/templates/layers.html
index 2367e7c..abad007 100644
--- a/lib/toaster/toastergui/templates/layers.html
+++ b/lib/toaster/toastergui/templates/layers.html
@@ -73,14 +73,14 @@
 {% include "basetable_top_layers.html" %}
     {% for o in objects %}
     <tr class="data">
-            <td class="layer"><a href="{% url 'layerdetails' o.id %}">{{o.layer.name}}</a></td>
+            <td class="layer"><a href="{% url 'layerdetails' project.id o.id %}">{{o.layer.name}}</a></td>
             <td class="description">{% if o.layer.summary %}{{o.layer.summary}}{%endif%}</td>
-            <td class="git-repo"><a href="{% url 'layerdetails' o.pk %}"><code>{{o.layer.vcs_url}}</code></a>
+            <td class="git-repo"><a href="{% url 'layerdetails' project.id o.pk %}"><code>{{o.layer.vcs_url}}</code></a>
             {% if o.get_vcs_link_url %}
             <a target="_blank" href="{{ o.get_vcs_link_url }}"><i class="icon-share get-info"></i></a>
         {% endif %}
         </td>
-            <td class="git-subdir" style="display: table-cell;"><a href="{% url 'layerdetails' o.pk %}"><code>{{o.dirpath}}</code></a>
+            <td class="git-subdir" style="display: table-cell;"><a href="{% url 'layerdetails' project.id o.pk %}"><code>{{o.dirpath}}</code></a>
                 {% if o.dirpath and o.get_vcs_dirpath_link_url %}
             <a target="_blank" href="{{ o.get_vcs_dirpath_link_url }}"><i class="icon-share get-info"></i></a>
                 {% endif %}
@@ -100,10 +100,10 @@
         {% with ods=o.dependencies.all%}
             {% if ods.count %}
                     <a class="btn"
-                        title="<a href='{% url "layerdetails" o.pk %}'>{{o.layer.name}}</a> dependencies"
+                        title="<a href='{% url "layerdetails" project.id o.pk %}'>{{o.layer.name}}</a> dependencies"
                         data-content="<ul class='unstyled'>
                           {% for i in ods%}
-                            <li><a href='{% url "layerdetails" i.depends_on.pk %}'>{{i.depends_on.layer.name}}</a></li>
+                            <li><a href='{% url "layerdetails" project.id i.depends_on.pk %}'>{{i.depends_on.layer.name}}</a></li>
                           {% endfor %}
                         </ul>">
                         {{ods.count}}
@@ -113,11 +113,11 @@
             </td>
             {% if project %}
             <td class="add-del-layers" value="{{o.pk}}">
-                <button class="btn btn-danger btn-block layer-exists-{{o.pk}} layerbtn" style="display:none;" data-layer='{ "id": {{o.pk}}, "name":  "{{o.layer.name}}", "url": "{%url 'layerdetails' o.pk%}"}' data-directive="remove" >
+                <button class="btn btn-danger btn-block layer-exists-{{o.pk}} layerbtn" style="display:none;" data-layer='{ "id": {{o.pk}}, "name":  "{{o.layer.name}}", "url": "{%url 'layerdetails' project.id o.pk%}"}' data-directive="remove" >
                     <i class="icon-trash"></i>
                     Delete layer
                 </button>
-                <button class="btn btn-block layer-add-{{o.pk}} layerbtn" data-layer='{ "id": {{o.pk}}, "name":  "{{o.layer.name}}", "url": "{%url 'layerdetails' o.pk%}"}' data-directive="add">
+                <button class="btn btn-block layer-add-{{o.pk}} layerbtn" data-layer='{ "id": {{o.pk}}, "name":  "{{o.layer.name}}", "url": "{%url 'layerdetails' project.id o.pk%}"}' data-directive="add">
                     <i class="icon-plus"></i>
                     Add layer
                 </button>
diff --git a/lib/toaster/toastergui/templates/machines.html b/lib/toaster/toastergui/templates/machines.html
index d116a45..4a09862 100644
--- a/lib/toaster/toastergui/templates/machines.html
+++ b/lib/toaster/toastergui/templates/machines.html
@@ -69,12 +69,12 @@
   <tr class="data">
     <td class="machine">{{o.name}}</td>
     <td class="description">{{o.description}}</td>
-    <td class="layer"><a href="{%url "layerdetails" o.layer_version.id %}">{{o.layer_version.layer.name}}</a></td>
+    <td class="layer"><a href="{%url "layerdetails" project.id o.layer_version.id %}">{{o.layer_version.layer.name}}</a></td>
     <td class="branch">{{o.layer_version.get_vcs_reference}}</td>
     <td class="machinefile"><code>/machine/conf/{{o.name}}.conf</code><a href="{{o.get_vcs_machine_file_link_url}}" target="_blank"><i class="icon-share get-info"></i></a></td>
     <td class="select-or-add" style="height: 32px;">
       <a href="{% url 'project' project.id %}#/machineselect={{o.name}}" class="btn btn-block layer-exists-{{o.layer_version.id}}" style="margin-top: 5px; display:none">Select machine</a>
-      <button class="btn btn-block layerbtn layer-add-{{o.layer_version.id}}" data-layer='{ "id": {{o.layer_version.id}}, "name":  "{{o.layer_version.layer.name}}", "url": "{%url 'layerdetails' o.layer_version.id %}"}' data-directive="add">
+      <button class="btn btn-block layerbtn layer-add-{{o.layer_version.id}}" data-layer='{ "id": {{o.layer_version.id}}, "name":  "{{o.layer_version.layer.name}}", "url": "{%url 'layerdetails' project.id o.layer_version.id %}"}' data-directive="add">
         <i class="icon-plus"></i>
         Add layer
         <i title="" class="icon-question-sign get-help" data-original-title="To enable this machine, you must first add the {{o.layer_version.layer.name}} layer to your project"></i></i>
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index 5f8f4d1..85a1b16 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -24,7 +24,7 @@ vim: expandtab tabstop=2
 	  <p>Toaster has no layer information. Without layer information, you cannot run builds. To generate layer information you can:</p>
 		<ul>
 			 <li> <a href="http://www.yoctoproject.org/docs/latest/toaster-manual/toaster-manual.html#layer-source">Configure a layer source</a></li>
-			 <li> <a href="{% url 'importlayer' %}">Import a layer</a></li>
+			 <li> <a href="{% url 'importlayer' project.id %}">Import a layer</a></li>
 		</ul>
 </div>
 
@@ -111,7 +111,7 @@ vim: expandtab tabstop=2
       </div>
       <i class="icon-question-sign get-help get-help-blue" title="Type the name of one or more recipes you want to build, separated by a space. You can also specify a task by appending a semicolon and a task name to a recipe name, like so: <code>core-image-minimal:do_build</code>"></i>
       <p>
-        <a href="{% url 'all-targets' %}">View all compatible recipes</a>
+        <a href="{% url 'all-targets' project.id %}">View all compatible recipes</a>
         <i class="icon-question-sign get-help get-help-blue heading-help" title="View all the recipes you can build with the release selected for this project, which is {[project.release.desc]}"></i>
         {% if completedbuilds.count %}
           | <a href="{% url 'projectbuilds' project.id %}">View all project builds ({{completedbuilds.count}})</a>
@@ -278,8 +278,8 @@ vim: expandtab tabstop=2
         <p>
         You can:
           <ul>
-            <li> <a href="{% url 'layers'%}">View all compatible layers available in Toaster</a>
-            <li> <a href="{% url 'importlayer' %}">Import a layer</a>
+            <li> <a href="{% url 'all-layers' project.id %}">View all compatible layers available in Toaster</a>
+            <li> <a href="{% url 'importlayer' project.id %}">Import a layer</a>
             <li> <a href="https://www.yoctoproject.org/docs/1.6.1/dev-manual/dev-manual.html#understanding-and-creating-layers" target="_blank">Read about layers in the manual</a>
           </ul>
         Or type a layer name below.
@@ -293,10 +293,10 @@ vim: expandtab tabstop=2
         {% csrf_token %}
       </form>
       <p>
-        <a href="{% url 'layers' %}">View all compatible layers</a>
+        <a href="{% url 'all-layers' project.id %}">View all compatible layers</a>
         <i class="icon-question-sign get-help" title="View all the layers you can build with the release selected for this project, which is {[project.release.desc]}"></i>
         |
-        <a href="{% url 'importlayer' %}">Import layer</a></p>
+        <a href="{% url 'importlayer' project.id %}">Import layer</a></p>
       <ul class="unstyled configuration-list">
           <li ng-repeat="l in layers track by l.id" class="animate-repeat">
             <a href="{[l.layerdetailurl]}" class="layer-info" data-toggle="tooltip" tooltip-placement="right" tooltip="{[l.giturl]} | {[l.branch.name]}">{[l.name]}</a>
@@ -321,7 +321,7 @@ vim: expandtab tabstop=2
           {% csrf_token %}
         </form>
         <p>
-          <a href="{% url 'all-targets' %}">View all compatible recipes</a>
+          <a href="{% url 'all-targets' project.id %}">View all compatible recipes</a>
           <i class="icon-question-sign get-help" title="View all the recipes you can build with the release selected for this project, which is {[project.release.desc]}"></i>
         </p>
         <div ng-if="frequenttargets.length">
@@ -361,7 +361,7 @@ vim: expandtab tabstop=2
               {% csrf_token %}
         </form>
         <p>
-          <a href="{% url 'machines' %}" class="link">View all compatible machines</a>
+          <a href="{% url 'all-machines' project.id %}" class="link">View all compatible machines</a>
         <i class="icon-question-sign get-help" title="View all the machines you can set with the release selected for this project, which is {[project.release.desc]}"></i>
       </p>
       </div>
@@ -432,10 +432,10 @@ angular.element(document).ready(function() {
   scope.urls.xhr_build = "{% url 'xhr_projectbuild' project.id %}";
   scope.urls.xhr_edit = "{% url 'xhr_projectedit' project.id %}";
   scope.urls.xhr_datatypeahead = "{% url 'xhr_datatypeahead' %}";
-  scope.urls.layers = "{% url 'layers' %}";
-  scope.urls.targets = "{% url 'all-targets' %}";
-  scope.urls.importlayer = "{% url 'importlayer'%}";
-  scope.urls.layer = "{% url 'base_layerdetails' %}";
+  scope.urls.layers = "{% url 'all-layers' project.id %}";
+  scope.urls.targets = "{% url 'all-targets' project.id %}";
+  scope.urls.importlayer = "{% url 'importlayer' project.id %}";
+  scope.urls.layer = "{% url 'base_layerdetails' project.id %}";
   scope.project = {{prj|json}};
   scope.builds = {{builds|json}};
   scope.layers = {{layers|json}};
diff --git a/lib/toaster/toastergui/templates/targets.html b/lib/toaster/toastergui/templates/targets.html
index 903e841..dc2cef6 100644
--- a/lib/toaster/toastergui/templates/targets.html
+++ b/lib/toaster/toastergui/templates/targets.html
@@ -62,7 +62,7 @@
       <p>Toaster has no recipe information. To generate recipe information you can:</p>
       <ul>
        <li><a href="http://www.yoctoproject.org/docs/latest/toaster-manual/toaster-manual.html#layer-source">Configure a layer source</a></li>
-       <li><a href="{% url 'importlayer' %}">Import a layer</a>, then run a build</li>
+       <li><a href="{% url 'importlayer' project.id %}">Import a layer</a>, then run a build</li>
       </ul>
     </div>
   {% endif %}
@@ -84,7 +84,7 @@
         </td>
         <td class="target-section">{{o.section}}</td>
         <td class="license">{{o.license}}</td>
-        <td class="layer"><a href="{% url 'layerdetails' o.preffered_layerversion.id%}">{{o.preffered_layerversion.layer.name}}</a></td>
+        <td class="layer"><a href="{% url 'layerdetails' project.id o.preffered_layerversion.id%}">{{o.preffered_layerversion.layer.name}}</a></td>
         <td class="branch">
         {% if o.preffered_layerversion.up_branch %}
             {{o.preffered_layerversion.up_branch.name}}
@@ -101,7 +101,7 @@
           <a href="{% url 'project' project.id %}#/targetbuild={{o.name}}" class="btn btn-block layer-exists-{{o.preffered_layerversion.pk}}" style="display:none; margin-top: 5px;" >
             Build recipe
           </a>
-          <button class="btn btn-block layerbtn layer-add-{{o.preffered_layerversion.pk}}" data-layer='{ "id": {{o.preffered_layerversion.pk}}, "name":  "{{o.preffered_layerversion.layer.name}}", "url": "{%url 'layerdetails' o.preffered_layerversion.pk%}"}' data-directive="add">
+          <button class="btn btn-block layerbtn layer-add-{{o.preffered_layerversion.pk}}" data-layer='{ "id": {{o.preffered_layerversion.pk}}, "name":  "{{o.preffered_layerversion.layer.name}}", "url": "{%url 'layerdetails' project.id o.preffered_layerversion.pk%}"}' data-directive="add">
             <i class="icon-plus"></i>
             Add layer
             <i title="" class="icon-question-sign get-help" data-original-title="To build this target, you must first add the {{o.preffered_layerversion.layer.name}} layer to your project"></i></i>
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index 76357e3..52fc0cc 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -76,20 +76,25 @@ urlpatterns = patterns('toastergui.views',
 
         # project URLs
         url(r'^newproject/$', 'newproject', name='newproject'),
-        url(r'^importlayer/$', 'importlayer', name='importlayer'),
 
-        url(r'^layers/$', 'layers', name='layers'),
-        url(r'^layer/(?P<layerid>\d+)/$', 'layerdetails', name='layerdetails'),
-        url(r'^layer/$', lambda x: HttpResponseBadRequest(), name='base_layerdetails'),
-        url(r'^targets/$', 'targets', name='all-targets'),
-        url(r'^machines/$', 'machines', name='machines'),
 
         url(r'^projects/$', 'projects', name='all-projects'),
 
         url(r'^project/$', lambda x: HttpResponseBadRequest(), name='base_project'),
-        url(r'^project/(?P<pid>\d+)/$', 'project', name='project'),
+
+        url(r'^project/(?P<pid>\d+)$', 'project', name='project'),
         url(r'^project/(?P<pid>\d+)/configuration$', 'projectconf', name='projectconf'),
-        url(r'^project/(?P<pid>\d+)/builds$', 'projectbuilds', name='projectbuilds'),
+        url(r'^project/(?P<pid>\d+)/builds/$', 'projectbuilds', name='projectbuilds'),
+
+        url(r'^project/(?P<pid>\d+)/layers/$', 'layers', name='all-layers'),
+        url(r'^project/(?P<pid>\d+)/layer/(?P<layerid>\d+)$', 'layerdetails', name='layerdetails'),
+        url(r'^project/(?P<pid>\d+)/layer/$', lambda x: HttpResponseBadRequest(), name='base_layerdetails'),
+
+        # the import layer is a project-specific functionality;
+        url(r'^project/(?P<pid>\d+)/importlayer$', 'importlayer', name='importlayer'),
+
+        url(r'^project/(?P<pid>\d+)/targets/$', 'targets', name='all-targets'),
+        url(r'^project/(?P<pid>\d+)/machines/$', 'machines', name='all-machines'),
 
         url(r'^xhr_build/$', 'xhr_build', name='xhr_build'),
         url(r'^xhr_projectbuild/(?P<pid>\d+)/$', 'xhr_projectbuild', name='xhr_projectbuild'),
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index e296cf6..23025a2 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1806,6 +1806,20 @@ def package_included_reverse_dependencies(request, build_id, target_id, package_
 def image_information_dir(request, build_id, target_id, packagefile_id):
     # stubbed for now
     return redirect(builds)
+    # the context processor that supplies data used across all the pages
+
+
+def managedcontextprocessor(request):
+    import subprocess
+    ret = {
+        "projects": Project.objects.all(),
+        "MANAGED" : toastermain.settings.MANAGED,
+        "DEBUG" : toastermain.settings.DEBUG,
+        "TOASTER_BRANCH": toastermain.settings.TOASTER_BRANCH,
+        "TOASTER_REVISION" : toastermain.settings.TOASTER_REVISION,
+    }
+    return ret
+
 
 
 import toastermain.settings
@@ -1827,23 +1841,6 @@ if toastermain.settings.MANAGED:
 
     class BadParameterException(Exception): pass        # error thrown on invalid POST requests
 
-    # the context processor that supplies data used across all the pages
-    def managedcontextprocessor(request):
-        import subprocess
-        ret = {
-            "projects": Project.objects.all(),
-            "MANAGED" : toastermain.settings.MANAGED,
-            "DEBUG" : toastermain.settings.DEBUG,
-            "TOASTER_BRANCH": toastermain.settings.TOASTER_BRANCH,
-            "TOASTER_REVISION" : toastermain.settings.TOASTER_REVISION,
-        }
-        if 'project_id' in request.session:
-            try:
-                ret['project'] = Project.objects.get(pk = request.session['project_id'])
-            except Project.DoesNotExist:
-                del request.session['project_id']
-        return ret
-
 
     class InvalidRequestException(Exception):
         def __init__(self, response):
@@ -2176,7 +2173,7 @@ if toastermain.settings.MANAGED:
             puser = None
 
         # we use implicit knowledge of the current user's project to filter layer information, e.g.
-        request.session['project_id'] = prj.id
+        pid = prj.id
 
         from collections import Counter
         freqtargets = []
@@ -2201,7 +2198,7 @@ if toastermain.settings.MANAGED:
                         "name" : x.layercommit.layer.name,
                         "giturl": x.layercommit.layer.vcs_url,
                         "url": x.layercommit.layer.layer_index_url,
-                        "layerdetailurl": reverse("layerdetails", args=(x.layercommit.pk,)),
+                        "layerdetailurl": reverse("layerdetails", args=(prj.id, x.layercommit.pk,)),
                 # This branch name is actually the release
                         "branch" : { "name" : x.layercommit.get_vcs_reference(), "layersource" : x.layercommit.up_branch.layer_source.name if x.layercommit.up_branch != None else None}},
                     prj.projectlayer_set.all().order_by("id")),
@@ -2237,7 +2234,7 @@ if toastermain.settings.MANAGED:
         try:
             if request.method != "POST":
                 raise BadParameterException("invalid method")
-            request.session['project_id'] = pid
+            pid = pid
             prj = Project.objects.get(id = pid)
 
 
@@ -2326,7 +2323,7 @@ if toastermain.settings.MANAGED:
             # return all project settings
             return HttpResponse(jsonfilter( {
                 "error": "ok",
-                "layers" :  map(lambda x: {"id": x.layercommit.pk, "orderid" : x.pk, "name" : x.layercommit.layer.name, "giturl" : x.layercommit.layer.vcs_url, "url": x.layercommit.layer.layer_index_url, "layerdetailurl": reverse("layerdetails", args=(x.layercommit.pk,)), "branch" : { "name" : x.layercommit.get_vcs_reference(), "layersource" : x.layercommit.up_branch.layer_source.name}}, prj.projectlayer_set.all().select_related("layer").order_by("id")),
+                "layers" :  map(lambda x: {"id": x.layercommit.pk, "orderid" : x.pk, "name" : x.layercommit.layer.name, "giturl" : x.layercommit.layer.vcs_url, "url": x.layercommit.layer.layer_index_url, "layerdetailurl": reverse("layerdetails", args=(prj.id, x.layercommit.pk,)), "branch" : { "name" : x.layercommit.get_vcs_reference(), "layersource" : x.layercommit.up_branch.layer_source.name}}, prj.projectlayer_set.all().select_related("layer").order_by("id")),
                 "builds" : _project_recent_build_list(prj),
                 "variables": map(lambda x: (x.name, x.value), prj.projectvariable_set.all()),
                 "machine": {"name": prj.projectvariable_set.get(name="MACHINE").value},
@@ -2344,8 +2341,6 @@ if toastermain.settings.MANAGED:
             prj = None
             if request.GET.has_key('project_id'):
                 prj = Project.objects.get(pk = request.GET['project_id'])
-            elif 'project_id' in request.session:
-                prj = Project.objects.get(pk = request.session['project_id'])
             else:
                 raise Exception("No valid project selected")
 
@@ -2389,8 +2384,6 @@ if toastermain.settings.MANAGED:
 
             # returns layer versions that would be deleted on the new release__pk
             if request.GET['type'] == "versionlayers":
-                if not 'project_id' in request.session:
-                    raise Exception("This call cannot makes no sense outside a project context")
 
                 retval = []
                 for i in prj.projectlayer_set.all():
@@ -2689,16 +2682,15 @@ if toastermain.settings.MANAGED:
 
 
 
-    def importlayer(request):
+    def importlayer(request, pid):
         template = "importlayer.html"
         context = {
+            'project': Project.objects.get(id=pid),
         }
         return render(request, template, context)
 
 
-    def layers(request):
-        if not 'project_id' in request.session:
-            raise Exception("invalid page: cannot show page without a project")
+    def layers(request, pid):
 
         template = "layers.html"
         # define here what parameters the view needs in the GET portion in order to
@@ -2708,13 +2700,13 @@ if toastermain.settings.MANAGED:
         mandatory_parameters = { 'count': pagesize,  'page' : 1, 'orderby' : orderby };
         retval = _verify_parameters( request.GET, mandatory_parameters )
         if retval:
-            return _redirect_parameters( 'layers', request.GET, mandatory_parameters)
+            return _redirect_parameters( 'all-layers', request.GET, mandatory_parameters, pid=pid)
 
         # boilerplate code that takes a request for an object type and returns a queryset
         # for that object type. copypasta for all needed table searches
         (filter_string, search_term, ordering_string) = _search_tuple(request, Layer_Version)
 
-        prj = Project.objects.get(pk = request.session['project_id'])
+        prj = Project.objects.get(pk = pid)
 
         queryset_all = prj.compatible_layerversions()
 
@@ -2729,6 +2721,7 @@ if toastermain.settings.MANAGED:
 
 
         context = {
+            'project' : prj,
             'projectlayerset' : jsonfilter(map(lambda x: x.layercommit.id, prj.projectlayer_set.all())),
             'objects' : layer_info,
             'objectname' : "layers",
@@ -2773,7 +2766,7 @@ if toastermain.settings.MANAGED:
 
         return response
 
-    def layerdetails(request, layerid):
+    def layerdetails(request, pid, layerid):
         template = "layerdetails.html"
         limit = 10
 
@@ -2806,8 +2799,9 @@ if toastermain.settings.MANAGED:
         machines = _build_page_range(Paginator(machines_query.order_by("name"), limit), request.GET.get('mpage', 1))
 
         context = {
+            'project' : Project.objects.get(pk=pid),
             'layerversion': layer_version,
-            'layer_in_project' : ProjectLayer.objects.filter(project_id=request.session['project_id'],layercommit=layerid).count(),
+            'layer_in_project' : ProjectLayer.objects.filter(project_id=pid,layercommit=layerid).count(),
             'machines': machines,
             'targets': targets,
             'total_targets': Recipe.objects.filter(layer_version=layer_version).count(),
@@ -2816,19 +2810,16 @@ if toastermain.settings.MANAGED:
         }
         return render(request, template, context)
 
-    def targets(request):
-        if not 'project_id' in request.session:
-            raise Exception("invalid page: cannot show page without a project")
-
+    def targets(request, pid):
         template = 'targets.html'
         (pagesize, orderby) = _get_parameters_values(request, 100, 'name:+')
         mandatory_parameters = { 'count': pagesize,  'page' : 1, 'orderby' : orderby }
         retval = _verify_parameters( request.GET, mandatory_parameters )
         if retval:
-            return _redirect_parameters( 'all-targets', request.GET, mandatory_parameters)
+            return _redirect_parameters( 'all-targets', request.GET, mandatory_parameters, pid = pid)
         (filter_string, search_term, ordering_string) = _search_tuple(request, Recipe)
 
-        prj = Project.objects.get(pk = request.session['project_id'])
+        prj = Project.objects.get(pk = pid)
         queryset_all = Recipe.objects.filter(Q(layer_version__up_branch__name= prj.release.name) | Q(layer_version__build__in = prj.build_set.all())).filter(name__regex=r'.{1,}.*')
 
         queryset_with_search = _get_queryset(Recipe, queryset_all, None, search_term, ordering_string, '-name')
@@ -2854,6 +2845,7 @@ if toastermain.settings.MANAGED:
                 e.vcs_link_url = e.vcs_link_url.replace('%branch%', e.preffered_layerversion.up_branch.name)
 
         context = {
+            'project' : prj,
             'projectlayerset' : jsonfilter(map(lambda x: x.layercommit.id, prj.projectlayer_set.all().select_related("layercommit"))),
             'objects' : target_info,
             'objectname' : "recipes",
@@ -2916,10 +2908,7 @@ if toastermain.settings.MANAGED:
 
         return response
 
-    def machines(request):
-        if not 'project_id' in request.session:
-            raise Exception("invalid page: cannot show page without a project")
-
+    def machines(request, pid):
         template = "machines.html"
         # define here what parameters the view needs in the GET portion in order to
         # be able to display something.  'count' and 'page' are mandatory for all views
@@ -2928,13 +2917,13 @@ if toastermain.settings.MANAGED:
         mandatory_parameters = { 'count': pagesize,  'page' : 1, 'orderby' : orderby };
         retval = _verify_parameters( request.GET, mandatory_parameters )
         if retval:
-            return _redirect_parameters( 'machines', request.GET, mandatory_parameters)
+            return _redirect_parameters( 'all-machines', request.GET, mandatory_parameters, pid = pid)
 
         # boilerplate code that takes a request for an object type and returns a queryset
         # for that object type. copypasta for all needed table searches
         (filter_string, search_term, ordering_string) = _search_tuple(request, Machine)
 
-        prj = Project.objects.get(pk = request.session['project_id'])
+        prj = Project.objects.get(pk = pid)
         compatible_layers = prj.compatible_layerversions()
 
         queryset_all = Machine.objects.filter(layer_version__in=compatible_layers)
@@ -2946,7 +2935,7 @@ if toastermain.settings.MANAGED:
         # Make sure we only show machines / layers which are compatible
         # with the current project
 
-        project_layers = ProjectLayer.objects.filter(project_id=request.session['project_id']).values_list('layercommit',flat=True)
+        project_layers = ProjectLayer.objects.filter(project_id=pid).values_list('layercommit',flat=True)
 
         # Now we need to weed out the layers which will appear as duplicated
         # because they're from a layer source which doesn't need to be used
@@ -2958,6 +2947,7 @@ if toastermain.settings.MANAGED:
         machine_info = _build_page_range(Paginator(queryset_all, request.GET.get('count', 100)),request.GET.get('page', 1))
 
         context = {
+            'project': prj,
             'objects' : machine_info,
             'projectlayerset' : jsonfilter(map(lambda x: x.layercommit.id, prj.projectlayer_set.all())),
             'objectname' : "machines",
@@ -3041,6 +3031,7 @@ if toastermain.settings.MANAGED:
             configvars = configvars.exclude(name = var)
 
         context = {
+            'project':          prj,
             'configvars':       configvars,
             'vars_managed':     vars_managed,
             'vars_fstypes':     vars_fstypes,
@@ -3316,17 +3307,6 @@ if toastermain.settings.MANAGED:
 
 
 else:
-    # these are pages that are NOT available in interactive mode
-    def managedcontextprocessor(request):
-        return {
-            "projects": [],
-            "MANAGED" : toastermain.settings.MANAGED,
-            "DEBUG" : toastermain.settings.DEBUG,
-            "TOASTER_BRANCH": toastermain.settings.TOASTER_BRANCH,
-            "TOASTER_REVISION" : toastermain.settings.TOASTER_REVISION,
-        }
-
-
     # shows the "all builds" page for interactive mode; this is the old code, simply moved
     def builds(request):
         template = 'build.html'
-- 
1.9.1


