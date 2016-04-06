Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
	by mail.openembedded.org (Postfix) with ESMTP id 377667710D
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:33 +0000 (UTC)
Received: by mail-wm0-f54.google.com with SMTP id l6so73378708wml.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=P82ZIABMYZ+71fN/EpYdjBQtl/4bZ/VGxolEKktASMA=;
	b=XXzfjcxcLBClRAcB7qWI4THhhIBhEdbEuaMj/j5sNe/rI7Iutj3rATz4J9cFlsG6/y
	HYrUoIR3XX184IYg/CUZJ8Uj2GuUB+KHl/h2wTdJDCXJmu+WIvXbEt6VMgmVHRtuFfQe
	DU7WtGarQjwYpaXRobtw1XT8/wZ1k/NXcRfubJELnkv+vmNv+TZ8+DLVSEGDooxptDNX
	eoqJlrEN/n3Kb3S7YNv9DIUyShbSdMMX9PshOoHgVk3M3AL1ENynytmIG40lV37b9r0t
	GQwQP7/jeoV6k1yWIpYtTP4nMjzLag6p3GM5gHPdykiD30LNcwz1CccsHfpo3V+R+DWq
	bavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=P82ZIABMYZ+71fN/EpYdjBQtl/4bZ/VGxolEKktASMA=;
	b=ApPVdop/YOhv6J5z7dMXBBjkYm6NzJ2MRgS2xxmJx56FhWDMOJVgm27S+HqRFo+Xil
	iS6PZlyNouZPrmPFrxZiRM3nb3nZ1pbiwKm11dQHgIUpy0bCoFzPijPAWG2k0rljdx/D
	MnQmABkIcjxW2pqkuyVCeuk1PZxRXJzYr9I7xb2csYZbWhtH1On0Lry9SaYGnBRCYGZc
	+9Wved/lwmSOsrwCwzJosUmEEbxkMry2mUZr0qZz4QSNsWzKB7auPdwEmKyg5ywvFHs6
	PcJksZxBM7gzNugafk0D/EfWPLyqxsojVz0uqVqCKn/cRvRsPRWkbbv02ehi+LngDaW3
	/VUg==
X-Gm-Message-State: AD7BkJL14fmhol04gHNNdDXdePZQdmcXVD+96gKjdCCgyXbtaiPgpXcsg9+nxn57mxA+1KJV
X-Received: by 10.28.175.201 with SMTP id y192mr25947783wme.54.1459961253771; 
	Wed, 06 Apr 2016 09:47:33 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.32
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:32 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:38 +0100
Message-Id: <ab7a22e37ea464b27cda96e6bfeb92ccae4f8f2d.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 28/38] toaster: mrb_section template Add build cancel button
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
X-List-Received-Date: Wed, 06 Apr 2016 16:47:33 -0000

Add the cancel build button to the mrb section template and add the event
handlers to cancelABuild.
Also clean up the calls to startABuild to use the updated libtoaster methods
and to make the code consistent with it's cancelABuild counterpart.

Co-Author: Sujith H <sujith.h@gmail.com>

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/mrbsection.js    |  95 ++++++++++++++
 lib/toaster/toastergui/templates/mrb_section.html | 148 ++++++++--------------
 2 files changed, 149 insertions(+), 94 deletions(-)
 create mode 100644 bitbake/lib/toaster/toastergui/static/js/mrbsection.js

diff --git a/lib/toaster/toastergui/static/js/mrbsection.js b/lib/toaster/toastergui/static/js/mrbsection.js
new file mode 100644
index 0000000..09117e1
--- /dev/null
+++ b/lib/toaster/toastergui/static/js/mrbsection.js
@@ -0,0 +1,95 @@
+
+function mrbSectionInit(ctx){
+
+  var projectBuilds;
+
+  if (ctx.mrbType === 'project')
+    projectBuilds = true;
+
+  $(".cancel-build-btn").click(function(e){
+    e.preventDefault();
+
+    var url = $(this).data('request-url');
+    var buildReqIds = $(this).data('buildrequest-id');
+    var banner = $(this).parents(".alert");
+
+    banner.find(".progress-info").fadeOut().promise().done(function(){
+      $("#cancelling-msg-" + buildReqIds).show();
+      console.log("cancel build");
+      libtoaster.cancelABuild(url, buildReqIds, function(){
+        if (projectBuilds == false){
+          /* the all builds page is not 'self updating' like thei
+           * project Builds
+           */
+          window.location.reload();
+        }
+      }, null);
+    });
+  });
+
+  $(".run-again-btn").click(function(e){
+    e.preventDefault();
+
+    var url = $(this).data('request-url');
+    var target = $(this).data('target');
+
+    libtoaster.startABuild(url, target, function(){
+      window.location.reload();
+    }, null);
+  });
+
+
+  var progressTimer;
+
+  if (projectBuilds === true){
+    progressTimer = window.setInterval(function() {
+      libtoaster.getProjectInfo(libtoaster.ctx.projectPageUrl,
+        function(prjInfo){
+          /* These two are needed because a build can be 100% and still
+           * in progress due to the fact that the % done is updated at the
+           * start of a task so it can be doing the last task at 100%
+           */
+          var inProgress = 0;
+          var allPercentDone = 0;
+          if (prjInfo.builds.length === 0)
+            return
+
+          for (var i in prjInfo.builds){
+            var build = prjInfo.builds[i];
+
+            if (build.outcome === "In Progress" ||
+               $(".progress .bar").length > 0){
+              /* Update the build progress */
+              var percentDone;
+
+              if (build.outcome !== "In Progress"){
+                /* We have to ignore the value when it's Succeeded because it
+                *   goes back to 0
+                */
+                percentDone = 100;
+              } else {
+                percentDone = build.percentDone;
+                inProgress++;
+              }
+
+              $("#build-pc-done-" + build.id).text(percentDone);
+              $("#build-pc-done-title-" + build.id).attr("title", percentDone);
+              $("#build-pc-done-bar-" + build.id).css("width",
+                String(percentDone) + "%");
+
+              allPercentDone += percentDone;
+            }
+          }
+
+          if (allPercentDone === (100 * prjInfo.builds.length) && !inProgress)
+            window.location.reload();
+
+          /* Our progress bar is not still showing so shutdown the polling. */
+          if ($(".progress .bar").length === 0)
+            window.clearInterval(progressTimer);
+
+      });
+    }, 1500);
+  }
+}
+
diff --git a/lib/toaster/toastergui/templates/mrb_section.html b/lib/toaster/toastergui/templates/mrb_section.html
index 551e341..b5e798d 100644
--- a/lib/toaster/toastergui/templates/mrb_section.html
+++ b/lib/toaster/toastergui/templates/mrb_section.html
@@ -2,6 +2,21 @@
 {% load projecttags %}
 {% load project_url_tag %}
 {% load humanize %}
+<script src="{% static 'js/mrbsection.js' %}"></script>
+<script>
+  $(document).ready(function () {
+    var ctx = {
+      mrbType : "{{mrb_type}}",
+    }
+
+    try {
+      mrbSectionInit(ctx);
+    } catch (e) {
+      document.write("Sorry, An error has occurred loading this page");
+      console.warn(e);
+    }
+  });
+</script>
 
 {%if mru and mru.count > 0%}
 
@@ -99,7 +114,7 @@
                   " title="Builds in this project cannot be started from Toaster: they are started from the command line">
                   </i>
               {% else %}
-                  <button class="btn
+                  <button class="run-again-btn btn
                       {% if build.outcome == build.SUCCEEDED %}
                           btn-success
                       {% elif build.outcome == build.FAILED %}
@@ -108,10 +123,9 @@
                           btn-info
                       {%endif%}
                       pull-right"
-                      onclick='scheduleBuild({% url 'projectbuilds' build.project.id as bpi %}{{bpi|json}},
-                        {{build.project.name|json}},
-                        {% url 'project' build.project.id as purl %}{{purl|json}},
-                        {{build.target_set.all|get_tasks|json}})'>
+                      data-request-url="{% url 'xhr_buildrequest' build.project.pk %}"
+                      data-target='{{build.target_set.all|get_tasks|json}}'>
+
 
                         Rebuild
                   </button>
@@ -119,100 +133,46 @@
             </div>
     {%endif%}
     {%if build.outcome == build.IN_PROGRESS %}
-            <div class="span4 offset1">
-              <div class="progress" id="build-pc-done-title-{{build.pk}}" style="margin-top:5px;" data-toggle="tooltip" title="{{build.completeper}}% of tasks complete">
-                  <div id="build-pc-done-bar-{{build.pk}}" style="width: {{build.completeper}}%;" class="bar"></div>
-                </div>
-            </div>
-            <div class="lead pull-right"><span id="build-pc-done-{{build.pk}}">{{build.completeper}}</span>% of tasks complete</div>
-    {%endif%}
-        </div>
+    <div class="span4" style="display:none" id="cancelling-msg-{{build.buildrequest.pk}}">
+      <p class="lead">Cancelling the build ...</p>
     </div>
+    <div class="span4 offset1 progress-info">
+      <div class="progress" id="build-pc-done-title-{{build.pk}}" style="margin-top:5px;" data-toggle="tooltip" title="{{build.completeper}}% of tasks complete">
+        <div id="build-pc-done-bar-{{build.pk}}" style="width: {{build.completeper}}%;" class="bar"></div>
+      </div>
+    </div>
+    <div class="lead span3 progress-info"><span id="build-pc-done-{{build.pk}}">{{build.completeper}}</span>% of tasks complete</div>
+    {# No build cancel for command line builds project #}
+    {% if build.project.is_default %}
+    <i class="icon-question-sign get-help get-help-blue pull-right" title="" data-original-title="Builds in this project cannot be cancelled from Toaster: they can only be cancalled from the command line"></i>
+    {% else %}
+    <div class="lead pull-right progress-info">
+      <button class="cancel-build-btn btn btn-info pull-right"
+          data-buildrequest-id={{build.buildrequest.pk}}
+          data-request-url="{% url 'xhr_buildrequest' build.project.pk %}" >
+        Cancel
+      </button>
+    </div>
+    {% endif %}
 
-  {% endfor %}
-  </div>
-
-<script>
-
-function scheduleBuild(url, projectName, projectUrl, buildlist) {
-  console.log("scheduleBuild");
-  libtoaster.startABuild(url, null, buildlist.join(" "), function(){
-    console.log("reloading page");
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
-
-  {%if mrb_type == 'project' %}
-  var projectBuilds = true;
-  {% else %}
-  var projectBuilds = false;
-  {% endif %}
-
-  var progressTimer;
-
-  if (projectBuilds === true){
-    progressTimer = window.setInterval(function() {
-      libtoaster.getProjectInfo(libtoaster.ctx.projectPageUrl,
-        function(prjInfo){
-          /* These two are needed because a build can be 100% and still
-           * in progress due to the fact that the % done is updated at the
-           * start of a task so it can be doing the last task at 100%
-           */
-          var inProgress = 0;
-          var allPercentDone = 0;
-
-          for (var i in prjInfo.builds){
-            var build = prjInfo.builds[i];
-
-            if (build.outcome === "In Progress" ||
-               $(".progress .bar").length > 0){
-              /* Update the build progress */
-              var percentDone;
-
-              if (build.outcome !== "In Progress"){
-                /* We have to ignore the value when it's Succeeded because it
-                *   goes back to 0
-                */
-                percentDone = 100;
-              } else {
-                percentDone = build.percentDone;
-                inProgress++;
-              }
-
-              $("#build-pc-done-" + build.id).text(percentDone);
-              $("#build-pc-done-title-" + build.id).attr("title", percentDone);
-              $("#build-pc-done-bar-" + build.id).css("width",
-                String(percentDone) + "%");
-
-              allPercentDone += percentDone;
-            }
-          }
-
-          if (allPercentDone === (100 * prjInfo.builds.length) && !inProgress)
-            window.location.reload();
+    {%endif%} {# end if in progress #}
 
-          /* Our progress bar is not still showing so shutdown the polling. */
-          if ($(".progress .bar").length === 0)
-            window.clearInterval(progressTimer);
+    {% if build.outcome == build.CANCELLED %}
+    <div class="span4">
+      <p class="lead">Build cancelled</p>
+    </div>
+    <button class="btn btn-info pull-right run-again-btn"
+        data-request-url="{% url 'xhr_buildrequest' build.project.pk %}"
+        data-target='{{build.target_set.all|get_tasks|json}}'>
+      Rebuild
 
-      });
-    }, 1500);
-  }
-});
+    </button>
+    {% endif %}
+  </div>
+</div>
 
-</script>
+  {% endfor %}
+  </div>
 
 {%endif%}
 
-- 
2.1.4


