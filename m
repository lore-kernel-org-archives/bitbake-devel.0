Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f179.google.com (mail-pd0-f179.google.com
	[209.85.192.179])
	by mail.openembedded.org (Postfix) with ESMTP id 458F57373A
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Feb 2015 17:21:07 +0000 (UTC)
Received: by pdjz10 with SMTP id z10so34828039pdj.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Feb 2015 09:21:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=ES/hLr41KNat9HuQsSgC6ieWB8T7OEm4hSmvb9ztXoc=;
	b=TAYN0uapua5aWH772dJ3UbZdEbn0no0nhQQxj6TnsCK5VWeOa5yLepFFpYHdtUfa+e
	VK/36aGA6YtwSodzbeFs7qxvB0nryNHFF3YBSEIfSO6wcqcL6T0y1+4edZMpMmACfh2C
	6QgyGKuLRbFF0MN/G+FRPhbYrwxVbzGvqkford6KGWabJJPssU70IySHGSm2u2YdYzxY
	71ehPUT9WgmsPEi2dh/OIiKn9BFN64cMM+Iw+eKcMYl/aQLg79ql/g9R1A/GhLFgS3kB
	f4eg98SV7HYl3CGy1k2jmDhAdXsoK8X3F0AHzgX59q1BOI8mMXjzf4l/4ZCDyXMI5i1P
	H9lA==
X-Gm-Message-State: ALoCoQkpjMDca56aM67EZZ2vANDTiKv5PboMnQ90BCjGdwZ3T+FCum42tVZa4TvCW9FQJy/Gvwrf
X-Received: by 10.70.103.162 with SMTP id fx2mr30916363pdb.24.1424798469324;
	Tue, 24 Feb 2015 09:21:09 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	qa1sm31782235pdb.84.2015.02.24.09.21.07
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 24 Feb 2015 09:21:08 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 98EE656192B; Tue, 24 Feb 2015 17:21:01 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Feb 2015 17:20:55 +0000
Message-Id: <25c2fc976db2894db6ba82010258d2930a08f716.1424798369.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <50c0fc6c7d6afead28271d2f2501f025eb0b160e.1424798369.git.alexandru.damian@intel.com>
References: <50c0fc6c7d6afead28271d2f2501f025eb0b160e.1424798369.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424798369.git.alexandru.damian@intel.com>
References: <cover.1424798369.git.alexandru.damian@intel.com>
Subject: [PATCH 07/12] toasterui: improving the latest builds consistency
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
X-List-Received-Date: Tue, 24 Feb 2015 17:21:11 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

We have 2 pages where we have a 'latest builds' section:
the 'all builds / all projects' page and the 'project'
page. Unfortunately, we are currently using different
code base in both, which means that some inconsistencies
between the two in behaviour and presentation have sneaked
in.

This patch addresses some of such inconsistencies.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/static/css/default.css      |  1 +
 .../toastergui/templates/managed_mrb_section.html  | 27 +++++++++++++---------
 lib/toaster/toastergui/templates/project.html      | 10 ++++----
 3 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index 277888b..0cf0f19 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -145,6 +145,7 @@ select { width: auto; }
 /* styles for showing the project name in build mode */
 .project-name { padding-top: 0; }
 .project-name .label { font-weight: normal; margin-bottom: 5px; margin-left: -15px; padding: 5px; }
+.project-name .label > a { color: #fff; font-weight: normal; }
 
 /* Remove bottom margin for forms inside modal dialogs */
 #dependencies_modal_form { margin-bottom: 0px; }
diff --git a/lib/toaster/toastergui/templates/managed_mrb_section.html b/lib/toaster/toastergui/templates/managed_mrb_section.html
index b8d087a..08bb05d 100644
--- a/lib/toaster/toastergui/templates/managed_mrb_section.html
+++ b/lib/toaster/toastergui/templates/managed_mrb_section.html
@@ -15,7 +15,9 @@
 
     <div class="alert {%if build.outcome == build.SUCCEEDED%}alert-success{%elif build.outcome == build.FAILED%}alert-error{%else%}alert-info{%endif%} {% if MANAGED and build.project %}project-name{% endif %} ">
     {% if MANAGED and build.project %}
-       <span class="label {%if build.outcome == build.SUCCEEDED%}label-success{%elif build.outcome == build.FAILED%}label-danger{%else%}label-info{%endif%}"> {{build.project.name}} </span>
+       <span class="label {%if build.outcome == build.SUCCEEDED%}label-success{%elif build.outcome == build.FAILED%}label-important{%else%}label-info{%endif%}">
+        <a href="{% url 'project' build.project.id %}"> {{build.project.name}} </a>
+       </span>
     {% endif %}
 
         <div class="row-fluid">
@@ -29,6 +31,7 @@
                 </a>
     {% endif %}
             </div>
+    {%if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
             <div class="span2 lead">
                 {% if build.completed_on|format_build_date  %}
                     {{ build.completed_on|date:'d/m/y H:i' }}
@@ -36,7 +39,6 @@
                     {{ build.completed_on|date:'H:i' }}
                 {% endif %}
             </div>
-    {%if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
             <div class="span2 lead">
       {% if  build.errors_no %}
                 <i class="icon-minus-sign red"></i> <a href="{%url 'builddashboard' build.pk%}#errors" class="error">{{build.errors_no}} error{{build.errors_no|pluralize}}</a>
@@ -52,12 +54,13 @@
                 Build time: <a href="{% url 'buildtime' build.pk %}">{{ build.timespent|sectohms }}</a>
               </span>
           {% if build.project %}
-              <button class="btn {%if build.outcome == build.SUCCEEDED%}btn-success{%elif build.outcome == build.FAILED%}btn-danger{%else%}btn-info{%endif%} pull-right" onclick='scheduleBuild({% url 'xhr_projectbuild' build.project.id as bpi%}{{bpi|json}}, {{build.project.name|json}}, {{build.get_sorted_target_list|mapselect:'target'|json}})'>Run again</button>
+              <button class="btn {%if build.outcome == build.SUCCEEDED%}btn-success{%elif build.outcome == build.FAILED%}btn-danger{%else%}btn-info{%endif%} pull-right" onclick='scheduleBuild({% url 'xhr_projectbuild' build.project.id as bpi%}{{bpi|json}}, {{build.project.name|json}},
+{% url 'project' buildrequest.project.id as bpurl%}{{bpurl|json}}, {{build.get_sorted_target_list|mapselect:'target'|json}})'>Run again</button>
           {% endif %}
             </div>
     {%endif%}
     {%if build.outcome == build.IN_PROGRESS %}
-            <div class="span4">
+            <div class="span4 offset1">
                 <div class="progress" style="margin-top:5px;" data-toggle="tooltip" title="{{build.completeper}}% of tasks complete">
                     <div style="width: {{build.completeper}}%;" class="bar"></div>
                 </div>
@@ -73,7 +76,9 @@
 
 
   <div class="alert {% if buildrequest.state  == buildrequest.REQ_FAILED %}alert-error{% else %}alert-info{% endif %} project-name">
-       <span class="label label-danger"> {{buildrequest.project.name}} </span>
+       <span class="label {% if buildrequest.state  == buildrequest.REQ_FAILED %}label-important{% else%}label-info{% endif %}">
+        <a href="{% url 'project' buildrequest.project.id %}"> {{buildrequest.project.name}} </a>
+       </span>
     <div class="row-fluid">
 
           {% if buildrequest.state == buildrequest.REQ_FAILED %}
@@ -100,7 +105,7 @@
               <span class="lead{%if not MANAGED or not buildrequest.project%} pull-right{%endif%}">
                 Build time: {{ buildrequest.get_duration|sectohms }}
               </span>
-              <button class="btn btn-danger pull-right" onclick='scheduleBuild({% url 'xhr_projectbuild' buildrequest.project.id as bpi%}{{bpi|json}}, {{buildrequest.project.name|json}}, {{buildrequest.get_sorted_target_list|mapselect:'target'|json}})'>Run again</button>
+              <button class="btn btn-danger pull-right" onclick='scheduleBuild({% url 'xhr_projectbuild' buildrequest.project.id as bpi%}{{bpi|json}},  {{buildrequest.project.name|json}}, {% url 'project' buildrequest.project.id as bpurl%}|{{bpurl|json}}, {{buildrequest.get_sorted_target_list|mapselect:'target'|json}})'>Run again</button>
 
             </div>
 
@@ -111,7 +116,7 @@
 
                 <span data-toggle="tooltip" {%if buildrequest.brtarget_set.all.count > 1%}title="Targets: {%for target in buildrequest.brtarget_set.all%}{{target.target}} {%endfor%}"{%endif%}>{{buildrequest.brtarget_set.all.0.target}} {%if buildrequest.brtarget_set.all.count > 1%}(+ {{buildrequest.brtarget_set.all.count|add:"-1"}}){%endif%} </span>
             </div>
-            <div class="span4 lead" >Build queued
+            <div class="span4 lead">Build queued
               <i title="This build will start as soon as a build server is available" class="icon-question-sign get-help get-help-blue heading-help" data-toggle="tooltip"></i>
             </div>
 
@@ -172,13 +177,13 @@ function _makeXHRBuildCall(url, data, onsuccess, onfail) {
 }
 
 
-function scheduleBuild(url, projectName, buildlist) {
+function scheduleBuild(url, projectName, projectUrl, buildlist) {
   console.log("scheduleBuild");
   _makeXHRBuildCall(url, {targets: buildlist.join(" ")}, function (_data) {
 
-      $('#latest-builds').prepend('<div class="alert alert-info" style="padding-top:0px">' + '<span class="label label-info" style="font-weight: normal; margin-bottom: 5px; margin-left:-15px; padding-top:5px;">'+projectName+'</span><div class="row-fluid">' +
-  '<div class="span4 lead">' + buildlist.join(" ") +
-  '</div><div class="span4 lead pull-right">Build queued. Your build will start shortly.</div></div></div>');
+      $('#latest-builds').prepend("<div class=\"alert alert-info project-name\"><span class=\"label label-info\"><a href=\""+projectUrl+"\">"+projectName+"</a></span><div class=\"row-fluid\">" +
+  "<div class=\"span5 lead\">" + buildlist.join(" ") +
+  "</div><div class=\"span4 lead\">Build queued <i title=\"This build will start as soon as a build server is available\" class=\"icon-question-sign get-help get-help-blue heading-help\"></i></div></div></div>");
   });
 }
 
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index a1cce33..a8cb917 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -165,17 +165,17 @@ vim: expandtab tabstop=2
           </case>
 
           <case ng-switch-when="created">
-            <div class="lead span3"> <span ng-repeat="t in b.targets" ng-include src="'target_display'"></span>   </div>
-            <div class="span6" >
+            <div class="lead span5"> <span ng-repeat="t in b.targets" ng-include src="'target_display'"></span>   </div>
+            <div class="span4">
               <span class="lead">Creating build</span>
             </div>
             <button class="btn pull-right btn-info" ng-click="buildCancel(b)">Cancel</button>
           </case>
 
           <case ng-switch-when="deleted">
-            <div class="lead span3"> <span ng-repeat="t in b.targets" ng-include src="'target_display'"></span>   </div>
-            <div class="span6" id="{[b.id]}-deleted" >
-              <span class="lead">Build deleted</span>
+            <div class="lead span5"> <span ng-repeat="t in b.targets" ng-include src="'target_display'"></span>   </div>
+            <div class="span4" id="{[b.id]}-deleted" >
+              <span class="lead">Build cancelled</span>
             </div>
             <button class="btn pull-right btn-info" ng-click="buildDelete(b)">Close</button>
           </case>
-- 
1.9.1


