Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f44.google.com (mail-wg0-f44.google.com [74.125.82.44])
	by mail.openembedded.org (Postfix) with ESMTP id D00D57568E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 10:34:51 +0000 (UTC)
Received: by wgbhy7 with SMTP id hy7so58680730wgb.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 03:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=wEVJp+M3eVO75gLxmvg3y9Ab2db1xopKZRA3ZxmXt6E=;
	b=ZCiJ/kMbsG4CmpbyOY1qn3TN1NsHaC7aFyJaalYL2HS+D4UE+gxpKuBu7Ju2yIgpLP
	eA9zroBS9/4aZypeRttV8JegkK1px6/jmZtFDQht1NZ+01B4NF1HQP79p3JVvZRF5xuL
	uuu/DBc7YewmlpMf4OVc2ZPe6F4iqN/DNuSEPm8QWzZqegH9T5+uoUFWX75K7Dy/MBnE
	wq/HdNxdH5eS7MNew6rinbWERJDFJqHj/s7UXhNvGXLVdCaj+MeAs532AqNlXrejtXNB
	bPviINSiShfyK1NA186gWyki0xqZ42DrmMxGu2jF3kKVtZOUi3RD82f92ORToE1S7YNM
	HOdw==
X-Gm-Message-State: ALoCoQl/qDDcUjpp3ld6jnJ1gUCDyuFfRAkYzrY+ZlC4mlncFdaQz54pLTywX10cYw0j1FZ1zj7j
X-Received: by 10.181.13.36 with SMTP id ev4mr4385827wid.65.1435228492519;
	Thu, 25 Jun 2015 03:34:52 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id v3sm6934445wiz.14.2015.06.25.03.34.51
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Jun 2015 03:34:51 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id DBE9A56289D; Thu, 25 Jun 2015 11:34:01 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Jun 2015 11:33:53 +0100
Message-Id: <7aecb974d44d9bc711ffba5cc65e770811397fba.1435228176.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
References: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1435228175.git.alexandru.damian@intel.com>
References: <cover.1435228175.git.alexandru.damian@intel.com>
Subject: [PATCH 16/23] toasterui: fixes after html5 compliance testing
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
X-List-Received-Date: Thu, 25 Jun 2015 10:34:55 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch brings fixes for issues highlighted by
HTML5 compliance testing.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/orm/models.py                                 |  4 +++-
 lib/toaster/toastergui/static/js/base.js                  |  2 +-
 lib/toaster/toastergui/templates/configvars.html          |  2 +-
 .../toastergui/templates/detail_search_header.html        |  2 +-
 .../toastergui/templates/detail_sorted_header.html        |  2 +-
 .../toastergui/templates/generic-toastertable-page.html   |  2 ++
 lib/toaster/toastergui/templates/importlayer.html         | 15 +++++++++++++--
 lib/toaster/toastergui/templates/target.html              |  2 +-
 lib/toaster/toastergui/templates/toastertable-simple.html |  4 ++--
 lib/toaster/toastergui/templates/toastertable.html        |  4 ++--
 lib/toaster/toastergui/views.py                           | 11 ++++++-----
 11 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 8488aa4..7e8ab16 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -180,7 +180,9 @@ class Project(models.Model):
         if release == None:
             release = self.release
         # layers on the same branch or layers specifically set for this project
-        queryset = Layer_Version.objects.filter((Q(up_branch__name = release.branch_name) & Q(project = None)) | Q(project = self) | Q(build__project = self))
+        queryset = Layer_Version.objects.filter(Q(project = self) | Q(build__project = self))
+        if release is not None:
+            queryset = queryset.filter(Q(up_branch__name = release.branch_name) & Q(project = None))
         if layer_name is not None:
             # we select only a layer name
             queryset = queryset.filter(layer__name = layer_name)
diff --git a/lib/toaster/toastergui/static/js/base.js b/lib/toaster/toastergui/static/js/base.js
index d079f23..f1711c1 100644
--- a/lib/toaster/toastergui/static/js/base.js
+++ b/lib/toaster/toastergui/static/js/base.js
@@ -39,7 +39,7 @@ function basePageInit(ctx) {
 
     libtoaster.getProjectInfo(selectedProject.projectPageUrl,
       function (data) {
-        if (data.machine.name === undefined || data.layers.length === 0) {
+        if (data.machine === null || data.machine.name === undefined || data.layers.length === 0) {
           /* we can't build anything with out a machine and some layers */
           $("#new-build-button #targets-form").hide();
           $("#new-build-button .alert").show();
diff --git a/lib/toaster/toastergui/templates/configvars.html b/lib/toaster/toastergui/templates/configvars.html
index 8957673..8a572ae 100644
--- a/lib/toaster/toastergui/templates/configvars.html
+++ b/lib/toaster/toastergui/templates/configvars.html
@@ -39,7 +39,7 @@
   <div class="row-fluid">
       <div class="alert">
         <form class="no-results input-append" id="searchform">
-            <input id="search" name="search" class="input-xxlarge" type="text" value="{{request.GET.search}}"/>{% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>{% endif %}
+            <input id="search" name="search" class="input-xxlarge" type="text" value="{% if request.GET.search %}{{request.GET.search}}{% endif %}"/>{% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>{% endif %}
             <button class="btn" type="submit" value="Search">Search</button>
             <button class="btn btn-link" onclick="javascript:$('#search').val('');searchform.submit()">Show all variables</button>
         </form>
diff --git a/lib/toaster/toastergui/templates/detail_search_header.html b/lib/toaster/toastergui/templates/detail_search_header.html
index ca8e158..7bea3f4 100644
--- a/lib/toaster/toastergui/templates/detail_search_header.html
+++ b/lib/toaster/toastergui/templates/detail_search_header.html
@@ -28,7 +28,7 @@ $(document).ready(function() {
     <form id="searchform" class="navbar-search input-append pull-left">
   {% endif %}
 
-      <input id="search" class="input-xlarge" type="text" placeholder="Search {{search_what}}" name="search" value="{{request.GET.search}}">
+      <input id="search" class="input-xlarge" type="text" placeholder="Search {{search_what}}" name="search" value="{% if request.GET.search %}{{request.GET.search}}{% endif %}">
       <input type="hidden" value="name:+" name="orderby">
       <input type="hidden" value="l" name="page">
   {% if request.GET.search %}
diff --git a/lib/toaster/toastergui/templates/detail_sorted_header.html b/lib/toaster/toastergui/templates/detail_sorted_header.html
index 5214444..6ce292e 100644
--- a/lib/toaster/toastergui/templates/detail_sorted_header.html
+++ b/lib/toaster/toastergui/templates/detail_sorted_header.html
@@ -9,7 +9,7 @@
     <thead>
         <!-- Table header row; generated from "tablecols" entry in the context dict -->
         <tr>
-            {% for tc in tablecols %}<th class="{{tc.dclass}} {{tc.clclass}}">
+            {% for tc in tablecols %}<th class="{%if tc.dclass%}{{tc.dclass}}{% endif %} {%if tc.class %}{{tc.clclass}}{% endif %}">
                 {%if tc.qhelp%}<i class="icon-question-sign get-help" title="{{tc.qhelp}}"></i>{%endif%}
                 {%if tc.orderfield%}<a {%if tc.ordericon%} class="sorted" {%endif%}href="javascript:reload_params({'page': 1, 'orderby' : '{{tc.orderfield}}' })">{{tc.name}}</a>{%else%}<span class="muted">{{tc.name}}</span>{%endif%}
                 {%if tc.ordericon%} <i class="icon-caret-{{tc.ordericon}}"></i>{%endif%}
diff --git a/lib/toaster/toastergui/templates/generic-toastertable-page.html b/lib/toaster/toastergui/templates/generic-toastertable-page.html
index d7ad2e7..78e942c 100644
--- a/lib/toaster/toastergui/templates/generic-toastertable-page.html
+++ b/lib/toaster/toastergui/templates/generic-toastertable-page.html
@@ -11,7 +11,9 @@
 {% block projectinfomain %}
 <div class="page-header">
   <h1>{{title}} (<span class="table-count-{{table_name}}"></span>)
+    {% if project.release %}
     <i class="icon-question-sign get-help heading-help" title="This page lists {{title}} compatible with the release selected for this project, which is {{project.release.description}}"></i>
+    {% endif %}
   </h1>
 </div>
 <div id="zone1alerts" style="display:none">
diff --git a/lib/toaster/toastergui/templates/importlayer.html b/lib/toaster/toastergui/templates/importlayer.html
index 498a204..6a5d412d 100644
--- a/lib/toaster/toastergui/templates/importlayer.html
+++ b/lib/toaster/toastergui/templates/importlayer.html
@@ -9,6 +9,7 @@
 
 {% block projectinfomain %}
 
+        {% if project and project.release %}
                   <script src="{% static 'js/layerDepsModal.js' %}"></script>
                   <script src="{% static 'js/importlayer.js' %}"></script>
                   <script>
@@ -31,9 +32,7 @@
                 </div>
 
                 <form>
-        {% if project %}
                     <span class="help-block" style="padding-left:19px;">The layer you are importing must be compatible with <strong>{{project.release.description}}</strong>, which is the release you are using in this project.</span>
-          {% endif %}
                    <fieldset class="air">
                       <legend>Layer repository information</legend>
                       <div class="alert alert-error" id="import-error" style="display:none">
@@ -131,4 +130,16 @@
                   </div>
                   </form>
 
+          {% else %} {#project and project release#}
+                <div class="page-header">
+                    <h1>Import layer</h1>
+                </div>
+                      <div class="alert alert-info" id="import-error" >
+                        <h3>Unsupported project type</h3>
+                        <p>This project does not support importing layers.</p>
+                        <ul></ul>
+                      </div>
+
+          {% endif %}
+
 {% endblock %}
diff --git a/lib/toaster/toastergui/templates/target.html b/lib/toaster/toastergui/templates/target.html
index fa59f4e..65e6c4a 100644
--- a/lib/toaster/toastergui/templates/target.html
+++ b/lib/toaster/toastergui/templates/target.html
@@ -53,7 +53,7 @@
     <div class="row-fluid">
         <div class="alert">
             <form class="no-results input-append" id="searchform">
-                <input id="search" name="search" class="input-xxlarge" type="text" value="{{request.GET.search}}"/>{% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>{% endif %}
+                <input id="search" name="search" class="input-xxlarge" type="text" value="{% if request.GET.search %}{{request.GET.search}}{% endif %}"/>{% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>{% endif %}
                 <button class="btn" type="submit" value="Search">Search</button>
                 <button class="btn btn-link" onclick="javascript:$('#search').val('');searchform.submit()">Show all packages</button>
             </form>
diff --git a/lib/toaster/toastergui/templates/toastertable-simple.html b/lib/toaster/toastergui/templates/toastertable-simple.html
index ea7b38e..212318b 100644
--- a/lib/toaster/toastergui/templates/toastertable-simple.html
+++ b/lib/toaster/toastergui/templates/toastertable-simple.html
@@ -29,7 +29,7 @@
 <div class="row-fluid" id="no-results-{{table_name}}" style="display:none">
   <div class="alert">
     <form class="no-results input-append">
-      <input class="input-xlarge" id="new-search-input-{{table_name}}" name="search" type="text" placeholder="Search {{title|lower}}" value="{{request.GET.search}}"/>
+      <input class="input-xlarge" id="new-search-input-{{table_name}}" name="search" type="text" placeholder="Search {{title|lower}}" value="{% if request.GET.search %}{{request.GET.search}}{% endif %}"/>
       <a href="#" class="add-on btn remove-search-btn-{{table_name}}" tabindex="-1">
         <i class="icon-remove"></i>
       </a>
@@ -44,7 +44,7 @@
   <div class="row-fluid" id="table-chrome-{{table_name}}">
       <div class="navbar-search input-append pull-left">
 
-        <input class="input-xlarge" id="search-input-{{table_name}}" name="search" type="text" placeholder="Search {{title|lower}}" value="{{request.GET.search}}"/>
+        <input class="input-xlarge" id="search-input-{{table_name}}" name="search" type="text" placeholder="Search {{title|lower}}" value="{% if request.GET.search %}{{request.GET.search}}{% endif %}"/>
         <a href="#" style="display:none" class="add-on btn remove-search-btn-{{table_name}}" tabindex="-1">
           <i class="icon-remove"></i>
         </a>
diff --git a/lib/toaster/toastergui/templates/toastertable.html b/lib/toaster/toastergui/templates/toastertable.html
index c7c7a84..0473116 100644
--- a/lib/toaster/toastergui/templates/toastertable.html
+++ b/lib/toaster/toastergui/templates/toastertable.html
@@ -29,7 +29,7 @@
 <div class="row-fluid" id="no-results-{{table_name}}" style="display:none">
   <div class="alert">
     <form class="no-results input-append">
-      <input class="input-xxlarge" id="new-search-input-{{table_name}}" name="search" type="text" placeholder="Search {{title|lower}}" value="{{request.GET.search}}"/>
+      <input class="input-xxlarge" id="new-search-input-{{table_name}}" name="search" type="text" placeholder="Search {{title|lower}}" value="{%if request.GET.search %}{{request.GET.search}}{%endif%}"/>
       <a href="#" class="add-on btn remove-search-btn-{{table_name}}" tabindex="-1">
         <i class="icon-remove"></i>
       </a>
@@ -46,7 +46,7 @@
     <div class="navbar-inner">
       <div class="navbar-search input-append pull-left">
 
-        <input class="input-xxlarge" id="search-input-{{table_name}}" name="search" type="text" placeholder="Search {{title|lower}}" value="{{request.GET.search}}"/>
+        <input class="input-xxlarge" id="search-input-{{table_name}}" name="search" type="text" placeholder="Search {{title|lower}}" value="{%if request.GET.search%}{{request.GET.search}}{%endif%}"/>
         <a href="#" style="display:none" class="add-on btn remove-search-btn-{{table_name}}" tabindex="-1">
           <i class="icon-remove"></i>
         </a>
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index ec65903..82650d0 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -165,8 +165,8 @@ def _lv_to_dict(prj, x = None):
 
     return {"id": x.pk,
             "name": x.layer.name,
-            "tooltip": x.layer.vcs_url+" | "+x.get_vcs_reference(),
-            "detail": "(" + x.layer.vcs_url + (")" if x.up_branch == None else " | "+x.get_vcs_reference()+")"),
+            "tooltip": "%s | %s" % (x.layer.vcs_url,x.get_vcs_reference()),
+            "detail": "(%s" % x.layer.vcs_url + (")" if x.up_branch == None else " | "+x.get_vcs_reference()+")"),
             "giturl": x.layer.vcs_url,
             "layerdetailurl" : reverse('layerdetails', args=(prj.id,x.pk)),
             "revision" : x.get_vcs_reference(),
@@ -559,10 +559,10 @@ def task( request, build_id, task_id ):
     uri_list= [ ]
     variables = Variable.objects.filter(build=build_id)
     v=variables.filter(variable_name='SSTATE_DIR')
-    if v.count > 0:
+    if v.count() > 0:
         uri_list.append(v[0].variable_value)
     v=variables.filter(variable_name='SSTATE_MIRRORS')
-    if (v.count > 0):
+    if (v.count() > 0):
         for mirror in v[0].variable_value.split('\\n'):
             s=re.sub('.* ','',mirror.strip(' \t\n\r'))
             if len(s): uri_list.append(s)
@@ -2124,9 +2124,10 @@ if True:
                     login(request, user)
 
                 #  save the project
-                release = Release.objects.get(pk = request.POST.get('projectversion', None ))
                 if ptype == "analysis":
                     release = None
+                else:
+                    release = Release.objects.get(pk = request.POST.get('projectversion', None ))
 
                 prj = Project.objects.create_project(name = request.POST['projectname'], release = release)
                 prj.user_id = request.user.pk
-- 
1.9.1


