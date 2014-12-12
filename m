Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f54.google.com (mail-wg0-f54.google.com [74.125.82.54])
	by mail.openembedded.org (Postfix) with ESMTP id 0CCAC7249A
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Dec 2014 11:45:21 +0000 (UTC)
Received: by mail-wg0-f54.google.com with SMTP id l2so8901915wgh.41
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Dec 2014 03:45:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=diD/w+ktC9/QJPjmblWgnfNfkz9wNZ1DZTw0my9SucQ=;
	b=S/qQwJ0amIjTXOf8LrtNvZkrVB8kAijOZfdIe8mq6EyEC65v1deqS56VaCGTCTgYBF
	zMgvy62/ypDWk/Lbjq+eTYfK8YQ6TotVySwt8XwndLDEGTKx4FnrNnqe707nalHJUQ46
	dp9cGb1iAtLHdgg+AZRU1FjwqSiAqX+igm2pmdWTmR6mjmgGEHniP1STpCIJmdNiruGD
	3YqgAJ6q8TxO8zftmSAz6njhGCKwREgEbc5H1S3yPGqtxmFSkOBqkXpKMk8N5LWMteWK
	YiQ1C6AnVvpeTxcooM5EQuS8rzW4/eu3lhCk6tUQGNl/baa2InXaCSrdFb1ZnE38eCP2
	RHPw==
X-Gm-Message-State: ALoCoQlvuvq0bh0A4TA5+cPFwJ+yHZf+2Qo+/r2T3+Qny4WTgp47drZA70ChttzHxhUgVrDfBd16
X-Received: by 10.180.84.198 with SMTP id b6mr6878172wiz.41.1418384722299;
	Fri, 12 Dec 2014 03:45:22 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id k5sm1525806wjn.1.2014.12.12.03.45.18
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Dec 2014 03:45:19 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 38583565776; Fri, 12 Dec 2014 11:45:19 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Dec 2014 11:45:03 +0000
Message-Id: <6000e1ae5c846e51932ecd0dc21e0fa02eb10357.1418384609.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <bbe24d912869312d561be199b2c029b0c898e049.1418384609.git.alexandru.damian@intel.com>
References: <bbe24d912869312d561be199b2c029b0c898e049.1418384609.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1418384609.git.alexandru.damian@intel.com>
References: <cover.1418384609.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 04/18] toastergui: implement UI changes to allow file download
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
X-List-Received-Date: Fri, 12 Dec 2014 11:45:23 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patchset adds download links in the build analisys pages
if toaster runs in managed mode. This allows the user to access
data directly from the web interface.

[YOCTO #6837]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/base.html         |  18 +--
 lib/toaster/toastergui/templates/build.html        |  29 +++-
 .../toastergui/templates/builddashboard.html       | 131 +++++++++++-----
 .../toastergui/templates/configuration.html        |   6 +-
 .../toastergui/templates/package_detail_base.html  |   3 +
 lib/toaster/toastergui/templates/recipe.html       |  11 +-
 lib/toaster/toastergui/templates/recipes.html      |   7 +-
 lib/toaster/toastergui/templates/target.html       |   8 +-
 lib/toaster/toastergui/templates/task.html         |  18 ++-
 lib/toaster/toastergui/templates/tasks.html        |  12 +-
 lib/toaster/toastergui/views.py                    | 168 +++++++++++++--------
 11 files changed, 276 insertions(+), 135 deletions(-)

diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index 594c495..bc7a0ee 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -3,14 +3,14 @@
 <html lang="en">
     <head>
         <title>{% if objectname %} {{objectname|title}} - {% endif %}Toaster</title>
-<link rel="stylesheet" href="{% static 'css/bootstrap.min.css' %}" type="text/css">
-<link rel="stylesheet" href="{% static 'css/bootstrap-responsive.min.css' %}" type='text/css'>
-<link rel="stylesheet" href="{% static 'css/font-awesome.min.css' %}" type='text/css'>
-<link rel="stylesheet" href="{% static 'css/prettify.css' %}" type='text/css'>
-<link rel="stylesheet" href="{% static 'css/default.css' %}" type='text/css'>
+<link rel="stylesheet" href="{% static 'css/bootstrap.min.css' %}" type="text/css"/>
+<link rel="stylesheet" href="{% static 'css/bootstrap-responsive.min.css' %}" type='text/css'/>
+<link rel="stylesheet" href="{% static 'css/font-awesome.min.css' %}" type='text/css'/>
+<link rel="stylesheet" href="{% static 'css/prettify.css' %}" type='text/css'/>
+<link rel="stylesheet" href="{% static 'css/default.css' %}" type='text/css'/>
 
 <meta name="viewport" content="width=device-width, initial-scale=1.0" />
-<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
+<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
 <script src="{% static 'js/jquery-2.0.3.min.js' %}">
 </script>
 <script src="{% static 'js/jquery.cookie.js' %}">
@@ -64,7 +64,7 @@
             </div>
             <!-- New build popover -->
             <div class="btn-group pull-right" id="new-build-button">
-              <button class="btn dropdown-toggle" data-toggle="dropdown" href="#">
+              <button class="btn dropdown-toggle" data-toggle="dropdown">
                 New build
                 <i class="icon-caret-down"></i>
               </button>
@@ -78,7 +78,7 @@
                   </span>
                   <form id="change-project-form" style="display:none;">
                     <div class="input-append">
-                      <input type="text" class="input-medium" id="project-name-input" placeholder="Type a project name" autocomplete="off" data-minLength="1" data-autocomplete="off" data-provide="typeahead">
+                      <input type="text" class="input-medium" id="project-name-input" placeholder="Type a project name" autocomplete="off" data-minLength="1" data-autocomplete="off" data-provide="typeahead"/>
                         <button id="save-project-button" class="btn" type="button">Save</button>
                         <a href="#" id="cancel-change-project" class="btn btn-link">Cancel</a>
                       </div>
@@ -92,7 +92,7 @@
                   <li id="targets-form">
                     <h6>Target(s):</h6>
                     <form>
-                      <input type="text" class="input-xlarge" id="build-target-input" placeholder="Type a target name" autocomplete="off" data-minLength="1" data-autocomplete="off" data-provide="typeahead" >
+                      <input type="text" class="input-xlarge" id="build-target-input" placeholder="Type a target name" autocomplete="off" data-minLength="1" data-autocomplete="off" data-provide="typeahead" />
                       <div>
                         <a class="btn btn-primary" id="build-button" disabled="disabled" data-project-id="{{project.id}}">Build</a>
                       </div>
diff --git a/lib/toaster/toastergui/templates/build.html b/lib/toaster/toastergui/templates/build.html
index f20f041..e71e38f 100644
--- a/lib/toaster/toastergui/templates/build.html
+++ b/lib/toaster/toastergui/templates/build.html
@@ -45,11 +45,34 @@
             <td class="machine"><a href="{% url "builddashboard" build.id %}">{{build.machine}}</a></td>
             <td class="started_on"><a href="{% url "builddashboard" build.id %}">{{build.started_on|date:"d/m/y H:i"}}</a></td>
             <td class="completed_on"><a href="{% url "builddashboard" build.id %}">{{build.completed_on|date:"d/m/y H:i"}}</a></td>
-            <td class="failed_tasks error">{% query build.task_build outcome=4 order__gt=0 as exectask%}{% if exectask.count == 1 %}<a href="{% url "task" build.id exectask.0.id %}">{{exectask.0.recipe.name}}.{{exectask.0.task_name}}</a>{% elif exectask.count > 1%}<a href="{% url "tasks" build.id %}?filter=outcome%3A4">{{exectask.count}}</a>{%endif%}</td>
-            <td class="errors_no">{% if  build.errors_no %}<a class="errors_no error" href="{% url "builddashboard" build.id %}#errors">{{build.errors_no}} error{{build.errors_no|pluralize}}</a>{%endif%}</td>
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
             <td class="warnings_no">{% if  build.warnings_no %}<a class="warnings_no warning" href="{% url "builddashboard" build.id %}#warnings">{{build.warnings_no}} warning{{build.warnings_no|pluralize}}</a>{%endif%}</td>
             <td class="time"><a href="{% url "buildtime" build.id %}">{{build.timespent|sectohms}}</a></td>
-            <td class="log">{{build.cooker_log_path}}</td>
+            {% if not MANAGED or not build.project %}
+                <td class="log">{{build.cooker_log_path}}</td>
+            {% endif %}
             <td class="output">
               {% if build.outcome == build.SUCCEEDED %}
               <a href="{%url "builddashboard" build.id%}#images">{{fstypes|get_dict_value:build.id}}</a>
diff --git a/lib/toaster/toastergui/templates/builddashboard.html b/lib/toaster/toastergui/templates/builddashboard.html
index e682094..2458cdb 100644
--- a/lib/toaster/toastergui/templates/builddashboard.html
+++ b/lib/toaster/toastergui/templates/builddashboard.html
@@ -42,9 +42,9 @@
     {% if build.toaster_exceptions.count > 0 %}
     <div class="row">
         <small class="pull-right">
-		<i class="icon-question-sign get-help get-help-blue" title="" data-original-title="Toaster exceptions do not affect your build: only the operation of Toaster"></i>
-		<a class="show-exceptions" href="#exceptions">Toaster threw {{build.toaster_exceptions.count}} exception{{build.toaster_exceptions.count|pluralize}}</a>
-	</small>
+        <i class="icon-question-sign get-help get-help-blue" title="" data-original-title="Toaster exceptions do not affect your build: only the operation of Toaster"></i>
+        <a class="show-exceptions" href="#exceptions">Toaster threw {{build.toaster_exceptions.count}} exception{{build.toaster_exceptions.count|pluralize}}</a>
+    </small>
     </div>
     {% endif %}
   </div>
@@ -54,6 +54,9 @@
 <div class="accordion span10 pull-right" id="errors">
   <div class="accordion-group">
     <div class="accordion-heading">
+      {% if MANAGED and build.project %}
+          <a class="btn btn-large pull-right" href="{% url 'build_artifact' build.id "cookerlog" build.id %}" style="margin:15px;">Download build log</a>
+      {% endif %}
       <a class="accordion-toggle error toggle-errors">
          <h2 id="error-toggle">
            <i class="icon-minus-sign"></i>
@@ -66,13 +69,10 @@
         <div class="span10">
           {% for error in logmessages %}{% if error.level == 2 %}
             <div class="alert alert-error">
-	    {% if MANAGED and error.pathname %}
-	      <pre><a href="{% url 'build_artifact' build.pk 'logmessagefile' error.pk %}" target="_blanc">{{error.message}}</pre>
-	    {% else %}
               <pre>{{error.message}}</pre>
-	    {% endif %}
             </div>
-          {% endif %}{% endfor %}
+          {% endif %}
+          {% endfor %}
         </div>
       </div>
     </div>
@@ -84,21 +84,21 @@
 <!-- built images -->
 {% if hasImages %}
 <div class="row-fluid span10 pull-right">
-	<h2>Images</h2>
-	{% for target in targets %}
+    <h2>Images</h2>
+    {% for target in targets %}
         {% if target.target.is_image %}
-	<div class="well dashboard-section">
-		<h3><a href="{% url 'target' build.pk target.target.pk %}">{{target.target}}</a>
+    <div class="well dashboard-section">
+        <h3><a href="{% url 'target' build.pk target.target.pk %}">{{target.target}}</a>
                 </h3>
-		<dl class="dl-horizontal">
-			<dt>Packages included</dt>
-			<dd><a href="{% url 'target' build.pk target.target.pk %}">{{target.npkg}}</a></dd>
-			<dt>Total package size</dt>
-			<dd>{{target.pkgsz|filtered_filesizeformat}}</dd>
+        <dl class="dl-horizontal">
+            <dt>Packages included</dt>
+            <dd><a href="{% url 'target' build.pk target.target.pk %}">{{target.npkg}}</a></dd>
+            <dt>Total package size</dt>
+            <dd>{{target.pkgsz|filtered_filesizeformat}}</dd>
                         {% if target.targetHasNoImages %}
-				</dl>
-				<div class="row-fluid">
-					<div class="alert alert-info span7">
+                </dl>
+                <div class="row-fluid">
+                    <div class="alert alert-info span7">
                     <p>
                                     <b>This build did not create any image files</b>
                                   </p>
@@ -111,30 +111,45 @@
                                       license manifest information</a> in Toaster.
                                   </p>
                     </div>
-				</div>
+                </div>
                         {% else %}
-			<dt>
-				<i class="icon-question-sign get-help" title="The location in disk of the license manifest, a document listing all packages installed in your image and their licenses"></i>
-				<a href="{% url 'targetpkg' build.pk target.target.pk %}">License manifest</a>
-			</dt>
-			<dd><code>{{target.target.license_manifest_path}}</code></dd>
-			<dt>
-				<i class="icon-question-sign get-help" title="Image files are stored in <code>/build/tmp/deploy/images/</code>"></i>
-				Image files
-			</dt>
-			<dd>
-				<ul>
+            <dt>
+                <i class="icon-question-sign get-help" title="The location in disk of the license manifest, a document listing all packages installed in your image and their licenses"></i>
+
+            {% if MANAGED and build.project %}
+                License manifest
+            {% else %}
+                <a href="{% url 'targetpkg' build.pk target.target.pk %}">License manifest</a>
+            {% endif %}
+            </dt>
+            {% if MANAGED and build.project %}
+            <dd>
+                <a href="{% url 'targetpkg' build.pk target.target.pk %}">View in Toaster</a> |
+                <a href="{% url 'build_artifact' build.pk 'licensemanifest' target.target.pk %}">Download</a></dd>
+            {% else %}
+            <dd><code>{{target.target.license_manifest_path}}</code></dd>
+            {% endif %}
+            <dt>
+                <i class="icon-question-sign get-help" title="Image files are stored in <code>/build/tmp/deploy/images/</code>"></i>
+                Image files
+            </dt>
+            <dd>
+                <ul>
                                   {% for i in target.imageFiles %}
-					<li>{{i.path}}
-					({{i.size|filtered_filesizeformat}})</li>
+            {% if build.project %}
+                    <li><a href="{% url 'build_artifact' build.pk 'imagefile' i.id %}">{{i.path}}</a>
+            {% else %}
+                    <li>{{i.path}}
+            {% endif %}
+                    ({{i.size|filtered_filesizeformat}})</li>
                                   {% endfor %}
-				</ul>
-			</dd>
-		</dl>
+                </ul>
+            </dd>
+        </dl>
                         {% endif %}
-	</div>
+    </div>
         {% endif %}
-	{% endfor %}
+    {% endfor %}
 </div>
 {% endif %}
 
@@ -142,6 +157,35 @@
 <!-- error dump -->
 {%endif%}
 
+<!-- other artifacts -->
+{% if build.buildartifact_set.all.count > 0 %}
+<div class="row-fluid span10 pull-right">
+<h2>Other artifacts</h2>
+
+    <div class="well dashboard-section">
+        <dl class="dl-horizontal">
+            <dt>
+                <i class="icon-question-sign get-help" title="Build artifacts discovered in <i>tmp/deploy/images</i>. Usually kernel images and kernel modules."></i>
+                Other artifacts</dt>
+            <dd><div>
+              {% for ba in build.buildartifact_set.all|dictsort:"file_name" %}
+                {% if MANAGED and build.project %}
+                <a href="{%url 'build_artifact' build.id 'buildartifact' ba.id %}">
+                {% endif %}
+                    {{ba.get_local_file_name}}
+                {% if MANAGED and build.project %}
+                </a>
+                {% endif %}
+
+                ({{ba.file_size|filtered_filesizeformat}}) <br/>
+              {% endfor %}
+                </div>
+            </dd>
+
+    </div>
+
+</div>
+{% endif %}
 <!-- build summary -->
 <div class="row-fluid span10 pull-right">
 <h2>Build summary</h2>
@@ -158,12 +202,19 @@
             <dl>
             {% query build.task_build outcome=4 order__gt=0 as exectask%}
             {% if exectask.count > 0 %}
-                <dt>Failed tasks</td>
+                <dt>Failed tasks</dt>
                 <dd>
                 {% if exectask.count == 1 %}
                     <a class="error" href="{% url "task" build.id exectask.0.id %}">
                         {{exectask.0.recipe.name}}
                         <span class="task-name">{{exectask.0.task_name}}</span>
+
+                      {% if MANAGED and build.project %}
+                        <a href="{% url 'build_artifact' build.id "tasklogfile" exectask.0.id %}">
+                            <i class="icon-download-alt" title="" data-original-title="Download task log file"></i>
+                        </a>
+                      {% endif %}
+
                     </a>
                 {% elif exectask.count > 1%}
                     <a class="error" href="{% url "tasks" build.id %}?filter=outcome%3A4">{{exectask.count}}</a>
diff --git a/lib/toaster/toastergui/templates/configuration.html b/lib/toaster/toastergui/templates/configuration.html
index 49a6a89..d3b34a2 100644
--- a/lib/toaster/toastergui/templates/configuration.html
+++ b/lib/toaster/toastergui/templates/configuration.html
@@ -50,7 +50,9 @@
           <th>Layer</th>
           <th>Layer branch</th>
           <th>Layer commit</th>
-          <th>Layer directory</th>
+          {% if not MANAGED or not build.project %}
+              <th>Layer directory</th>
+          {% endif %}
         </tr>
       </thead>
       <tbody>{% for lv in build.layer_version_build.all|dictsort:"layer.name" %}
@@ -61,7 +63,9 @@
                 <li>{{lv.commit}}</li> </ul>">
                     {{lv.commit|truncatechars:13}}
                 </a></td>
+          {% if not MANAGED or not build.project %}
             <td>{{lv.layer.local_path}}</td>
+          {% endif %}
         </tr>{% endfor %}
       </tbody>
     </table>
diff --git a/lib/toaster/toastergui/templates/package_detail_base.html b/lib/toaster/toastergui/templates/package_detail_base.html
index cd015d3..dfeba55 100644
--- a/lib/toaster/toastergui/templates/package_detail_base.html
+++ b/lib/toaster/toastergui/templates/package_detail_base.html
@@ -135,11 +135,14 @@
             </dt>
 
             <dd class="iscommit">{{package.recipe.layer_version.commit}}</dd>
+
+          {% if not MANAGED or not build.project %}
             <dt>
                 Layer directory
                 <i class="icon-question-sign get-help" title="Path to the layer providing the recipe that builds this package"></i>
             </dt>
             <dd><code>{{package.recipe.layer_version.layer.local_path}}</code></dd>
+          {% endif %}
         </dl>
     </div> <!-- row4 well -->
     {% endblock twocolumns %}
diff --git a/lib/toaster/toastergui/templates/recipe.html b/lib/toaster/toastergui/templates/recipe.html
index a830ba9..b20c65e 100644
--- a/lib/toaster/toastergui/templates/recipe.html
+++ b/lib/toaster/toastergui/templates/recipe.html
@@ -52,16 +52,19 @@
                     Layer
                 </dt>
                 <dd>{{layer.name}}</dd>
+
+          {% if not MANAGED or not build.project %}
                 <dt>
                     <i class="icon-question-sign get-help" title="Path to the layer providing the recipe"></i>
                     Layer directory
                 </dt>
                 <dd><code>{{layer.local_path}}</code></dd>
+          {% endif %}
                 <dt>
                     <i class="icon-question-sign get-help" title="Path to the recipe .bb file"></i>
                     Recipe file
                 </dt>
-                <dd><code>{{object.file_path}}</code></dd>
+                <dd><code>{{object.get_local_path}}</code></dd>
                 {% if layer_version.branch %}
                 <dt>
                     <i class="icon-question-sign get-help" title="The Git branch of the layer providing the recipe"></i>
@@ -126,6 +129,12 @@
                     <td>
                         {% ifnotequal task.sstate_result task.SSTATE_NA %}
                         <a {{ task|task_color }} href="{% url "task" build.pk task.pk %}">{{task.get_sstate_result_display}}</a>
+                    {% if MANAGED and build.project and task.outcome = task.OUTCOME_FAILED %}
+                        <a href="{% url 'build_artifact' build.pk "tasklogfile" task.pk %}">
+                            <i class="icon-download-alt" title="" data-original-title="Download task log file"></i>
+                        </a>
+                    {% endif %}
+
                         {% endifnotequal %}
                     </td>
 
diff --git a/lib/toaster/toastergui/templates/recipes.html b/lib/toaster/toastergui/templates/recipes.html
index 791a487..889e676 100644
--- a/lib/toaster/toastergui/templates/recipes.html
+++ b/lib/toaster/toastergui/templates/recipes.html
@@ -98,8 +98,11 @@
                 {{recipe.layer_version.commit|truncatechars:13}}
             </a>
         </td>
-        <!-- Layer directory -->
-        <td class="layer_version__layer__local_path">{{recipe.layer_version.layer.local_path}}</td>
+
+        {% if not MANAGED or not build.project %}
+            <!-- Layer directory -->
+            <td class="layer_version__layer__local_path">{{recipe.layer_version.layer.local_path}}</td>
+        {% endif %}
     </tr>
 
     {% endfor %}
diff --git a/lib/toaster/toastergui/templates/target.html b/lib/toaster/toastergui/templates/target.html
index c879c39d..1309b52 100644
--- a/lib/toaster/toastergui/templates/target.html
+++ b/lib/toaster/toastergui/templates/target.html
@@ -152,9 +152,11 @@
                 {{package.recipe.layer_version.commit|truncatechars:13}}
             </a>
         </td>
-        <td class="layer_directory">
-            {{ package.recipe.layer_version.layer.local_path }}
-        </td>
+        {% if not MANAGED or not build.project %}
+            <td class="layer_directory">
+                {{ package.recipe.layer_version.layer.local_path }}
+            </td>
+        {% endif %}
     </tr>
     {% endfor %}
 
diff --git a/lib/toaster/toastergui/templates/task.html b/lib/toaster/toastergui/templates/task.html
index 1b27042..09fd25b 100644
--- a/lib/toaster/toastergui/templates/task.html
+++ b/lib/toaster/toastergui/templates/task.html
@@ -24,17 +24,17 @@
     {# executed tasks outcome #}
     <dl class="dl-horizontal">
 	{% if task.logfile %}
+	{% if MANAGED and build.project %}
+            <a class="btn btn-large" href="{% url 'build_artifact' build.id "tasklogfile" task.pk %}" style="margin:15px;">Download task log</a>
+	{% else %}
         <dt>
             <i class="icon-question-sign get-help" title="Path the task log file"></i> Log file
         </dt>
         <dd>
-	{% if MANAGED %}
-            <code><a href="{% url 'build_artifact' build.pk 'tasklogfile' task.pk %}" target="_blanc">{{task.logfile}}</a></code>
-	{% else %}
-            <code>{{task.logfile}}</code>
-	{% endif %}
+             <code>{{task.logfile}}</code>
         </dd>
 	{% endif %}
+	{% endif %}
         {# show stack trace for failed task #}
         {% if task.outcome == task.OUTCOME_FAILED and log_head %}
             <h3>Python stack trace</h3>
@@ -191,6 +191,9 @@
             <strong>Failed</strong> to restore output from sstate cache. The file was found but could not be unpacked.
         </div>
         <dl class="dl-horizontal">
+          {% if MANAGED and build.project %}
+            <a href="{% url 'build_artifact' build.id "tasklogfile" task.pk %}" style="margin:15px;">Download log</a>
+          {% else %}
             <dt>
                 <i class="icon-question-sign get-help" title="Path to the cache attempt log file"></i>
                 Log file
@@ -201,6 +204,7 @@
                 Time (secs)
             </dt>
             <dd>{{task.elapsed_time|format_none_and_zero}}</dd>
+          {% endif %}
         </dl>
         <div class="alert alert-info">
             Running the real task instead.
@@ -268,8 +272,8 @@
             Time (secs)
         </dt>
         <dd>{{task.elapsed_time|format_none_and_zero|floatformat:2}}</dd>
-		{% endif %}	
-		{% if task.cpu_usage > 0 %}	
+		{% endif %}
+		{% if task.cpu_usage > 0 %}
         <dt>
             <i class="icon-question-sign get-help" title="The percentage of task CPU utilization"></i>
             CPU usage
diff --git a/lib/toaster/toastergui/templates/tasks.html b/lib/toaster/toastergui/templates/tasks.html
index d0c6f4e..4cbcc5e 100644
--- a/lib/toaster/toastergui/templates/tasks.html
+++ b/lib/toaster/toastergui/templates/tasks.html
@@ -94,6 +94,11 @@
             <td class="outcome">
                 <a href="{%url "task" build.pk task.pk%} ">{{task.get_outcome_display}} </a>
                 <i class="icon-question-sign get-help hover-help" title="{{task.get_outcome_help}}"></i>
+                    {% if MANAGED and build.project and task.outcome = task.OUTCOME_FAILED %}
+                        <a href="{% url 'build_artifact' build.pk "tasklogfile" task.pk %}">
+                            <i class="icon-download-alt" title="" data-original-title="Download task log file"></i>
+                        </a>
+                    {% endif %}
             </td>
             <td class="cache_attempt">
                 <a href="{%url "task" build.pk task.pk%} ">{{task.get_sstate_result_display|format_none_and_zero}}</a>
@@ -107,9 +112,12 @@
             <td class="disk_io">
                 {{task.disk_io|format_none_and_zero}}
             </td>
+
+        {% if not MANAGED or not build.project %}
             <td class="task_log">
                 {{task.logfile}}
             </td>
+        {% endif %}
         </tr>
     {% endfor %}
 
@@ -124,10 +132,10 @@
         // enable blue hightlight animation for the order link
         if (location.href.search('#') > -1) {
             var task_order = location.href.split('#')[1];
-            $("#" + task_order).addClass("highlight"); 
+            $("#" + task_order).addClass("highlight");
         }
     });
-    
+
 </script>
 
 {% endblock %}
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 8301f6c..736de78 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -27,7 +27,7 @@ from django.db import IntegrityError
 from django.shortcuts import render, redirect
 from orm.models import Build, Target, Task, Layer, Layer_Version, Recipe, LogMessage, Variable
 from orm.models import Task_Dependency, Recipe_Dependency, Package, Package_File, Package_Dependency
-from orm.models import Target_Installed_Package, Target_File, Target_Image_File
+from orm.models import Target_Installed_Package, Target_File, Target_Image_File, BuildArtifact
 from django.views.decorators.cache import cache_control
 from django.core.urlresolvers import reverse
 from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
@@ -421,30 +421,36 @@ def builds(request):
                  'ordericon':_get_toggle_order_icon(request, "timespent"),
                  'orderkey' : 'timespent',
                 },
-                {'name': 'Log',
+                {'name': 'Image files', 'clclass': 'output',
+                 'qhelp': "The root file system types produced by the build. You can find them in your <code>/build/tmp/deploy/images/</code> directory",
+                    # TODO: compute image fstypes from Target_Image_File
+                },
+                ]
+            }
+
+    if not toastermain.settings.MANAGED:
+        context['tablecols'].insert(-2,
+                {'name': 'Log1',
                  'dclass': "span4",
                  'qhelp': "Path to the build main log file",
                  'clclass': 'log', 'hidden': 1,
                  'orderfield': _get_toggle_order(request, "cooker_log_path"),
                  'ordericon':_get_toggle_order_icon(request, "cooker_log_path"),
                  'orderkey' : 'cooker_log_path',
-                },
-                {'name': 'Output', 'clclass': 'output',
-                 'qhelp': "The root file system types produced by the build. You can find them in your <code>/build/tmp/deploy/images/</code> directory",
-                    # TODO: compute image fstypes from Target_Image_File
-                },
-                ]
-            }
+                }
+        )
+
 
     if toastermain.settings.MANAGED:
         context['tablecols'].append(
-            {'name': 'Project', 'clclass': 'project',
-             'filter': {'class': 'project',
+                {'name': 'Project', 'clclass': 'project',
+                 'filter': {'class': 'project',
                         'label': 'Project:',
                         'options':  map(lambda x: (x.name,'',x.build_set.filter(outcome__lt=Build.IN_PROGRESS).count()), Project.objects.all()),
 
                        }
-            })
+                }
+        )
 
 
     response = render(request, template, context)
@@ -481,12 +487,8 @@ def builddashboard( request, build_id ):
             hasImages = True
         npkg = 0
         pkgsz = 0
-        pid= 0
-        tp = Target_Installed_Package.objects.filter( target_id = t.id )
         package = None
-        for p in tp:
-            pid = p.package_id
-            package = Package.objects.get( pk = p.package_id )
+        for package in Package.objects.filter(id__in = [x.package_id for x in t.target_installed_package_set.all()]):
             pkgsz = pkgsz + package.size
             if ( package.installed_name ):
                 npkg = npkg + 1
@@ -499,7 +501,7 @@ def builddashboard( request, build_id ):
             if ( ndx < 0 ):
                 ndx = 0;
             f = i.file_name[ ndx + 1: ]
-            imageFiles.append({ 'path': f, 'size' : i.file_size })
+            imageFiles.append({ 'id': i.id, 'path': f, 'size' : i.file_size })
         if ( t.is_image and
              (( len( imageFiles ) <= 0 ) or ( len( t.license_manifest_path ) <= 0 ))):
             targetHasNoImages = True
@@ -517,6 +519,8 @@ def builddashboard( request, build_id ):
         if ( p.installed_name ):
             packageCount = packageCount + 1
 
+    logmessages = list(LogMessage.objects.filter( build = build_id ))
+
     context = {
             'build'           : build,
             'hasImages'       : hasImages,
@@ -524,7 +528,7 @@ def builddashboard( request, build_id ):
             'targets'         : targets,
             'recipecount'     : recipeCount,
             'packagecount'    : packageCount,
-            'logmessages'     : LogMessage.objects.filter( build = build_id ),
+            'logmessages'     : logmessages,
     }
     return render( request, template, context )
 
@@ -637,6 +641,9 @@ def target_common( request, build_id, target_id, variant ):
             Package, queryset, filter_string, search_term, ordering_string, 'name' )
     packages = _build_page_range( Paginator(queryset, pagesize), request.GET.get( 'page', 1 ))
 
+
+    build = Build.objects.get( pk = build_id )
+
     # bring in package dependencies
     for p in packages.object_list:
         p.runtime_dependencies = p.package_dependencies_source.filter(
@@ -697,8 +704,7 @@ eans multiple licenses exist that cover different parts of the source',
         tc_dependencies[ "hidden" ] = 1
     tc_rdependencies = {
         'name'       : 'Reverse dependencies',
-        'qhelp'      : 'Package run-time reverse dependencies (i.e. which other packages depend on t\
-his package',
+        'qhelp'      : 'Package run-time reverse dependencies (i.e. which other packages depend on this package',
         'clclass'    : 'brought_in_by',
         }
     if ( variant == 'target' ):
@@ -741,18 +747,10 @@ his package',
         'clclass'    : 'layer_commit',
         'hidden'     : 1,
         }
-    tc_layerDir = {
-        'name':'Layer directory',
-        'qhelp':'Location in disk of the layer providing the recipe that builds the package',
-        'orderfield' : _get_toggle_order( request, "recipe__layer_version__layer__local_path" ),
-        'ordericon'  : _get_toggle_order_icon( request, "recipe__layer_version__layer__local_path" )\
-,
-        'clclass'    : 'layer_directory',
-        'hidden'     : 1,
-        }
+
     context = {
         'objectname': variant,
-        'build'                : Build.objects.filter( pk = build_id )[ 0 ],
+        'build'                : build,
         'target'               : Target.objects.filter( pk = target_id )[ 0 ],
         'objects'              : packages,
         'packages_sum'         : packages_sum[ 'installed_size__sum' ],
@@ -771,10 +769,21 @@ his package',
                     tc_layer,
                     tc_layerBranch,
                     tc_layerCommit,
-                    tc_layerDir,
                 ]
         }
 
+    if not toastermain.settings.MANAGED or build.project is None:
+
+        tc_layerDir = {
+            'name':'Layer directory',
+            'qhelp':'Location in disk of the layer providing the recipe that builds the package',
+            'orderfield' : _get_toggle_order( request, "recipe__layer_version__layer__local_path" ),
+            'ordericon'  : _get_toggle_order_icon( request, "recipe__layer_version__layer__local_path" ),
+            'clclass'    : 'layer_directory',
+            'hidden'     : 1,
+        }
+        context['tablecols'].append(tc_layerDir)
+
     response = render(request, template, context)
     _save_parameters_cookies(response, pagesize, orderby, request)
     return response
@@ -1136,12 +1145,13 @@ def tasks_common(request, build_id, variant, task_anchor):
     }
     if   'diskio' == variant: tc_diskio['hidden']='0'; del tc_diskio['clclass']; tc_cache['hidden']='1';
 
+    build = Build.objects.get(pk=build_id)
 
     context = { 'objectname': variant,
                 'object_search_display': object_search_display,
                 'filter_search_display': filter_search_display,
                 'title': title_variant,
-                'build': Build.objects.get(pk=build_id),
+                'build': build,
                 'objects': tasks,
                 'default_orderby' : orderby,
                 'search_term': search_term,
@@ -1157,9 +1167,12 @@ def tasks_common(request, build_id, variant, task_anchor):
                     tc_time,
                     tc_cpu,
                     tc_diskio,
-                    tc_log,
                 ]}
 
+
+    if not toastermain.settings.MANAGED or build.project is None:
+        context['tablecols'].append(tc_log)
+
     response = render(request, template, context)
     _save_parameters_cookies(response, pagesize, orderby, request)
     return response
@@ -1206,9 +1219,11 @@ def recipes(request, build_id):
             revlist.append(recipe_dep)
         revs[recipe.id] = revlist
 
+    build = Build.objects.get(pk=build_id)
+
     context = {
         'objectname': 'recipes',
-        'build': Build.objects.get(pk=build_id),
+        'build': build,
         'objects': recipes,
         'default_orderby' : 'name:+',
         'recipe_deps' : deps,
@@ -1279,6 +1294,11 @@ def recipes(request, build_id):
                 'qhelp':'The Git commit of the layer providing the recipe',
                 'clclass': 'layer_version__layer__commit', 'hidden': 1,
             },
+            ]
+        }
+
+    if not toastermain.settings.MANAGED or build.project is None:
+        context['tablecols'].append(
             {
                 'name':'Layer directory',
                 'qhelp':'Path to the layer prodiving the recipe',
@@ -1286,9 +1306,8 @@ def recipes(request, build_id):
                 'ordericon':_get_toggle_order_icon(request, "layer_version__layer__local_path"),
                 'orderkey' : 'layer_version__layer__local_path',
                 'clclass': 'layer_version__layer__local_path', 'hidden': 1,
-            },
-            ]
-        }
+            })
+
 
     response = render(request, template, context)
     _save_parameters_cookies(response, pagesize, orderby, request)
@@ -2685,41 +2704,53 @@ if toastermain.settings.MANAGED:
         return render(request, template, context)
 
 
+    def _file_name_for_artifact(b, artifact_type, artifact_id):
+        file_name = None
+        # Target_Image_File file_name
+        if artifact_type == "imagefile":
+            file_name = Target_Image_File.objects.get(target__build = b, pk = artifact_id).file_name
 
-    def build_artifact(request, build_id, artifact_type, artifact_id):
-        try:
-            b = Build.objects.get(pk=build_id)
-            if b.buildrequest is None or b.buildrequest.environment is None:
-                raise Exception("Cannot download file")
+        elif artifact_type == "cookerlog":
+            file_name = b.cooker_log_path
+
+        elif artifact_type == "buildartifact":
+            file_name = BuildArtifact.objects.get(build = b, pk = artifact_id).file_name
 
-            file_name = None
-            fsock = None
-            content_type='application/force-download'
-            # Target_Image_File file_name
-            # Task logfile
-            if artifact_type == "tasklogfile":
-                file_name = Task.objects.get(build = b, pk = artifact_id).logfile
+        elif artifact_type ==  "licensemanifest":
+            file_name = Target.objects.get(build = b, pk = artifact_id).license_manifest_path
 
-            # Task path_to_sstate_obj
-            # Package_File path
-            # Recipe file_path
-            # VariableHistory file_name
-            # LogMessage pathname
-            if artifact_type == "logmessagefile":
-                file_name = LogMessage.objects.get(build = b, pk = artifact_id).pathname
+        elif artifact_type == "tasklogfile":
+            file_name = Task.objects.get(build = b, pk = artifact_id).logfile
 
-            if file_name is not None:
-                content_type = b.buildrequest.environment.get_artifact_type(file_name)
-                fsock = b.buildrequest.environment.get_artifact(file_name)
-                file_name = os.path.basename(file_name)
+        elif artifact_type == "logmessagefile":
+            file_name = LogMessage.objects.get(build = b, pk = artifact_id).pathname
+        else:
+            raise Exception("FIXME: artifact type %s not implemented" % (artifact_type))
 
-            response = HttpResponse(fsock, content_type = content_type)
+        return file_name
 
-            # returns a file from the environment
-            response['Content-Disposition'] = 'attachment; filename=' + file_name
-            return response
-        except:
-            raise
+
+    def build_artifact(request, build_id, artifact_type, artifact_id):
+        b = Build.objects.get(pk=build_id)
+        if b.buildrequest is None or b.buildrequest.environment is None:
+            raise Exception("Artifact not available for download (missing build request or build environment)")
+
+        file_name = _file_name_for_artifact(b, artifact_type, artifact_id)
+        fsock = None
+        content_type='application/force-download'
+
+        if file_name is None:
+            raise Exception("Could not handle artifact %s id %s" % (artifact_type, artifact_id))
+        else:
+            content_type = b.buildrequest.environment.get_artifact_type(file_name)
+            fsock = b.buildrequest.environment.get_artifact(file_name)
+            file_name = os.path.basename(file_name) # we assume that the build environment system has the same path conventions as host
+
+        response = HttpResponse(fsock, content_type = content_type)
+
+        # returns a file from the environment
+        response['Content-Disposition'] = 'attachment; filename=' + file_name
+        return response
 
 
 
@@ -2856,3 +2887,6 @@ else:
 
     def projects(request):
         raise Exception("page not available in interactive mode")
+
+    def xhr_importlayer(request):
+        raise Exception("page not available in interactive mode")
-- 
1.9.1


