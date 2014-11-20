Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f175.google.com (mail-pd0-f175.google.com
	[209.85.192.175])
	by mail.openembedded.org (Postfix) with ESMTP id 2589D7219D
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Nov 2014 16:27:35 +0000 (UTC)
Received: by mail-pd0-f175.google.com with SMTP id y10so3351998pdj.34
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Nov 2014 08:27:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=pC0zJWFpwdYKQ8MvA4FUMs5xr7JYUKCdPZSyCL5d85c=;
	b=dFyBw3LRWY+8ZG8ORp5FrPZHc4DqB6ctFCw81aJ7k2Oy4RFRm9MobRvChIjOd2fY+q
	AjXHsvtEo3bFgcp1asLBheUX3y5lhwQmcKz8EA917uCh797xdJbxOc1cX6lhcWw1TIou
	fryicrNwvLNAn7gkCuFMvDRLjv9tQszN+c5X+MPawqFsNxuEoHzt9P4bLt8ZHytYgf4s
	XuqyZp+poD92sO317c3Wvap4OQNjIDpOTctqahYiYFWprP/S6qy4XFrn6ffE7whfqAxv
	BVP5Z1tZ20d/TQSCFtbz6/6bhaQaZygWi3WDUn4m14tScgf85tksW0yJLnMJ5swyHTIQ
	vByQ==
X-Gm-Message-State: ALoCoQlK97R7bL27h0Gxx8RA9D3H5INlWsXyIgALeaZPDtrLMhwfCtfJFXMTaddOwd53vWPsnpCd
X-Received: by 10.70.52.98 with SMTP id s2mr56611294pdo.5.1416500856222;
	Thu, 20 Nov 2014 08:27:36 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id l6sm2484704pdr.39.2014.11.20.08.27.34
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 20 Nov 2014 08:27:35 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 822035641D7; Thu, 20 Nov 2014 16:27:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 20 Nov 2014 16:27:22 +0000
Message-Id: <e92769b43b00764082a7cb2207e314b40510ef62.1416500715.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <d4a47bc84f762666a847f1152cc2e75c9ef36092.1416500715.git.alexandru.damian@intel.com>
References: <d4a47bc84f762666a847f1152cc2e75c9ef36092.1416500715.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1416500715.git.alexandru.damian@intel.com>
References: <cover.1416500715.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 06/11] toaster: Add New Build Button feature
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
X-List-Received-Date: Thu, 20 Nov 2014 16:27:37 -0000

From: Michael Wood <michael.g.wood@intel.com>

This adds a quick access dropdown menu feature for running builds on a
selected project.

[YOCTO #6677]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/static/css/default.css |   4 +
 lib/toaster/toastergui/static/js/base.js      | 125 ++++++++++++++++++++++++++
 lib/toaster/toastergui/templates/base.html    |  69 ++++++++++++--
 lib/toaster/toastergui/urls.py                |   3 +
 lib/toaster/toastergui/views.py               |  32 ++++++-
 5 files changed, 227 insertions(+), 6 deletions(-)
 create mode 100644 lib/toaster/toastergui/static/js/base.js

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index 8e60fd8..6194c97 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -131,6 +131,10 @@ select { width: auto; }
 /* make tables Chrome-happy (me, not so much) */
 #otable { table-layout: fixed; word-wrap: break-word; }
 
+/* styles for the new build button */
+.new-build .btn-primary { padding: 4px 30px; }
+#view-all-projects { display: block; }
+
 /* Configuration styles */
 .icon-trash { color: #B94A48; font-size: 16px; padding-left: 2px; }
 .icon-trash:hover { color: #943A38; text-decoration: none; cursor: pointer; }
diff --git a/lib/toaster/toastergui/static/js/base.js b/lib/toaster/toastergui/static/js/base.js
new file mode 100644
index 0000000..864130d
--- /dev/null
+++ b/lib/toaster/toastergui/static/js/base.js
@@ -0,0 +1,125 @@
+
+
+function basePageInit (ctx) {
+
+  var newBuildButton = $("#new-build-button");
+  /* Hide the button if we're on the project,newproject or importlyaer page */
+  if (ctx.currentUrl.search('newproject|project/\\d/$|importlayer/$') > 0){
+    newBuildButton.hide();
+    return;
+  }
+
+
+  newBuildButton.show().removeAttr("disabled");
+
+  _checkProjectBuildable()
+  _setupNewBuildButton();
+
+
+  function _checkProjectBuildable(){
+    libtoaster.getProjectInfo(ctx.projectInfoUrl, ctx.projectId,
+      function(data){
+        if (data.machine.name == undefined || data.layers.length == 0) {
+          /* we can't build anything with out a machine and some layers */
+          $("#new-build-button #targets-form").hide();
+          $("#new-build-button .alert").show();
+        } else {
+          $("#new-build-button #targets-form").show();
+          $("#new-build-button .alert").hide();
+        }
+    }, null);
+  }
+
+  function _setupNewBuildButton() {
+    /* Setup New build button */
+    var newBuildProjectInput = $("#new-build-button #project-name-input");
+    var newBuildTargetBuildBtn = $("#new-build-button #build-button");
+    var newBuildTargetInput = $("#new-build-button #build-target-input");
+    var newBuildProjectSaveBtn = $("#new-build-button #save-project-button");
+    var selectedTarget;
+    var selectedProject;
+
+    /* If we don't have a current project then present the set project
+     * form.
+     */
+    if (ctx.projectId == undefined) {
+      $('#change-project-form').show();
+      $('#project .icon-pencil').hide();
+    }
+
+    libtoaster.makeTypeahead(newBuildTargetInput, ctx.xhrDataTypeaheadUrl, { type : "targets", project_id: ctx.projectId }, function(item){
+        /* successfully selected a target */
+        selectedTarget = item;
+    });
+
+
+    libtoaster.makeTypeahead(newBuildProjectInput, ctx.xhrDataTypeaheadUrl, { type : "projects" }, function(item){
+        /* successfully selected a project */
+        newBuildProjectSaveBtn.removeAttr("disabled");
+        selectedProject = item;
+    });
+
+    /* Any typing in the input apart from enter key is going to invalidate
+     * the value that has been set by selecting a suggestion from the typeahead
+     */
+    newBuildProjectInput.keyup(function(event) {
+        if (event.keyCode == 13)
+          return;
+        newBuildProjectSaveBtn.attr("disabled", "disabled");
+    });
+
+    newBuildTargetInput.keyup(function() {
+      if ($(this).val().length == 0)
+        newBuildTargetBuildBtn.attr("disabled", "disabled");
+      else
+        newBuildTargetBuildBtn.removeAttr("disabled");
+    });
+
+    newBuildTargetBuildBtn.click(function() {
+      if (!newBuildTargetInput.val())
+        return;
+
+      /* fire and forget */
+      libtoaster.startABuild(ctx.projectBuildUrl, ctx.projectId, selectedTarget.name, null, null);
+      window.location.replace(ctx.projectPageUrl+ctx.projectId);
+    });
+
+    newBuildProjectSaveBtn.click(function() {
+      ctx.projectId = selectedProject.id
+      /* Update the typeahead project_id paramater */
+      _checkProjectBuildable();
+      newBuildTargetInput.data('typeahead').options.xhrParams.project_id = ctx.projectId;
+      newBuildTargetInput.val("");
+
+      $("#new-build-button #project a").text(selectedProject.name).attr('href', ctx.projectPageUrl+ctx.projectId);
+      $("#new-build-button .alert a").attr('href', ctx.projectPageUrl+ctx.projectId);
+
+
+      $("#change-project-form").slideUp({ 'complete' : function() {
+          $("#new-build-button #project").show();
+      }});
+    });
+
+    $('#new-build-button #project .icon-pencil').click(function() {
+      newBuildProjectSaveBtn.attr("disabled", "disabled");
+      newBuildProjectInput.val($("#new-build-button #project a").text());
+      $(this).parent().hide();
+      $("#change-project-form").slideDown();
+    });
+
+    $("#new-build-button #cancel-change-project").click(function() {
+      $("#change-project-form").hide(function(){
+        $('#new-build-button #project').show();
+      });
+
+      newBuildProjectInput.val("");
+      newBuildProjectSaveBtn.attr("disabled", "disabled");
+    });
+
+    /* Keep the dropdown open even unless we click outside the dropdown area */
+    $(".new-build").click (function(event) {
+      event.stopPropagation();
+    });
+  };
+
+}
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index 1b9edfd..87746bf 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -8,6 +8,7 @@
 <link rel="stylesheet" href="{% static 'css/font-awesome.min.css' %}" type='text/css'>
 <link rel="stylesheet" href="{% static 'css/prettify.css' %}" type='text/css'>
 <link rel="stylesheet" href="{% static 'css/default.css' %}" type='text/css'>
+<link rel="stylesheet" href="assets/css/jquery-ui-1.10.3.custom.min.css" type='text/css'>
 <meta name="viewport" content="width=device-width, initial-scale=1.0" />
 <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
 <script src="{% static 'js/jquery-2.0.3.min.js' %}">
@@ -20,7 +21,25 @@
 </script>
 <script src="{% static 'js/libtoaster.js' %}">
 </script>
+<script src="{% static 'js/base.js' %}"></script>
+{%if MANAGED %}
+<script>
+  $(document).ready(function () {
+    /* Vars needed for base.js */
+    var ctx = {};
+    ctx.xhrDataTypeaheadUrl = "{% url 'xhr_datatypeahead' %}";
+    ctx.projectBuildUrl = "{% url 'xhr_build' %}";
+    ctx.projectPageUrl = "{% url 'project' %}";
+    ctx.projectInfoUrl = "{% url 'xhr_projectinfo' %}";
+    {% if project %}
+      ctx.projectId = {{project.id}};
+    {% endif %}
+    ctx.currentUrl = "{{request.path|escapejs}}";
+
+    basePageInit(ctx);
+  });
 </script>
+{% endif %}
 <script>
 
 </script>
@@ -34,15 +53,55 @@
     <div class="navbar-inner">
             <a class="brand logo" href="#"><img src="{% static 'img/logo.png' %}" class="" alt="Yocto logo project"/></a>
             <a class="brand" href="/">Toaster</a>
-				{%if MANAGED %}
-					  <div class="btn-group pull-right">
-						  <a class="btn" href="{% url 'newproject' %}">New project</a>
-					  </div>
-				{%endif%}
             <a class="pull-right manual" target="_blank" href="http://www.yoctoproject.org/documentation/toaster-manual">
                 <i class="icon-book"></i>
                 Toaster manual
             </a>
+            {%if MANAGED %}
+            <div class="btn-group pull-right">
+              <a class="btn" href="{% url 'newproject' %}">New project</a>
+            </div>
+            <!-- New build popover -->
+            <div class="btn-group pull-right" id="new-build-button">
+              <button class="btn dropdown-toggle" data-toggle="dropdown" href="#">
+                New build
+                <i class="icon-caret-down"></i>
+              </button>
+              <ul class="dropdown-menu new-build multi-select">
+                <li>
+                  <h3>New build</h3>
+                  <h6>Project:</h6>
+                  <span id="project">
+                    <a class="lead" href="{% if project.id %}{% url 'project' project.id %}{% endif %}">{{project.name}}</a>
+                    <i class="icon-pencil"></i>
+                  </span>
+                  <form id="change-project-form" style="display:none;">
+                    <div class="input-append">
+                      <input type="text" class="input-medium" id="project-name-input" placeholder="Type a project name" autocomplete="off" data-minLength="1" data-autocomplete="off" data-provide="typeahead">
+                        <button id="save-project-button" class="btn" type="button">Save</button>
+                        <a href="#" id="cancel-change-project" class="btn btn-link">Cancel</a>
+                      </div>
+                      <a id="view-all-projects" href="{% url 'all-projects' %}">View all projects</a>
+                    </form>
+                  </li>
+                  <div class="alert" style="display:none">
+                    This project's configuration is incomplete,<br/>so you cannot run builds.<br/>
+                    <a href="{% if project.id %}{% url 'project' project.id %}{% endif %}">View project configuration</a>
+                  </div>
+                  <li id="targets-form">
+                    <h6>Target(s):</h6>
+                    <form>
+                      <input type="text" class="input-xlarge" id="build-target-input" placeholder="Type a target name" autocomplete="off" data-minLength="1" data-autocomplete="off" data-provide="typeahead" >
+                      <div>
+                        <a class="btn btn-primary" id="build-button" disabled="disabled" data-project-id="{{project.id}}">Build</a>
+                      </div>
+                    </form>
+                  </li>
+              </ul>
+            </div>
+
+            {%endif%}
+
     </div>
 </div>
 
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index bae7103..b60f761 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -80,10 +80,13 @@ urlpatterns = patterns('toastergui.views',
         url(r'^machines/$', 'machines', name='machines'),
 
         url(r'^projects/$', 'projects', name='all-projects'),
+
+        url(r'^project/$', 'project', name='project'),
         url(r'^project/(?P<pid>\d+)/$', 'project', name='project'),
         url(r'^project/(?P<pid>\d+)/configuration$', 'projectconf', name='projectconf'),
         url(r'^project/(?P<pid>\d+)/builds$', 'projectbuilds', name='projectbuilds'),
 
+        url(r'^xhr_build/$', 'xhr_build', name='xhr_build'),
         url(r'^xhr_projectbuild/(?P<pid>\d+)/$', 'xhr_projectbuild', name='xhr_projectbuild'),
         url(r'^xhr_projectinfo/$', 'xhr_projectinfo', name='xhr_projectinfo'),
         url(r'^xhr_projectedit/(?P<pid>\d+)/$', 'xhr_projectedit', name='xhr_projectedit'),
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 9f214bb..a0dcf87 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2015,10 +2015,20 @@ if toastermain.settings.MANAGED:
         response['Pragma'] = "no-cache"
         return response
 
+    # This is a wrapper for xhr_projectbuild which allows for a project id
+    # which only becomes known client side.
+    def xhr_build(request):
+        if request.POST.has_key("project_id"):
+            pid = request.POST['project_id']
+            return xhr_projectbuild(request, pid)
+        else:
+            raise BadParameterException("invalid project id")
+
     def xhr_projectbuild(request, pid):
         try:
             if request.method != "POST":
                 raise BadParameterException("invalid method")
+			request.session['project_id'] = pid
             prj = Project.objects.get(id = pid)
 
 
@@ -2057,6 +2067,8 @@ if toastermain.settings.MANAGED:
         except Exception as e:
             return HttpResponse(jsonfilter({"error":str(e) + "\n" + traceback.format_exc()}), content_type = "application/json")
 
+    # This is a wraper for xhr_projectedit which allows for a project id
+    # which only becomes known client side
     def xhr_projectinfo(request):
         if request.POST.has_key("project_id") == False:
             raise BadParameterException("invalid project id")
@@ -2121,8 +2133,12 @@ if toastermain.settings.MANAGED:
     def xhr_datatypeahead(request):
         try:
             prj = None
-            if 'project_id' in request.session:
+            if request.GET.has_key('project_id'):
+				prj = Project.objects.get(pk = request.GET['project_id'])
+            elif 'project_id' in request.session:
                 prj = Project.objects.get(pk = request.session['project_id'])
+			else:
+				raise Exception("No valid project selected")
 
             # returns layers for current project release that are not in the project set
             if request.GET['type'] == "layers":
@@ -2188,6 +2204,14 @@ if toastermain.settings.MANAGED:
 
                     }), content_type = "application/json")
 
+            if request.GET['type'] == "projects":
+                queryset_all = Project.objects.all()
+                ret = { "error": "ok",
+                       "list": map (lambda x: {"id":x.pk, "name": x.name},
+                                    queryset_all.filter(name__icontains=request.GET.get('value',''))[:8])}
+
+                return HttpResponse(jsonfilter(ret), content_type = "application/json")
+
             raise Exception("Unknown request! " + request.GET.get('type', "No parameter supplied"))
         except Exception as e:
             return HttpResponse(jsonfilter({"error":str(e) + "\n" + traceback.format_exc()}), content_type = "application/json")
@@ -2773,6 +2797,12 @@ else:
     def xhr_projectbuild(request, pid):
         raise Exception("page not available in interactive mode")
 
+    def xhr_build(request, pid):
+        raise Exception("page not available in interactive mode")
+
+    def xhr_projectinfo(request, pid):
+        raise Exception("page not available in interactive mode")
+
     def xhr_projectedit(request, pid):
         raise Exception("page not available in interactive mode")
 
-- 
1.9.1


