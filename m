Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
	[209.85.212.170])
	by mail.openembedded.org (Postfix) with ESMTP id 443347596C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 10:34:21 +0000 (UTC)
Received: by wiwl6 with SMTP id l6so13733233wiw.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 03:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=oQHqWEZRjg7bOsaH11iDTZzx3tSK7R7Geloe52EIC20=;
	b=dXX3p9rTdoiiW1O0KNew/98hTAGV6YIv4zkvmGy9J3gwmhSNMmfY5N/o4xIDLlZoFt
	gOhZ1R126Bcj6Req/pwxvC3gxqwhZAoEuKKjOl0RzXrnUuKVBzRm41H1YF9CMYhsVoKR
	bDrilcotvuM2XXRtf3UgWHBe0IDFwutE/WUWxcNhBKIb1STwgEsng1lYQ1IVIgb7xobx
	c7ww2eJXAmIujPWWt8c5KowlqLxrQfB+vEeSz9QUTwXVWQAjhS+RGcSyO6eTT9bjaKLj
	eDmu+hsdWCKdbgVq6IO+OkBfIptAhQsPz3SlOgkBa3OpiTIFGIeCREQL4zUhfGETITYf
	xg/A==
X-Gm-Message-State: ALoCoQkqqgwfBSyJiIB1bnYdx0RRaTwI1I24/hnz1Eswkeq7q+bHlUAYLNBgutHuoOtliIWGXGSW
X-Received: by 10.195.11.202 with SMTP id ek10mr76967518wjd.12.1435228461708; 
	Thu, 25 Jun 2015 03:34:21 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	w11sm45180598wjr.48.2015.06.25.03.34.18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Jun 2015 03:34:19 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id C5D05562472; Thu, 25 Jun 2015 11:34:01 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Jun 2015 11:33:44 +0100
Message-Id: <6e46e1e3882b9770872d8a0bb459bc7d5d6bfed3.1435228176.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
References: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1435228175.git.alexandru.damian@intel.com>
References: <cover.1435228175.git.alexandru.damian@intel.com>
Subject: [PATCH 07/23] toaster: refactor the builds pages
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
X-List-Received-Date: Thu, 25 Jun 2015 10:34:23 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Taking out the managed mode-specific bits in build-related
pages, as there is always only one mode available.

Also refactors the build pages in order to always display
Build objects instead of BuildRequest objects.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/static/js/projectapp.js     |  14 +-
 .../templates/{build.html => builds.html}          |   7 +-
 .../toastergui/templates/managed_builds.html       | 167 --------
 .../toastergui/templates/managed_mrb_section.html  | 193 ---------
 lib/toaster/toastergui/templates/mrb_section.html  |  41 +-
 lib/toaster/toastergui/templates/project.html      |  40 +-
 .../toastergui/templates/projectbuilds.html        |   1 -
 lib/toaster/toastergui/templates/projects.html     |  22 +-
 lib/toaster/toastergui/urls.py                     |   2 +-
 lib/toaster/toastergui/views.py                    | 437 +++++----------------
 10 files changed, 175 insertions(+), 749 deletions(-)
 rename lib/toaster/toastergui/templates/{build.html => builds.html} (97%)
 delete mode 100644 lib/toaster/toastergui/templates/managed_builds.html
 delete mode 100644 lib/toaster/toastergui/templates/managed_mrb_section.html

diff --git a/lib/toaster/toastergui/static/js/projectapp.js b/lib/toaster/toastergui/static/js/projectapp.js
index b2e65c5..40e2e1f 100644
--- a/lib/toaster/toastergui/static/js/projectapp.js
+++ b/lib/toaster/toastergui/static/js/projectapp.js
@@ -429,13 +429,17 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
      */
 
     $scope.validateData = function () {
-        if ($scope.layers.length === 0) {
+        if ($scope.project.release) {
+            if ($scope.layers.length === 0) {
             $scope.layeralert = $scope.displayAlert($scope.zone1alerts, "You need to add some layers to this project. <a href=\""+$scope.urls.layers+"\">View all layers available in Toaster</a> or <a href=\""+$scope.urls.importlayer+"\">import a layer</a>");
-        } else {
-            if ($scope.layeralert !== undefined) {
-                $scope.layeralert.close();
-                $scope.layeralert = undefined;
+            } else {
+                if ($scope.layeralert !== undefined) {
+                    $scope.layeralert.close();
+                    $scope.layeralert = undefined;
+                }
             }
+        } else {
+            $scope.layeralert = $scope.displayAlert($scope.zone1alerts, "This project is not set to run builds.");
         }
     };
 
diff --git a/lib/toaster/toastergui/templates/build.html b/lib/toaster/toastergui/templates/builds.html
similarity index 97%
rename from lib/toaster/toastergui/templates/build.html
rename to lib/toaster/toastergui/templates/builds.html
index f0b5ea5..e9211af 100644
--- a/lib/toaster/toastergui/templates/build.html
+++ b/lib/toaster/toastergui/templates/builds.html
@@ -14,13 +14,15 @@
 
 {% block pagecontent %}
 
+{% if last_date_from and last_date_to %}
 <script>
-    // intiialize the date range controls
+    // initialize the date range controls
     $(document).ready(function () {
         date_init('started_on','{{last_date_from}}','{{last_date_to}}','{{dateMin_started_on}}','{{dateMax_started_on}}','{{daterange_selected}}');
         date_init('completed_on','{{last_date_from}}','{{last_date_to}}','{{dateMin_completed_on}}','{{dateMax_completed_on}}','{{daterange_selected}}');
     });
 </script>
+{%endif%} {# last_date_from and last_date_to #}
 
 <div class="row-fluid">
 
@@ -87,9 +89,8 @@
               <a href="{%url "builddashboard" build.id%}#images">{{fstypes|get_dict_value:build.id}}</a>
               {% endif %}
             </td>
-            {% if build.project %}
+	    <td>
                 <a href="{% url 'project' build.project.id %}">{{build.project.name}}</a>
-            {% endif %}
             </td>
         </tr>
 
diff --git a/lib/toaster/toastergui/templates/managed_builds.html b/lib/toaster/toastergui/templates/managed_builds.html
deleted file mode 100644
index 63ae540..0000000
--- a/lib/toaster/toastergui/templates/managed_builds.html
+++ /dev/null
@@ -1,167 +0,0 @@
-{% extends "base.html" %}
-
-{% load static %}
-{% load projecttags %}
-{% load humanize %}
-
-{% block extraheadcontent %}
-<link rel="stylesheet" href="/static/css/jquery-ui.min.css" type='text/css'>
-<link rel="stylesheet" href="/static/css/jquery-ui.structure.min.css" type='text/css'>
-<link rel="stylesheet" href="/static/css/jquery-ui.theme.min.css" type='text/css'>
-<script src="/static/js/jquery-ui.min.js"></script>
-<script src="/static/js/filtersnippet.js"></script>
-{% endblock %}
-
-{% block pagecontent %}
-
-<script>
-    // initialize the date range controls
-    $(document).ready(function () {
-        date_init('created','{{last_date_from}}','{{last_date_to}}','{{dateMin_created}}','{{dateMax_created}}','{{daterange_selected}}');
-        date_init('updated','{{last_date_from}}','{{last_date_to}}','{{dateMin_updated}}','{{dateMax_updated}}','{{daterange_selected}}');
-    });
-</script>
-
-<div class="row-fluid">
-
-  {% include "managed_mrb_section.html" %}
-
-
-  {% if 1 %}
-  <div class="page-header top-air">
-     <h1>
-      {% if request.GET.filter and objects.paginator.count > 0 or request.GET.search and objects.paginator.count > 0 %}
-          {{objects.paginator.count}} build{{objects.paginator.count|pluralize}} found
-      {%elif request.GET.filter and objects.paginator.count == 0 or request.GET.search and objects.paginator.count == 0 %}
-          No builds found
-      {%else%}
-          All builds
-      {%endif%}
-     </h1>
-  </div>
-
-  {% if objects.paginator.count == 0 %}
-    <div class="row-fluid">
-      {% if request.GET.filter or request.GET.search %}
-      <div class="alert">
-        <form class="no-results input-append" id="searchform">
-            <input id="search" name="search" class="input-xxlarge" type="text" value="{{request.GET.search}}"/>{% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>{% endif %}
-            <button class="btn" type="submit" value="Search">Search</button>
-            <button class="btn btn-link" onclick="javascript:$('#search').val('');searchform.submit()">Show all builds</button>
-        </form>
-      </div>
-      {% else %}
-      <div class="alert alert-info">
-      <p class="lead">Toaster has not recorded any builds yet. To run a build, <a href="{% url 'all-projects' %}">select the project</a> for which you want to build.
-      </div>
-      {% endif %}
-    </div>
-
-
-  {% else %} {# We have builds to display #}
-  {% include "basetable_top_buildprojects.html" %}
-        <!-- Table data rows; the order needs to match the order of "tablecols" definitions; and the <td class value needs to match the tablecols clclass value for show/hide buttons to work -->
-        {% for buildrequest in objects %}{% if buildrequest.build %}  {% with build=buildrequest.build %} {# if we have a build, just display it #}
-        <tr class="data">
-            <td class="outcome"><a href="{% url "builddashboard" build.id %}">{%if build.outcome == build.SUCCEEDED%}<i class="icon-ok-sign success"></i>{%elif build.outcome == build.FAILED%}<i class="icon-minus-sign error"></i>{%else%}{%endif%}</a>
-                {% if build.project %}
-                        &nbsp; <a href="{% url 'build_artifact' build.id "cookerlog" build.id %}">
-                            <i class="icon-download-alt" title="" data-original-title="Download build log"></i>
-                        </a>
-                    {% endif %}
-
-            </td>
-            <td class="target">{% for t in build.target_set.all %} <a href="{% url "builddashboard" build.id %}"> {{t.target}} </a> <br />{% endfor %}</td>
-            <td class="machine"><a href="{% url "builddashboard" build.id %}">{{build.machine}}</a></td>
-   {% if MANAGED %}
-            <td class="project">
-            {% if build.project %}
-                <a href="{% url 'project' build.project.id %}">{{build.project.name}}</a>
-            {% endif %}
-            </td>
-   {% endif %}
-            <td class="started_on"><a href="{% url "builddashboard" build.id %}">{{build.started_on|date:"d/m/y H:i"}}</a></td>
-            <td class="completed_on"><a href="{% url "builddashboard" build.id %}">{{build.completed_on|date:"d/m/y H:i"}}</a></td>
-            <td class="failed_tasks error">
-                {% query build.task_build outcome=4 order__gt=0 as exectask%}
-                    {% if exectask.count == 1 %}
-                        <a href="{% url "task" build.id exectask.0.id %}">{{exectask.0.recipe.name}}.{{exectask.0.task_name}}</a>
-                      {% if MANAGED and build.project %}
-                        <a href="{% url 'build_artifact' build.id "tasklogfile" exectask.0.id %}">
-                            <i class="icon-download-alt" title="" data-original-title="Download task log file"></i>
-                        </a>
-                      {% endif %}
-                    {% elif exectask.count > 1%}
-                        <a href="{% url "tasks" build.id %}?filter=outcome%3A4">{{exectask.count}} task{{exectask.count|pluralize}}</a>
-                    {%endif%}
-            </td>
-            <td class="errors_no">
-                {% if  build.errors_no %}
-                    <a class="errors_no error" href="{% url "builddashboard" build.id %}#errors">{{build.errors_no}} error{{build.errors_no|pluralize}}</a>
-                    {% if MANAGED and build.project and build.buildartifact_set.count %}
-                        <a href="{% url 'build_artifact' build.id "cookerlog" build.id %}">
-                            <i class="icon-download-alt" title="" data-original-title="Download build log"></i>
-                        </a>
-                    {% endif %}
-                {%endif%}
-            </td>
-            <td class="warnings_no">{% if  build.warnings_no %}<a class="warnings_no warning" href="{% url "builddashboard" build.id %}#warnings">{{build.warnings_no}} warning{{build.warnings_no|pluralize}}</a>{%endif%}</td>
-            <td class="time"><a href="{% url "buildtime" build.id %}">{{build.timespent|sectohms}}</a></td>
-            {% if not MANAGED or not build.project %}
-                <td class="log">{{build.cooker_log_path}}</td>
-            {% endif %}
-            <td class="output">
-              {% if build.outcome == build.SUCCEEDED %}
-              <a href="{%url "builddashboard" build.id%}#images">{{fstypes|get_dict_value:build.id}}</a>
-              {% endif %}
-            </td>
-        </tr>
-
-
-              {%endwith%}
-      {% else %} {# we don't have a build for this build request, mask the data with build request data #}
-
-
-
-        <tr class="data">
-            <td class="outcome">{% if buildrequest.state == buildrequest.REQ_FAILED %}<i class="icon-minus-sign error"></i>{%else%}FIXME_build_request_state{%endif%}</td>
-            <td class="target">
-                <a href="{% url "buildrequestdetails" buildrequest.project.id buildrequest.id %}"><span data-toggle="tooltip" {%if buildrequest.brtarget_set.all.count > 1%}title="Targets: {%for target in buildrequest.brtarget_set.all%}{{target.target}} {%endfor%}"{%endif%}>{{buildrequest.brtarget_set.all.0.target}} {%if buildrequest.brtarget_set.all.count > 1%}(+ {{buildrequest.brtarget_set.all.count|add:"-1"}}){%endif%} </span></a>
-            </td>
-            <td class="machine">
-                <a href="{% url "buildrequestdetails" buildrequest.project.id buildrequest.id %}">{{buildrequest.machine}}</a>
-            </td>
-   {% if MANAGED %}
-            <td class="project">
-                <a href="{% url 'project' buildrequest.project.id %}">{{buildrequest.project.name}}</a>
-            </td>
-   {% endif %}
-            <td class="started_on">
-                <a href="{% url "buildrequestdetails" buildrequest.project.id buildrequest.id %}">{{buildrequest.created|date:"d/m/y H:i"}}</a>
-            </td>
-            <td class="completed_on">
-                <a href="{% url "buildrequestdetails" buildrequest.project.id buildrequest.id %}">{{buildrequest.updated|date:"d/m/y H:i"}}</a>
-            </td>
-            <td class="failed_tasks error">
-            </td>
-            <td class="errors_no">
-                <a class="errors_no error" href="{% url "buildrequestdetails" buildrequest.project.id buildrequest.id %}#errors">{{buildrequest.brerror_set.all.count}} error{{buildrequest.brerror_set.all.count|pluralize}}</a>
-            </td>
-            <td class="warnings_no">
-            </td>
-            <td class="time">
-                {{br.timespent.total_seconds|sectohms}}
-            </td>
-            <td class="output"> {# we have no output here #}
-            </td>
-        </tr>
-          {%endif%}
-        {% endfor %}
-
-
-  {% include "basetable_bottom.html" %}
-  {% endif %} {# objects.paginator.count #}
-{% endif %} {# empty #}
-</div><!-- end row-fluid-->
-
-{% endblock %}
diff --git a/lib/toaster/toastergui/templates/managed_mrb_section.html b/lib/toaster/toastergui/templates/managed_mrb_section.html
deleted file mode 100644
index 47e64ea..0000000
--- a/lib/toaster/toastergui/templates/managed_mrb_section.html
+++ /dev/null
@@ -1,193 +0,0 @@
-{% load static %}
-{% load projecttags %}
-{% load humanize %}
-
-{%if mru|length > 0%}
-{# Template provides the latest builds section requires mru in the context which can be added from _managed_get_latest_builds #}
-  <div class="page-header top-air">
-      <h1>
-          Latest builds
-      </h1>
-  </div>
-  <div id="latest-builds">
-  {% for buildrequest in mru %}{% with build=buildrequest.build %}
-
-  {% if build %} {# if we have a build, just display it #}
-
-    <div class="alert {%if build.outcome == build.SUCCEEDED%}alert-success{%elif build.outcome == build.FAILED%}alert-error{%else%}alert-info{%endif%} {% if MANAGED and build.project %}project-name{% endif %} ">
-    {% if MANAGED and build.project %}
-       <span class="label {%if build.outcome == build.SUCCEEDED%}label-success{%elif build.outcome == build.FAILED%}label-important{%else%}label-info{%endif%}">
-        <a href="{% url 'project' build.project.id %}"> {{build.project.name}} </a>
-       </span>
-    {% endif %}
-
-        <div class="row-fluid">
-            <div class="span3 lead">
-    {%if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
-                <a href="{%url 'builddashboard' build.pk%}" class="{%if build.outcome == build.SUCCEEDED %}success{%else%}error{%endif%}">
-    {% endif %}
-    {% include "brtargets.html" %}
-    {%if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
-                </a>
-    {% endif %}
-            </div>
-    {%if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
-            <div class="span2 lead">
-                {% if build.completed_on|format_build_date  %}
-                    {{ build.completed_on|date:'d/m/y H:i' }}
-                {% else %}
-                    {{ build.completed_on|date:'H:i' }}
-                {% endif %}
-            </div>
-            <div class="span2 lead">
-      {% if  build.errors_no %}
-                <i class="icon-minus-sign red"></i> <a href="{%url 'builddashboard' build.pk%}#errors" class="error">{{build.errors_no}} error{{build.errors_no|pluralize}}</a>
-      {% endif %}
-            </div>
-            <div class="span2 lead">
-      {% if  build.warnings_no %}
-                <i class="icon-warning-sign yellow"></i> <a href="{%url 'builddashboard' build.pk%}#warnings" class="warning">{{build.warnings_no}} warning{{build.warnings_no|pluralize}}</a>
-      {% endif %}
-            </div>
-            <div class="lead ">
-              <span class="lead{%if not MANAGED or not build.project%} pull-right{%endif%}">
-                Build time: <a href="{% url 'buildtime' build.pk %}">{{ build.timespent|sectohms }}</a>
-              </span>
-          {% if build.project %}
-              <button class="btn
-                  {% if build.outcome == build.SUCCEEDED %}
-                      btn-success
-                  {% elif build.outcome == build.FAILED %}
-                      btn-danger
-                  {% else %}
-                      btn-info
-                  {%endif%}
-                  pull-right"
-                  {% include "runagain.html" %}
-              </button>
-          {% endif %}
-            </div>
-    {%endif%}
-    {%if build.outcome == build.IN_PROGRESS %}
-            <div class="span4 offset1">
-                <div class="progress" style="margin-top:5px;" data-toggle="tooltip" title="{{build.completeper}}% of tasks complete">
-                    <div style="width: {{build.completeper}}%;" class="bar"></div>
-                </div>
-            </div>
-            <div class="lead pull-right">{{build.completeper}}% tasks completed</div>
-    {%endif%}
-        </div>
-    </div>
-
-  {% else %}  {# we use the project's page recent build design #}
-
-
-
-
-  <div class="alert {% if buildrequest.state  == buildrequest.REQ_FAILED %}alert-error{% else %}alert-info{% endif %} project-name">
-       <span class="label {% if buildrequest.state  == buildrequest.REQ_FAILED %}label-important{% else%}label-info{% endif %}">
-        <a href="{% url 'project' buildrequest.project.id %}"> {{buildrequest.project.name}} </a>
-       </span>
-    <div class="row-fluid">
-
-          {% if buildrequest.state == buildrequest.REQ_FAILED %}
-            <div class="span3 lead">
-                <a href="{%url 'buildrequestdetails' buildrequest.project.id buildrequest.pk%}" class="error">
-                  {% include "brtargets.html" %}
-                </a>
-            </div>
-            <div class="span2 lead">
-                {% if buildrequest.updated|format_build_date  %}
-                    {{ buildrequest.updated|date:'d/m/y H:i' }}
-                {% else %}
-                    {{ buildrequest.updated|date:'H:i' }}
-                {% endif %}
-            </div>
-            <div class="span2 lead">
-      {% if  buildrequest.brerror_set.all.count %}
-                <i class="icon-minus-sign red"></i> <a href="{%url 'buildrequestdetails' buildrequest.project.id buildrequest.pk %}#errors" class="error">{{buildrequest.brerror_set.all.count}} error{{buildrequest.brerror_set.all.count|pluralize}}</a>
-      {% endif %}
-            </div>
-            <div class="span2 lead"> {# there are no warnings for buildrequests #}
-            </div>
-            <div class="lead ">
-              <span class="lead{%if not MANAGED or not buildrequest.project%} pull-right{%endif%}">
-                Build time: {{ buildrequest.get_duration|sectohms }}
-              </span>
-
-              <button class="btn btn-danger pull-right"
-                  {% include "runagain.html" %}
-              </button>
-            </div>
-
-
-         {% elif buildrequest.state == buildrequest.REQ_QUEUED %}
-
-            <div class="lead span5">
-                {% include "brtargets.html" %}
-            </div>
-            <div class="span4 lead">Build queued
-              <i title="This build will start as soon as a build server is available" class="icon-question-sign get-help get-help-blue heading-help" data-toggle="tooltip"></i>
-            </div>
-            <button class="btn btn-info pull-right cancel-build-btn" data-build-id="{{buildrequest.id}}" data-request-url="{% url 'projectbuilds' buildrequest.project.id %}" >Cancel</button>
-
-         {% elif buildrequest.state == buildrequest.REQ_CREATED %}
-
-            <div class="lead span3">
-                {% include "brtargets.html" %}
-            </div>
-            <div class="span6" >
-              <span class="lead">Creating build</span>
-            </div>
-
-         {% elif buildrequest.state == buildrequest.REQ_INPROGRESS %}
-
-                <div class="lead span5">
-                  {% include "brtargets.html" %}
-                </div>
-                <div class="span4 lead">
-                  Checking out layers
-                </div>
-          {% else %}
-
-          <div>FIXME!</div>
-
-          {% endif %}
-      <div class="lead pull-right">
-      </div>
-    </div>
-  </div>
-
-
-
-  {% endif %} {# this ends the build request most recent build section #}
-
-{%endwith%}{% endfor %}
-  </div>
-
-<script>
-
-function scheduleBuild(url, projectName, projectUrl, buildlist) {
-  console.log("scheduleBuild");
-  libtoaster.startABuild(url, null, buildlist.join(" "), function(){
-    window.location.reload();
-  }, null);
-}
-
-$(document).ready(function(){
-
-  $(".cancel-build-btn").click(function (){
-    var url = $(this).data('request-url');
-    var buildIds = $(this).data('build-id');
-    var btn = $(this);
-
-    libtoaster.cancelABuild(url, buildIds, function(){
-      btn.parents(".alert").fadeOut();
-    }, null);
-  });
-});
-
-</script>
-
-{%endif%}
-
diff --git a/lib/toaster/toastergui/templates/mrb_section.html b/lib/toaster/toastergui/templates/mrb_section.html
index c7bddf0..7e84e41 100644
--- a/lib/toaster/toastergui/templates/mrb_section.html
+++ b/lib/toaster/toastergui/templates/mrb_section.html
@@ -12,18 +12,24 @@
   </div>
   <div id="latest-builds">
   {% for build in mru %}
-    <div class="alert {%if build.outcome == build.SUCCEEDED%}alert-success{%elif build.outcome == build.FAILED%}alert-error{%else%}alert-info{%endif%} {% if MANAGED and build.project %}project-name{% endif %} ">
-    {% if MANAGED and build.project %}
+    <div class="alert {%if build.outcome == build.SUCCEEDED%}alert-success{%elif build.outcome == build.FAILED%}alert-error{%else%}alert-info{%endif%} project-name ">
        <span class="label {%if build.outcome == build.SUCCEEDED%}label-success{%elif build.outcome == build.FAILED%}label-danger{%else%}label-info{%endif%}"> {{build.project.name}} </span>
-    {% endif %}
 
         <div class="row-fluid">
             <div class="span3 lead">
     {%if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
                 <a href="{%url 'builddashboard' build.pk%}" class="{%if build.outcome == build.SUCCEEDED %}success{%else%}error{%endif%}">
     {% endif %}
-                <span data-toggle="tooltip" {%if build.target_set.all.count > 1%}title="Targets: {%for target in build.target_set.all%}{{target.target}} {%endfor%}"{%endif%}>{{build.target_set.all.0.target}} {%if build.target_set.all.count > 1%}(+ {{build.target_set.all.count|add:"-1"}}){%endif%}
-		        </span>
+            {% if build.target_set.all.count > 0 %}
+                <span data-toggle="tooltip"
+                  {%if build.target_set.all.count > 1%}
+                    title="Targets: {%for target in build.target_set.all%}{{target.target}} {%endfor%}"
+                  {%endif%}
+                >
+
+                  {{build.target_set.all.0.target}} {%if build.target_set.all.count > 1%}(+ {{build.target_set.all.count|add:"-1"}}){%endif%}
+                </span>
+             {% endif %}
     {%if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
                 </a>
     {% endif %}
@@ -65,5 +71,30 @@
 
   {% endfor %}
   </div>
+
+<script>
+
+function scheduleBuild(url, projectName, projectUrl, buildlist) {
+  console.log("scheduleBuild");
+  libtoaster.startABuild(url, null, buildlist.join(" "), function(){
+    window.location.reload();
+  }, null);
+}
+
+$(document).ready(function(){
+
+  $(".cancel-build-btn").click(function (){
+    var url = $(this).data('request-url');
+    var buildIds = $(this).data('build-id');
+    var btn = $(this);
+
+    libtoaster.cancelABuild(url, buildIds, function(){
+      btn.parents(".alert").fadeOut();
+    }, null);
+  });
+});
+
+</script>
+
 {%endif%}
 
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index bca703a..0f6a77b 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -124,7 +124,7 @@ vim: expandtab tabstop=2
   <div class="well">
     <form class="build-form" data-ng-submit="buildNamedTarget()">
       <div class="input-append controls">
-        <input type="text" class="huge input-xxlarge" placeholder="Type the recipe(s) you want to build" autocomplete="off" data-ng-model="targetName" data-typeahead="a.name for a in getRecipesAutocompleteSuggestions($viewValue)" data-typeahead-template-url="recipes_suggestion_details" data-ng-disabled="!layers.length"/>
+        <input type="text" class="huge input-xxlarge" placeholder="Type the recipe(s) you want to build" autocomplete="off" data-ng-model="targetName" data-typeahead="a.name for a in getRecipesAutocompleteSuggestions($viewValue)" data-typeahead-template-url="recipes_suggestion_details" data-ng-disabled="!project.release || !layers.length"/>
         <button type="submit" class="btn btn-large btn-primary" data-ng-disabled="!targetName.length">
         Build
         </button>
@@ -145,11 +145,11 @@ vim: expandtab tabstop=2
 
   <a id="buildslist"></a>
   <h2 class="air" data-ng-if="builds.length">Latest builds</h2>
-  <div class="animate-repeat alert"  data-ng-repeat="b in builds track by b.id" data-ng-class="{'queued':'alert-info', 'deleted':'alert-info', 'in progress': 'alert-info', 'failed':'alert-error', 'completed':{'In Progress':'alert-info', 'Succeeded':'alert-success', 'Failed':'alert-error'}[b.build[0].status]}[b.status]">
+  <div class="animate-repeat alert"  data-ng-repeat="b in builds track by b.id" data-ng-class="{'In Progress':'alert-info', 'Succeeded':'alert-success', 'Failed':'alert-error'}[b.status]">
     <div class="row-fluid">
         <switch data-ng-switch="b.status">
 
-          <case data-ng-switch-when="failed">
+          <case data-ng-switch-when="Failed">
             <div class="lead span3">
               <a data-ng-class="{'succeeded': 'success', 'failed': 'error'}[b.status]" href="{[b.br_page_url]}">
                 <span data-ng-repeat="t in b.targets" data-ng-include src="'target_display'"></span>
@@ -182,32 +182,8 @@ vim: expandtab tabstop=2
             </div>
           </case>
 
-          <case data-ng-switch-when="queued">
-            <div class="lead span5"> <span data-ng-repeat="t in b.targets" data-ng-include src="'target_display'"></span>   </div>
-            <div class="span4 lead" >Build queued
-              <i title="This build will start as soon as a build server is available" class="icon-question-sign get-help get-help-blue heading-help" data-toggle="tooltip"></i>
-            </div>
-            <button class="btn pull-right btn-info" data-ng-click="buildCancel(b)">Cancel</button>
-          </case>
-
-          <case data-ng-switch-when="created">
-            <div class="lead span5"> <span data-ng-repeat="t in b.targets" data-ng-include src="'target_display'"></span>   </div>
-            <div class="span4">
-              <span class="lead">Creating build</span>
-            </div>
-            <button class="btn pull-right btn-info" data-ng-click="buildCancel(b)">Cancel</button>
-          </case>
-
-          <case data-ng-switch-when="deleted">
-            <div class="lead span5"> <span data-ng-repeat="t in b.targets" data-ng-include src="'target_display'"></span>   </div>
-            <div class="span4" id="{[b.id]}-deleted" >
-              <span class="lead">Build cancelled</span>
-            </div>
-            <button class="btn pull-right btn-info" data-ng-click="buildDelete(b)">Close</button>
-          </case>
-
 
-          <case data-ng-switch-when="in progress">
+          <case data-ng-switch-when="In Progress">
             <switch data-ng-switch="b.build.length">
               <case data-ng-switch-when="0">
                 <div class="lead span5"> <span data-ng-repeat="t in b.targets" data-ng-include src="'target_display'"></span>   </div>
@@ -227,7 +203,7 @@ vim: expandtab tabstop=2
           </case>
 
 
-          <case data-ng-switch-when="completed">
+          <case data-ng-switch-when="Succeeded">
             <div class="lead span3">
               <a data-ng-class="{'Succeeded': 'success', 'Failed': 'error'}[b.build[0].status]" href="{[b.build[0].build_page_url]}">
                 <span data-ng-repeat="t in b.targets" data-ng-include src="'target_display'"></span>
@@ -293,7 +269,7 @@ vim: expandtab tabstop=2
         Layers <span class="muted counter">({[layers.length]})</span>
         <i class="icon-question-sign get-help heading-help" title="Bitbake reads metadata files from modules called 'layers'. Layers allow you to isolate different types of customizations from each other. <a href='http://www.yoctoproject.org/docs/current/dev-manual/dev-manual.html#understanding-and-creating-layers' target='_blank'>More on layers</a>"></i>
       </h3>
-      <div class="alert" data-ng-if="!layers.length">
+      <div class="alert" data-ng-if="project.release && !layers.length">
         <b>You need to add some layers </b>
         <p>
         You can:
@@ -307,7 +283,7 @@ vim: expandtab tabstop=2
       </div>
       <form data-ng-submit="layerAdd()">
         <div class="input-append">
-          <input type="text" class="input-xlarge" id="layer" autocomplete="off" placeholder="Type a layer name" data-minLength="1" data-ng-model="layerAddName" data-typeahead="e for e in getLayersAutocompleteSuggestions($viewValue)" data-typeahead-template-url="layers_suggestion_details" data-typeahead-on-select="onLayerSelect($item, $model, $label)" data-typeahead-editable="false" data-ng-class="{ 'has-error': layerAddName.$invalid }" />
+          <input type="text" class="input-xlarge" id="layer" autocomplete="off" placeholder="Type a layer name" data-minLength="1" data-ng-model="layerAddName" data-typeahead="e for e in getLayersAutocompleteSuggestions($viewValue)" data-typeahead-template-url="layers_suggestion_details" data-typeahead-on-select="onLayerSelect($item, $model, $label)" data-typeahead-editable="false" data-ng-class="{ 'has-error': layerAddName.$invalid }" data-ng-disabled="!project.release" />
           <input type="submit" id="add-layer" class="btn" value="Add" data-ng-disabled="!layerAddName.length"/>
         </div>
         {% csrf_token %}
@@ -334,7 +310,7 @@ vim: expandtab tabstop=2
       </h3>
         <form data-ng-submit="buildNamedTarget()">
           <div class="input-append">
-            <input type="text" class="input-xlarge" placeholder="Type the recipe(s) you want to build" autocomplete="off" data-minLength="1"  data-ng-model="targetName1" data-typeahead="a.name for a in getRecipesAutocompleteSuggestions($viewValue)" data-typeahead-template-url="recipes_suggestion_details" data-ng-disabled="!layers.length">
+            <input type="text" class="input-xlarge" placeholder="Type the recipe(s) you want to build" autocomplete="off" data-minLength="1"  data-ng-model="targetName1" data-typeahead="a.name for a in getRecipesAutocompleteSuggestions($viewValue)" data-typeahead-template-url="recipes_suggestion_details" data-ng-disabled="!project.release || !layers.length">
             <button type="submit" class="btn btn-primary" data-ng-disabled="!targetName1.length">
               Build </button>
           </div>
diff --git a/lib/toaster/toastergui/templates/projectbuilds.html b/lib/toaster/toastergui/templates/projectbuilds.html
index 18b2495..896c3b5 100644
--- a/lib/toaster/toastergui/templates/projectbuilds.html
+++ b/lib/toaster/toastergui/templates/projectbuilds.html
@@ -105,7 +105,6 @@
             </td>
         </tr>
 
-
               {%endwith%}
       {% else %} {# we don't have a build for this build request, mask the data with build request data #}
 
diff --git a/lib/toaster/toastergui/templates/projects.html b/lib/toaster/toastergui/templates/projects.html
index 2334008..9c4346c 100644
--- a/lib/toaster/toastergui/templates/projects.html
+++ b/lib/toaster/toastergui/templates/projects.html
@@ -7,7 +7,7 @@
 {% block pagecontent %}
 
 
-  {% include "managed_mrb_section.html" %}
+  {% include "mrb_section.html" %}
 
 
   <div class="page-header top-air">
@@ -39,7 +39,13 @@
     <tr class="data">
       <td><a href="{% url 'project' o.id %}">{{o.name}}</a></td>
       <td class="updated"><a href="{% url 'project' o.id %}">{{o.updated|date:"d/m/y H:i"}}</a></td>
-      <td><a href="{% url 'project' o.id %}#project-details">{{o.release.name}}</a></td>
+      <td>
+        {% if o.release %}
+            <a href="{% url 'project' o.id %}#project-details">{{o.release.name}}</a>
+        {% else %}
+            No release available
+        {% endif %}
+      </td>
       <td><a href="{% url 'project' o.id %}#machine-distro">{{o.get_current_machine_name}}</a></td>
       {% if o.get_number_of_builds == 0 %}
       <td class="muted">{{o.get_number_of_builds}}</td>
@@ -52,13 +58,13 @@
       <td><a href="{% url 'projectbuilds' o.id %}">{{o.get_number_of_builds}}</a></td>
       <td class="loutcome"><a href="{% url "builddashboard" o.get_last_build_id %}">{%if o.get_last_outcome == build_SUCCEEDED%}<i class="icon-ok-sign success"></i>{%elif o.get_last_outcome == build_FAILED%}<i class="icon-minus-sign error"></i>{%else%}{%endif%}</a></td>
       <td class="ltarget"><a href="{% url "builddashboard" o.get_last_build_id %}">{{o.get_last_target}} </a></td>
-	  <td class="lerrors">{% if o.get_last_errors %}<a class="errors_no error" href="{% url "builddashboard" o.get_last_build_id %}#errors">{{o.get_last_errors}} error{{o.get_last_errors|pluralize}}</a>{%endif%}</td>
-	  <td class="lwarnings">{% if o.get_last_warnings %}<a class="warnings_no warning" href="{% url "builddashboard" o.get_last_build_id %}#warnings">{{o.get_last_warnings}} warning{{o.get_last_warnings|pluralize}}</a>{%endif%}</td>
+      <td class="lerrors">{% if o.get_last_errors %}<a class="errors_no error" href="{% url "builddashboard" o.get_last_build_id %}#errors">{{o.get_last_errors}} error{{o.get_last_errors|pluralize}}</a>{%endif%}</td>
+      <td class="lwarnings">{% if o.get_last_warnings %}<a class="warnings_no warning" href="{% url "builddashboard" o.get_last_build_id %}#warnings">{{o.get_last_warnings}} warning{{o.get_last_warnings|pluralize}}</a>{%endif%}</td>
       <td class="limagefiles">
-	    {% if o.get_last_outcome == build_SUCCEEDED %}
-	    <a href="{%url "builddashboard" o.get_last_build_id %}#images">{{fstypes|get_dict_value:o.id}}</a>
-	    {% endif %}
-	  </td>
+        {% if o.get_last_outcome == build_SUCCEEDED %}
+        <a href="{%url "builddashboard" o.get_last_build_id %}#images">{{fstypes|get_dict_value:o.id}}</a>
+        {% endif %}
+      </td>
 
       {% endif %}
     </tr>
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index bd3eb40..681f067 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -132,7 +132,7 @@ urlpatterns = patterns('toastergui.views',
         url(r'^xhr_updatelayer/$', 'xhr_updatelayer', name='xhr_updatelayer'),
 
         # dashboard for failed build requests
-        url(r'^project/(?P<pid>\d+)/buildrequest/(?P<brid>\d+)$', 'buildrequestdetails', name='buildrequestdetails'),
+        url(r'^project/(?P<pid>\d+)/buildrequest/(?P<bid>\d+)$', 'buildrequestdetails', name='buildrequestdetails'),
 
         # default redirection
         url(r'^$', RedirectView.as_view( url= 'landing')),
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 060d680..0324d17 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -55,11 +55,23 @@ def landing(request):
 
     return render(request, 'landing.html', context)
 
-# returns a list for most recent builds; for use in the Project page, xhr_ updates,  and other places, as needed
+
+
+# returns a list for most recent builds;
+def _get_latest_builds(prj=None):
+    queryset = Build.objects.all()
+
+    if prj is not None:
+        queryset = queryset.filter(project = prj)
+
+    return itertools.chain(queryset.filter(outcome__lt=Build.IN_PROGRESS).order_by("-pk")[:3], queryset.filter(outcome=Build.IN_PROGRESS).order_by("-pk"))
+
+
+# a JSON-able dict of recent builds; for use in the Project page, xhr_ updates,  and other places, as needed
 def _project_recent_build_list(prj):
     data = []
     # take the most recent 3 completed builds, plus any builds in progress
-    for x in itertools.chain(prj.build_set.filter(outcome__lt=Build.IN_PROGRESS).order_by("-pk")[:3], prj.build_set.filter(outcome=Build.IN_PROGRESS).order_by("-pk")):
+    for x in _get_latest_builds(prj):
         d = {
             "id":  x.pk,
             "targets" : map(lambda y: {"target": y.target, "task": None }, x.target_set.all()), # TODO: create the task entry in the Target table
@@ -1866,10 +1878,10 @@ if True:
         # be able to display something.  'count' and 'page' are mandatory for all views
         # that use paginators.
 
-        buildrequests = BuildRequest.objects.exclude(state__lte = BuildRequest.REQ_INPROGRESS).exclude(state=BuildRequest.REQ_DELETED)
+        queryset = Build.objects.filter(outcome__lte = Build.IN_PROGRESS)
 
         try:
-            context, pagesize, orderby = _build_list_helper(request, buildrequests, True)
+            context, pagesize, orderby = _build_list_helper(request, queryset)
         except InvalidRequestException as e:
             raise RedirectException( builds, request.GET, e.response)
 
@@ -1878,66 +1890,37 @@ if True:
 
 
     # helper function, to be used on "all builds" and "project builds" pages
-    def _build_list_helper(request, buildrequests, insert_projects):
-        # ATTN: we use here the ordering parameters for interactive mode; the translation for BuildRequest fields will happen below
+    def _build_list_helper(request, queryset_all):
+
         default_orderby = 'completed_on:-'
         (pagesize, orderby) = _get_parameters_values(request, 10, default_orderby)
         mandatory_parameters = { 'count': pagesize,  'page' : 1, 'orderby' : orderby }
         retval = _verify_parameters( request.GET, mandatory_parameters )
         if retval:
-            raise InvalidRequestException(mandatory_parameters)
-
-        orig_orderby = orderby
-        # translate interactive mode ordering to managed mode ordering
-        ordering_params = orderby.split(":")
-        if ordering_params[0] == "completed_on":
-            ordering_params[0] = "updated"
-        if ordering_params[0] == "started_on":
-            ordering_params[0] = "created"
-        if ordering_params[0] == "errors_no":
-            ordering_params[0] = "build__errors_no"
-        if ordering_params[0] == "warnings_no":
-            ordering_params[0] = "build__warnings_no"
-        if ordering_params[0] == "machine":
-            ordering_params[0] = "build__machine"
-        if ordering_params[0] == "target__target":
-            ordering_params[0] = "brtarget__target"
-        if ordering_params[0] == "timespent":
-            ordering_params[0] = "id"
-            orderby = default_orderby
-
-        request.GET = request.GET.copy()        # get a mutable copy of the GET QueryDict
-        request.GET['orderby'] = ":".join(ordering_params)
+            raise RedirectException( 'all-builds', request.GET, mandatory_parameters)
 
         # boilerplate code that takes a request for an object type and returns a queryset
         # for that object type. copypasta for all needed table searches
-        (filter_string, search_term, ordering_string) = _search_tuple(request, BuildRequest)
+        (filter_string, search_term, ordering_string) = _search_tuple(request, Build)
         # post-process any date range filters
         filter_string,daterange_selected = _modify_date_range_filter(filter_string)
-
-        # we don't display in-progress or deleted builds
-        queryset_all = buildrequests.exclude(state = BuildRequest.REQ_DELETED)
-        queryset_all = queryset_all.select_related("build", "build__project").annotate(Count('brerror'))
-        queryset_with_search = _get_queryset(BuildRequest, queryset_all, filter_string, search_term, ordering_string, '-updated')
-
+        queryset_all = queryset_all.select_related("project")
+        queryset_with_search = _get_queryset(Build, queryset_all, None, search_term, ordering_string, '-completed_on')
+        queryset = _get_queryset(Build, queryset_all, filter_string, search_term, ordering_string, '-completed_on')
 
         # retrieve the objects that will be displayed in the table; builds a paginator and gets a page range to display
-        build_info = _build_page_range(Paginator(queryset_with_search, pagesize), request.GET.get('page', 1))
+        build_info = _build_page_range(Paginator(queryset, pagesize), request.GET.get('page', 1))
 
         # build view-specific information; this is rendered specifically in the builds page, at the top of the page (i.e. Recent builds)
-        # most recent build is like projects' most recent builds, but across all projects
-        build_mru = _managed_get_latest_builds()
+        build_mru = Build.objects.order_by("-started_on")[:3]
+
+        # calculate the exact begining of local today and yesterday, append context
+        context_date,today_begin,yesterday_begin = _add_daterange_context(queryset_all, request, {'started_on','completed_on'})
 
+        # set up list of fstypes for each build
         fstypes_map = {};
-        for build_request in build_info:
-            # set display variables for build request
-            build_request.machine = build_request.brvariable_set.get(name="MACHINE").value
-            build_request.timespent = build_request.updated - build_request.created
-
-            # set up list of fstypes for each build
-            if build_request.build is None:
-                continue
-            targets = Target.objects.filter( build_id = build_request.build.id )
+        for build in build_info:
+            targets = Target.objects.filter( build_id = build.id )
             comma = "";
             extensions = "";
             for t in targets:
@@ -1951,8 +1934,7 @@ if True:
                     if None == re.search(s,extensions):
                         extensions += comma + s
                         comma = ", "
-            fstypes_map[build_request.build.id]=extensions
-
+            fstypes_map[build.id]=extensions
 
         # send the data to the template
         context = {
@@ -1961,7 +1943,7 @@ if True:
                 # TODO: common objects for all table views, adapt as needed
                     'objects' : build_info,
                     'objectname' : "builds",
-                    'default_orderby' : 'updated:-',
+                    'default_orderby' : default_orderby,
                     'fstypes' : fstypes_map,
                     'search_term' : search_term,
                     'total_count' : queryset_with_search.count(),
@@ -1971,151 +1953,137 @@ if True:
                     {'name': 'Outcome',                                                # column with a single filter
                      'qhelp' : "The outcome tells you if a build successfully completed or failed",     # the help button content
                      'dclass' : "span2",                                                # indication about column width; comes from the design
-                     'orderfield': _get_toggle_order(request, "state"),               # adds ordering by the field value; default ascending unless clicked from ascending into descending
-                     'ordericon':_get_toggle_order_icon(request, "state"),
+                     'orderfield': _get_toggle_order(request, "outcome"),               # adds ordering by the field value; default ascending unless clicked from ascending into descending
+                     'ordericon':_get_toggle_order_icon(request, "outcome"),
                       # filter field will set a filter on that column with the specs in the filter description
                       # the class field in the filter has no relation with clclass; the control different aspects of the UI
                       # still, it is recommended for the values to be identical for easy tracking in the generated HTML
                      'filter' : {'class' : 'outcome',
                                  'label': 'Show:',
                                  'options' : [
-                                             ('Successful builds', 'build__outcome:' + str(Build.SUCCEEDED), queryset_all.filter(build__outcome = Build.SUCCEEDED).count()),  # this is the field search expression
-                                             ('Failed builds', 'build__outcome:NOT'+ str(Build.SUCCEEDED), queryset_all.exclude(build__outcome = Build.SUCCEEDED).count()),
+                                             ('Successful builds', 'outcome:' + str(Build.SUCCEEDED), queryset_with_search.filter(outcome=str(Build.SUCCEEDED)).count()),  # this is the field search expression
+                                             ('Failed builds', 'outcome:'+ str(Build.FAILED), queryset_with_search.filter(outcome=str(Build.FAILED)).count()),
                                              ]
                                 }
                     },
                     {'name': 'Recipe',                                                 # default column, disabled box, with just the name in the list
                      'qhelp': "What you built (i.e. one or more recipes or image recipes)",
-                     'orderfield': _get_toggle_order(request, "brtarget__target"),
-                     'ordericon':_get_toggle_order_icon(request, "brtarget__target"),
+                     'orderfield': _get_toggle_order(request, "target__target"),
+                     'ordericon':_get_toggle_order_icon(request, "target__target"),
                     },
                     {'name': 'Machine',
                      'qhelp': "The machine is the hardware for which you are building a recipe or image recipe",
-                     'orderfield': _get_toggle_order(request, "build__machine"),
-                     'ordericon':_get_toggle_order_icon(request, "build__machine"),
+                     'orderfield': _get_toggle_order(request, "machine"),
+                     'ordericon':_get_toggle_order_icon(request, "machine"),
                      'dclass': 'span3'
                     },                           # a slightly wider column
-                    ]
-                }
-
-        if (insert_projects):
-            context['tablecols'].append(
-                    {'name': 'Project', 'clclass': 'project_column',
-                    }
-            )
-
-        # calculate the exact begining of local today and yesterday
-        context_date,today_begin,yesterday_begin = _add_daterange_context(queryset_all, request, {'created','updated'})
-        context.update(context_date)
-
-        context['tablecols'].append(
                     {'name': 'Started on', 'clclass': 'started_on', 'hidden' : 1,      # this is an unchecked box, which hides the column
                      'qhelp': "The date and time you started the build",
-                     'orderfield': _get_toggle_order(request, "created", True),
-                     'ordericon':_get_toggle_order_icon(request, "created"),
-                     'filter' : {'class' : 'created',
+                     'orderfield': _get_toggle_order(request, "started_on", True),
+                     'ordericon':_get_toggle_order_icon(request, "started_on"),
+                     'orderkey' : "started_on",
+                     'filter' : {'class' : 'started_on',
                                  'label': 'Show:',
                                  'options' : [
-                                             ("Today's builds" , 'created__gte:'+today_begin.strftime("%Y-%m-%d"), queryset_all.filter(created__gte=today_begin).count()),
+                                             ("Today's builds" , 'started_on__gte:'+today_begin.strftime("%Y-%m-%d"), queryset_all.filter(started_on__gte=today_begin).count()),
                                              ("Yesterday's builds",
-                                                 'created__gte!created__lt:'
+                                                 'started_on__gte!started_on__lt:'
                                                      +yesterday_begin.strftime("%Y-%m-%d")+'!'
                                                      +today_begin.strftime("%Y-%m-%d"),
                                                  queryset_all.filter(
-                                                     created__gte=yesterday_begin,
-                                                     created__lt=today_begin
+                                                     started_on__gte=yesterday_begin,
+                                                     started_on__lt=today_begin
                                                      ).count()),
-                                             ("Build date range", 'daterange', 1, '', 'created'),
+                                             ("Build date range", 'daterange', 1, '', 'started_on'),
                                              ]
                                 }
-                    }
-            )
-        context['tablecols'].append(
+                     },
                     {'name': 'Completed on',
                      'qhelp': "The date and time the build finished",
-                     'orderfield': _get_toggle_order(request, "updated", True),
-                     'ordericon':_get_toggle_order_icon(request, "updated"),
-                     'orderkey' : 'updated',
-                     'filter' : {'class' : 'updated',
+                     'orderfield': _get_toggle_order(request, "completed_on", True),
+                     'ordericon':_get_toggle_order_icon(request, "completed_on"),
+                     'orderkey' : 'completed_on',
+                     'filter' : {'class' : 'completed_on',
                                  'label': 'Show:',
                                  'options' : [
-                                             ("Today's builds" , 'updated__gte:'+today_begin.strftime("%Y-%m-%d"), queryset_all.filter(updated__gte=today_begin).count()),
+                                             ("Today's builds" , 'completed_on__gte:'+today_begin.strftime("%Y-%m-%d"), queryset_all.filter(completed_on__gte=today_begin).count()),
                                              ("Yesterday's builds",
-                                                 'updated__gte!updated__lt:'
+                                                 'completed_on__gte!completed_on__lt:'
                                                      +yesterday_begin.strftime("%Y-%m-%d")+'!'
                                                      +today_begin.strftime("%Y-%m-%d"),
                                                  queryset_all.filter(
-                                                     updated__gte=yesterday_begin,
-                                                     updated__lt=today_begin
+                                                     completed_on__gte=yesterday_begin,
+                                                     completed_on__lt=today_begin
                                                      ).count()),
-                                             ("Build date range", 'daterange', 1, '', 'updated'),
+                                             ("Build date range", 'daterange', 1, '', 'completed_on'),
                                              ]
                                 }
-                    }
-            )
-        context['tablecols'].append(
+                    },
                     {'name': 'Failed tasks', 'clclass': 'failed_tasks',                # specifing a clclass will enable the checkbox
                      'qhelp': "How many tasks failed during the build",
                      'filter' : {'class' : 'failed_tasks',
                                  'label': 'Show:',
                                  'options' : [
-                                             ('Builds with failed tasks', 'build__task_build__outcome:%d' % Task.OUTCOME_FAILED,
-                                                queryset_all.filter(build__task_build__outcome=Task.OUTCOME_FAILED).count()),
-                                             ('Builds without failed tasks', 'build__task_build__outcome:%d' % Task.OUTCOME_FAILED,
-                                                queryset_all.filter(~Q(build__task_build__outcome=Task.OUTCOME_FAILED)).count()),
+                                             ('Builds with failed tasks', 'task_build__outcome:4', queryset_with_search.filter(task_build__outcome=4).count()),
+                                             ('Builds without failed tasks', 'task_build__outcome:NOT4', queryset_with_search.filter(~Q(task_build__outcome=4)).count()),
                                              ]
                                 }
-                    }
-            )
-        context['tablecols'].append(
+                    },
                     {'name': 'Errors', 'clclass': 'errors_no',
                      'qhelp': "How many errors were encountered during the build (if any)",
-                     'orderfield': _get_toggle_order(request, "build__errors_no", True),
-                     'ordericon':_get_toggle_order_icon(request, "build__errors_no"),
+                     'orderfield': _get_toggle_order(request, "errors_no", True),
+                     'ordericon':_get_toggle_order_icon(request, "errors_no"),
                      'orderkey' : 'errors_no',
                      'filter' : {'class' : 'errors_no',
                                  'label': 'Show:',
                                  'options' : [
-                                             ('Builds with errors', 'build|build__errors_no__gt:None|0',
-                                                queryset_all.filter(Q(build=None) | Q(build__errors_no__gt=0)).count()),
-                                             ('Builds without errors', 'build__errors_no:0',
-                                                queryset_all.filter(build__errors_no=0).count()),
+                                             ('Builds with errors', 'errors_no__gte:1', queryset_with_search.filter(errors_no__gte=1).count()),
+                                             ('Builds without errors', 'errors_no:0', queryset_with_search.filter(errors_no=0).count()),
                                              ]
                                 }
-                    }
-            )
-        context['tablecols'].append(
+                    },
                     {'name': 'Warnings', 'clclass': 'warnings_no',
                      'qhelp': "How many warnings were encountered during the build (if any)",
-                     'orderfield': _get_toggle_order(request, "build__warnings_no", True),
-                     'ordericon':_get_toggle_order_icon(request, "build__warnings_no"),
-                     'orderkey' : 'build__warnings_no',
-                     'filter' : {'class' : 'build__warnings_no',
+                     'orderfield': _get_toggle_order(request, "warnings_no", True),
+                     'ordericon':_get_toggle_order_icon(request, "warnings_no"),
+                     'orderkey' : 'warnings_no',
+                     'filter' : {'class' : 'warnings_no',
                                  'label': 'Show:',
                                  'options' : [
-                                             ('Builds with warnings','build__warnings_no__gte:1', queryset_all.filter(build__warnings_no__gte=1).count()),
-                                             ('Builds without warnings','build__warnings_no:0', queryset_all.filter(build__warnings_no=0).count()),
+                                             ('Builds with warnings','warnings_no__gte:1', queryset_with_search.filter(warnings_no__gte=1).count()),
+                                             ('Builds without warnings','warnings_no:0', queryset_with_search.filter(warnings_no=0).count()),
                                              ]
                                 }
-                    }
-            )
-        context['tablecols'].append(
+                    },
+                    {'name': 'Log',
+                     'dclass': "span4",
+                     'qhelp': "Path to the build main log file",
+                     'clclass': 'log', 'hidden': 1,
+                     'orderfield': _get_toggle_order(request, "cooker_log_path"),
+                     'ordericon':_get_toggle_order_icon(request, "cooker_log_path"),
+                     'orderkey' : 'cooker_log_path',
+                    },
                     {'name': 'Time', 'clclass': 'time', 'hidden' : 1,
                      'qhelp': "How long it took the build to finish",
-#                    'orderfield': _get_toggle_order(request, "timespent", True),
-#                    'ordericon':_get_toggle_order_icon(request, "timespent"),
+                     'orderfield': _get_toggle_order(request, "timespent", True),
+                     'ordericon':_get_toggle_order_icon(request, "timespent"),
                      'orderkey' : 'timespent',
-                    }
-            )
-        context['tablecols'].append(
+                    },
                     {'name': 'Image files', 'clclass': 'output',
                      'qhelp': "The root file system types produced by the build. You can find them in your <code>/build/tmp/deploy/images/</code> directory",
                         # TODO: compute image fstypes from Target_Image_File
+                    },
+                    {'name': 'Project', 'clcalss': 'project_column',
                     }
-            )
+                    ]
+                }
 
+        # merge daterange values
+        context.update(context_date)
         return context, pagesize, orderby
 
+
+
     # new project
     def newproject(request):
         template = "newproject.html"
@@ -2236,7 +2204,7 @@ if True:
             "lvs_nos" : Layer_Version.objects.all().count(),
             "completedbuilds": Build.objects.filter(project_id = pid).filter(outcome__lte = Build.IN_PROGRESS),
             "prj" : {"name": prj.name, },
-            #"buildrequests" : prj.buildrequest_set.filter(state=BuildRequest.REQ_QUEUED),
+            "buildrequests" : prj.build_set.filter(outcome=Build.IN_PROGRESS),
             "builds" : _project_recent_build_list(prj),
             "layers" :  map(lambda x: {
                         "id": x.layercommit.pk,
@@ -2607,9 +2575,10 @@ if True:
 
     @_template_renderer('projectbuilds.html')
     def projectbuilds(request, pid):
-        # process any build request
         prj = Project.objects.get(id = pid)
+
         if request.method == "POST":
+            # process any build request
 
             if 'buildCancel' in request.POST:
                 for i in request.POST['buildCancel'].strip().split(" "):
@@ -2641,10 +2610,10 @@ if True:
                 br = prj.schedule_build()
 
 
-        buildrequests = BuildRequest.objects.filter(project = prj).exclude(state__lte = BuildRequest.REQ_INPROGRESS).exclude(state=BuildRequest.REQ_DELETED)
+        queryset = Build.objects.filter(outcome__lte = Build.IN_PROGRESS)
 
         try:
-            context, pagesize, orderby = _build_list_helper(request, buildrequests, False)
+            context, pagesize, orderby = _build_list_helper(request, queryset)
         except InvalidRequestException as e:
             raise RedirectException('projectbuilds', request.GET, e.response, pid = pid)
 
@@ -2759,12 +2728,6 @@ if True:
             }
             return render(request, "unavailable_artifact.html", context)
 
-    # This returns the mru object that is needed for the
-    # managed_mrb_section.html template
-    def _managed_get_latest_builds():
-        build_mru = BuildRequest.objects.all()
-        build_mru = list(build_mru.filter(Q(state__lt=BuildRequest.REQ_COMPLETED) or Q(state=BuildRequest.REQ_DELETED)).order_by("-pk")) + list(build_mru.filter(state__in=[BuildRequest.REQ_COMPLETED, BuildRequest.REQ_FAILED]).order_by("-pk")[:3])
-        return build_mru
 
 
 
@@ -2796,7 +2759,7 @@ if True:
             p.projectTargetsUrl = reverse('projectavailabletargets', args=(p.id,))
 
         # build view-specific information; this is rendered specifically in the builds page, at the top of the page (i.e. Recent builds)
-        build_mru = _managed_get_latest_builds()
+        build_mru = _get_latest_builds()
 
         # translate the project's build target strings
         fstypes_map = {};
@@ -2878,202 +2841,8 @@ if True:
         return context
 
     @_template_renderer("buildrequestdetails.html")
-    def buildrequestdetails(request, pid, brid):
+    def buildrequestdetails(request, pid, bid):
         context = {
-            'buildrequest' : BuildRequest.objects.get(pk = brid, project_id = pid)
+            'buildrequest' : Build.objects.get(pk = bid, project_id = pid).buildrequest
         }
         return context
-
-
-    @_template_renderer('builds.html')
-    def builds_old(request):
-        # define here what parameters the view needs in the GET portion in order to
-        # be able to display something.  'count' and 'page' are mandatory for all views
-        # that use paginators.
-        (pagesize, orderby) = _get_parameters_values(request, 10, 'completed_on:-')
-        mandatory_parameters = { 'count': pagesize,  'page' : 1, 'orderby' : orderby }
-        retval = _verify_parameters( request.GET, mandatory_parameters )
-        if retval:
-            raise RedirectException( 'all-builds', request.GET, mandatory_parameters)
-
-        # boilerplate code that takes a request for an object type and returns a queryset
-        # for that object type. copypasta for all needed table searches
-        (filter_string, search_term, ordering_string) = _search_tuple(request, Build)
-        # post-process any date range filters
-        filter_string,daterange_selected = _modify_date_range_filter(filter_string)
-        queryset_all = Build.objects.exclude(outcome = Build.IN_PROGRESS)
-        queryset_with_search = _get_queryset(Build, queryset_all, None, search_term, ordering_string, '-completed_on')
-        queryset = _get_queryset(Build, queryset_all, filter_string, search_term, ordering_string, '-completed_on')
-
-        # retrieve the objects that will be displayed in the table; builds a paginator and gets a page range to display
-        build_info = _build_page_range(Paginator(queryset, pagesize), request.GET.get('page', 1))
-
-        # build view-specific information; this is rendered specifically in the builds page, at the top of the page (i.e. Recent builds)
-        build_mru = Build.objects.order_by("-started_on")[:3]
-
-        # calculate the exact begining of local today and yesterday, append context
-        context_date,today_begin,yesterday_begin = _add_daterange_context(queryset_all, request, {'started_on','completed_on'})
-
-        # set up list of fstypes for each build
-        fstypes_map = {};
-        for build in build_info:
-            targets = Target.objects.filter( build_id = build.id )
-            comma = "";
-            extensions = "";
-            for t in targets:
-                if ( not t.is_image ):
-                    continue
-                tif = Target_Image_File.objects.filter( target_id = t.id )
-                for i in tif:
-                    s=re.sub('.*tar.bz2', 'tar.bz2', i.file_name)
-                    if s == i.file_name:
-                        s=re.sub('.*\.', '', i.file_name)
-                    if None == re.search(s,extensions):
-                        extensions += comma + s
-                        comma = ", "
-            fstypes_map[build.id]=extensions
-
-        # send the data to the template
-        context = {
-                # specific info for
-                    'mru' : build_mru,
-                # TODO: common objects for all table views, adapt as needed
-                    'objects' : build_info,
-                    'objectname' : "builds",
-                    'default_orderby' : 'completed_on:-',
-                    'fstypes' : fstypes_map,
-                    'search_term' : search_term,
-                    'total_count' : queryset_with_search.count(),
-                    'daterange_selected' : daterange_selected,
-                # Specifies the display of columns for the table, appearance in "Edit columns" box, toggling default show/hide, and specifying filters for columns
-                    'tablecols' : [
-                    {'name': 'Outcome',                                                # column with a single filter
-                     'qhelp' : "The outcome tells you if a build successfully completed or failed",     # the help button content
-                     'dclass' : "span2",                                                # indication about column width; comes from the design
-                     'orderfield': _get_toggle_order(request, "outcome"),               # adds ordering by the field value; default ascending unless clicked from ascending into descending
-                     'ordericon':_get_toggle_order_icon(request, "outcome"),
-                      # filter field will set a filter on that column with the specs in the filter description
-                      # the class field in the filter has no relation with clclass; the control different aspects of the UI
-                      # still, it is recommended for the values to be identical for easy tracking in the generated HTML
-                     'filter' : {'class' : 'outcome',
-                                 'label': 'Show:',
-                                 'options' : [
-                                             ('Successful builds', 'outcome:' + str(Build.SUCCEEDED), queryset_with_search.filter(outcome=str(Build.SUCCEEDED)).count()),  # this is the field search expression
-                                             ('Failed builds', 'outcome:'+ str(Build.FAILED), queryset_with_search.filter(outcome=str(Build.FAILED)).count()),
-                                             ]
-                                }
-                    },
-                    {'name': 'Recipe',                                                 # default column, disabled box, with just the name in the list
-                     'qhelp': "What you built (i.e. one or more recipes or image recipes)",
-                     'orderfield': _get_toggle_order(request, "target__target"),
-                     'ordericon':_get_toggle_order_icon(request, "target__target"),
-                    },
-                    {'name': 'Machine',
-                     'qhelp': "The machine is the hardware for which you are building a recipe or image recipe",
-                     'orderfield': _get_toggle_order(request, "machine"),
-                     'ordericon':_get_toggle_order_icon(request, "machine"),
-                     'dclass': 'span3'
-                    },                           # a slightly wider column
-                    {'name': 'Started on', 'clclass': 'started_on', 'hidden' : 1,      # this is an unchecked box, which hides the column
-                     'qhelp': "The date and time you started the build",
-                     'orderfield': _get_toggle_order(request, "started_on", True),
-                     'ordericon':_get_toggle_order_icon(request, "started_on"),
-                     'filter' : {'class' : 'started_on',
-                                 'label': 'Show:',
-                                 'options' : [
-                                             ("Today's builds" , 'started_on__gte:'+today_begin.strftime("%Y-%m-%d"), queryset_all.filter(started_on__gte=today_begin).count()),
-                                             ("Yesterday's builds",
-                                                 'started_on__gte!started_on__lt:'
-                                                     +yesterday_begin.strftime("%Y-%m-%d")+'!'
-                                                     +today_begin.strftime("%Y-%m-%d"),
-                                                 queryset_all.filter(
-                                                     started_on__gte=yesterday_begin,
-                                                     started_on__lt=today_begin
-                                                     ).count()),
-                                             ("Build date range", 'daterange', 1, '', 'started_on'),
-                                             ]
-                                }
-                     },
-                    {'name': 'Completed on',
-                     'qhelp': "The date and time the build finished",
-                     'orderfield': _get_toggle_order(request, "completed_on", True),
-                     'ordericon':_get_toggle_order_icon(request, "completed_on"),
-                     'orderkey' : 'completed_on',
-                     'filter' : {'class' : 'completed_on',
-                                 'label': 'Show:',
-                                 'options' : [
-                                             ("Today's builds" , 'completed_on__gte:'+today_begin.strftime("%Y-%m-%d"), queryset_all.filter(completed_on__gte=today_begin).count()),
-                                             ("Yesterday's builds",
-                                                 'completed_on__gte!completed_on__lt:'
-                                                     +yesterday_begin.strftime("%Y-%m-%d")+'!'
-                                                     +today_begin.strftime("%Y-%m-%d"),
-                                                 queryset_all.filter(
-                                                     completed_on__gte=yesterday_begin,
-                                                     completed_on__lt=today_begin
-                                                     ).count()),
-                                             ("Build date range", 'daterange', 1, '', 'completed_on'),
-                                             ]
-                                }
-                    },
-                    {'name': 'Failed tasks', 'clclass': 'failed_tasks',                # specifing a clclass will enable the checkbox
-                     'qhelp': "How many tasks failed during the build",
-                     'filter' : {'class' : 'failed_tasks',
-                                 'label': 'Show:',
-                                 'options' : [
-                                             ('Builds with failed tasks', 'task_build__outcome:4', queryset_with_search.filter(task_build__outcome=4).count()),
-                                             ('Builds without failed tasks', 'task_build__outcome:NOT4', queryset_with_search.filter(~Q(task_build__outcome=4)).count()),
-                                             ]
-                                }
-                    },
-                    {'name': 'Errors', 'clclass': 'errors_no',
-                     'qhelp': "How many errors were encountered during the build (if any)",
-                     'orderfield': _get_toggle_order(request, "errors_no", True),
-                     'ordericon':_get_toggle_order_icon(request, "errors_no"),
-                     'orderkey' : 'errors_no',
-                     'filter' : {'class' : 'errors_no',
-                                 'label': 'Show:',
-                                 'options' : [
-                                             ('Builds with errors', 'errors_no__gte:1', queryset_with_search.filter(errors_no__gte=1).count()),
-                                             ('Builds without errors', 'errors_no:0', queryset_with_search.filter(errors_no=0).count()),
-                                             ]
-                                }
-                    },
-                    {'name': 'Warnings', 'clclass': 'warnings_no',
-                     'qhelp': "How many warnings were encountered during the build (if any)",
-                     'orderfield': _get_toggle_order(request, "warnings_no", True),
-                     'ordericon':_get_toggle_order_icon(request, "warnings_no"),
-                     'orderkey' : 'warnings_no',
-                     'filter' : {'class' : 'warnings_no',
-                                 'label': 'Show:',
-                                 'options' : [
-                                             ('Builds with warnings','warnings_no__gte:1', queryset_with_search.filter(warnings_no__gte=1).count()),
-                                             ('Builds without warnings','warnings_no:0', queryset_with_search.filter(warnings_no=0).count()),
-                                             ]
-                                }
-                    },
-                    {'name': 'Log',
-                     'dclass': "span4",
-                     'qhelp': "Path to the build main log file",
-                     'clclass': 'log', 'hidden': 1,
-                     'orderfield': _get_toggle_order(request, "cooker_log_path"),
-                     'ordericon':_get_toggle_order_icon(request, "cooker_log_path"),
-                     'orderkey' : 'cooker_log_path',
-                    },
-                    {'name': 'Time', 'clclass': 'time', 'hidden' : 1,
-                     'qhelp': "How long it took the build to finish",
-                     'orderfield': _get_toggle_order(request, "timespent", True),
-                     'ordericon':_get_toggle_order_icon(request, "timespent"),
-                     'orderkey' : 'timespent',
-                    },
-                    {'name': 'Image files', 'clclass': 'output',
-                     'qhelp': "The root file system types produced by the build. You can find them in your <code>/build/tmp/deploy/images/</code> directory",
-                        # TODO: compute image fstypes from Target_Image_File
-                    },
-                    ]
-                }
-
-        # merge daterange values
-        context.update(context_date)
-        _set_parameters_values(pagesize, orderby, request)
-
-        return context
-- 
1.9.1


