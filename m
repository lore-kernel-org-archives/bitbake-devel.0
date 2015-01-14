Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f180.google.com (mail-pd0-f180.google.com
	[209.85.192.180])
	by mail.openembedded.org (Postfix) with ESMTP id D17E4721E2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Jan 2015 12:46:58 +0000 (UTC)
Received: by mail-pd0-f180.google.com with SMTP id fl12so9607627pdb.11
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Jan 2015 04:46:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=ss57oaOPVuBCE2yQRJ37ZUiw34gG7OXInFIvqWBWU6Y=;
	b=OyzTzQWgNcFq86jnptSySJ3lwQTWrbCHpbm3ukeyN3SGb/EefpXwOfgDaYvnsohdOL
	LSDzojxz6GqeVPBkkXxPb/6oFPvoGBTt7J/T+4JSrKeZbJ+Kfh1Rjj7j/In3PMbIKyZu
	ttlLmH7Bu2e9kgVraVPV2ECM6lrk907lUpDhv6RbyEZsPIh8dllLIxrP48VQoVZnR+06
	J0DadjIDqoPC64HQbkVnxmiwWBr9h9mzygD+ba31jp+PjsydDI4Wiz+NJfv72ZE756v+
	o7uGuQPgZF6g8Oci+yfmjotz9zovn00G9V/fCD13QFPj2BDswTf0c/4T0EMEQy1yio42
	51Yg==
X-Gm-Message-State: ALoCoQkCPXDOQQRbYKjT0bjTOyiFIhDYkQU1XQmMqzLnXpJxNhearRFAP1MeFpqu/zI22yRbBr7f
X-Received: by 10.68.130.225 with SMTP id oh1mr5232051pbb.157.1421239619625;
	Wed, 14 Jan 2015 04:46:59 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id r1sm19749829pdb.24.2015.01.14.04.46.57
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 14 Jan 2015 04:46:58 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id EE28D56224B; Wed, 14 Jan 2015 12:46:56 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Jan 2015 12:46:54 +0000
Message-Id: <203ffa604f5b39217fb3b414652e5a7b4b3ee2b2.1421239131.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <37d047c01cabee67a55e0750bfe51ec407be6b09.1421239131.git.alexandru.damian@intel.com>
References: <37d047c01cabee67a55e0750bfe51ec407be6b09.1421239131.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1421239131.git.alexandru.damian@intel.com>
References: <cover.1421239131.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 3/4] toastergui: all builds page lists failed build requests
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
X-List-Received-Date: Wed, 14 Jan 2015 12:47:01 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch modifies the all builds page by splitting the page
into two variants - the "interactive" (default) and "managed" mode
versions.

In the "managed" mode version, we display build requests instead of
builds, including the failed build requests that have no build
associated with them.

[YOCTO #6671]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 .../toastergui/templates/managed_builds.html       | 135 +++++
 .../toastergui/templates/managed_mrb_section.html  | 172 ++++++
 lib/toaster/toastergui/templatetags/projecttags.py |  19 +
 lib/toaster/toastergui/views.py                    | 615 ++++++++++++++-------
 4 files changed, 742 insertions(+), 199 deletions(-)
 create mode 100644 lib/toaster/toastergui/templates/managed_builds.html
 create mode 100644 lib/toaster/toastergui/templates/managed_mrb_section.html

diff --git a/lib/toaster/toastergui/templates/managed_builds.html b/lib/toaster/toastergui/templates/managed_builds.html
new file mode 100644
index 0000000..5944dc4
--- /dev/null
+++ b/lib/toaster/toastergui/templates/managed_builds.html
@@ -0,0 +1,135 @@
+{% extends "base.html" %}
+
+{% load static %}
+{% load projecttags %}
+{% load humanize %}
+
+{% block pagecontent %}
+<div class="row-fluid">
+
+  {% include "managed_mrb_section.html" %}
+
+
+  {% if 1 %}
+  <div class="page-header top-air">
+     <h1>
+      {% if request.GET.filter and objects.paginator.count > 0 or request.GET.search and objects.paginator.count > 0 %}
+          {{objects.paginator.count}} build{{objects.paginator.count|pluralize}} found
+      {%elif request.GET.filter and objects.paginator.count == 0 or request.GET.search and objects.paginator.count == 0 %}
+          No builds found
+      {%else%}
+          All builds
+      {%endif%}
+     </h1>
+  </div>
+
+  {% if objects.paginator.count == 0 %}
+    <div class="row-fluid">
+      <div class="alert">
+        <form class="no-results input-append" id="searchform">
+            <input id="search" name="search" class="input-xxlarge" type="text" value="{{request.GET.search}}"/>{% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>{% endif %}
+            <button class="btn" type="submit" value="Search">Search</button>
+            <button class="btn btn-link" onclick="javascript:$('#search').val('');searchform.submit()">Show all builds</button>
+        </form>
+      </div>
+    </div>
+
+
+  {% else %}
+  {% include "basetable_top_buildprojects.html" %}
+        <!-- Table data rows; the order needs to match the order of "tablecols" definitions; and the <td class value needs to match the tablecols clclass value for show/hide buttons to work -->
+        {% for br in objects %}{% if br.build %}  {% with build=br.build %} {# if we have a build, just display it #}
+        <tr class="data">
+            <td class="outcome"><a href="{% url "builddashboard" build.id %}">{%if build.outcome == build.SUCCEEDED%}<i class="icon-ok-sign success"></i>{%elif build.outcome == build.FAILED%}<i class="icon-minus-sign error"></i>{%else%}{%endif%}</a></td>
+            <td class="target">{% for t in build.target_set.all %} <a href="{% url "builddashboard" build.id %}"> {{t.target}} </a> <br />{% endfor %}</td>
+            <td class="machine"><a href="{% url "builddashboard" build.id %}">{{build.machine}}</a></td>
+            <td class="started_on"><a href="{% url "builddashboard" build.id %}">{{build.started_on|date:"d/m/y H:i"}}</a></td>
+            <td class="completed_on"><a href="{% url "builddashboard" build.id %}">{{build.completed_on|date:"d/m/y H:i"}}</a></td>
+            <td class="failed_tasks error">
+                {% query build.task_build outcome=4 order__gt=0 as exectask%}
+                    {% if exectask.count == 1 %}
+                        <a href="{% url "task" build.id exectask.0.id %}">{{exectask.0.recipe.name}}.{{exectask.0.task_name}}</a>
+                      {% if MANAGED and build.project %}
+                        <a href="{% url 'build_artifact' build.id "tasklogfile" exectask.0.id %}">
+                            <i class="icon-download-alt" title="" data-original-title="Download task log file"></i>
+                        </a>
+                      {% endif %}
+                    {% elif exectask.count > 1%}
+                        <a href="{% url "tasks" build.id %}?filter=outcome%3A4">{{exectask.count}} task{{exectask.count|pluralize}}</a>
+                    {%endif%}
+            </td>
+            <td class="errors_no">
+                {% if  build.errors_no %}
+                    <a class="errors_no error" href="{% url "builddashboard" build.id %}#errors">{{build.errors_no}} error{{build.errors_no|pluralize}}</a>
+                    {% if MANAGED and build.project %}
+                        <a href="{% url 'build_artifact' build.id "cookerlog" build.id %}">
+                            <i class="icon-download-alt" title="" data-original-title="Download build log"></i>
+                        </a>
+                    {% endif %}
+                {%endif%}
+            </td>
+            <td class="warnings_no">{% if  build.warnings_no %}<a class="warnings_no warning" href="{% url "builddashboard" build.id %}#warnings">{{build.warnings_no}} warning{{build.warnings_no|pluralize}}</a>{%endif%}</td>
+            <td class="time"><a href="{% url "buildtime" build.id %}">{{build.timespent|sectohms}}</a></td>
+            {% if not MANAGED or not build.project %}
+                <td class="log">{{build.cooker_log_path}}</td>
+            {% endif %}
+            <td class="output">
+              {% if build.outcome == build.SUCCEEDED %}
+              <a href="{%url "builddashboard" build.id%}#images">{{fstypes|get_dict_value:build.id}}</a>
+              {% endif %}
+            </td>
+   {% if MANAGED %}
+            <td class="project">
+            {% if build.project %}
+                <a href="{% url 'project' build.project.id %}">{{build.project.name}}</a>
+            {% endif %}
+            </td>
+   {% endif %}
+        </tr>
+
+
+              {%endwith%}
+      {% else %} {# we don't have a build for this build request, mask the data with build request data #}
+
+
+
+        <tr class="data">
+            <td class="outcome">{% if buildrequest.state == buildrequest.REQ_FAILED %}<i class="icon-minus-sign error"></i>{%else%}FIXME_build_request_state{%endif%}</td>
+            <td class="target">
+                <span data-toggle="tooltip" {%if br.brtarget_set.all.count > 1%}title="Targets: {%for target in br.brtarget_set.all%}{{target.target}} {%endfor%}"{%endif%}>{{br.brtarget_set.all.0.target}} {%if br.brtarget_set.all.count > 1%}(+ {{br.brtarget_set.all.count|add:"-1"}}){%endif%} </span>
+            </td>
+            <td class="machine">
+                {{br.machine}}
+            </td>
+            <td class="started_on">
+                {{br.created|date:"d/m/y H:i"}}
+            </td>
+            <td class="completed_on">
+                {{br.updated|date:"d/m/y H:i"}}
+            </td>
+            <td class="failed_tasks error">
+                {{br.brerror_set.all.0.errmsg|whitespace_slice:":32"}}
+            </td>
+            <td class="errors_no">
+            </td>
+            <td class="warnings_no">
+            </td>
+            <td class="time">
+                {{br.timespent.total_seconds|sectohms}}
+            </td>
+            <td class="output"> {# we have no output here #}
+            </td>
+            <td class="project">
+                <a href="{% url 'project' br.project.id %}">{{br.project.name}}</a>
+            </td>
+        </tr>
+          {%endif%}
+        {% endfor %}
+
+
+  {% include "basetable_bottom.html" %}
+  {% endif %} {# objects.paginator.count #}
+{% endif %} {# empty #}
+</div><!-- end row-fluid-->
+
+{% endblock %}
diff --git a/lib/toaster/toastergui/templates/managed_mrb_section.html b/lib/toaster/toastergui/templates/managed_mrb_section.html
new file mode 100644
index 0000000..d4959a0
--- /dev/null
+++ b/lib/toaster/toastergui/templates/managed_mrb_section.html
@@ -0,0 +1,172 @@
+{% load static %}
+{% load projecttags %}
+{% load humanize %}
+
+
+{%if mru.count > 0%}
+
+  <div class="page-header top-air">
+      <h1>
+          Latest builds
+       </h1>
+  </div>
+  <div id="latest-builds">
+  {% for buildrequest in mru %}{% with build=buildrequest.build %}
+
+  {% if build %} {# if we have a build, just display it #}
+
+    <div class="alert {%if build.outcome == build.SUCCEEDED%}alert-success{%elif build.outcome == build.FAILED%}alert-error{%else%}alert-info{%endif%} {% if MANAGED and build.project %}project-name{% endif %} ">
+    {% if MANAGED and build.project %}
+       <span class="label {%if build.outcome == build.SUCCEEDED%}label-success{%elif build.outcome == build.FAILED%}label-danger{%else%}label-info{%endif%}"> {{build.project.name}} </span>
+    {% endif %}
+
+        <div class="row-fluid">
+            <div class="span3 lead">
+    {%if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
+                <a href="{%url 'builddashboard' build.pk%}" class="{%if build.outcome == build.SUCCEEDED %}success{%else%}error{%endif%}">
+    {% endif %}
+                <span data-toggle="tooltip" {%if build.target_set.all.count > 1%}title="Targets: {%for target in build.target_set.all%}{{target.target}} {%endfor%}"{%endif%}>{{build.target_set.all.0.target}} {%if build.target_set.all.count > 1%}(+ {{build.target_set.all.count|add:"-1"}}){%endif%}
+		        </span>
+    {%if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
+                </a>
+    {% endif %}
+            </div>
+            <div class="span2 lead">
+                {% if build.completed_on|format_build_date  %}
+                    {{ build.completed_on|date:'d/m/y H:i' }}
+                {% else %}
+                    {{ build.completed_on|date:'H:i' }}
+                {% endif %}
+            </div>
+    {%if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
+            <div class="span2 lead">
+      {% if  build.errors_no %}
+                <i class="icon-minus-sign red"></i> <a href="{%url 'builddashboard' build.pk%}#errors" class="error">{{build.errors_no}} error{{build.errors_no|pluralize}}</a>
+      {% endif %}
+            </div>
+            <div class="span2 lead">
+      {% if  build.warnings_no %}
+                <i class="icon-warning-sign yellow"></i> <a href="{%url 'builddashboard' build.pk%}#warnings" class="warning">{{build.warnings_no}} warning{{build.warnings_no|pluralize}}</a>
+      {% endif %}
+            </div>
+            <div class="lead ">
+              <span class="lead{%if not MANAGED or not build.project%} pull-right{%endif%}">
+                Build time: <a href="{% url 'buildtime' build.pk %}">{{ build.timespent|sectohms }}</a>
+              </span>
+          {% if MANAGED and build.project %}
+              <a class="btn {%if build.outcome == build.SUCCEEDED%}btn-success{%elif build.outcome == build.FAILED%}btn-danger{%else%}btn-info{%endif%} pull-right" onclick="scheduleBuild({% url 'xhr_projectbuild' build.project.id as bpi%}{{bpi|json}}, {{build.project.name|json}}, {{build.get_sorted_target_list|mapselect:'target'|json}})">Run again</a>
+          {% endif %}
+            </div>
+    {%endif%}
+    {%if build.outcome == build.IN_PROGRESS %}
+            <div class="span4">
+                <div class="progress" style="margin-top:5px;" data-toggle="tooltip" title="{{build.completeper}}% of tasks complete">
+                    <div style="width: {{build.completeper}}%;" class="bar"></div>
+                </div>
+            </div>
+            <div class="lead pull-right">ETA: in {{build.eta|naturaltime}}</div>
+    {%endif%}
+        </div>
+    </div>
+
+  {% else %}  {# we use the project's page recent build design #}
+
+  <div class="alert {% if buildrequest.state  == buildrequest.REQ_FAILED %}alert-error{% else %}alert-info{% endif %}">
+    <div class="row-fluid">
+
+
+          {% if buildrequest.state == buildrequest.REQ_FAILED %}
+            <div class="lead span3">
+                <span data-toggle="tooltip" {%if buildrequest.brtarget_set.all.count > 1%}title="Targets: {%for target in buildrequest.brtarget_set.all%}{{target.target}} {%endfor%}"{%endif%}>{{buildrequest.brtarget_set.all.0.target}} {%if buildrequest.brtarget_set.all.count > 1%}(+ {{buildrequest.brtarget_set.all.count|add:"-1"}}){%endif%} </span>
+            </div>
+            <div >
+            </div>
+            <div class="row-fluid">
+              {% for e in buildrequest.brerror_set.all|slice:":3" %}
+              <div class="air well">
+                    <pre>{{e.errmsg|whitespace_slice:":150"}}</pre>
+              </div>
+              {% endfor %}
+            </div>
+
+         {% elif buildrequest.state == buildrequest.REQ_QUEUED %}
+
+            <div class="lead span5">
+
+                <span data-toggle="tooltip" {%if buildrequest.brtarget_set.all.count > 1%}title="Targets: {%for target in buildrequest.brtarget_set.all%}{{target.target}} {%endfor%}"{%endif%}>{{buildrequest.brtarget_set.all.0.target}} {%if buildrequest.brtarget_set.all.count > 1%}(+ {{buildrequest.brtarget_set.all.count|add:"-1"}}){%endif%} </span>
+            </div>
+            <div class="span4 lead" >Build queued
+              <i title="This build will start as soon as a build server is available" class="icon-question-sign get-help get-help-blue heading-help" data-toggle="tooltip"></i>
+            </div>
+
+         {% elif buildrequest.state == buildrequest.REQ_CREATED %}
+
+            <div class="lead span3">
+                <span data-toggle="tooltip" {%if buildrequest.brtarget_set.all.count > 1%}title="Targets: {%for target in buildrequest.brtarget_set.all%}{{target.target}} {%endfor%}"{%endif%}>{{buildrequest.brtarget_set.all.0.target}} {%if buildrequest.brtarget_set.all.count > 1%}(+ {{buildrequest.brtarget_set.all.count|add:"-1"}}){%endif%} </span>
+            </div>
+            <div class="span6" >
+              <span class="lead">Creating build</span>
+            </div>
+
+         {% elif buildrequest.state == buildrequest.REQ_INPROGRESS %}
+
+                <div class="lead span5">
+                  <span data-toggle="tooltip" {%if buildrequest.brtarget_set.all.count > 1%}title="Targets: {%for target in buildrequest.brtarget_set.all%}{{target.target}} {%endfor%}"{%endif%}>{{buildrequest.brtarget_set.all.0.target}} {%if buildrequest.brtarget_set.all.count > 1%}(+ {{buildrequest.brtarget_set.all.count|add:"-1"}}){%endif%} </span>
+                </div>
+                <div class="span4 lead">
+                  Checking out layers
+                </div>
+          {% else %}
+
+          <div>FIXME!</div>
+
+          {% endif %}
+      <div class="lead pull-right">
+      </div>
+    </div>
+  </div>
+
+
+
+  {% endif %} {# this ends the build request most recent build section #}
+
+{%endwith%}{% endfor %}
+  </div>
+
+<script>
+
+function _makeXHRBuildCall(url, data, onsuccess, onfail) {
+    $.ajax( {
+        type: "POST",
+        url: url,
+        data: data,
+        headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
+        success: function (_data) {
+            if (_data.error != "ok") {
+                alert(_data.error);
+            } else {
+                if (onsuccess != undefined) onsuccess(_data);
+            }
+        },
+        error: function (_data) {
+            alert("Call failed");
+            console.log(_data);
+            if (onfail) onfail(data);
+        } });
+}
+
+
+function scheduleBuild(url, projectName, buildlist) {
+  console.log("scheduleBuild");
+  _makeXHRBuildCall(url, {targets: buildlist.join(" ")}, function (_data) {
+
+      $('#latest-builds').prepend('<div class="alert alert-info" style="padding-top:0px">' + '<span class="label label-info" style="font-weight: normal; margin-bottom: 5px; margin-left:-15px; padding-top:5px;">'+projectName+'</span><div class="row-fluid">' +
+  '<div class="span4 lead">' + buildlist.join(" ") +
+  '</div><div class="span4 lead pull-right">Build queued. Your build will start shortly.</div></div></div>');
+  });
+}
+
+</script>
+
+{%endif%}
+
diff --git a/lib/toaster/toastergui/templatetags/projecttags.py b/lib/toaster/toastergui/templatetags/projecttags.py
index f564edf..276c6eb 100644
--- a/lib/toaster/toastergui/templatetags/projecttags.py
+++ b/lib/toaster/toastergui/templatetags/projecttags.py
@@ -65,6 +65,25 @@ def query(qs, **kwargs):
     """
     return qs.filter(**kwargs)
 
+
+@register.filter("whitespace_slice")
+def whitespace_space_filter(value, arg):
+    try:
+        bits = []
+        for x in arg.split(":"):
+            if len(x) == 0:
+                bits.append(None)
+            else:
+                # convert numeric value to the first whitespace after
+                first_whitespace = value.find(" ", int(x))
+                if first_whitespace == -1:
+                    bits.append(int(x))
+                else:
+                    bits.append(first_whitespace)
+        return value[slice(*bits)]
+    except (ValueError, TypeError):
+        raise
+
 @register.filter
 def divide(value, arg):
     if int(arg) == 0:
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index e414b66..e8e4927 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -255,197 +255,6 @@ def _save_parameters_cookies(response, pagesize, orderby, request):
     return response
 
 
-
-# shows the "all builds" page
-def builds(request):
-    template = 'build.html'
-    # define here what parameters the view needs in the GET portion in order to
-    # be able to display something.  'count' and 'page' are mandatory for all views
-    # that use paginators.
-    (pagesize, orderby) = _get_parameters_values(request, 10, 'completed_on:-')
-    mandatory_parameters = { 'count': pagesize,  'page' : 1, 'orderby' : orderby }
-    retval = _verify_parameters( request.GET, mandatory_parameters )
-    if retval:
-        return _redirect_parameters( 'all-builds', request.GET, mandatory_parameters)
-
-    # boilerplate code that takes a request for an object type and returns a queryset
-    # for that object type. copypasta for all needed table searches
-    (filter_string, search_term, ordering_string) = _search_tuple(request, Build)
-    queryset_all = Build.objects.exclude(outcome = Build.IN_PROGRESS)
-    queryset_with_search = _get_queryset(Build, queryset_all, None, search_term, ordering_string, '-completed_on')
-    queryset = _get_queryset(Build, queryset_all, filter_string, search_term, ordering_string, '-completed_on')
-
-    # retrieve the objects that will be displayed in the table; builds a paginator and gets a page range to display
-    build_info = _build_page_range(Paginator(queryset, pagesize), request.GET.get('page', 1))
-
-    # build view-specific information; this is rendered specifically in the builds page, at the top of the page (i.e. Recent builds)
-    build_mru = Build.objects.order_by("-started_on")[:3]
-
-    # set up list of fstypes for each build
-    fstypes_map = {};
-    for build in build_info:
-        targets = Target.objects.filter( build_id = build.id )
-        comma = "";
-        extensions = "";
-        for t in targets:
-            if ( not t.is_image ):
-                continue
-            tif = Target_Image_File.objects.filter( target_id = t.id )
-            for i in tif:
-                s=re.sub('.*tar.bz2', 'tar.bz2', i.file_name)
-                if s == i.file_name:
-                    s=re.sub('.*\.', '', i.file_name)
-                if None == re.search(s,extensions):
-                    extensions += comma + s
-                    comma = ", "
-        fstypes_map[build.id]=extensions
-
-    # send the data to the template
-    context = {
-            # specific info for
-                'mru' : build_mru,
-            # TODO: common objects for all table views, adapt as needed
-                'objects' : build_info,
-                'objectname' : "builds",
-                'default_orderby' : 'completed_on:-',
-                'fstypes' : fstypes_map,
-                'search_term' : search_term,
-                'total_count' : queryset_with_search.count(),
-            # Specifies the display of columns for the table, appearance in "Edit columns" box, toggling default show/hide, and specifying filters for columns
-                'tablecols' : [
-                {'name': 'Outcome',                                                # column with a single filter
-                 'qhelp' : "The outcome tells you if a build successfully completed or failed",     # the help button content
-                 'dclass' : "span2",                                                # indication about column width; comes from the design
-                 'orderfield': _get_toggle_order(request, "outcome"),               # adds ordering by the field value; default ascending unless clicked from ascending into descending
-                 'ordericon':_get_toggle_order_icon(request, "outcome"),
-                  # filter field will set a filter on that column with the specs in the filter description
-                  # the class field in the filter has no relation with clclass; the control different aspects of the UI
-                  # still, it is recommended for the values to be identical for easy tracking in the generated HTML
-                 'filter' : {'class' : 'outcome',
-                             'label': 'Show:',
-                             'options' : [
-                                         ('Successful builds', 'outcome:' + str(Build.SUCCEEDED), queryset_with_search.filter(outcome=str(Build.SUCCEEDED)).count()),  # this is the field search expression
-                                         ('Failed builds', 'outcome:'+ str(Build.FAILED), queryset_with_search.filter(outcome=str(Build.FAILED)).count()),
-                                         ]
-                            }
-                },
-                {'name': 'Target',                                                 # default column, disabled box, with just the name in the list
-                 'qhelp': "This is the build target or build targets (i.e. one or more recipes or image recipes)",
-                 'orderfield': _get_toggle_order(request, "target__target"),
-                 'ordericon':_get_toggle_order_icon(request, "target__target"),
-                },
-                {'name': 'Machine',
-                 'qhelp': "The machine is the hardware for which you are building a recipe or image recipe",
-                 'orderfield': _get_toggle_order(request, "machine"),
-                 'ordericon':_get_toggle_order_icon(request, "machine"),
-                 'dclass': 'span3'
-                },                           # a slightly wider column
-                {'name': 'Started on', 'clclass': 'started_on', 'hidden' : 1,      # this is an unchecked box, which hides the column
-                 'qhelp': "The date and time you started the build",
-                 'orderfield': _get_toggle_order(request, "started_on", True),
-                 'ordericon':_get_toggle_order_icon(request, "started_on"),
-                 'filter' : {'class' : 'started_on',
-                             'label': 'Show:',
-                             'options' : [
-                                         ("Today's builds" , 'started_on__gte:'+timezone.now().strftime("%Y-%m-%d"), queryset_with_search.filter(started_on__gte=timezone.now()).count()),
-                                         ("Yesterday's builds", 'started_on__gte:'+(timezone.now()-timedelta(hours=24)).strftime("%Y-%m-%d"), queryset_with_search.filter(started_on__gte=(timezone.now()-timedelta(hours=24))).count()),
-                                         ("This week's builds", 'started_on__gte:'+(timezone.now()-timedelta(days=7)).strftime("%Y-%m-%d"), queryset_with_search.filter(started_on__gte=(timezone.now()-timedelta(days=7))).count()),
-                                         ]
-                            }
-                },
-                {'name': 'Completed on',
-                 'qhelp': "The date and time the build finished",
-                 'orderfield': _get_toggle_order(request, "completed_on", True),
-                 'ordericon':_get_toggle_order_icon(request, "completed_on"),
-                 'orderkey' : 'completed_on',
-                 'filter' : {'class' : 'completed_on',
-                             'label': 'Show:',
-                             'options' : [
-                                         ("Today's builds", 'completed_on__gte:'+timezone.now().strftime("%Y-%m-%d"), queryset_with_search.filter(completed_on__gte=timezone.now()).count()),
-                                         ("Yesterday's builds", 'completed_on__gte:'+(timezone.now()-timedelta(hours=24)).strftime("%Y-%m-%d"), queryset_with_search.filter(completed_on__gte=(timezone.now()-timedelta(hours=24))).count()),
-                                         ("This week's builds", 'completed_on__gte:'+(timezone.now()-timedelta(days=7)).strftime("%Y-%m-%d"), queryset_with_search.filter(completed_on__gte=(timezone.now()-timedelta(days=7))).count()),
-                                         ]
-                            }
-                },
-                {'name': 'Failed tasks', 'clclass': 'failed_tasks',                # specifing a clclass will enable the checkbox
-                 'qhelp': "How many tasks failed during the build",
-                 'filter' : {'class' : 'failed_tasks',
-                             'label': 'Show:',
-                             'options' : [
-                                         ('Builds with failed tasks', 'task_build__outcome:4', queryset_with_search.filter(task_build__outcome=4).count()),
-                                         ('Builds without failed tasks', 'task_build__outcome:NOT4', queryset_with_search.filter(~Q(task_build__outcome=4)).count()),
-                                         ]
-                            }
-                },
-                {'name': 'Errors', 'clclass': 'errors_no',
-                 'qhelp': "How many errors were encountered during the build (if any)",
-                 'orderfield': _get_toggle_order(request, "errors_no", True),
-                 'ordericon':_get_toggle_order_icon(request, "errors_no"),
-                 'orderkey' : 'errors_no',
-                 'filter' : {'class' : 'errors_no',
-                             'label': 'Show:',
-                             'options' : [
-                                         ('Builds with errors', 'errors_no__gte:1', queryset_with_search.filter(errors_no__gte=1).count()),
-                                         ('Builds without errors', 'errors_no:0', queryset_with_search.filter(errors_no=0).count()),
-                                         ]
-                            }
-                },
-                {'name': 'Warnings', 'clclass': 'warnings_no',
-                 'qhelp': "How many warnings were encountered during the build (if any)",
-                 'orderfield': _get_toggle_order(request, "warnings_no", True),
-                 'ordericon':_get_toggle_order_icon(request, "warnings_no"),
-                 'orderkey' : 'warnings_no',
-                 'filter' : {'class' : 'warnings_no',
-                             'label': 'Show:',
-                             'options' : [
-                                         ('Builds with warnings','warnings_no__gte:1', queryset_with_search.filter(warnings_no__gte=1).count()),
-                                         ('Builds without warnings','warnings_no:0', queryset_with_search.filter(warnings_no=0).count()),
-                                         ]
-                            }
-                },
-                {'name': 'Time', 'clclass': 'time', 'hidden' : 1,
-                 'qhelp': "How long it took the build to finish",
-                 'orderfield': _get_toggle_order(request, "timespent", True),
-                 'ordericon':_get_toggle_order_icon(request, "timespent"),
-                 'orderkey' : 'timespent',
-                },
-                {'name': 'Image files', 'clclass': 'output',
-                 'qhelp': "The root file system types produced by the build. You can find them in your <code>/build/tmp/deploy/images/</code> directory",
-                    # TODO: compute image fstypes from Target_Image_File
-                },
-                ]
-            }
-
-    if not toastermain.settings.MANAGED:
-        context['tablecols'].insert(-2,
-                {'name': 'Log1',
-                 'dclass': "span4",
-                 'qhelp': "Path to the build main log file",
-                 'clclass': 'log', 'hidden': 1,
-                 'orderfield': _get_toggle_order(request, "cooker_log_path"),
-                 'ordericon':_get_toggle_order_icon(request, "cooker_log_path"),
-                 'orderkey' : 'cooker_log_path',
-                }
-        )
-
-
-    if toastermain.settings.MANAGED:
-        context['tablecols'].append(
-                {'name': 'Project', 'clclass': 'project',
-                 'filter': {'class': 'project',
-                        'label': 'Project:',
-                        'options':  map(lambda x: (x.name,'',x.build_set.filter(outcome__lt=Build.IN_PROGRESS).count()), Project.objects.all()),
-
-                       }
-                }
-        )
-
-
-    response = render(request, template, context)
-    _save_parameters_cookies(response, pagesize, orderby, request)
-    return response
-
-
 ##
 # build dashboard for a single build, coming in as argument
 # Each build may contain multiple targets and each target
@@ -1895,6 +1704,221 @@ if toastermain.settings.MANAGED:
                 del request.session['project_id']
         return ret
 
+
+    # shows the "all builds" page for managed mode; it displays build requests (at least started!) instead of actual builds
+    def builds(request):
+        template = 'managed_builds.html'
+        # define here what parameters the view needs in the GET portion in order to
+        # be able to display something.  'count' and 'page' are mandatory for all views
+        # that use paginators.
+
+        # ATTN: we use here the ordering parameters for interactive mode; the translation for BuildRequest fields will happen below
+        (pagesize, orderby) = _get_parameters_values(request, 10, 'completed_on:-')
+        mandatory_parameters = { 'count': pagesize,  'page' : 1, 'orderby' : orderby }
+        retval = _verify_parameters( request.GET, mandatory_parameters )
+        if retval:
+            return _redirect_parameters( 'all-builds', request.GET, mandatory_parameters)
+
+        # translate interactive mode ordering to managed mode ordering
+        ordering_params = orderby.split(":")
+        if ordering_params[0] == "completed_on":
+            ordering_params[0] = "updated"
+        if ordering_params[0] == "started_on":
+            ordering_params = "created"
+
+        request.GET = request.GET.copy()        # get a mutable copy of the GET QueryDict
+        request.GET['orderby'] = ":".join(ordering_params)
+
+        # boilerplate code that takes a request for an object type and returns a queryset
+        # for that object type. copypasta for all needed table searches
+        (filter_string, search_term, ordering_string) = _search_tuple(request, BuildRequest)
+        # we don't display in-progress or deleted builds
+        queryset_all = BuildRequest.objects.exclude(state__lte = BuildRequest.REQ_INPROGRESS).exclude(state=BuildRequest.REQ_DELETED)
+        queryset_with_search = _get_queryset(BuildRequest, queryset_all, None, search_term, ordering_string, '-updated')
+        queryset = _get_queryset(BuildRequest, queryset_all, filter_string, search_term, ordering_string, '-updated')
+
+        # retrieve the objects that will be displayed in the table; builds a paginator and gets a page range to display
+        build_info = _build_page_range(Paginator(queryset, pagesize), request.GET.get('page', 1))
+
+        # build view-specific information; this is rendered specifically in the builds page, at the top of the page (i.e. Recent builds)
+        # most recent build is like projects' most recent builds, but across all projects
+        build_mru = BuildRequest.objects.all()
+        build_mru = list(build_mru.filter(Q(state__lt=BuildRequest.REQ_COMPLETED) or Q(state=BuildRequest.REQ_DELETED)).order_by("-pk")) + list(build_mru.filter(state__in=[BuildRequest.REQ_COMPLETED, BuildRequest.REQ_FAILED]).order_by("-pk")[:3])
+
+        fstypes_map = {};
+        for build_request in build_info:
+            # set display variables for build request
+            build_request.machine = build_request.brvariable_set.get(name="MACHINE").value
+            build_request.timespent = build_request.updated - build_request.created
+
+            # set up list of fstypes for each build
+            if build_request.build is None:
+                continue
+            targets = Target.objects.filter( build_id = build_request.build.id )
+            comma = "";
+            extensions = "";
+            for t in targets:
+                if ( not t.is_image ):
+                    continue
+                tif = Target_Image_File.objects.filter( target_id = t.id )
+                for i in tif:
+                    s=re.sub('.*tar.bz2', 'tar.bz2', i.file_name)
+                    if s == i.file_name:
+                        s=re.sub('.*\.', '', i.file_name)
+                    if None == re.search(s,extensions):
+                        extensions += comma + s
+                        comma = ", "
+            fstypes_map[build_request.build.id]=extensions
+
+
+        # send the data to the template
+        context = {
+                # specific info for
+                    'mru' : build_mru,
+                # TODO: common objects for all table views, adapt as needed
+                    'objects' : build_info,
+                    'objectname' : "builds",
+                    'default_orderby' : 'updated:-',
+                    'fstypes' : fstypes_map,
+                    'search_term' : search_term,
+                    'total_count' : queryset_with_search.count(),
+                # Specifies the display of columns for the table, appearance in "Edit columns" box, toggling default show/hide, and specifying filters for columns
+                    'tablecols' : [
+                    {'name': 'Outcome',                                                # column with a single filter
+                     'qhelp' : "The outcome tells you if a build successfully completed or failed",     # the help button content
+                     'dclass' : "span2",                                                # indication about column width; comes from the design
+                     'orderfield': _get_toggle_order(request, "state"),               # adds ordering by the field value; default ascending unless clicked from ascending into descending
+                     'ordericon':_get_toggle_order_icon(request, "state"),
+                      # filter field will set a filter on that column with the specs in the filter description
+                      # the class field in the filter has no relation with clclass; the control different aspects of the UI
+                      # still, it is recommended for the values to be identical for easy tracking in the generated HTML
+                     'filter' : {'class' : 'outcome',
+                                 'label': 'Show:',
+                                 'options' : [
+                                             ('Successful builds', 'state:' + str(BuildRequest.REQ_COMPLETED), queryset_with_search.filter(state=str(BuildRequest.REQ_COMPLETED)).count()),  # this is the field search expression
+                                             ('Failed builds', 'state:'+ str(BuildRequest.REQ_FAILED), queryset_with_search.filter(state=str(BuildRequest.REQ_FAILED)).count()),
+                                             ]
+                                }
+                    },
+                    {'name': 'Target',                                                 # default column, disabled box, with just the name in the list
+                     'qhelp': "This is the build target or build targets (i.e. one or more recipes or image recipes)",
+                     'orderfield': _get_toggle_order(request, "target__target"),
+                     'ordericon':_get_toggle_order_icon(request, "target__target"),
+                    },
+                    {'name': 'Machine',
+                     'qhelp': "The machine is the hardware for which you are building a recipe or image recipe",
+                     'orderfield': _get_toggle_order(request, "machine"),
+                     'ordericon':_get_toggle_order_icon(request, "machine"),
+                     'dclass': 'span3'
+                    },                           # a slightly wider column
+                    {'name': 'Started on', 'clclass': 'started_on', 'hidden' : 1,      # this is an unchecked box, which hides the column
+                     'qhelp': "The date and time you started the build",
+                     'orderfield': _get_toggle_order(request, "created", True),
+                     'ordericon':_get_toggle_order_icon(request, "created"),
+                     'filter' : {'class' : 'created',
+                                 'label': 'Show:',
+                                 'options' : [
+                                             ("Today's builds" , 'created__gte:'+timezone.now().strftime("%Y-%m-%d"), queryset_with_search.filter(created__gte=timezone.now()).count()),
+                                             ("Yesterday's builds", 'created__gte:'+(timezone.now()-timedelta(hours=24)).strftime("%Y-%m-%d"), queryset_with_search.filter(created__gte=(timezone.now()-timedelta(hours=24))).count()),
+                                             ("This week's builds", 'created__gte:'+(timezone.now()-timedelta(days=7)).strftime("%Y-%m-%d"), queryset_with_search.filter(created__gte=(timezone.now()-timedelta(days=7))).count()),
+                                             ]
+                                }
+                    },
+                    {'name': 'Completed on',
+                     'qhelp': "The date and time the build finished",
+                     'orderfield': _get_toggle_order(request, "updated", True),
+                     'ordericon':_get_toggle_order_icon(request, "updated"),
+                     'orderkey' : 'updated',
+                     'filter' : {'class' : 'updated',
+                                 'label': 'Show:',
+                                 'options' : [
+                                             ("Today's builds", 'updated__gte:'+timezone.now().strftime("%Y-%m-%d"), queryset_with_search.filter(updated__gte=timezone.now()).count()),
+                                             ("Yesterday's builds", 'updated__gte:'+(timezone.now()-timedelta(hours=24)).strftime("%Y-%m-%d"), queryset_with_search.filter(updated__gte=(timezone.now()-timedelta(hours=24))).count()),
+                                             ("This week's builds", 'updated__gte:'+(timezone.now()-timedelta(days=7)).strftime("%Y-%m-%d"), queryset_with_search.filter(updated__gte=(timezone.now()-timedelta(days=7))).count()),
+                                             ]
+                                }
+                    },
+                    {'name': 'Failed tasks', 'clclass': 'failed_tasks',                # specifing a clclass will enable the checkbox
+                     'qhelp': "How many tasks failed during the build",
+                     'filter' : {'class' : 'failed_tasks',
+                                 'label': 'Show:',
+                                 'options' : [
+                                             ('BuildRequests with failed tasks', 'build__task_build__outcome:4', queryset_with_search.filter(build__task_build__outcome=4).count()),
+                                             ('BuildRequests without failed tasks', 'build__task_build__outcome:NOT4', queryset_with_search.filter(~Q(build__task_build__outcome=4)).count()),
+                                             ]
+                                }
+                    },
+                    {'name': 'Errors', 'clclass': 'errors_no',
+                     'qhelp': "How many errors were encountered during the build (if any)",
+                     'orderfield': _get_toggle_order(request, "errors_no", True),
+                     'ordericon':_get_toggle_order_icon(request, "errors_no"),
+                     'orderkey' : 'errors_no',
+                     'filter' : {'class' : 'errors_no',
+                                 'label': 'Show:',
+                                 'options' : [
+                                             ('BuildRequests with errors', 'errors_no__gte:1', queryset_with_search.filter(build__errors_no__gte=1).count()),
+                                             ('BuildRequests without errors', 'errors_no:0', queryset_with_search.filter(build__errors_no=0).count()),
+                                             ]
+                                }
+                    },
+                    {'name': 'Warnings', 'clclass': 'warnings_no',
+                     'qhelp': "How many warnings were encountered during the build (if any)",
+                     'orderfield': _get_toggle_order(request, "build__warnings_no", True),
+                     'ordericon':_get_toggle_order_icon(request, "build__warnings_no"),
+                     'orderkey' : 'build__warnings_no',
+                     'filter' : {'class' : 'build__warnings_no',
+                                 'label': 'Show:',
+                                 'options' : [
+                                             ('BuildRequests with warnings','build__warnings_no__gte:1', queryset_with_search.filter(build__warnings_no__gte=1).count()),
+                                             ('BuildRequests without warnings','build__warnings_no:0', queryset_with_search.filter(build__warnings_no=0).count()),
+                                             ]
+                                }
+                    },
+                    {'name': 'Time', 'clclass': 'time', 'hidden' : 1,
+                     'qhelp': "How long it took the build to finish",
+                     'orderfield': _get_toggle_order(request, "timespent", True),
+                     'ordericon':_get_toggle_order_icon(request, "timespent"),
+                     'orderkey' : 'timespent',
+                    },
+                    {'name': 'Image files', 'clclass': 'output',
+                     'qhelp': "The root file system types produced by the build. You can find them in your <code>/build/tmp/deploy/images/</code> directory",
+                        # TODO: compute image fstypes from Target_Image_File
+                    },
+                    ]
+                }
+
+        if not toastermain.settings.MANAGED:
+            context['tablecols'].insert(-2,
+                    {'name': 'Log1',
+                     'dclass': "span4",
+                     'qhelp': "Path to the build main log file",
+                     'clclass': 'log', 'hidden': 1,
+                     'orderfield': _get_toggle_order(request, "cooker_log_path"),
+                     'ordericon':_get_toggle_order_icon(request, "cooker_log_path"),
+                     'orderkey' : 'cooker_log_path',
+                    }
+            )
+
+
+        if toastermain.settings.MANAGED:
+            context['tablecols'].append(
+                    {'name': 'Project', 'clclass': 'project',
+                     'filter': {'class': 'project',
+                            'label': 'Project:',
+                            'options':  map(lambda x: (x.name,'',x.build_set.filter(outcome__lt=BuildRequest.REQ_INPROGRESS).count()), Project.objects.all()),
+
+                           }
+                    }
+            )
+
+
+        response = render(request, template, context)
+        _save_parameters_cookies(response, pagesize, orderby, request)
+        return response
+
+
+
+
     # new project
     def newproject(request):
         template = "newproject.html"
@@ -2819,21 +2843,21 @@ if toastermain.settings.MANAGED:
                      'filter' : {'class' : 'failed_tasks',
                                  'label': 'Show:',
                                  'options' : [
-                                             ('Builds with failed tasks', 'task_build__outcome:4', queryset_with_search.filter(task_build__outcome=4).count()),
-                                             ('Builds without failed tasks', 'task_build__outcome:NOT4', queryset_with_search.filter(~Q(task_build__outcome=4)).count()),
+                                             ('Builds with failed tasks', 'build__task_build__outcome:4', queryset_with_search.filter(build__task_build__outcome=4).count()),
+                                             ('Builds without failed tasks', 'build__task_build__outcome:NOT4', queryset_with_search.filter(~Q(build__task_build__outcome=4)).count()),
                                              ]
                                 }
                     },
                     {'name': 'Errors', 'clclass': 'errors_no',
                      'qhelp': "How many errors were encountered during the build (if any)",
-                     'orderfield': _get_toggle_order(request, "errors_no", True),
-                     'ordericon':_get_toggle_order_icon(request, "errors_no"),
-                     'orderkey' : 'errors_no',
-                     'filter' : {'class' : 'errors_no',
+                     'orderfield': _get_toggle_order(request, "build__errors_no", True),
+                     'ordericon':_get_toggle_order_icon(request, "build__errors_no"),
+                     'orderkey' : 'build__errors_no',
+                     'filter' : {'class' : 'build__errors_no',
                                  'label': 'Show:',
                                  'options' : [
-                                             ('Builds with errors', 'errors_no__gte:1', queryset_with_search.filter(errors_no__gte=1).count()),
-                                             ('Builds without errors', 'errors_no:0', queryset_with_search.filter(errors_no=0).count()),
+                                             ('Builds with errors', 'build__errors_no__gte:1', queryset_with_search.filter(build__errors_no__gte=1).count()),
+                                             ('Builds without errors', 'build__errors_no:0', queryset_with_search.filter(build__errors_no=0).count()),
                                              ]
                                 }
                     },
@@ -3007,6 +3031,199 @@ else:
             "DEBUG" : toastermain.settings.DEBUG
         }
 
+
+    # shows the "all builds" page for interactive mode; this is the old code, simply moved
+    def builds(request):
+        template = 'build.html'
+        # define here what parameters the view needs in the GET portion in order to
+        # be able to display something.  'count' and 'page' are mandatory for all views
+        # that use paginators.
+        (pagesize, orderby) = _get_parameters_values(request, 10, 'completed_on:-')
+        mandatory_parameters = { 'count': pagesize,  'page' : 1, 'orderby' : orderby }
+        retval = _verify_parameters( request.GET, mandatory_parameters )
+        if retval:
+            return _redirect_parameters( 'all-builds', request.GET, mandatory_parameters)
+
+        # boilerplate code that takes a request for an object type and returns a queryset
+        # for that object type. copypasta for all needed table searches
+        (filter_string, search_term, ordering_string) = _search_tuple(request, Build)
+        queryset_all = Build.objects.exclude(outcome = Build.IN_PROGRESS)
+        queryset_with_search = _get_queryset(Build, queryset_all, None, search_term, ordering_string, '-completed_on')
+        queryset = _get_queryset(Build, queryset_all, filter_string, search_term, ordering_string, '-completed_on')
+
+        # retrieve the objects that will be displayed in the table; builds a paginator and gets a page range to display
+        build_info = _build_page_range(Paginator(queryset, pagesize), request.GET.get('page', 1))
+
+        # build view-specific information; this is rendered specifically in the builds page, at the top of the page (i.e. Recent builds)
+        build_mru = Build.objects.order_by("-started_on")[:3]
+
+        # set up list of fstypes for each build
+        fstypes_map = {};
+        for build in build_info:
+            targets = Target.objects.filter( build_id = build.id )
+            comma = "";
+            extensions = "";
+            for t in targets:
+                if ( not t.is_image ):
+                    continue
+                tif = Target_Image_File.objects.filter( target_id = t.id )
+                for i in tif:
+                    s=re.sub('.*tar.bz2', 'tar.bz2', i.file_name)
+                    if s == i.file_name:
+                        s=re.sub('.*\.', '', i.file_name)
+                    if None == re.search(s,extensions):
+                        extensions += comma + s
+                        comma = ", "
+            fstypes_map[build.id]=extensions
+
+        # send the data to the template
+        context = {
+                # specific info for
+                    'mru' : build_mru,
+                # TODO: common objects for all table views, adapt as needed
+                    'objects' : build_info,
+                    'objectname' : "builds",
+                    'default_orderby' : 'completed_on:-',
+                    'fstypes' : fstypes_map,
+                    'search_term' : search_term,
+                    'total_count' : queryset_with_search.count(),
+                # Specifies the display of columns for the table, appearance in "Edit columns" box, toggling default show/hide, and specifying filters for columns
+                    'tablecols' : [
+                    {'name': 'Outcome',                                                # column with a single filter
+                     'qhelp' : "The outcome tells you if a build successfully completed or failed",     # the help button content
+                     'dclass' : "span2",                                                # indication about column width; comes from the design
+                     'orderfield': _get_toggle_order(request, "outcome"),               # adds ordering by the field value; default ascending unless clicked from ascending into descending
+                     'ordericon':_get_toggle_order_icon(request, "outcome"),
+                      # filter field will set a filter on that column with the specs in the filter description
+                      # the class field in the filter has no relation with clclass; the control different aspects of the UI
+                      # still, it is recommended for the values to be identical for easy tracking in the generated HTML
+                     'filter' : {'class' : 'outcome',
+                                 'label': 'Show:',
+                                 'options' : [
+                                             ('Successful builds', 'outcome:' + str(Build.SUCCEEDED), queryset_with_search.filter(outcome=str(Build.SUCCEEDED)).count()),  # this is the field search expression
+                                             ('Failed builds', 'outcome:'+ str(Build.FAILED), queryset_with_search.filter(outcome=str(Build.FAILED)).count()),
+                                             ]
+                                }
+                    },
+                    {'name': 'Target',                                                 # default column, disabled box, with just the name in the list
+                     'qhelp': "This is the build target or build targets (i.e. one or more recipes or image recipes)",
+                     'orderfield': _get_toggle_order(request, "target__target"),
+                     'ordericon':_get_toggle_order_icon(request, "target__target"),
+                    },
+                    {'name': 'Machine',
+                     'qhelp': "The machine is the hardware for which you are building a recipe or image recipe",
+                     'orderfield': _get_toggle_order(request, "machine"),
+                     'ordericon':_get_toggle_order_icon(request, "machine"),
+                     'dclass': 'span3'
+                    },                           # a slightly wider column
+                    {'name': 'Started on', 'clclass': 'started_on', 'hidden' : 1,      # this is an unchecked box, which hides the column
+                     'qhelp': "The date and time you started the build",
+                     'orderfield': _get_toggle_order(request, "started_on", True),
+                     'ordericon':_get_toggle_order_icon(request, "started_on"),
+                     'filter' : {'class' : 'started_on',
+                                 'label': 'Show:',
+                                 'options' : [
+                                             ("Today's builds" , 'started_on__gte:'+timezone.now().strftime("%Y-%m-%d"), queryset_with_search.filter(started_on__gte=timezone.now()).count()),
+                                             ("Yesterday's builds", 'started_on__gte:'+(timezone.now()-timedelta(hours=24)).strftime("%Y-%m-%d"), queryset_with_search.filter(started_on__gte=(timezone.now()-timedelta(hours=24))).count()),
+                                             ("This week's builds", 'started_on__gte:'+(timezone.now()-timedelta(days=7)).strftime("%Y-%m-%d"), queryset_with_search.filter(started_on__gte=(timezone.now()-timedelta(days=7))).count()),
+                                             ]
+                                }
+                    },
+                    {'name': 'Completed on',
+                     'qhelp': "The date and time the build finished",
+                     'orderfield': _get_toggle_order(request, "completed_on", True),
+                     'ordericon':_get_toggle_order_icon(request, "completed_on"),
+                     'orderkey' : 'completed_on',
+                     'filter' : {'class' : 'completed_on',
+                                 'label': 'Show:',
+                                 'options' : [
+                                             ("Today's builds", 'completed_on__gte:'+timezone.now().strftime("%Y-%m-%d"), queryset_with_search.filter(completed_on__gte=timezone.now()).count()),
+                                             ("Yesterday's builds", 'completed_on__gte:'+(timezone.now()-timedelta(hours=24)).strftime("%Y-%m-%d"), queryset_with_search.filter(completed_on__gte=(timezone.now()-timedelta(hours=24))).count()),
+                                             ("This week's builds", 'completed_on__gte:'+(timezone.now()-timedelta(days=7)).strftime("%Y-%m-%d"), queryset_with_search.filter(completed_on__gte=(timezone.now()-timedelta(days=7))).count()),
+                                             ]
+                                }
+                    },
+                    {'name': 'Failed tasks', 'clclass': 'failed_tasks',                # specifing a clclass will enable the checkbox
+                     'qhelp': "How many tasks failed during the build",
+                     'filter' : {'class' : 'failed_tasks',
+                                 'label': 'Show:',
+                                 'options' : [
+                                             ('Builds with failed tasks', 'task_build__outcome:4', queryset_with_search.filter(task_build__outcome=4).count()),
+                                             ('Builds without failed tasks', 'task_build__outcome:NOT4', queryset_with_search.filter(~Q(task_build__outcome=4)).count()),
+                                             ]
+                                }
+                    },
+                    {'name': 'Errors', 'clclass': 'errors_no',
+                     'qhelp': "How many errors were encountered during the build (if any)",
+                     'orderfield': _get_toggle_order(request, "errors_no", True),
+                     'ordericon':_get_toggle_order_icon(request, "errors_no"),
+                     'orderkey' : 'errors_no',
+                     'filter' : {'class' : 'errors_no',
+                                 'label': 'Show:',
+                                 'options' : [
+                                             ('Builds with errors', 'errors_no__gte:1', queryset_with_search.filter(errors_no__gte=1).count()),
+                                             ('Builds without errors', 'errors_no:0', queryset_with_search.filter(errors_no=0).count()),
+                                             ]
+                                }
+                    },
+                    {'name': 'Warnings', 'clclass': 'warnings_no',
+                     'qhelp': "How many warnings were encountered during the build (if any)",
+                     'orderfield': _get_toggle_order(request, "warnings_no", True),
+                     'ordericon':_get_toggle_order_icon(request, "warnings_no"),
+                     'orderkey' : 'warnings_no',
+                     'filter' : {'class' : 'warnings_no',
+                                 'label': 'Show:',
+                                 'options' : [
+                                             ('Builds with warnings','warnings_no__gte:1', queryset_with_search.filter(warnings_no__gte=1).count()),
+                                             ('Builds without warnings','warnings_no:0', queryset_with_search.filter(warnings_no=0).count()),
+                                             ]
+                                }
+                    },
+                    {'name': 'Time', 'clclass': 'time', 'hidden' : 1,
+                     'qhelp': "How long it took the build to finish",
+                     'orderfield': _get_toggle_order(request, "timespent", True),
+                     'ordericon':_get_toggle_order_icon(request, "timespent"),
+                     'orderkey' : 'timespent',
+                    },
+                    {'name': 'Image files', 'clclass': 'output',
+                     'qhelp': "The root file system types produced by the build. You can find them in your <code>/build/tmp/deploy/images/</code> directory",
+                        # TODO: compute image fstypes from Target_Image_File
+                    },
+                    ]
+                }
+
+        if not toastermain.settings.MANAGED:
+            context['tablecols'].insert(-2,
+                    {'name': 'Log1',
+                     'dclass': "span4",
+                     'qhelp': "Path to the build main log file",
+                     'clclass': 'log', 'hidden': 1,
+                     'orderfield': _get_toggle_order(request, "cooker_log_path"),
+                     'ordericon':_get_toggle_order_icon(request, "cooker_log_path"),
+                     'orderkey' : 'cooker_log_path',
+                    }
+            )
+
+
+        if toastermain.settings.MANAGED:
+            context['tablecols'].append(
+                    {'name': 'Project', 'clclass': 'project',
+                     'filter': {'class': 'project',
+                            'label': 'Project:',
+                            'options':  map(lambda x: (x.name,'',x.build_set.filter(outcome__lt=Build.IN_PROGRESS).count()), Project.objects.all()),
+
+                           }
+                    }
+            )
+
+
+        response = render(request, template, context)
+        _save_parameters_cookies(response, pagesize, orderby, request)
+        return response
+
+
+
+
     def newproject(request):
         raise Exception("page not available in interactive mode")
 
-- 
1.9.1


