Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f53.google.com (mail-wg0-f53.google.com [74.125.82.53])
	by mail.openembedded.org (Postfix) with ESMTP id 1A47E6A9FE
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jan 2015 14:27:39 +0000 (UTC)
Received: by mail-wg0-f53.google.com with SMTP id a1so15003876wgh.12
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jan 2015 06:27:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=1GNh9v/GJdGYhOUsW8JfPJQ5JAKEgV5tGSbxZLShUyY=;
	b=Ds723lFbu35YZQEV5opdFUJcfpqLM8R503d8xhWaIU6hZ3REAsQT0L6r36ZLdAk72c
	OYNbsGlaCmLl14wOrOcu3/sBplmQWoGI+yLDEMPOBIwj8HoDYYkeEuFa5Qhp7J8YIcoN
	Fomgr/p7FUWpXfJBnjsnEPJB1yW0jD5qPyAAMbKU9dZM56F4v4qwhTalMS7aCiJbokT9
	1kcIopo/GScjkLbAmR1XkWx9ppHDYYGVCsW0qgm/MmlQi9c8hX43ZZCKhnj0ffo2gf7A
	7de0XVPTuPgAcSZtUpNgLhpBSHDfVd82Ibn0vJ38KwmMc66/MYjsd/jSeK/FG9/8J9ds
	y6ug==
X-Gm-Message-State: ALoCoQlPlb/ngzTtbi57Apu0sL6fFVVSEnH5dTNvcmmAT+6BAykYj7vjVtB7if0iuiHkCYaoTDuT
X-Received: by 10.180.72.199 with SMTP id f7mr6559120wiv.58.1422368859601;
	Tue, 27 Jan 2015 06:27:39 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id di11sm2398200wid.8.2015.01.27.06.27.35
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 27 Jan 2015 06:27:38 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id B67FF562734; Tue, 27 Jan 2015 14:27:36 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Jan 2015 14:27:35 +0000
Message-Id: <ee13bf45cecd6a0132d724b3206a6f4515669496.1422368757.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <49d56fcbbf6b7d0c0c589b93182e4c73071b3fcf.1422368757.git.alexandru.damian@intel.com>
References: <49d56fcbbf6b7d0c0c589b93182e4c73071b3fcf.1422368757.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1422368757.git.alexandru.damian@intel.com>
References: <cover.1422368757.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 14/14] toastergui: update project build listing
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
X-List-Received-Date: Tue, 27 Jan 2015 14:27:40 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We update the build listings in the project mode to enable
proper display and selection of build requests that do not have
an actual build object because the bitbake process did not start.

We add a page to display error details for build requests that
did not start a build.

Fixing errors and misspelling in build sections.

Sorting by "timespent" is disabled for build-listing pages.

[YOCTO #7165]
[YOCTO #7156]
[YOCTO #7196]
[YOCTO #7188]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/bldcontrol/models.py                   |   9 ++
 .../toastergui/templates/buildrequestdetails.html  |  67 ++++++++++++++
 .../toastergui/templates/managed_builds.html       |  18 ++--
 .../toastergui/templates/managed_mrb_section.html  |  42 ++++++---
 .../toastergui/templates/projectbuilds.html        |  20 ++--
 lib/toaster/toastergui/urls.py                     |   2 +
 lib/toaster/toastergui/views.py                    | 103 +++++++++++++--------
 7 files changed, 193 insertions(+), 68 deletions(-)
 create mode 100644 lib/toaster/toastergui/templates/buildrequestdetails.html

diff --git a/lib/toaster/bldcontrol/models.py b/lib/toaster/bldcontrol/models.py
index 2386d23..dc4afca 100644
--- a/lib/toaster/bldcontrol/models.py
+++ b/lib/toaster/bldcontrol/models.py
@@ -113,6 +113,15 @@ class BuildRequest(models.Model):
     created     = models.DateTimeField(auto_now_add = True)
     updated     = models.DateTimeField(auto_now = True)
 
+    def get_duration(self):
+        return (self.updated - self.created).total_seconds()
+
+    def get_sorted_target_list(self):
+        tgts = self.brtarget_set.order_by( 'target' );
+        return( tgts );
+
+    def get_machine(self):
+        return self.brvariable_set.get(name="MACHINE").value
 
 # These tables specify the settings for running an actual build.
 # They MUST be kept in sync with the tables in orm.models.Project*
diff --git a/lib/toaster/toastergui/templates/buildrequestdetails.html b/lib/toaster/toastergui/templates/buildrequestdetails.html
new file mode 100644
index 0000000..2a4571f
--- /dev/null
+++ b/lib/toaster/toastergui/templates/buildrequestdetails.html
@@ -0,0 +1,67 @@
+{% extends "baseprojectpage.html" %}
+
+{% load static %}
+{% load projecttags %}
+{% load humanize %}
+
+{% block localbreadcrumb %}
+<li> {{buildrequest.get_sorted_target_list.0.target}} {%if buildrequest.brtarget_set.all.count > 1%}(+ {{buildrequest.brtarget_set.all.count|add:"-1"}}){%endif%} {{buildrequest.get_machine}} ({{buildrequest.updated|date:"d/m/y H:i"}}) </li>
+{% endblock %}
+
+{% block projectinfomain %}
+      <!-- begin content -->
+
+          <div class="row-fluid">
+
+            <!-- end left sidebar container -->
+            <!-- Begin right container -->
+            <div class="span10">
+              <div class="page-header">
+                <h1>
+ <span data-toggle="tooltip" {%if buildrequest.brtarget_set.all.count > 1%}title="Targets: {%for target in buildrequest.brtarget_set.all%}{{target.target}} {%endfor%}"{%endif%}>{{buildrequest.brtarget_set.all.0.target}} {%if buildrequest.brtarget_set.all.count > 1%}(+ {{buildrequest.brtarget_set.all.count|add:"-1"}}){%endif%} {{buildrequest.get_machine}} </span>
+
+        </h1>
+              </div>
+              <div class="alert alert-error">
+                <p class="lead">
+                  <strong>Failed</strong>
+                    on {{ buildrequest.updated|date:'d/m/y H:i' }}
+            with
+
+                                    <i class="icon-minus-sign error" style="margin-left:6px;"></i>
+                  <strong><a class="error accordion-toggle toggle-errors" href="#errors">
+                        {{buildrequest.brerror_set.all.count}} error{{buildrequest.brerror_set.all.count|pluralize}}
+              </a></strong>
+                  <span class="pull-right">Build time: {{buildrequest.get_duration|sectohms}}</span>
+                </p>
+              </div>
+
+              <div class="accordion" id="errors" name="errors">
+                <div class="accordion-group">
+                  <div class="accordion-heading">
+                    <a class="accordion-toggle error toggle-errors">
+                      <h2>
+                        <i class="icon-minus-sign"></i>
+                        {{buildrequest.brerror_set.all.count}} error{{buildrequest.brerror_set.all.count|pluralize}}
+                      </h2>
+                    </a>
+                  </div>
+                  <div class="accordion-body collapse in" id="collapse-errors">
+                    <div class="accordion-inner">
+                      <div class="span10">
+               {% for error in buildrequest.brerror_set.all %}
+                        <div class="alert alert-error">
+                          ERROR: <div class="air well"><pre>{{error.errmsg}}</pre></div>
+                        </div>
+                      {% endfor %}
+                      </div>
+                    </div>
+                  </div>
+
+                </div>
+              </div>
+            </div>
+          </div> <!-- end of row-fluid -->
+
+
+{%endblock%}
diff --git a/lib/toaster/toastergui/templates/managed_builds.html b/lib/toaster/toastergui/templates/managed_builds.html
index 5944dc4..183be76 100644
--- a/lib/toaster/toastergui/templates/managed_builds.html
+++ b/lib/toaster/toastergui/templates/managed_builds.html
@@ -35,10 +35,10 @@
     </div>
 
 
-  {% else %}
+  {% else %} {# We have builds to display #}
   {% include "basetable_top_buildprojects.html" %}
         <!-- Table data rows; the order needs to match the order of "tablecols" definitions; and the <td class value needs to match the tablecols clclass value for show/hide buttons to work -->
-        {% for br in objects %}{% if br.build %}  {% with build=br.build %} {# if we have a build, just display it #}
+        {% for buildrequest in objects %}{% if buildrequest.build %}  {% with build=buildrequest.build %} {# if we have a build, just display it #}
         <tr class="data">
             <td class="outcome"><a href="{% url "builddashboard" build.id %}">{%if build.outcome == build.SUCCEEDED%}<i class="icon-ok-sign success"></i>{%elif build.outcome == build.FAILED%}<i class="icon-minus-sign error"></i>{%else%}{%endif%}</a></td>
             <td class="target">{% for t in build.target_set.all %} <a href="{% url "builddashboard" build.id %}"> {{t.target}} </a> <br />{% endfor %}</td>
@@ -61,7 +61,7 @@
             <td class="errors_no">
                 {% if  build.errors_no %}
                     <a class="errors_no error" href="{% url "builddashboard" build.id %}#errors">{{build.errors_no}} error{{build.errors_no|pluralize}}</a>
-                    {% if MANAGED and build.project %}
+                    {% if MANAGED and build.project and build.buildartifact_set.count %}
                         <a href="{% url 'build_artifact' build.id "cookerlog" build.id %}">
                             <i class="icon-download-alt" title="" data-original-title="Download build log"></i>
                         </a>
@@ -96,21 +96,21 @@
         <tr class="data">
             <td class="outcome">{% if buildrequest.state == buildrequest.REQ_FAILED %}<i class="icon-minus-sign error"></i>{%else%}FIXME_build_request_state{%endif%}</td>
             <td class="target">
-                <span data-toggle="tooltip" {%if br.brtarget_set.all.count > 1%}title="Targets: {%for target in br.brtarget_set.all%}{{target.target}} {%endfor%}"{%endif%}>{{br.brtarget_set.all.0.target}} {%if br.brtarget_set.all.count > 1%}(+ {{br.brtarget_set.all.count|add:"-1"}}){%endif%} </span>
+                <a href="{% url "buildrequestdetails" buildrequest.project.id buildrequest.id %}"><span data-toggle="tooltip" {%if buildrequest.brtarget_set.all.count > 1%}title="Targets: {%for target in buildrequest.brtarget_set.all%}{{target.target}} {%endfor%}"{%endif%}>{{buildrequest.brtarget_set.all.0.target}} {%if buildrequest.brtarget_set.all.count > 1%}(+ {{buildrequest.brtarget_set.all.count|add:"-1"}}){%endif%} </span></a>
             </td>
             <td class="machine">
-                {{br.machine}}
+                <a href="{% url "buildrequestdetails" buildrequest.project.id buildrequest.id %}">{{buildrequest.machine}}</a>
             </td>
             <td class="started_on">
-                {{br.created|date:"d/m/y H:i"}}
+                <a href="{% url "buildrequestdetails" buildrequest.project.id buildrequest.id %}">{{buildrequest.created|date:"d/m/y H:i"}}</a>
             </td>
             <td class="completed_on">
-                {{br.updated|date:"d/m/y H:i"}}
+                <a href="{% url "buildrequestdetails" buildrequest.project.id buildrequest.id %}">{{buildrequest.updated|date:"d/m/y H:i"}}</a>
             </td>
             <td class="failed_tasks error">
-                {{br.brerror_set.all.0.errmsg|whitespace_slice:":32"}}
             </td>
             <td class="errors_no">
+                <a class="errors_no error" href="{% url "buildrequestdetails" buildrequest.project.id buildrequest.id %}#errors">{{buildrequest.brerror_set.all.count}} error{{buildrequest.brerror_set.all.count|pluralize}}</a>
             </td>
             <td class="warnings_no">
             </td>
@@ -120,7 +120,7 @@
             <td class="output"> {# we have no output here #}
             </td>
             <td class="project">
-                <a href="{% url 'project' br.project.id %}">{{br.project.name}}</a>
+                <a href="{% url 'project' buildrequest.project.id %}">{{buildrequest.project.name}}</a>
             </td>
         </tr>
           {%endif%}
diff --git a/lib/toaster/toastergui/templates/managed_mrb_section.html b/lib/toaster/toastergui/templates/managed_mrb_section.html
index da5a3f7..d2ffdcd 100644
--- a/lib/toaster/toastergui/templates/managed_mrb_section.html
+++ b/lib/toaster/toastergui/templates/managed_mrb_section.html
@@ -26,7 +26,7 @@
                 <a href="{%url 'builddashboard' build.pk%}" class="{%if build.outcome == build.SUCCEEDED %}success{%else%}error{%endif%}">
     {% endif %}
                 <span data-toggle="tooltip" {%if build.target_set.all.count > 1%}title="Targets: {%for target in build.target_set.all%}{{target.target}} {%endfor%}"{%endif%}>{{build.target_set.all.0.target}} {%if build.target_set.all.count > 1%}(+ {{build.target_set.all.count|add:"-1"}}){%endif%}
-		        </span>
+                </span>
     {%if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
                 </a>
     {% endif %}
@@ -71,24 +71,42 @@
 
   {% else %}  {# we use the project's page recent build design #}
 
-  <div class="alert {% if buildrequest.state  == buildrequest.REQ_FAILED %}alert-error{% else %}alert-info{% endif %}">
-    <div class="row-fluid">
 
 
+
+  <div class="alert {% if buildrequest.state  == buildrequest.REQ_FAILED %}alert-error{% else %}alert-info{% endif %} project-name">
+       <span class="label label-danger"> {{buildrequest.project.name}} </span>
+    <div class="row-fluid">
+
           {% if buildrequest.state == buildrequest.REQ_FAILED %}
-            <div class="lead span3">
-                <span data-toggle="tooltip" {%if buildrequest.brtarget_set.all.count > 1%}title="Targets: {%for target in buildrequest.brtarget_set.all%}{{target.target}} {%endfor%}"{%endif%}>{{buildrequest.brtarget_set.all.0.target}} {%if buildrequest.brtarget_set.all.count > 1%}(+ {{buildrequest.brtarget_set.all.count|add:"-1"}}){%endif%} </span>
+            <div class="span3 lead">
+                <a href="{%url 'buildrequestdetails' buildrequest.project.id buildrequest.pk%}" class="error">
+                  <span data-toggle="tooltip" {%if buildrequest.brtarget_set.all.count > 1%}title="Targets: {%for target in buildrequest.brtarget_set.all%}{{target.target}} {%endfor%}"{%endif%}>{{buildrequest.brtarget_set.all.0.target}} {%if buildrequest.brtarget_set.all.count > 1%}(+ {{buildrequest.brtarget_set.all.count|add:"-1"}}){%endif%} </span>
+                </a>
+            </div>
+            <div class="span2 lead">
+                {% if buildrequest.updated|format_build_date  %}
+                    {{ buildrequest.updated|date:'d/m/y H:i' }}
+                {% else %}
+                    {{ buildrequest.updated|date:'H:i' }}
+                {% endif %}
+            </div>
+            <div class="span2 lead">
+      {% if  buildrequest.brerror_set.all.count %}
+                <i class="icon-minus-sign red"></i> <a href="{%url 'buildrequestdetails' buildrequest.project.id buildrequest.pk %}#errors" class="error">{{buildrequest.brerror_set.all.count}} error{{buildrequest.brerror_set.all.count|pluralize}}</a>
+      {% endif %}
             </div>
-            <div >
+            <div class="span2 lead"> {# there are no warnings for buildrequests #}
             </div>
-            <div class="row-fluid">
-              {% for e in buildrequest.brerror_set.all|slice:":3" %}
-              <div class="air well">
-                    <pre>{{e.errmsg|whitespace_slice:":150"}}</pre>
-              </div>
-              {% endfor %}
+            <div class="lead ">
+              <span class="lead{%if not MANAGED or not buildrequest.project%} pull-right{%endif%}">
+                Build time: <a href="{% url 'buildrequestdetails' buildrequest.project.id buildrequest.pk %}">{{ buildrequest.get_duration|sectohms }}</a>
+              </span>
+              <button class="btn btn-danger pull-right" onclick='scheduleBuild({% url 'xhr_projectbuild' buildrequest.project.id as bpi%}{{bpi|json}}, {{buildrequest.project.name|json}}, {{buildrequest.get_sorted_target_list|mapselect:'target'|json}})'>Run again</button>
+
             </div>
 
+
          {% elif buildrequest.state == buildrequest.REQ_QUEUED %}
 
             <div class="lead span5">
diff --git a/lib/toaster/toastergui/templates/projectbuilds.html b/lib/toaster/toastergui/templates/projectbuilds.html
index 8f9172c..2a8bd58 100644
--- a/lib/toaster/toastergui/templates/projectbuilds.html
+++ b/lib/toaster/toastergui/templates/projectbuilds.html
@@ -13,11 +13,11 @@
                      No builds found
 
  {% else %}
-	{% if  request.GET.filter or request.GET.search  %}
-			{{objects.paginator.count}} builds found
-	{% else %}
+    {% if  request.GET.filter or request.GET.search  %}
+            {{objects.paginator.count}} builds found
+    {% else %}
                         Project builds <small>({{objects.paginator.count}})</small>
-	{% endif %}
+    {% endif %}
  {% endif %}
                         <i class="icon-question-sign get-help heading-help" title="This page lists all the builds for the current project"></i>
                     </h1>
@@ -89,23 +89,23 @@
 
 
         <tr class="data">
-            <td class="outcome">{% if buildrequest.state == buildrequest.REQ_FAILED %}<i class="icon-minus-sign error"></i>{%else%}FIXME_build_request_state{%endif%}</td>
+            <td class="outcome">{% if br.state == br.REQ_FAILED %}<i class="icon-minus-sign error"></i>{%else%}FIXME_build_request_state{%endif%}</td>
             <td class="target">
-                <span data-toggle="tooltip" {%if br.brtarget_set.all.count > 1%}title="Targets: {%for target in br.brtarget_set.all%}{{target.target}} {%endfor%}"{%endif%}>{{br.brtarget_set.all.0.target}} {%if br.brtarget_set.all.count > 1%}(+ {{br.brtarget_set.all.count|add:"-1"}}){%endif%} </span>
+                <a href="{% url "buildrequestdetails" br.project.id br.id %}"><span data-toggle="tooltip" {%if br.brtarget_set.all.count > 1%}title="Targets: {%for target in br.brtarget_set.all%}{{target.target}} {%endfor%}"{%endif%}>{{br.brtarget_set.all.0.target}} {%if br.brtarget_set.all.count > 1%}(+ {{br.brtarget_set.all.count|add:"-1"}}){%endif%} </span></a>
             </td>
             <td class="machine">
-                {{br.machine}}
+                <a href="{% url "buildrequestdetails" br.project.id br.id %}">{{br.machine}}</a>
             </td>
             <td class="started_on">
-                {{br.created|date:"d/m/y H:i"}}
+                <a href="{% url "buildrequestdetails" br.project.id br.id %}">{{br.created|date:"d/m/y H:i"}}</a>
             </td>
             <td class="completed_on">
-                {{br.updated|date:"d/m/y H:i"}}
+                <a href="{% url "buildrequestdetails" br.project.id br.id %}">{{br.updated|date:"d/m/y H:i"}}</a>
             </td>
             <td class="failed_tasks error">
-                {{br.brerror_set.all.0.errmsg|whitespace_slice:":32"}}
             </td>
             <td class="errors_no">
+        <a class="errors_no error" href="{% url "buildrequestdetails" br.project.id br.id %}#errors">{{br.brerror_set.all.count}} error{{br.brerror_set.all.count|pluralize}}</a>
             </td>
             <td class="warnings_no">
             </td>
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index 8c3b5a8..1c83090 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -97,6 +97,8 @@ urlpatterns = patterns('toastergui.views',
         url(r'^xhr_importlayer/$', 'xhr_importlayer', name='xhr_importlayer'),
         url(r'^xhr_updatelayer/$', 'xhr_updatelayer', name='xhr_updatelayer'),
 
+        # dashboard for failed build requests
+        url(r'^project/(?P<pid>\d+)/buildrequest/(?P<brid>\d+)$', 'buildrequestdetails', name='buildrequestdetails'),
 
         # default redirection
         url(r'^$', RedirectView.as_view( url= 'landing')),
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index e718ced..6ccbf54 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -22,7 +22,7 @@
 import operator,re
 import HTMLParser
 
-from django.db.models import Q, Sum
+from django.db.models import Q, Sum, Count
 from django.db import IntegrityError
 from django.shortcuts import render, redirect
 from orm.models import Build, Target, Task, Layer, Layer_Version, Recipe, LogMessage, Variable
@@ -117,7 +117,8 @@ def _redirect_parameters(view, g, mandatory_parameters, *args, **kwargs):
     return redirect(url + "?%s" % urllib.urlencode(params), *args, **kwargs)
 
 FIELD_SEPARATOR = ":"
-VALUE_SEPARATOR = "!"
+AND_VALUE_SEPARATOR = "!"
+OR_VALUE_SEPARATOR = "|"
 DESCENDING = "-"
 
 def __get_q_for_val(name, value):
@@ -126,20 +127,31 @@ def __get_q_for_val(name, value):
     if "AND" in value:
         return reduce(operator.and_, map(lambda x: __get_q_for_val(name, x), [ x for x in value.split("AND") ]))
     if value.startswith("NOT"):
-        kwargs = { name : value.strip("NOT") }
+        value = value[3:]
+        if value == 'None':
+            value = None
+        kwargs = { name : value }
         return ~Q(**kwargs)
     else:
+        if value == 'None':
+            value = None
         kwargs = { name : value }
         return Q(**kwargs)
 
 def _get_filtering_query(filter_string):
 
     search_terms = filter_string.split(FIELD_SEPARATOR)
-    keys = search_terms[0].split(VALUE_SEPARATOR)
-    values = search_terms[1].split(VALUE_SEPARATOR)
+    and_keys = search_terms[0].split(AND_VALUE_SEPARATOR)
+    and_values = search_terms[1].split(AND_VALUE_SEPARATOR)
+
+    and_query = []
+    for kv in zip(and_keys, and_values):
+        or_keys = kv[0].split(OR_VALUE_SEPARATOR)
+        or_values = kv[1].split(OR_VALUE_SEPARATOR)
+        querydict = dict(zip(or_keys, or_values))
+        and_query.append(reduce(operator.or_, map(lambda x: __get_q_for_val(x, querydict[x]), [k for k in querydict])))
 
-    querydict = dict(zip(keys, values))
-    return reduce(operator.and_, map(lambda x: __get_q_for_val(x, querydict[x]), [k for k in querydict]))
+    return reduce(operator.and_, [k for k in and_query])
 
 def _get_toggle_order(request, orderkey, reverse = False):
     if reverse:
@@ -169,13 +181,13 @@ def _validate_input(input, model):
             return None, invalid
 
         # Check we have an equal number of terms both sides of the colon
-        if len(input_list[0].split(VALUE_SEPARATOR)) != len(input_list[1].split(VALUE_SEPARATOR)):
+        if len(input_list[0].split(AND_VALUE_SEPARATOR)) != len(input_list[1].split(AND_VALUE_SEPARATOR)):
             invalid = "Not all arg names got values"
             return None, invalid + str(input_list)
 
         # Check we are looking for a valid field
         valid_fields = model._meta.get_all_field_names()
-        for field in input_list[0].split(VALUE_SEPARATOR):
+        for field in input_list[0].split(AND_VALUE_SEPARATOR):
             if not reduce(lambda x, y: x or y, map(lambda x: field.startswith(x), [ x for x in valid_fields ])):
                 return None, (field, [ x for x in valid_fields ])
 
@@ -216,6 +228,7 @@ def _search_tuple(request, model):
 def _get_queryset(model, queryset, filter_string, search_term, ordering_string, ordering_secondary=''):
     if filter_string:
         filter_query = _get_filtering_query(filter_string)
+#        raise Exception(filter_query)
         queryset = queryset.filter(filter_query)
     else:
         queryset = queryset.all()
@@ -1780,12 +1793,13 @@ if toastermain.settings.MANAGED:
         # for that object type. copypasta for all needed table searches
         (filter_string, search_term, ordering_string) = _search_tuple(request, BuildRequest)
         # we don't display in-progress or deleted builds
-        queryset_all = buildrequests
-        queryset_with_search = _get_queryset(BuildRequest, queryset_all, None, search_term, ordering_string, '-updated')
-        queryset = _get_queryset(BuildRequest, queryset_all, filter_string, search_term, ordering_string, '-updated')
+        queryset_all = buildrequests.exclude(state = BuildRequest.REQ_DELETED)
+        queryset_all = queryset_all.annotate(Count('brerror'))
+        queryset_with_search = _get_queryset(BuildRequest, queryset_all, filter_string, search_term, ordering_string, '-updated')
+
 
         # retrieve the objects that will be displayed in the table; builds a paginator and gets a page range to display
-        build_info = _build_page_range(Paginator(queryset, pagesize), request.GET.get('page', 1))
+        build_info = _build_page_range(Paginator(queryset_with_search, pagesize), request.GET.get('page', 1))
 
         # build view-specific information; this is rendered specifically in the builds page, at the top of the page (i.e. Recent builds)
         # most recent build is like projects' most recent builds, but across all projects
@@ -1842,8 +1856,8 @@ if toastermain.settings.MANAGED:
                      'filter' : {'class' : 'outcome',
                                  'label': 'Show:',
                                  'options' : [
-                                             ('Successful builds', 'state:' + str(BuildRequest.REQ_COMPLETED), queryset_with_search.filter(state=str(BuildRequest.REQ_COMPLETED)).count()),  # this is the field search expression
-                                             ('Failed builds', 'state:'+ str(BuildRequest.REQ_FAILED), queryset_with_search.filter(state=str(BuildRequest.REQ_FAILED)).count()),
+                                             ('Successful builds', 'state:' + str(BuildRequest.REQ_COMPLETED), queryset_all.filter(state=str(BuildRequest.REQ_COMPLETED)).count()),  # this is the field search expression
+                                             ('Failed builds', 'state:'+ str(BuildRequest.REQ_FAILED), queryset_all.filter(state=str(BuildRequest.REQ_FAILED)).count()),
                                              ]
                                 }
                     },
@@ -1865,9 +1879,9 @@ if toastermain.settings.MANAGED:
                      'filter' : {'class' : 'created',
                                  'label': 'Show:',
                                  'options' : [
-                                             ("Today's builds" , 'created__gte:'+timezone.now().strftime("%Y-%m-%d"), queryset_with_search.filter(created__gte=timezone.now()).count()),
-                                             ("Yesterday's builds", 'created__gte:'+(timezone.now()-timedelta(hours=24)).strftime("%Y-%m-%d"), queryset_with_search.filter(created__gte=(timezone.now()-timedelta(hours=24))).count()),
-                                             ("This week's builds", 'created__gte:'+(timezone.now()-timedelta(days=7)).strftime("%Y-%m-%d"), queryset_with_search.filter(created__gte=(timezone.now()-timedelta(days=7))).count()),
+                                             ("Today's builds" , 'created__gte:'+timezone.now().strftime("%Y-%m-%d"), queryset_all.filter(created__gte=timezone.now()).count()),
+                                             ("Yesterday's builds", 'created__gte:'+(timezone.now()-timedelta(hours=24)).strftime("%Y-%m-%d"), queryset_all.filter(created__gte=(timezone.now()-timedelta(hours=24))).count()),
+                                             ("This week's builds", 'created__gte:'+(timezone.now()-timedelta(days=7)).strftime("%Y-%m-%d"), queryset_all.filter(created__gte=(timezone.now()-timedelta(days=7))).count()),
                                              ]
                                 }
                     },
@@ -1879,9 +1893,9 @@ if toastermain.settings.MANAGED:
                      'filter' : {'class' : 'updated',
                                  'label': 'Show:',
                                  'options' : [
-                                             ("Today's builds", 'updated__gte:'+timezone.now().strftime("%Y-%m-%d"), queryset_with_search.filter(updated__gte=timezone.now()).count()),
-                                             ("Yesterday's builds", 'updated__gte:'+(timezone.now()-timedelta(hours=24)).strftime("%Y-%m-%d"), queryset_with_search.filter(updated__gte=(timezone.now()-timedelta(hours=24))).count()),
-                                             ("This week's builds", 'updated__gte:'+(timezone.now()-timedelta(days=7)).strftime("%Y-%m-%d"), queryset_with_search.filter(updated__gte=(timezone.now()-timedelta(days=7))).count()),
+                                             ("Today's builds", 'updated__gte:'+timezone.now().strftime("%Y-%m-%d"), queryset_all.filter(updated__gte=timezone.now()).count()),
+                                             ("Yesterday's builds", 'updated__gte:'+(timezone.now()-timedelta(hours=24)).strftime("%Y-%m-%d"), queryset_all.filter(updated__gte=(timezone.now()-timedelta(hours=24))).count()),
+                                             ("This week's builds", 'updated__gte:'+(timezone.now()-timedelta(days=7)).strftime("%Y-%m-%d"), queryset_all.filter(updated__gte=(timezone.now()-timedelta(days=7))).count()),
                                              ]
                                 }
                     },
@@ -1890,8 +1904,10 @@ if toastermain.settings.MANAGED:
                      'filter' : {'class' : 'failed_tasks',
                                  'label': 'Show:',
                                  'options' : [
-                                             ('Build with failed tasks', 'build__task_build__outcome:4', queryset_with_search.filter(build__task_build__outcome=4).count()),
-                                             ('Build without failed tasks', 'build__task_build__outcome:NOT4', queryset_with_search.filter(~Q(build__task_build__outcome=4)).count()),
+                                             ('Builds with failed tasks', 'build__task_build__outcome:%d' % Task.OUTCOME_FAILED,
+                                                queryset_all.filter(build__task_build__outcome=Task.OUTCOME_FAILED).count()),
+                                             ('Builds without failed tasks', 'build__task_build__outcome:%d' % Task.OUTCOME_FAILED,
+                                                queryset_all.filter(~Q(build__task_build__outcome=Task.OUTCOME_FAILED)).count()),
                                              ]
                                 }
                     },
@@ -1903,8 +1919,10 @@ if toastermain.settings.MANAGED:
                      'filter' : {'class' : 'errors_no',
                                  'label': 'Show:',
                                  'options' : [
-                                             ('Build with errors', 'build__errors_no__gte:1', queryset_with_search.filter(build__errors_no__gte=1).count()),
-                                             ('Build without errors', 'build__errors_no:0', queryset_with_search.filter(build__errors_no=0).count()),
+                                             ('Builds with errors', 'build|build__errors_no__gt:None|0',
+                                                queryset_all.filter(Q(build=None) | Q(build__errors_no__gt=0)).count()),
+                                             ('Builds without errors', 'build__errors_no:0',
+                                                queryset_all.filter(build__errors_no=0).count()),
                                              ]
                                 }
                     },
@@ -1916,8 +1934,8 @@ if toastermain.settings.MANAGED:
                      'filter' : {'class' : 'build__warnings_no',
                                  'label': 'Show:',
                                  'options' : [
-                                             ('Build with warnings','build__warnings_no__gte:1', queryset_with_search.filter(build__warnings_no__gte=1).count()),
-                                             ('Build without warnings','build__warnings_no:0', queryset_with_search.filter(build__warnings_no=0).count()),
+                                             ('Builds with warnings','build__warnings_no__gte:1', queryset_all.filter(build__warnings_no__gte=1).count()),
+                                             ('Builds without warnings','build__warnings_no:0', queryset_all.filter(build__warnings_no=0).count()),
                                              ]
                                 }
                     },
@@ -2016,7 +2034,7 @@ if toastermain.settings.MANAGED:
 
         context = {
             "project" : prj,
-            "completedbuilds": Build.objects.filter(project = prj).exclude(outcome = Build.IN_PROGRESS),
+            "completedbuilds": BuildRequest.objects.filter(project_id = pid).exclude(state__lte = BuildRequest.REQ_INPROGRESS).exclude(state=BuildRequest.REQ_DELETED),
             "prj" : {"name": prj.name, "release": { "id": prj.release.pk, "name": prj.release.name, "desc": prj.release.description}},
             #"buildrequests" : prj.buildrequest_set.filter(state=BuildRequest.REQ_QUEUED),
             "builds" : _project_recent_build_list(prj),
@@ -2061,7 +2079,7 @@ if toastermain.settings.MANAGED:
         try:
             if request.method != "POST":
                 raise BadParameterException("invalid method")
-			request.session['project_id'] = pid
+            request.session['project_id'] = pid
             prj = Project.objects.get(id = pid)
 
 
@@ -2167,11 +2185,11 @@ if toastermain.settings.MANAGED:
         try:
             prj = None
             if request.GET.has_key('project_id'):
-				prj = Project.objects.get(pk = request.GET['project_id'])
+                prj = Project.objects.get(pk = request.GET['project_id'])
             elif 'project_id' in request.session:
                 prj = Project.objects.get(pk = request.session['project_id'])
-			else:
-				raise Exception("No valid project selected")
+            else:
+                raise Exception("No valid project selected")
 
 
             def _lv_to_dict(x):
@@ -2819,10 +2837,10 @@ if toastermain.settings.MANAGED:
 
         vars_blacklist  = {
             'DL_DR','PARALLEL_MAKE','BB_NUMBER_THREADS','SSTATE_DIR',
-			'BB_DISKMON_DIRS','BB_NUMBER_THREADS','CVS_PROXY_HOST','CVS_PROXY_PORT',
-			'DL_DIR','PARALLEL_MAKE','SSTATE_DIR','SSTATE_DIR','SSTATE_MIRRORS','TMPDIR',
-			'all_proxy','ftp_proxy','http_proxy ','https_proxy'
-			}
+            'BB_DISKMON_DIRS','BB_NUMBER_THREADS','CVS_PROXY_HOST','CVS_PROXY_PORT',
+            'DL_DIR','PARALLEL_MAKE','SSTATE_DIR','SSTATE_DIR','SSTATE_MIRRORS','TMPDIR',
+            'all_proxy','ftp_proxy','http_proxy ','https_proxy'
+            }
 
         vars_fstypes  = {
             'btrfs','cpio','cpio.gz','cpio.lz4','cpio.lzma','cpio.xz','cramfs',
@@ -2874,7 +2892,7 @@ if toastermain.settings.MANAGED:
 
     def projectbuilds(request, pid):
         template = 'projectbuilds.html'
-        buildrequests = BuildRequest.objects.exclude(project_id = pid, state__lte = BuildRequest.REQ_INPROGRESS).exclude(state=BuildRequest.REQ_DELETED)
+        buildrequests = BuildRequest.objects.filter(project_id = pid).exclude(state__lte = BuildRequest.REQ_INPROGRESS).exclude(state=BuildRequest.REQ_DELETED)
 
         try:
             context, pagesize, orderby = _build_list_helper(request, buildrequests)
@@ -3012,6 +3030,14 @@ if toastermain.settings.MANAGED:
             }
         return render(request, template, context)
 
+    def buildrequestdetails(request, pid, brid):
+        template = "buildrequestdetails.html"
+        context = {
+            'buildrequest' : BuildRequest.objects.get(pk = brid, project_id = pid)
+        }
+        return render(request, template, context)
+
+
 else:
     # these are pages that are NOT available in interactive mode
     def managedcontextprocessor(request):
@@ -3256,3 +3282,6 @@ else:
 
     def xhr_updatelayer(request):
         raise Exception("page not available in interactive mode")
+
+    def buildrequestdetails(request, pid, brid):
+        raise Exception("page not available in interactive mode")
-- 
1.9.1


