Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
	[209.85.212.169])
	by mail.openembedded.org (Postfix) with ESMTP id 7ACBB73C27
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 31 Mar 2015 18:20:49 +0000 (UTC)
Received: by wibgn9 with SMTP id gn9so36819782wib.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 31 Mar 2015 11:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=/3Do4nYV6GBWNRWu2cvk2UlU1S5J7Q4S7g71vgm//aQ=;
	b=TI8qWAAZXp0evyX8SLRgDfd6OLjv88iuw/81qXBAP4l+4SjwQhwmbE0+6VVeRj0XId
	AzyA5qkFHQQOlzZuIbffs9XrbAETprxXBR8woYAxWoPayJGFw0hlV7+kvaAT5E0LdLY7
	5MuRgpL5Ni8Kn65yLNNrTLfIXE6vPJmcAZCXbdDpMmeuxB561P89i4sgxqF0MQhtRvH2
	E9FmgpL+G1Gg0bgT0zIHv/aa0DTdDA5/Utl+TEjwMXywVDI8+xyHD12OE0pgC7ycMiGn
	vE4XhKJfr35r9FKxFwMMR2PDySTuw2z2B3McJKNwIH1FqOIBZGhyVZpd9fxOpj9nYHWT
	6nuw==
X-Gm-Message-State: ALoCoQlYim4a9p+dy2IbeeplrG02iUQLhDE3jnY8UP2K8gEIlI9ZpmkT7aie2J23EOyJ1nEXQ020
X-Received: by 10.180.85.130 with SMTP id h2mr7851633wiz.3.1427826049888;
	Tue, 31 Mar 2015 11:20:49 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	nh17sm21373782wic.5.2015.03.31.11.20.48
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 31 Mar 2015 11:20:48 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 33B36561E68; Tue, 31 Mar 2015 15:07:31 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 31 Mar 2015 15:07:28 +0100
Message-Id: <9db057280661ecf4684a4b101422d8be1b60f473.1427810520.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <4b553dbeff7c7bc536669e7fee7d52f962259ebe.1427810520.git.alexandru.damian@intel.com>
References: <4b553dbeff7c7bc536669e7fee7d52f962259ebe.1427810520.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1427810520.git.alexandru.damian@intel.com>
References: <cover.1427810520.git.alexandru.damian@intel.com>
Subject: [PATCH 2/4] toasterui: rename 'targets' to 'recipes'
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
X-List-Received-Date: Tue, 31 Mar 2015 18:20:53 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

A recent round of informal user feedback has revealed
that the term 'target' is quite problematic. For
all the users we spoke to the word refers to the
target arch. In Toaster, it refers to the software
you build.

This patch replaces the word 'target' with 'recipe'
across the Toaster interface. This is by no means
self-explanatory, but at least it cannot be confused
with target hardware, and it is also consistent with
the terminology we use in the analysis portion of
the interface.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/static/js/layerdetails.js   |  2 +-
 lib/toaster/toastergui/templates/base.html         |  4 ++--
 lib/toaster/toastergui/templates/layerdetails.html | 16 ++++++++--------
 lib/toaster/toastergui/templates/project.html      | 22 +++++++++++-----------
 lib/toaster/toastergui/templates/targets.html      | 16 ++++++++--------
 lib/toaster/toastergui/views.py                    | 18 +++++++++---------
 6 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/layerdetails.js b/lib/toaster/toastergui/static/js/layerdetails.js
index 5b77877..bac60c4 100644
--- a/lib/toaster/toastergui/static/js/layerdetails.js
+++ b/lib/toaster/toastergui/static/js/layerdetails.js
@@ -155,7 +155,7 @@ function layerDetailsPageInit (ctx) {
     if (!ctx.layerVersion.inCurrentPrj){
       if (ctx.numTargets > 0) {
         var text = " Add the "+ctx.layerVersion.name+" layer to your project "+
-          "to enable these targets";
+          "to enable these recipes";
         addRmLayerBtn.text(text);
         addRmLayerBtn.prepend("<span class=\"icon-plus\"></span>");
       } else {
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index 2535f70..58392b3 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -100,9 +100,9 @@
                     <p><a href="{% if project.id %}{% url 'project' project.id %}{% endif %}">View project configuration</a></p>
                   </div>
                   <li id="targets-form">
-                    <h6>Target(s):</h6>
+                    <h6>Recipe(s):</h6>
                     <form>
-                      <input type="text" class="input-xlarge" id="build-target-input" placeholder="Type a target name" autocomplete="off" data-minLength="1" data-autocomplete="off" data-provide="typeahead" />
+                      <input type="text" class="input-xlarge" id="build-target-input" placeholder="Type a recipe name" autocomplete="off" data-minLength="1" data-autocomplete="off" data-provide="typeahead" />
                       <div>
                         <a class="btn btn-primary" id="build-button" disabled="disabled" data-project-id="{{project.id}}">Build</a>
                       </div>
diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index 11b1ffc..0d3aa15 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -84,7 +84,7 @@
             <a data-toggle="tab" href="#information" id="details-tab">Layer details</a>
           </li>
           <li>
-            <a data-toggle="tab" href="#targets" id="targets-tab">Targets ({{total_targets}})</a>
+            <a data-toggle="tab" href="#targets" id="targets-tab">Recipes ({{total_targets}})</a>
           </li>
           <li>
             <a data-toggle="tab" href="#machines" id="machines-tab">Machines ({{total_machines}})</a>
@@ -190,8 +190,8 @@
                 <div name="targets" id="targets" class="tab-pane">
                   {% if total_targets == 0 %}
                   <div class="alert alert-info">
-                    <p>Toaster does not have target information for the <strong> {{layerversion.layer.name}} </strong> layer.</p>
-		    <p>Toaster learns about layers when you build them. If this layer provides any targets, they will be listed here after you build the <strong> {{layerversion.layer.name}} </strong> layer.</p>
+                    <p>Toaster does not have recipe information for the <strong> {{layerversion.layer.name}} </strong> layer.</p>
+		    <p>Toaster learns about layers when you build them. If this layer provides any recipes, they will be listed here after you build the <strong> {{layerversion.layer.name}} </strong> layer.</p>
                   </div>
                   {% else %}
 
@@ -210,7 +210,7 @@
                       <form class="navbar-search input-append pull-left">
                     {% endif %}
 
-                      <input type="text" id="target-search" name="targets_search" placeholder="Search targets" class="input-xlarge" value="{{request.GET.targets_search}}">
+                      <input type="text" id="target-search" name="targets_search" placeholder="Search recipes" class="input-xlarge" value="{{request.GET.targets_search}}">
                         {% if request.GET.targets_search %}
                         <a class="add-on btn target-search-clear">
                           <i class="icon-remove"></i>
@@ -253,17 +253,17 @@
                     <tr>
                       <th>
                           <i class="icon-question-sign get-help" title="Information about a single piece of software, including where to download the source, configuration options, how to compile the source files and how to package the compiled output"></i>
-                          Target
+                          Recipe
                           {% if request.GET.targets_search %}
                             <span class="badge badge-info">{{targets.paginator.count}}</span>
                           {% endif %}
                         </th>
                         <th>
                           <i class="icon-question-sign get-help" title="The recipe version and revision"></i>
-                          Target version
+                          Recipe version
                         </th>
                         <th class="span4">Summary</th>
-                        <th class="span2">Build target</th>
+                        <th class="span2">Build recipe</th>
                       </tr>
                     </thead>
                     <tbody>
@@ -277,7 +277,7 @@
                         </td>
                         <td>{{target.version}}</td>
                         <td>{{target.summary}}</td>
-                        <td><button class="btn btn-block build-target-btn" data-target-name="{{target.name}}" {% if layer_in_project == 0 %}disabled="disabled"{% endif %} >Build target</button></td>
+                        <td><button class="btn btn-block build-target-btn" data-target-name="{{target.name}}" {% if layer_in_project == 0 %}disabled="disabled"{% endif %} >Build recipe</button></td>
                       </tr>
                       {% endfor %}
                     </tbody>
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index 9d51a57..5f8f4d1 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -104,15 +104,15 @@ vim: expandtab tabstop=2
   <div class="well">
     <form class="build-form" ng-submit="buildNamedTarget()">
       <div class="input-append controls">
-        <input type="text" class="huge input-xxlarge" placeholder="Type the target(s) you want to build" autocomplete="off" ng-model="targetName" typeahead="e.name for e in getAutocompleteSuggestions('targets', $viewValue)|filter:$viewValue" typeahead-template-url="suggestion_details" ng-disabled="!layers.length"/>
+        <input type="text" class="huge input-xxlarge" placeholder="Type the recipe(s) you want to build" autocomplete="off" ng-model="targetName" typeahead="e.name for e in getAutocompleteSuggestions('targets', $viewValue)|filter:$viewValue" typeahead-template-url="suggestion_details" ng-disabled="!layers.length"/>
         <button type="submit" class="btn btn-large btn-primary" ng-disabled="!targetName.length">
         Build
         </button>
       </div>
-      <i class="icon-question-sign get-help get-help-blue" title="Type the name of one or more targets you want to build, separated by a space. You can also specify a task by appending a semicolon and a task name to a target name, like so: <code>core-image-minimal:do_build</code>"></i>
+      <i class="icon-question-sign get-help get-help-blue" title="Type the name of one or more recipes you want to build, separated by a space. You can also specify a task by appending a semicolon and a task name to a recipe name, like so: <code>core-image-minimal:do_build</code>"></i>
       <p>
-        <a href="{% url 'all-targets' %}">View all compatible targets</a>
-        <i class="icon-question-sign get-help get-help-blue heading-help" title="View all the targets you can build with the release selected for this project, which is {[project.release.desc]}"></i>
+        <a href="{% url 'all-targets' %}">View all compatible recipes</a>
+        <i class="icon-question-sign get-help get-help-blue heading-help" title="View all the recipes you can build with the release selected for this project, which is {[project.release.desc]}"></i>
         {% if completedbuilds.count %}
           | <a href="{% url 'projectbuilds' project.id %}">View all project builds ({{completedbuilds.count}})</a>
         {% endif %}
@@ -309,24 +309,24 @@ vim: expandtab tabstop=2
     <!-- project targets -->
     <div id="target-container" class="well well-transparent span4">
       <h3>
-        Targets
-        <i class="icon-question-sign get-help heading-help" title="What you build, often a recipe producing a root file system file (an image). Something like <code>core-image-minimal</code> or <code>core-image-sato</code>"></i>
+        Recipes
+        <i class="icon-question-sign get-help heading-help" title="What you build, often an image recipe that produces a root file system file. Something like <code>core-image-minimal</code> or <code>core-image-sato</code>"></i>
       </h3>
         <form ng-submit="buildNamedTarget()">
           <div class="input-append">
-            <input type="text" class="input-xlarge" placeholder="Type the target(s) you want to build" autocomplete="off" data-minLength="1"  ng-model="targetName1" typeahead="e.name for e in getAutocompleteSuggestions('targets', $viewValue)|filter:$viewValue" typeahead-template-url="suggestion_details" ng-disabled="!layers.length">
+            <input type="text" class="input-xlarge" placeholder="Type the recipe(s) you want to build" autocomplete="off" data-minLength="1"  ng-model="targetName1" typeahead="e.name for e in getAutocompleteSuggestions('targets', $viewValue)|filter:$viewValue" typeahead-template-url="suggestion_details" ng-disabled="!layers.length">
             <button type="submit" class="btn btn-primary" ng-disabled="!targetName1.length">
               Build </button>
           </div>
           {% csrf_token %}
         </form>
         <p>
-          <a href="{% url 'all-targets' %}">View all compatible targets</a>
-          <i class="icon-question-sign get-help" title="View all the targets you can build with the release selected for this project, which is {[project.release.desc]}"></i>
+          <a href="{% url 'all-targets' %}">View all compatible recipes</a>
+          <i class="icon-question-sign get-help" title="View all the recipes you can build with the release selected for this project, which is {[project.release.desc]}"></i>
         </p>
         <div ng-if="frequenttargets.length">
         <h4 class="air">
-            Most built targets
+            Most built recipes
         </h4>
           <ul class="unstyled configuration-list {[mutedtargets]}">
           <li ng-repeat="t in frequenttargets">
@@ -335,7 +335,7 @@ vim: expandtab tabstop=2
             </label>
           </li>
         </ul>
-        <button class="btn btn-large btn-primary" ng-disabled="enableBuildSelectedTargets()" ng-click="buildSelectedTargets()">Build selected targets</button>
+        <button class="btn btn-large btn-primary" ng-disabled="enableBuildSelectedTargets()" ng-click="buildSelectedTargets()">Build selected recipes</button>
         </div>
     </div>
 
diff --git a/lib/toaster/toastergui/templates/targets.html b/lib/toaster/toastergui/templates/targets.html
index 6f59a6c..c272920 100644
--- a/lib/toaster/toastergui/templates/targets.html
+++ b/lib/toaster/toastergui/templates/targets.html
@@ -3,20 +3,20 @@
 {% load humanize %}
 
 {% block localbreadcrumb %}
-<li>All compatible targets</li>
+<li>All compatible recipes</li>
 {% endblock %}
 
 {% block projectinfomain %}
                 <div class="page-header">
                     <h1>
   {% if request.GET.filter and objects.paginator.count >  0 or request.GET.search and objects.paginator.count >  0 %}
-      {{objects.paginator.count}} target{{objects.paginator.count|pluralize}} found
+      {{objects.paginator.count}} recipe{{objects.paginator.count|pluralize}} found
   {% elif request.GET.filter and objects.paginator.count ==  0 or request.GET.search and objects.paginator.count == 0 %}
-      No targets found
+      No recipes found
   {%else%}
-      All compatible targets
+      All compatible recipes
   {%endif%}
-                        <i class="icon-question-sign get-help heading-help" title="This page lists all the targets compatible with the release selected for this project, which is {{project.release.description}}"></i>
+                        <i class="icon-question-sign get-help heading-help" title="This page lists all the recipes compatible with the release selected for this project, which is {{project.release.description}}"></i>
                      </h1>
                 </div>
 
@@ -31,13 +31,13 @@
         <form class="no-results input-append" id="searchform">
             <input id="search" name="search" class="input-xxlarge" type="text" value="{{request.GET.search}}"/>{% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>{% endif %}
             <button class="btn" type="submit" value="Search">Search</button>
-            <button class="btn btn-link" onclick="javascript:$('#search').val('');searchform.submit()">Show all targets</button>
+            <button class="btn btn-link" onclick="javascript:$('#search').val('');searchform.submit()">Show all recipes</button>
         </form>
       </div>
   </div>
   {% else %}
     <div class="alert alert-info lead">
-      <p>Toaster has no target information. To generate target information you can:</p>
+      <p>Toaster has no recipe information. To generate recipe information you can:</p>
       <ul>
        <li><a href="http://www.yoctoproject.org/docs/latest/toaster-manual/toaster-manual.html#layer-source">Configure a layer source</a></li>
        <li><a href="{% url 'importlayer' %}">Import a layer</a>, then run a build</li>
@@ -78,7 +78,7 @@
         <td class="add-layer" value="{{o.pk}}" layerversion_id="{{o.preffered_layerversion.pk}}">
             <div id="layer-tooltip-{{o.pk}}" style="display: none; font-size: 11px; line-height: 1.3;" class="tooltip-inner">layer was modified</div>
             <a href="{% url 'project' project.id %}#/targetbuild={{o.name}}" id="target-build-{{o.pk}}" class="btn btn-block remove-layer" style="display:none;" >
-                Build target
+                Build recipe
             </a>
             <a id="layer-add-{{o.pk}}" class="btn btn-block" style="display:none;" href="javascript:layerAdd({{o.preffered_layerversion.pk}}, '{{o.preffered_layerversion.layer.name}}', '{%url 'layerdetails' o.preffered_layerversion.pk%}', {{o.pk}})" >
                 <i class="icon-plus"></i>
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 2f8fb1a..48c65d8 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2005,8 +2005,8 @@ if toastermain.settings.MANAGED:
                                              ]
                                 }
                     },
-                    {'name': 'Target',                                                 # default column, disabled box, with just the name in the list
-                     'qhelp': "This is the build target or build targets (i.e. one or more recipes or image recipes)",
+                    {'name': 'Recipe',                                                 # default column, disabled box, with just the name in the list
+                     'qhelp': "What you built (i.e. one or more recipes or image recipes)",
                      'orderfield': _get_toggle_order(request, "brtarget__target"),
                      'ordericon':_get_toggle_order_icon(request, "brtarget__target"),
                     },
@@ -2884,15 +2884,15 @@ if toastermain.settings.MANAGED:
         context = {
             'projectlayerset' : jsonfilter(map(lambda x: x.layercommit.id, prj.projectlayer_set.all().select_related("layercommit"))),
             'objects' : target_info,
-            'objectname' : "targets",
+            'objectname' : "recipes",
             'default_orderby' : 'name:+',
 
             'tablecols' : [
-                {   'name': 'Target',
+                {   'name': 'Recipe',
                     'orderfield': _get_toggle_order(request, "name"),
                     'ordericon' : _get_toggle_order_icon(request, "name"),
                 },
-                {   'name': 'Target version',
+                {   'name': 'Recipe version',
                     'dclass': 'span2',
                 },
                 {   'name': 'Description',
@@ -3316,8 +3316,8 @@ if toastermain.settings.MANAGED:
                     {'name': 'Last build outcome', 'clclass': 'loutcome',
                     'qhelp': "Tells you if the last project build completed successfully or failed",
                     },
-                    {'name': 'Target', 'clclass': 'ltarget',
-                    'qhelp': "The last project build target(s): one or more recipes or image recipes",
+                    {'name': 'Recipe', 'clclass': 'ltarget',
+                    'qhelp': "The last recipe that was built in this project",
                     },
                     {'name': 'Errors', 'clclass': 'lerrors',
                     'qhelp': "How many errors were encountered during the last project build (if any)",
@@ -3431,8 +3431,8 @@ else:
                                              ]
                                 }
                     },
-                    {'name': 'Target',                                                 # default column, disabled box, with just the name in the list
-                     'qhelp': "This is the build target or build targets (i.e. one or more recipes or image recipes)",
+                    {'name': 'Recipe',                                                 # default column, disabled box, with just the name in the list
+                     'qhelp': "What you built (i.e. one or more recipes or image recipes)",
                      'orderfield': _get_toggle_order(request, "target__target"),
                      'ordericon':_get_toggle_order_icon(request, "target__target"),
                     },
-- 
1.9.1


