Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
	[209.85.212.171])
	by mail.openembedded.org (Postfix) with ESMTP id 802FE7239F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 17:08:14 +0000 (UTC)
Received: by mail-wi0-f171.google.com with SMTP id bs8so16372882wib.4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 09:08:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=pg80wtYozStW3P4+9BB137Aiw2XqkjaR9UshQ5bxpqM=;
	b=bhn5MM2diSBDQwpSP0Yftqzug8cXg6pDe0uB45oZEAsrW18JmapEzjM8Aj9ZtWBpOa
	RyJvFdxsLV63xzt48n26yuItmzw/3aYisVIf+RpI1g0avKdMjTB72EdoxNsVKEeAIIWd
	sPr24/Q/GPVUMCf4JMHzSAT1foQL1xIkUPVio7rjlpQ5wrizWKdgBDsRgidAhRQYJFHb
	xN3ZLAx36z3Kw3p9eGNwe6FZ9Kjk8R70aShZ0tE4qbpKVeFzvMfc3htV+3RLcw9xn/jY
	3NlogCesMkVH1dWpScOuf7FPeDvx+cDTyAWPu8Ou3OIvBBOhwmYOF57ZBrB/jefEsgKr
	FnlA==
X-Gm-Message-State: ALoCoQkrmHEJwoPnCGMN6PQBnqty1N7i+JKVgh8K/ek/holVH0tQriPZm8pCKehOCLoo8/P/5jDP
X-Received: by 10.180.198.211 with SMTP id je19mr668105wic.27.1417108094973;
	Thu, 27 Nov 2014 09:08:14 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id a2sm12416196wiy.11.2014.11.27.09.08.10
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 27 Nov 2014 09:08:11 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 114A5563F4C; Thu, 27 Nov 2014 17:08:07 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Nov 2014 17:08:04 +0000
Message-Id: <9a90bf201dab83060f0bdd6ac08c72b8d62f6060.1417107946.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <9f3cf52b3a96768e5b9764dde02833b078fe61e4.1417107946.git.alexandru.damian@intel.com>
References: <9f3cf52b3a96768e5b9764dde02833b078fe61e4.1417107946.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1417107946.git.alexandru.damian@intel.com>
References: <cover.1417107946.git.alexandru.damian@intel.com>
Cc: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Subject: [PATCH 13/14] toaster: release name consistency
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
X-List-Received-Date: Thu, 27 Nov 2014 17:08:14 -0000

From: Belen Barros Pena <belen.barros.pena@linux.intel.com>

Small changes to the project, new project and all layers
pages to ensure consitency in release naming across the
interface.

The changes are:

* In the new project page, change the label 'release version' to
'release'

* In the new project page, sort the releases in the dropdown menu
in ascending alphabetical order

* In the new project page, remove the release name that was
showing between brackets after the release description in the
dropdown menu

* In the project page, make sure the release information
shows the release description field instead of the release name,
to keep consistency with the new project page

* In the all layers page, provide some help text for the branch 'HEAD'

Signed-off-by: Belen Barros Pena <belen.barros.pena@linux.intel.com>
---
 lib/toaster/toastergui/templates/layers.html     | 9 ++++++++-
 lib/toaster/toastergui/templates/newproject.html | 4 ++--
 lib/toaster/toastergui/templates/project.html    | 4 ++--
 lib/toaster/toastergui/views.py                  | 4 ++--
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/lib/toaster/toastergui/templates/layers.html b/lib/toaster/toastergui/templates/layers.html
index 4e92332..ced54c2 100644
--- a/lib/toaster/toastergui/templates/layers.html
+++ b/lib/toaster/toastergui/templates/layers.html
@@ -52,7 +52,14 @@
             <a target="_blank" href="{{ o.get_vcs_dirpath_link_url }}"><i class="icon-share get-info"></i></a>
                 {% endif %}
         </td>
-            <td class="branch">{% if o.branch %}{{o.branch}}{% else %}{{o.up_branch.name}}{% endif %}</td>
+            <td class="branch">
+                {% if o.branch %}
+                    {{o.branch}}
+                {% else %}
+                    {{o.up_branch.name}}
+                    <i class="icon-question-sign get-help hover-help" title="Your builds will use the tip of the branch you have cloned or downloaded to your computer, so nothing will be fetched"></i>
+                {% endif %}
+            </td>
             <td class="dependencies">
         {% with ods=o.dependencies.all%}
             {% if ods.count %}
diff --git a/lib/toaster/toastergui/templates/newproject.html b/lib/toaster/toastergui/templates/newproject.html
index 5a5e1e6..512a8fa 100644
--- a/lib/toaster/toastergui/templates/newproject.html
+++ b/lib/toaster/toastergui/templates/newproject.html
@@ -18,12 +18,12 @@
               <input type="text" class="input-xlarge" required id="new-project-name" name="projectname">
        {% if releases.count > 1 %}
               <label class="project-form">
-                Release version
+                Release
                 <i class="icon-question-sign get-help" title="The version of the build system you want to use"></i>
               </label>
               <select name="projectversion" id="projectversion">
   {% for release in releases %}
-    <option value="{{release.id}}"{%if projectversion == release.id %} selected{%endif%}>{{release.description}} ({{release.name}})</option>
+    <option value="{{release.id}}"{%if projectversion == release.id %} selected{%endif%}>{{release.description}}</option>
   {% endfor %}
               </select>
   {% for release in releases %}
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index 0b2821c..fdfc3af 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -350,13 +350,13 @@ vim: expandtab tabstop=2
       <i class="icon-question-sign get-help heading-help" title="The version of the build system you want to use"></i>
     </h3>
     <p class="lead" id="change-project-version-opposite">
-      <span id="project-version">{[project.release.name]}</span>
+      <span id="project-version">{[project.release.desc]}</span>
       <i id="change-version" class="icon-pencil" ng-click="toggle('#change-project-version')" ></i>
     </p>
     <div class="div-inline" id="change-project-version" style="display:none;">
       <form ng-submit="test('#change-project-version')" class="input-append">
         <select id="select-version" ng-model="projectVersion">
-          <option ng-repeat="r in releases" value="{[r.id]}" ng-selected="r.id == project.release.id">{[r.name]}</option>
+          <option ng-repeat="r in releases" value="{[r.id]}" ng-selected="r.id == project.release.id">{[r.description]}</option>
         </select>
         <input type="submit" class="btn" style="margin-left:5px;" value="Save" ng-disabled="project.release.id == projectVersion"/>
         <input type="reset"  class="btn btn-link" value="Cancel" ng-click="toggle('#change-project-version')" ng-disabled="project.release.id == projectVersion"/>
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 49a7769..8301f6c 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1893,7 +1893,7 @@ if toastermain.settings.MANAGED:
         context = {
             'email': request.user.email if request.user.is_authenticated() else '',
             'username': request.user.username if request.user.is_authenticated() else '',
-            'releases': Release.objects.order_by("id"),
+            'releases': Release.objects.order_by("description"),
         }
 
         try:
@@ -2016,7 +2016,7 @@ if toastermain.settings.MANAGED:
                     prj.projectlayer_set.all().order_by("id")),
             "targets" : map(lambda x: {"target" : x.target, "task" : x.task, "pk": x.pk}, prj.projecttarget_set.all()),
             "freqtargets": freqtargets,
-            "releases": map(lambda x: {"id": x.pk, "name": x.name}, Release.objects.all()),
+            "releases": map(lambda x: {"id": x.pk, "name": x.name, "description":x.description}, Release.objects.all()),
         }
         try:
             context["machine"] = {"name": prj.projectvariable_set.get(name="MACHINE").value}
-- 
1.9.1


