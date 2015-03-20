Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
	[209.85.220.46])
	by mail.openembedded.org (Postfix) with ESMTP id CEB84739BB
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2015 10:25:42 +0000 (UTC)
Received: by pabxg6 with SMTP id xg6so92234393pab.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2015 03:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=YULrEJydtRXKVJuKAPHUhL6/L9pRdHnxNyo4v11TTAY=;
	b=FQsss4jdkZKuN+y0IbQarLj63DTiDEcuOozX3aOeyFEfqrMpLVdYP42DTILGccBxGv
	yWmo4R1Dy2pQpHDWGpreBeSYNmgVwckb96M8QnuXOWFhoKhZGEwWMPL0rUBP3q2ROpUA
	D04/YOjBHko/qw0/Kxq+4MXPxYFZ38sFt0oWHf7PQyyqVYSuXMYk6SEq1ac9UjFCTf3P
	czjcn47+PMgnv0wIsgG8l5/F4ya+3BaHw6BofKOZMWT/aISShDm8P8MaqNuXsNiHIGLx
	6h+W/j4A+3OVbkpe4INu6lcBTYeoFR+0KQC5nvbTFJ1j1L8MpIW1iEIIXnXmMpVECqos
	V7GA==
X-Gm-Message-State: ALoCoQlUG24Z3lti/rMy6Zao7D7GL6ZrtLnR5qbadIXd5W8yWzDi2sm7bcmKA2XkVRBhTkXuYmHZ
X-Received: by 10.70.65.105 with SMTP id w9mr9556222pds.129.1426847143859;
	Fri, 20 Mar 2015 03:25:43 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id g3sm7405213pdg.39.2015.03.20.03.25.41
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 20 Mar 2015 03:25:42 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id B9C9E564557; Fri, 20 Mar 2015 10:25:32 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 20 Mar 2015 10:25:28 +0000
Message-Id: <e335f36beb5e4b30535492b5cfb273f81bd1a3c3.1426598797.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <dae2559f8e6d87d54939bc73f4044916df29d93c.1426598797.git.alexandru.damian@intel.com>
References: <dae2559f8e6d87d54939bc73f4044916df29d93c.1426598797.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1426598797.git.alexandru.damian@intel.com>
References: <cover.1426598797.git.alexandru.damian@intel.com>
Subject: [PATCH 11/14] toaster: Add cancel build to latest build section
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
X-List-Received-Date: Fri, 20 Mar 2015 10:25:43 -0000

From: Michael Wood <michael.g.wood@intel.com>

Add this functionality to the common managed_mrb_section
Make sure we are using the correct version of this template in the
projects template and remove now redundant code.

[YOCTO #7351]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/libtoaster.js     | 28 +++++++++++++++
 .../toastergui/templates/managed_mrb_section.html  | 42 +++++++++-------------
 lib/toaster/toastergui/templates/mrb_section.html  | 39 --------------------
 lib/toaster/toastergui/templates/projects.html     |  2 +-
 lib/toaster/toastergui/views.py                    | 11 ++++--
 5 files changed, 53 insertions(+), 69 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index 3832066..fcf82ac 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -93,6 +93,33 @@ var libtoaster = (function (){
     } });
   }
 
+  /* cancelABuild:
+   * url: xhr_projectbuild
+   * builds_ids: space separated list of build request ids
+   * onsuccess: callback for successful execution
+   * onfail: callback for failed execution
+   */
+  function _cancelABuild(url, build_ids, onsuccess, onfail){
+    $.ajax( {
+        type: "POST",
+        url: url,
+        data: { 'buildCancel': build_ids },
+        headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
+        success: function (_data) {
+          if (_data.error !== "ok") {
+            console.warn(_data.error);
+          } else {
+            if (onsuccess !== undefined) onsuccess(_data);
+          }
+        },
+        error: function (_data) {
+          console.warn("Call failed");
+          console.warn(_data);
+          if (onfail) onfail(data);
+        }
+    });
+  }
+
   /* Get a project's configuration info */
   function _getProjectInfo(url, projectId, onsuccess, onfail){
     $.ajax({
@@ -197,6 +224,7 @@ var libtoaster = (function (){
   return {
     reload_params : reload_params,
     startABuild : _startABuild,
+    cancelABuild : _cancelABuild,
     makeTypeahead : _makeTypeahead,
     getProjectInfo: _getProjectInfo,
     getLayerDepsForProject : _getLayerDepsForProject,
diff --git a/lib/toaster/toastergui/templates/managed_mrb_section.html b/lib/toaster/toastergui/templates/managed_mrb_section.html
index 51610e4..a6d4ac6 100644
--- a/lib/toaster/toastergui/templates/managed_mrb_section.html
+++ b/lib/toaster/toastergui/templates/managed_mrb_section.html
@@ -3,6 +3,7 @@
 {% load humanize %}
 
 {%if mru|length > 0%}
+{# Template provides the latest builds section requires mru in the context which can be added from _managed_get_latest_builds #}
   <div class="page-header top-air">
       <h1>
           Latest builds
@@ -118,6 +119,7 @@
             <div class="span4 lead">Build queued
               <i title="This build will start as soon as a build server is available" class="icon-question-sign get-help get-help-blue heading-help" data-toggle="tooltip"></i>
             </div>
+            <button class="btn btn-info pull-right cancel-build-btn" data-build-id="{{buildrequest.id}}" data-request-url="{% url 'xhr_projectbuild' buildrequest.project.id %}" >Cancel</button>
 
          {% elif buildrequest.state == buildrequest.REQ_CREATED %}
 
@@ -155,37 +157,25 @@
 
 <script>
 
-/* ensure csrf cookie exists {% csrf_token %} */
-function _makeXHRBuildCall(url, data, onsuccess, onfail) {
-    $.ajax( {
-        type: "POST",
-        url: url,
-        data: data,
-        headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
-        success: function (_data) {
-            if (_data.error != "ok") {
-                alert(_data.error);
-            } else {
-                if (onsuccess != undefined) onsuccess(_data);
-            }
-        },
-        error: function (_data) {
-            alert("Call failed");
-            console.log(_data);
-            if (onfail) onfail(data);
-        } });
+function scheduleBuild(url, projectName, projectUrl, buildlist) {
+  console.log("scheduleBuild");
+  libtoaster.startABuild(url, null, buildlist.join(" "), function(){
+    window.location.reload();
+  }, null);
 }
 
+$(document).ready(function(){
 
-function scheduleBuild(url, projectName, projectUrl, buildlist) {
-  console.log("scheduleBuild");
-  _makeXHRBuildCall(url, {targets: buildlist.join(" ")}, function (_data) {
+  $(".cancel-build-btn").click(function (){
+    var url = $(this).data('request-url');
+    var buildIds = $(this).data('build-id');
+    var btn = $(this);
 
-      $('#latest-builds').prepend("<div class=\"alert alert-info project-name\"><span class=\"label label-info\"><a href=\""+projectUrl+"\">"+projectName+"</a></span><div class=\"row-fluid\">" +
-  "<div class=\"span5 lead\">" + buildlist.join(" ") +
-  "</div><div class=\"span4 lead\">Build queued <i title=\"This build will start as soon as a build server is available\" class=\"icon-question-sign get-help get-help-blue heading-help\"></i></div></div></div>");
+    libtoaster.cancelABuild(url, buildIds, function(){
+      btn.parents(".alert").fadeOut();
+    }, null);
   });
-}
+});
 
 </script>
 
diff --git a/lib/toaster/toastergui/templates/mrb_section.html b/lib/toaster/toastergui/templates/mrb_section.html
index 432955a..c7bddf0 100644
--- a/lib/toaster/toastergui/templates/mrb_section.html
+++ b/lib/toaster/toastergui/templates/mrb_section.html
@@ -50,9 +50,6 @@
               <span class="lead{%if not MANAGED or not build.project%} pull-right{%endif%}">
                 Build time: <a href="{% url 'buildtime' build.pk %}">{{ build.timespent|sectohms }}</a>
               </span>
-          {% if MANAGED and build.project %}
-              <a class="btn {%if build.outcome == build.SUCCEEDED%}btn-success{%elif build.outcome == build.FAILED%}btn-danger{%else%}btn-info{%endif%} pull-right" onclick="scheduleBuild({% url 'xhr_projectbuild' build.project.id as bpi%}{{bpi|json}}, {{build.project.name|json}}, {{build.get_sorted_target_list|mapselect:'target'|json}})">Run again</a>
-          {% endif %}
             </div>
     {%endif%}
     {%if build.outcome == build.IN_PROGRESS %}
@@ -68,41 +65,5 @@
 
   {% endfor %}
   </div>
-
-<script>
-
-function _makeXHRBuildCall(url, data, onsuccess, onfail) {
-    $.ajax( {
-        type: "POST",
-        url: url,
-        data: data,
-        headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
-        success: function (_data) {
-            if (_data.error != "ok") {
-                console.warn(_data.error);
-            } else {
-                if (onsuccess != undefined) onsuccess(_data);
-            }
-        },
-        error: function (_data) {
-            console.warn("Call failed");
-            console.warn(_data);
-            if (onfail) onfail(data);
-        } });
-}
-
-
-function scheduleBuild(url, projectName, buildlist) {
-  console.warn("scheduleBuild");
-  _makeXHRBuildCall(url, {targets: buildlist.join(" ")}, function (_data) {
-
-      $('#latest-builds').prepend('<div class="alert alert-info" style="padding-top:0px">' + '<span class="label label-info" style="font-weight: normal; margin-bottom: 5px; margin-left:-15px; padding-top:5px;">'+projectName+'</span><div class="row-fluid">' +
-  '<div class="span4 lead">' + buildlist.join(" ") +
-  '</div><div class="span4 lead pull-right">Build queued. Your build will start shortly.</div></div></div>');
-  });
-}
-
-</script>
-
 {%endif%}
 
diff --git a/lib/toaster/toastergui/templates/projects.html b/lib/toaster/toastergui/templates/projects.html
index 88d5bd3..88ee4bc 100644
--- a/lib/toaster/toastergui/templates/projects.html
+++ b/lib/toaster/toastergui/templates/projects.html
@@ -7,7 +7,7 @@
 {% block pagecontent %}
 
 
-  {% include "mrb_section.html" %}
+  {% include "managed_mrb_section.html" %}
 
 
   <div class="page-header top-air">
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 661023e..26c8760 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1871,8 +1871,7 @@ if toastermain.settings.MANAGED:
 
         # build view-specific information; this is rendered specifically in the builds page, at the top of the page (i.e. Recent builds)
         # most recent build is like projects' most recent builds, but across all projects
-        build_mru = BuildRequest.objects.all()
-        build_mru = list(build_mru.filter(Q(state__lt=BuildRequest.REQ_COMPLETED) or Q(state=BuildRequest.REQ_DELETED)).order_by("-pk")) + list(build_mru.filter(state__in=[BuildRequest.REQ_COMPLETED, BuildRequest.REQ_FAILED]).order_by("-pk")[:3])
+        build_mru = _managed_get_latest_builds()
 
         fstypes_map = {};
         for build_request in build_info:
@@ -3130,6 +3129,12 @@ if toastermain.settings.MANAGED:
             }
             return render(request, "unavailable_artifact.html", context)
 
+    # This returns the mru object that is needed for the
+    # managed_mrb_section.html template
+    def _managed_get_latest_builds():
+        build_mru = BuildRequest.objects.all()
+        build_mru = list(build_mru.filter(Q(state__lt=BuildRequest.REQ_COMPLETED) or Q(state=BuildRequest.REQ_DELETED)).order_by("-pk")) + list(build_mru.filter(state__in=[BuildRequest.REQ_COMPLETED, BuildRequest.REQ_FAILED]).order_by("-pk")[:3])
+        return build_mru
 
 
     def projects(request):
@@ -3153,7 +3158,7 @@ if toastermain.settings.MANAGED:
         project_info = _build_page_range(Paginator(queryset, pagesize), request.GET.get('page', 1))
 
         # build view-specific information; this is rendered specifically in the builds page, at the top of the page (i.e. Recent builds)
-        build_mru = Build.objects.order_by("-started_on")[:3]
+        build_mru = _managed_get_latest_builds()
 
         # translate the project's build target strings
         fstypes_map = {};
-- 
1.9.1


