Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
	[209.85.212.170])
	by mail.openembedded.org (Postfix) with ESMTP id D58B765C9D
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 14:39:06 +0000 (UTC)
Received: by wibut5 with SMTP id ut5so50708284wib.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 07:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=0DQv945xRCHex5RspYyhSqJJqUQ8SOGAFmU1WFd7/EA=;
	b=mriRzRM34+3ng1hHO9ZctLX+593+5zi0ME0oArsZaIS0j73SEVx/7BqlEx/dzdeKFo
	6wc94a61oMoXrETQHqvuhEeT271IAJT91IPT66bKx6whAH29pacM8AcDBPgxnynaTYIm
	hqj/fS4Jf6v8Ewoxg98s9qLIHacABryWjGnlhCoTW+o29lnjHuw4YQoM+mfznYjWoLN5
	uF4yh5qqv6CniYsYhHTC9CEcFA87G1hGVWwPB9y5D7Bobtz8FRlodIaPSyJ3scHg0sfg
	LhQBhi74G3WZdOwhi9WJAXtPFULWT+GTKsaWOvvcTX+3QECPh0DeO+JhXJkxz/1kuss0
	tExA==
X-Gm-Message-State: ALoCoQnIOT0MUxlzHw//jy7hOolEqSlupjgsotGpcfI+9GbKxuqT7hPbVKouHyILXAQCeXsu4eZ7
X-Received: by 10.194.205.101 with SMTP id lf5mr6997920wjc.42.1433947147768;
	Wed, 10 Jun 2015 07:39:07 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id q4sm14859322wja.24.2015.06.10.07.39.05
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Jun 2015 07:39:06 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 0666D56105C; Wed, 10 Jun 2015 15:39:09 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Jun 2015 15:38:49 +0100
Message-Id: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1433946742.git.alexandru.damian@intel.com>
References: <cover.1433946742.git.alexandru.damian@intel.com>
Subject: [PATCH 01/19] toaster: move project data typeahead to the REST API
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
X-List-Received-Date: Wed, 10 Jun 2015 14:39:07 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch enables JSON requests on the project REST endpoint,
and replaces the universal queries "xhr_datatypeahead" with the
`project` type to the REST project endpoint.

The patch adds a decorator that takes a context returned by a view
and either renders the template specified as the decorator argument,
or converts the context to JSON.

Normal "search", "filter" and "order" options for view work as normal
on the JSON API format. To enable the JSON return, set the "format"
GET parameter to "json".

In order to demonstrate the functionality, the "New build" button
is switched from using the xhr_datatypeahead to the project
REST API with JSON formatting. Additionally, the XHR APIs that
perform actions with the project id passed as parameter are removed,
and the needed URLs are populated from the project JSON API returns after
the project has been selected.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/static/js/base.js           | 51 ++++++++-----
 lib/toaster/toastergui/static/js/importlayer.js    |  6 +-
 lib/toaster/toastergui/static/js/layerdetails.js   |  2 +-
 lib/toaster/toastergui/static/js/libtoaster.js     | 12 +--
 lib/toaster/toastergui/templates/base.html         | 24 +++---
 .../toastergui/templates/basetable_bottom.html     |  2 +-
 .../templates/detail_pagination_bottom.html        |  2 +-
 lib/toaster/toastergui/templatetags/projecttags.py |  4 +-
 lib/toaster/toastergui/urls.py                     |  3 -
 lib/toaster/toastergui/views.py                    | 89 ++++++++++++++--------
 10 files changed, 119 insertions(+), 76 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/base.js b/lib/toaster/toastergui/static/js/base.js
index ccc23e0..9424b6c 100644
--- a/lib/toaster/toastergui/static/js/base.js
+++ b/lib/toaster/toastergui/static/js/base.js
@@ -15,20 +15,21 @@ function basePageInit (ctx) {
 
   /* Hide the change project icon when there is only one project */
   if (ctx.numProjects == 1){
-     $('#project .icon-pencil').hide(); 
+     $('#project .icon-pencil').hide();
   }
 
   newBuildButton.show().removeAttr("disabled");
 
+
   _checkProjectBuildable()
   _setupNewBuildButton();
 
 
   function _checkProjectBuildable(){
-    if (currentProjectId == undefined)
+    if (libtoaster.ctx.projectId == undefined)
       return;
 
-    libtoaster.getProjectInfo(ctx.projectInfoUrl, currentProjectId,
+    libtoaster.getProjectInfo(ctx.projectInfoUrl, libtoaster.ctx.projectId,
       function(data){
         if (data.machine.name == undefined || data.layers.length == 0) {
           /* we can't build anything with out a machine and some layers */
@@ -53,18 +54,13 @@ function basePageInit (ctx) {
     /* If we don't have a current project then present the set project
      * form.
      */
-    if (currentProjectId == undefined) {
+    if (libtoaster.ctx.projectId == undefined) {
       $('#change-project-form').show();
       $('#project .icon-pencil').hide();
     }
 
-    libtoaster.makeTypeahead(newBuildTargetInput, { type : "targets", project_id: currentProjectId }, function(item){
-        /* successfully selected a target */
-        selectedTarget = item;
-    });
 
-
-    libtoaster.makeTypeahead(newBuildProjectInput, { type : "projects" }, function(item){
+    libtoaster.makeTypeahead(newBuildProjectInput, libtoaster.ctx.projectsUrl, { format : "json" }, function(item){
         /* successfully selected a project */
         newBuildProjectSaveBtn.removeAttr("disabled");
         selectedProject = item;
@@ -93,20 +89,40 @@ function basePageInit (ctx) {
       if (!selectedTarget)
         selectedTarget = { name: newBuildTargetInput.val() };
       /* fire and forget */
-      libtoaster.startABuild(ctx.projectBuildUrl, currentProjectId, selectedTarget.name, null, null);
-      window.location.replace(ctx.projectBasePageUrl+currentProjectId);
+      libtoaster.startABuild(ctx.projectBuildUrl, libtoaster.ctx.projectId, selectedTarget.name, null, null);
+      window.location.replace(libtoaster.ctx.projectPageUrl);
     });
 
     newBuildProjectSaveBtn.click(function() {
-      currentProjectId = selectedProject.id
+      libtoaster.ctx.projectId = selectedProject.pk
       /* Update the typeahead project_id paramater */
       _checkProjectBuildable();
-      newBuildTargetInput.data('typeahead').options.xhrParams.project_id = currentProjectId;
-      newBuildTargetInput.val("");
 
-      $("#new-build-button #project a").text(selectedProject.name).attr('href', ctx.projectBasePageUrl+currentProjectId);
-      $("#new-build-button .alert a").attr('href', ctx.projectBasePageUrl+currentProjectId);
+      /* we set the effective context of the page to the currently selected project */
+      /* TBD: do we override even if we already have a context project ?? */
+      /* TODO: replace global library context with references to the "selected" project */
+      libtoaster.ctx.projectPageUrl = selectedProject.projectPageUrl;
+      libtoaster.ctx.xhrProjectEditUrl = selectedProject.xhrProjectEditUrl;
+      libtoaster.ctx.projectName = selectedProject.name;
+      libtoaster.ctx.projectId = selectedProject.id;
+
+      ctx.projectBuildUrl = selectedProject.projectBuildUrl;
+
+      /* we can create a target typeahead only after we have a project selected */
+      newBuildTargetInput.prop("disabled", false);
+      newBuildTargetBuildBtn.prop("disabled", false);
+
+      libtoaster.makeTypeahead(newBuildTargetInput, selectedProject.xhrProjectDataTypeaheadUrl, { type : "targets" }, function(item){
+        /* successfully selected a target */
+        selectedTarget = item;
+	    });
+
+      newBuildTargetInput.val("");
 
+      /* set up new form aspect */
+      $("#new-build-button #project a").text(selectedProject.name).attr('href', libtoaster.ctx.projectPageUrl);
+      $("#new-build-button .alert a").attr('href', libtoaster.ctx.projectPageUrl);
+      $("#project .icon-pencil").show();
 
       $("#change-project-form").slideUp({ 'complete' : function() {
           $("#new-build-button #project").show();
@@ -116,6 +132,7 @@ function basePageInit (ctx) {
     $('#new-build-button #project .icon-pencil').click(function() {
       newBuildProjectSaveBtn.attr("disabled", "disabled");
       newBuildProjectInput.val($("#new-build-button #project a").text());
+      $("#cancel-change-project").show();
       $(this).parent().hide();
       $("#change-project-form").slideDown();
     });
diff --git a/lib/toaster/toastergui/static/js/importlayer.js b/lib/toaster/toastergui/static/js/importlayer.js
index 875cc34..beb2ede 100644
--- a/lib/toaster/toastergui/static/js/importlayer.js
+++ b/lib/toaster/toastergui/static/js/importlayer.js
@@ -18,7 +18,7 @@ function importLayerPageInit (ctx) {
 
   $("#new-project-button").hide();
 
-  libtoaster.makeTypeahead(layerDepInput, { type : "layers", project_id: libtoaster.ctx.projectId, include_added: "true" }, function(item){
+  libtoaster.makeTypeahead(layerDepInput, libtoaster.ctx.xhrProjectDataTypeaheadUrl, { type : "layers", project_id: libtoaster.ctx.projectId, include_added: "true" }, function(item){
     currentLayerDepSelection = item;
 
     layerDepBtn.removeAttr("disabled");
@@ -28,7 +28,7 @@ function importLayerPageInit (ctx) {
   /* We automatically add "openembedded-core" layer for convenience as a
    * dependency as pretty much all layers depend on this one
    */
-  $.getJSON(libtoaster.ctx.xhrDataTypeaheadUrl, { type : "layers", project_id: libtoaster.ctx.projectId, include_added: "true" , value: "openembedded-core" }, function(layer) {
+  $.getJSON(libtoaster.ctx.xhrProjectDataTypeaheadUrl, { type : "layers", project_id: libtoaster.ctx.projectId, include_added: "true" , value: "openembedded-core" }, function(layer) {
     if (layer.list.length == 1) {
       currentLayerDepSelection = layer.list[0];
       layerDepBtn.click();
@@ -211,7 +211,7 @@ function importLayerPageInit (ctx) {
       var name = $(this).val();
 
       /* Check if the layer name exists */
-      $.getJSON(libtoaster.ctx.xhrDataTypeaheadUrl, { type : "layers", project_id: libtoaster.ctx.projectId, include_added: "true" , value: name }, function(layer) {
+      $.getJSON(libtoaster.ctx.xhrProjectDataTypeaheadUrl, { type : "layers", project_id: libtoaster.ctx.projectId, include_added: "true" , value: name }, function(layer) {
       if (layer.list.length > 0) {
         for (var i in layer.list){
           if (layer.list[i].name == name) {
diff --git a/lib/toaster/toastergui/static/js/layerdetails.js b/lib/toaster/toastergui/static/js/layerdetails.js
index 3746ea2..8e14b8f 100644
--- a/lib/toaster/toastergui/static/js/layerdetails.js
+++ b/lib/toaster/toastergui/static/js/layerdetails.js
@@ -9,7 +9,7 @@ function layerDetailsPageInit (ctx) {
   var addRmLayerBtn = $("#add-remove-layer-btn");
 
   /* setup the dependencies typeahead */
-  libtoaster.makeTypeahead(layerDepInput, { type : "layers", project_id: libtoaster.ctx.projectId, include_added: "true" }, function(item){
+  libtoaster.makeTypeahead(layerDepInput, libtoaster.ctx.xhrProjectDataTypeaheadUrl, { type : "layers", project_id: libtoaster.ctx.projectId, include_added: "true" }, function(item){
     currentLayerDepSelection = item;
 
     layerDepBtn.removeAttr("disabled");
diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index 99e1f03..72fb0a93 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -10,16 +10,16 @@ var libtoaster = (function (){
    * xhrUrl: the url to get the JSON from expects JSON in the form:
    *  { "list": [ { "name": "test", "detail" : "a test thing"  }, .... ] }
    * xhrParams: the data/parameters to pass to the getJSON url e.g.
-   *  { 'type' : 'projects' } the text typed will be passed as 'value'.
+   *  { 'type' : 'projects' } the text typed will be passed as 'search'.
    *  selectedCB: function to call once an item has been selected one
    *  arg of the item.
    */
-  function _makeTypeahead (jQElement, xhrParams, selectedCB) {
+  function _makeTypeahead (jQElement, xhrUrl, xhrParams, selectedCB) {
 
     jQElement.typeahead({
         source: function(query, process){
-          xhrParams.value = query;
-          $.getJSON(libtoaster.ctx.xhrDataTypeaheadUrl, this.options.xhrParams, function(data){
+          xhrParams.search = query;
+          $.getJSON(xhrUrl, this.options.xhrParams, function(data){
             if (data.error !== "ok") {
               console.log("Error getting data from server "+data.error);
               return;
@@ -41,7 +41,7 @@ var libtoaster = (function (){
           return $('<span></span>').text(item.name).get(0);
         },
         sorter: function (items) { return items; },
-        xhrUrl: libtoaster.ctx.xhrDataTypeaheadUrl,
+        xhrUrl: xhrUrl,
         xhrParams: xhrParams,
     });
 
@@ -172,7 +172,7 @@ var libtoaster = (function (){
 
   function _getLayerDepsForProject(projectId, layerId, onSuccess, onFail){
     /* Check for dependencies not in the current project */
-    $.getJSON(libtoaster.ctx.xhrDataTypeaheadUrl,
+    $.getJSON(libtoaster.ctx.xhrProjectDataTypeaheadUrl,
       { type: 'layerdeps', 'value': layerId , project_id: projectId },
       function(data) {
         if (data.error != "ok") {
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index 230dee4..e10dc11 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -31,11 +31,19 @@
     projectId : {{project.id|default:'undefined'}},
     jsUrl : "{% static 'js/' %}",
     htmlUrl : "{% static 'html/' %}",
+    projectsUrl : "{% url 'all-projects' %}",
     {% if project.id %}
-    xhrDataTypeaheadUrl : "{% url 'xhr_datatypeahead' project.id %}",
-    xhrProjectEditUrl : "{% url 'xhr_projectedit' project.id %}",
-    projectPageUrl : "{% url 'project' project.id %}",
-    projectName : "{{project.name}}",
+      xhrProjectDataTypeaheadUrl : "{% url 'xhr_datatypeahead' project.id %}",
+      xhrProjectEditUrl : "{% url 'xhr_projectedit' project.id %}",
+      projectPageUrl : "{% url 'project' project.id %}",
+      projectName : "{{project.name}}",
+      projectId : {{project.id}},
+    {% else %}
+      xhrProjectDataTypeaheadUrl : undefined,
+      xhrProjectEditUrl : undefined,
+      projectPageUrl : undefined,
+      projectName : undefined,
+      projectId : undefined,
     {% endif %}
   };
 </script>
@@ -45,8 +53,6 @@
   $(document).ready(function () {
     /* Vars needed for base.js */
     var ctx = {};
-    ctx.projectBuildUrl = "{% url 'xhr_build' %}";
-    ctx.projectBasePageUrl = "{% url 'base_project' %}";
     ctx.projectInfoUrl = "{% url 'xhr_projectinfo' %}";
     ctx.numProjects = {{projects|length}};
     ctx.currentUrl = "{{request.path|escapejs}}";
@@ -99,7 +105,7 @@
                     <div class="input-append">
                       <input type="text" class="input-medium" id="project-name-input" placeholder="Type a project name" autocomplete="off" data-minLength="1" data-autocomplete="off" data-provide="typeahead"/>
                         <button id="save-project-button" class="btn" type="button">Save</button>
-                        <a href="#" id="cancel-change-project" class="btn btn-link">Cancel</a>
+                        <a href="#" id="cancel-change-project" class="btn btn-link" style="display: none">Cancel</a>
                       </div>
                       <p><a id="view-all-projects" href="{% url 'all-projects' %}">View all projects</a></p>
                     </form>
@@ -111,9 +117,9 @@
                   <li id="targets-form">
                     <h6>Recipe(s):</h6>
                     <form>
-                      <input type="text" class="input-xlarge" id="build-target-input" placeholder="Type a recipe name" autocomplete="off" data-minLength="1" data-autocomplete="off" data-provide="typeahead" />
+                      <input type="text" class="input-xlarge" id="build-target-input" placeholder="Type a recipe name" autocomplete="off" data-minLength="1" data-autocomplete="off" data-provide="typeahead" disabled/>
                       <div>
-                        <a class="btn btn-primary" id="build-button" data-project-id="{{project.id}}">Build</a>
+                        <button class="btn btn-primary" id="build-button" data-project-id="{{project.id}}" disabled>Build</button>
                       </div>
                     </form>
                   </li>
diff --git a/lib/toaster/toastergui/templates/basetable_bottom.html b/lib/toaster/toastergui/templates/basetable_bottom.html
index 4c28cae..ce023f5 100644
--- a/lib/toaster/toastergui/templates/basetable_bottom.html
+++ b/lib/toaster/toastergui/templates/basetable_bottom.html
@@ -57,7 +57,7 @@
         }
     }
 
-    // load cookie for number of entries to be displayed on page
+    // load data for number of entries to be displayed on page
     if ({{request.GET.count}} != "") {
       pagesize = {{request.GET.count}};
     }
diff --git a/lib/toaster/toastergui/templates/detail_pagination_bottom.html b/lib/toaster/toastergui/templates/detail_pagination_bottom.html
index 434facb..f40c21d 100644
--- a/lib/toaster/toastergui/templates/detail_pagination_bottom.html
+++ b/lib/toaster/toastergui/templates/detail_pagination_bottom.html
@@ -38,7 +38,7 @@
 <!-- Update page display settings -->
 <script>
  $(document).ready(function() {
-    // load cookie for number of entries to be displayed on page
+    // load data for number of entries to be displayed on page
     if ({{request.GET.count}} != "") {
       pagesize = {{request.GET.count}};
     }
diff --git a/lib/toaster/toastergui/templatetags/projecttags.py b/lib/toaster/toastergui/templatetags/projecttags.py
index 8028ae0..e79a4e5 100644
--- a/lib/toaster/toastergui/templatetags/projecttags.py
+++ b/lib/toaster/toastergui/templatetags/projecttags.py
@@ -51,11 +51,11 @@ def get_tasks(queryset):
 
 
 @register.filter(name = "json")
-def json(value):
+def json(value, default = None):
     # JSON spec says that "\/" is functionally identical to "/" to allow for HTML-tag embedding in JSON strings
     # unfortunately, I can't find any option in the json module to turn on forward-slash escaping, so we do
     # it manually here
-    return mark_safe(JsonLib.dumps(value, ensure_ascii=False).replace('</', '<\\/'))
+    return mark_safe(JsonLib.dumps(value, default = default, ensure_ascii=False).replace('</', '<\\/'))
 
 @register.assignment_tag
 def query(qs, **kwargs):
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index 7a1132f..4e328da 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -77,8 +77,6 @@ urlpatterns = patterns('toastergui.views',
 
         url(r'^projects/$', 'projects', name='all-projects'),
 
-        url(r'^project/$', lambda x: HttpResponseBadRequest(), name='base_project'),
-
         url(r'^project/(?P<pid>\d+)/$', 'project', name='project'),
         url(r'^project/(?P<pid>\d+)/configuration$', 'projectconf', name='projectconf'),
         url(r'^project/(?P<pid>\d+)/builds/$', 'projectbuilds', name='projectbuilds'),
@@ -110,7 +108,6 @@ urlpatterns = patterns('toastergui.views',
             name="all-layers"),
 
 
-        url(r'^xhr_build/$', 'xhr_build', name='xhr_build'),
         url(r'^xhr_projectbuild/(?P<pid>\d+)$', 'xhr_projectbuild', name='xhr_projectbuild'),
         url(r'^xhr_projectinfo/$', 'xhr_projectinfo', name='xhr_projectinfo'),
         url(r'^xhr_projectedit/(?P<pid>\d+)$', 'xhr_projectedit', name='xhr_projectedit'),
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 0e248a7..d4a9b4c 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -129,7 +129,19 @@ def _redirect_parameters(view, g, mandatory_parameters, *args, **kwargs):
         if not i in params:
             params[i] = urllib.unquote(str(mandatory_parameters[i]))
 
-    return redirect(url + "?%s" % urllib.urlencode(params), *args, **kwargs)
+    return redirect(url + "?%s" % urllib.urlencode(params), permanent = False, *args, **kwargs)
+
+class RedirectException(Exception):
+    def __init__(self, view, g, mandatory_parameters, *args, **kwargs):
+        super(RedirectException, self).__init__()
+        self.view = view
+        self.g = g
+        self.mandatory_parameters = mandatory_parameters
+        self.oargs  = args
+        self.okwargs = kwargs
+
+    def get_redirect_response(self):
+        return _redirect_parameters(self.view, self.g, self.mandatory_parameters, self.oargs, self.okwargs)
 
 FIELD_SEPARATOR = ":"
 AND_VALUE_SEPARATOR = "!"
@@ -2200,14 +2212,6 @@ if toastermain.settings.MANAGED:
         response['Pragma'] = "no-cache"
         return response
 
-    # This is a wrapper for xhr_projectbuild which allows for a project id
-    # which only becomes known client side.
-    def xhr_build(request):
-        if request.POST.has_key("project_id"):
-            pid = request.POST['project_id']
-            return xhr_projectbuild(request, pid)
-        else:
-            raise BadParameterException("invalid project id")
 
     def xhr_projectbuild(request, pid):
         try:
@@ -2333,7 +2337,7 @@ if toastermain.settings.MANAGED:
             # returns layers for current project release that are not in the project set, matching the name
             if request.GET['type'] == "layers":
                 # all layers for the current project
-                queryset_all = prj.compatible_layerversions().filter(layer__name__icontains=request.GET.get('value',''))
+                queryset_all = prj.compatible_layerversions().filter(layer__name__icontains=request.GET.get('search',''))
 
                 # but not layers with equivalent layers already in project
                 if not request.GET.has_key('include_added'):
@@ -2348,7 +2352,7 @@ if toastermain.settings.MANAGED:
             # returns layer dependencies for a layer, excluding current project layers
             if request.GET['type'] == "layerdeps":
                 queryset = prj.compatible_layerversions().exclude(pk__in = [x.id for x in prj.projectlayer_equivalent_set()]).filter(
-                    layer__name__in = [ x.depends_on.layer.name for x in LayerVersionDependency.objects.filter(layer_version_id = request.GET['value'])])
+                    layer__name__in = [ x.depends_on.layer.name for x in LayerVersionDependency.objects.filter(layer_version_id = request.GET['search'])])
 
                 final_list = set([x.get_equivalents_wpriority(prj)[0] for x in queryset])
 
@@ -2361,7 +2365,7 @@ if toastermain.settings.MANAGED:
 
                 retval = []
                 for i in prj.projectlayer_set.all():
-                    lv = prj.compatible_layerversions(release = Release.objects.get(pk=request.GET['value'])).filter(layer__name = i.layercommit.layer.name)
+                    lv = prj.compatible_layerversions(release = Release.objects.get(pk=request.GET['search'])).filter(layer__name = i.layercommit.layer.name)
                     # there is no layer_version with the new release id, and the same name
                     if lv.count() < 1:
                         retval.append(i)
@@ -2374,10 +2378,10 @@ if toastermain.settings.MANAGED:
             # returns layer versions that provide the named targets
             if request.GET['type'] == "layers4target":
                 # we return data only if the recipe can't be provided by the current project layer set
-                if reduce(lambda x, y: x + y, [x.recipe_layer_version.filter(name=request.GET['value']).count() for x in prj.projectlayer_equivalent_set()], 0):
+                if reduce(lambda x, y: x + y, [x.recipe_layer_version.filter(name=request.GET['search']).count() for x in prj.projectlayer_equivalent_set()], 0):
                     final_list = []
                 else:
-                    queryset_all = prj.compatible_layerversions().filter(recipe_layer_version__name = request.GET['value'])
+                    queryset_all = prj.compatible_layerversions().filter(recipe_layer_version__name = request.GET['search'])
 
                     # exclude layers in the project
                     queryset_all = queryset_all.exclude(pk__in = [x.id for x in prj.projectlayer_equivalent_set()])
@@ -2389,7 +2393,7 @@ if toastermain.settings.MANAGED:
 
             # returns targets provided by current project layers
             if request.GET['type'] == "targets":
-                search_token = request.GET.get('value','')
+                search_token = request.GET.get('search','')
                 queryset_all = Recipe.objects.filter(layer_version__layer__name__in = [x.layercommit.layer.name for x in prj.projectlayer_set.all().select_related("layercommit__layer")]).filter(Q(name__icontains=search_token) | Q(layer_version__layer__name__icontains=search_token))
 
 #                layer_equivalent_set = []
@@ -2420,7 +2424,7 @@ if toastermain.settings.MANAGED:
                 if 'project_id' in request.session:
                     queryset_all = queryset_all.filter(layer_version__in =  prj.projectlayer_equivalent_set()).order_by("name")
 
-                search_token = request.GET.get('value','')
+                search_token = request.GET.get('search','')
                 queryset_all = queryset_all.filter(Q(name__icontains=search_token) | Q(description__icontains=search_token))
 
                 return HttpResponse(jsonfilter({ "error":"ok",
@@ -2432,15 +2436,6 @@ if toastermain.settings.MANAGED:
                         )
                     }), content_type = "application/json")
 
-            # returns all projects
-            if request.GET['type'] == "projects":
-                queryset_all = Project.objects.all()
-                ret = { "error": "ok",
-                       "list": map (lambda x: {"id":x.pk, "name": x.name},
-                                    queryset_all.filter(name__icontains=request.GET.get('value',''))[:8])}
-
-                return HttpResponse(jsonfilter(ret), content_type = "application/json")
-
             raise Exception("Unknown request! " + request.GET.get('type', "No parameter supplied"))
         except Exception as e:
             return HttpResponse(jsonfilter({"error":str(e) + "\n" + traceback.format_exc()}), content_type = "application/json")
@@ -2866,14 +2861,38 @@ if toastermain.settings.MANAGED:
         return build_mru
 
 
-    def projects(request):
-        template="projects.html"
+    def template_renderer(template):
+        def func_wrapper(view):
+            def returned_wrapper(request, *args, **kwargs):
+                try:
+                    context = view(request, *args, **kwargs)
+                except RedirectException as e:
+                    return e.get_redirect_response()
+
+                if request.GET.get('format', None) == 'json':
+                    # objects is a special keyword - it's a Page, but we need the actual objects here
+                    # in XHR, the objects come in the "list" property
+                    if "objects" in context:
+                        context["list"] = context["objects"].object_list
+                        del context["objects"]
+
+                    # we're about to return; to keep up with the XHR API, we set the error to OK
+                    context["error"] = "ok"
+
+                    return HttpResponse(jsonfilter(context, default=lambda obj: obj.isoformat() if isinstance(obj, datetime) else obj.__dict__ ),
+                                content_type = "application/json; charset=utf-8")
+                else:
+                    return render(request, template, context)
+            return returned_wrapper
+        return func_wrapper
 
+    @template_renderer("projects.html")
+    def projects(request):
         (pagesize, orderby) = _get_parameters_values(request, 10, 'updated:-')
         mandatory_parameters = { 'count': pagesize,  'page' : 1, 'orderby' : orderby }
         retval = _verify_parameters( request.GET, mandatory_parameters )
         if retval:
-            return _redirect_parameters( 'all-projects', request.GET, mandatory_parameters)
+            raise RedirectException( 'all-projects', request.GET, mandatory_parameters )
 
         queryset_all = Project.objects.all()
 
@@ -2886,6 +2905,14 @@ if toastermain.settings.MANAGED:
         # retrieve the objects that will be displayed in the table; projects a paginator and gets a page range to display
         project_info = _build_page_range(Paginator(queryset, pagesize), request.GET.get('page', 1))
 
+        # add fields needed in JSON dumps for API call support
+        for p in project_info.object_list:
+            p.id = p.pk
+            p.xhrProjectDataTypeaheadUrl = reverse('xhr_datatypeahead', args=(p.id,))
+            p.projectPageUrl = reverse('project', args=(p.id,))
+            p.xhrProjectEditUrl = reverse('xhr_projectedit', args=(p.id,))
+            p.projectBuildUrl = reverse('xhr_projectbuild', args=(p.id,))
+
         # build view-specific information; this is rendered specifically in the builds page, at the top of the page (i.e. Recent builds)
         build_mru = _managed_get_latest_builds()
 
@@ -2965,9 +2992,8 @@ if toastermain.settings.MANAGED:
                     ]
             }
 
-        response = render(request, template, context)
         _set_parameters_values(pagesize, orderby, request)
-        return response
+        return context
 
     def buildrequestdetails(request, pid, brid):
         template = "buildrequestdetails.html"
@@ -3185,9 +3211,6 @@ else:
     def xhr_projectbuild(request, pid):
         return render(request, 'landing_not_managed.html')
 
-    def xhr_build(request):
-        return render(request, 'landing_not_managed.html')
-
     def xhr_projectinfo(request):
         return render(request, 'landing_not_managed.html')
 
-- 
1.9.1


