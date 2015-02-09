Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f176.google.com (mail-pd0-f176.google.com
	[209.85.192.176])
	by mail.openembedded.org (Postfix) with ESMTP id A219A606E9
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Feb 2015 18:02:06 +0000 (UTC)
Received: by pdbft15 with SMTP id ft15so32793321pdb.11
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Feb 2015 10:02:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=HvDfieFaE4DduJuT8idL8BQKZcNnN8OZTDAPqOv4yUg=;
	b=e1c3t0H5/0mSQkOzFH2Zun2WzbjOd8YezUSty+T6jjROxb3wEhSgKlI81CZMAdHok2
	XGJOSqU2Yt7ndFkqjRwA6uXYsrvhAPm2EPJMnNzYzz1llFU1bXOsegw0uhey4SGLBapx
	Am7H7vfLheu44dcN1/roKBP8yhCp5Ht62CoymXV5BKJ8VDm881M4tqiqYWxToPU1FA59
	Ed5E/zV+WqGpx9sP+sMz/LSaj4x3uRVdqR6p2G+Gg18UsMYTkBai6Yi2K3mJyTwQwiDZ
	X+Z9F1m32XFZliE0c889j9CypBFVHz2ks3k4fJQvLOlpUujXc5b9711mDRMFwy/PMkju
	/2jA==
X-Gm-Message-State: ALoCoQm2XCW0d++3wJYokdHGiqK8myccjLzc/404O0SuWTOqmg6jzLqFpffLTrXB01xjGfcqp1G6
X-Received: by 10.66.120.236 with SMTP id lf12mr31687240pab.67.1423504927853; 
	Mon, 09 Feb 2015 10:02:07 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	tn2sm16982843pbc.15.2015.02.09.10.02.04
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 09 Feb 2015 10:02:06 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 577775661A5; Mon,  9 Feb 2015 18:01:58 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Feb 2015 18:01:41 +0000
Message-Id: <49d85b7035d12a6e482d608e828f69fcafb59d39.1423504574.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
References: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1423504574.git.alexandru.damian@intel.com>
References: <cover.1423504574.git.alexandru.damian@intel.com>
Subject: [PATCH 11/27] toastergui: add the word 'compatible' to 'all' pages
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
X-List-Received-Date: Mon, 09 Feb 2015 18:02:06 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Labels for the 'all' pages don't really convey what's provided in them.
The team has suggested we add the word 'compatible' to them,
to make clear they will show all layers / targets / machines that
can be built with the version of the build system you are
using in a certain project. A link like 'view all targets'
becomes 'view all compatible targets'.

I've also added some help text.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/static/css/default.css      |  2 +-
 lib/toaster/toastergui/templates/layerdetails.html |  2 +-
 lib/toaster/toastergui/templates/layers.html       |  6 +++---
 lib/toaster/toastergui/templates/machines.html     |  6 +++---
 lib/toaster/toastergui/templates/project.html      | 24 ++++++++++++++--------
 lib/toaster/toastergui/templates/targets.html      |  6 +++---
 6 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index a866773..41b73cc 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -34,7 +34,7 @@
 .get-help-yellow:hover { color: #B38942; cursor: pointer; }
 .get-help-red { color: #B94A48; font-size: 16px; padding-left: 2px; }
 .get-help-red:hover { color: #943A38; cursor: pointer; }
-.build-form .get-help { margin-left: 5px; }
+.build-form>i:first-of-type { margin-left: 5px; }
 .manual { margin: 11px 15px;}
 .heading-help { font-size: 14px; }
 
diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index 6705215..7a1a22d 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -3,7 +3,7 @@
 {% load humanize %}
 {% load static %}
 {% block localbreadcrumb %}
-<li><a href="{% url 'layers' %}">All layers</a></li>
+<li><a href="{% url 'layers' %}">All compatible layers</a></li>
 <li>
   {{layerversion.layer.name}} ({{layerversion.commit|truncatechars:13}})
 </li>
diff --git a/lib/toaster/toastergui/templates/layers.html b/lib/toaster/toastergui/templates/layers.html
index 33160e5..0943c39 100644
--- a/lib/toaster/toastergui/templates/layers.html
+++ b/lib/toaster/toastergui/templates/layers.html
@@ -3,7 +3,7 @@
 {% load humanize %}
 
 {% block localbreadcrumb %}
-<li>Layers</li>
+<li>All compatible layers</li>
 {% endblock %}
 
 {% block projectinfomain %}
@@ -14,9 +14,9 @@
   {% elif request.GET.filter and total_count ==  0 or request.GET.search and total_count == 0 %}
       No layers found
   {%else%}
-      All layers
+      All compatible layers
   {%endif%}
-                        <i class="icon-question-sign get-help heading-help" title="This page lists all the layers compatible with {{project.release.name}} that Toaster knows about."></i>
+                        <i class="icon-question-sign get-help heading-help" title="This page lists all the layers compatible with the release selected for this project, which is {{project.release.description}}"></i>
                      </h1>
                 </div>
 
diff --git a/lib/toaster/toastergui/templates/machines.html b/lib/toaster/toastergui/templates/machines.html
index 18e7485..e0bda51 100644
--- a/lib/toaster/toastergui/templates/machines.html
+++ b/lib/toaster/toastergui/templates/machines.html
@@ -3,14 +3,14 @@
 {% load humanize %}
 
 {% block localbreadcrumb %}
-<li>Machines</li>
+<li>All compatible machines</li>
 {% endblock %}
 
 {% block projectinfomain %}
                 <div class="page-header">
                     <h1>
-                        All machines
-                        <i class="icon-question-sign get-help heading-help" title="This page lists all the machines compatible with Yocto Project 1.7 'Dxxxx' that Toaster knows about. They include community-created targets suitable for use on top of OpenEmbedded Core and any targets you have imported"></i>
+                        All compatible machines
+                        <i class="icon-question-sign get-help heading-help" title="This page lists all the machines compatible with the release selected for this project, which is {{project.release.description}}"></i>
                      </h1>
                 </div>
                 <!--div class="alert">
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index 3b75d19..2c9cd81 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -1,4 +1,4 @@
-{% extends "baseprojectpage.html" %}
+ {% extends "baseprojectpage.html" %}
 <!--
 vim: expandtab tabstop=2
 -->
@@ -98,9 +98,8 @@ vim: expandtab tabstop=2
       </div>
       <i class="icon-question-sign get-help get-help-blue" title="Type the name of one or more targets you want to build, separated by a space. You can also specify a task by appending a semicolon and a task name to a target name, like so: <code>core-image-minimal:do_build</code>"></i>
       <p>
-        <a href="{% url 'all-targets' %}">
-          View all targets
-        </a>
+        <a href="{% url 'all-targets' %}">View all compatible targets</a>
+        <i class="icon-question-sign get-help get-help-blue heading-help" title="View all the targets you can build with the release selected for this project, which is {[project.release.desc]}"></i>
         {% if completedbuilds.count %}
           | <a href="{% url 'projectbuilds' project.id %}">View all project builds ({{completedbuilds.count}})</a>
         {% endif %}
@@ -256,7 +255,7 @@ vim: expandtab tabstop=2
         <p>
         You can:
           <ul>
-            <li> <a href="{% url 'layers'%}">View all layers available in Toaster</a>
+            <li> <a href="{% url 'layers'%}">View all compatible layers available in Toaster</a>
             <li> <a href="{% url 'importlayer' %}">Import a layer</a>
             <li> <a href="https://www.yoctoproject.org/docs/1.6.1/dev-manual/dev-manual.html#understanding-and-creating-layers" target="_blank">Read about layers in the manual</a>
           </ul>
@@ -270,7 +269,11 @@ vim: expandtab tabstop=2
         </div>
         {% csrf_token %}
       </form>
-      <p><a href="{% url 'layers' %}">View all layers</a> | <a href="{% url 'importlayer' %}">Import layer</a></p>
+      <p>
+        <a href="{% url 'layers' %}">View all compatible layers</a>
+        <i class="icon-question-sign get-help" title="View all the layers you can build with the release selected for this project, which is {[project.release.desc]}"></i>
+        |
+        <a href="{% url 'importlayer' %}">Import layer</a></p>
       <ul class="unstyled configuration-list">
           <li ng-repeat="l in layers track by l.id" class="animate-repeat">
             <a href="{[l.layerdetailurl]}" target="_#" class="layer-info" data-toggle="tooltip" tooltip="{[l.giturl]} | {[l.branch.name]}">{[l.name]}</a>
@@ -295,7 +298,9 @@ vim: expandtab tabstop=2
           {% csrf_token %}
         </form>
         <p>
-          <a href="{% url 'all-targets' %}">View all targets</a></p>
+          <a href="{% url 'all-targets' %}">View all compatible targets</a>
+          <i class="icon-question-sign get-help" title="View all the targets you can build with the release selected for this project, which is {[project.release.desc]}"></i>
+        </p>
         <div ng-if="frequenttargets.length">
         <h4 class="air">
             Most built targets
@@ -332,7 +337,10 @@ vim: expandtab tabstop=2
               <input type="reset" id="cancel-machine" class="btn btn-link" ng-click="toggle('#select-machine')" value="Cancel"></input>
               {% csrf_token %}
         </form>
-        <p><a href="{% url 'machines' %}" class="link">View all machines</a></p>
+        <p>
+          <a href="{% url 'machines' %}" class="link">View all compatible machines</a>
+        <i class="icon-question-sign get-help" title="View all the machines you can set with the release selected for this project, which is {[project.release.desc]}"></i>
+      </p>
       </div>
       <p class="link-action">
             <a href="{% url 'projectconf' project.id %}" class="link">Edit configuration variables</a>
diff --git a/lib/toaster/toastergui/templates/targets.html b/lib/toaster/toastergui/templates/targets.html
index 3038649..32c67ea 100644
--- a/lib/toaster/toastergui/templates/targets.html
+++ b/lib/toaster/toastergui/templates/targets.html
@@ -3,7 +3,7 @@
 {% load humanize %}
 
 {% block localbreadcrumb %}
-<li>Targets</li>
+<li>All compatible targets</li>
 {% endblock %}
 
 {% block projectinfomain %}
@@ -14,9 +14,9 @@
   {% elif request.GET.filter and objects.paginator.count ==  0 or request.GET.search and objects.paginator.count == 0 %}
       No targets found
   {%else%}
-      All targets
+      All compatible targets
   {%endif%}
-                        <i class="icon-question-sign get-help heading-help" title="This page lists all the targets compatible with " + {{project.release.name}} + " that Toaster knows about."></i>
+                        <i class="icon-question-sign get-help heading-help" title="This page lists all the targets compatible with the release selected for this project, which is {{project.release.description}}"></i>
                      </h1>
                 </div>
 
-- 
1.9.1


