Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f175.google.com (mail-we0-f175.google.com
	[74.125.82.175])
	by mail.openembedded.org (Postfix) with ESMTP id BE23260DFA
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Mar 2014 18:47:43 +0000 (UTC)
Received: by mail-we0-f175.google.com with SMTP id q58so11546966wes.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Mar 2014 11:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=3s9fEf5aaaDCNsTHnE6O+PVMezTLoVVkhbXkjtOUJUk=;
	b=GZTs9wVznaqgp12nAHBy1A7TJJWyCu3toSCJJbgmHtD5jJBvH7HCuV2TCRd/7dALSd
	oTwYoNvakcqGkhQd+arBPxO2UflF2NcymKK2i0KfSwL17Cdx+qrIh5eUoScN8hWmw2lV
	MN3YuceIk2HcBIUhsUpkQFZ9nNzG6n4ZDDv8sZFSLr8RQlsihdGBvzJzxhQmnrSjehOt
	NLV6g+lbapjGq/yy/sx9ujjiCkcRLBuUIO0QoVfz6ZZy3zX7/9AJ5idUVM4CWMpbwtSr
	x7QffHlXgmhUHX+e4t6Zk6DVF4tQtjquL+dIEiErYIS3k+jxZtTuseh/DffvmVUKKVFo
	QJcA==
X-Gm-Message-State: ALoCoQk8LD5pIif8XfCadIcvqf6ZFX+7Y4SQ5goWKyNGxXtLWuGgLXj8Mt8HzEHdIzcVIuYm0MXj
X-Received: by 10.180.89.136 with SMTP id bo8mr8691938wib.52.1394650064632;
	Wed, 12 Mar 2014 11:47:44 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id 12sm71809722wjm.10.2014.03.12.11.47.42
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Wed, 12 Mar 2014 11:47:42 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id B52435605BC; Wed, 12 Mar 2014 18:47:43 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 12 Mar 2014 18:47:42 +0000
Message-Id: <93666733ffc89c9a3534c2ad774c0a49857c028c.1394649860.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <f1ccf1eb81e7ba89b9e540a19c839a3dfdef234b.1394649860.git.alexandru.damian@intel.com>
References: <y>
	<f1ccf1eb81e7ba89b9e540a19c839a3dfdef234b.1394649860.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1394649860.git.alexandru.damian@intel.com>
References: <cover.1394649860.git.alexandru.damian@intel.com>
Cc: Amit Kumar Chaudhary <amit@floatingpondtech.com>
Subject: [PATCH 4/4] toaster: add errors and warnings listing
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
X-List-Received-Date: Wed, 12 Mar 2014 18:47:47 -0000

From: Amit Kumar Chaudhary <amit@floatingpondtech.com>

Add the errors and warnings listing to the build
dashboard page.

Signed-off-by: Amit Kumar Chaudhary <amit@floatingpondtech.com>
---
 lib/toaster/toastergui/static/js/main.js           | 20 ++++++++
 .../toastergui/templates/builddashboard.html       | 56 +++++++++++++++++++++-
 lib/toaster/toastergui/views.py                    |  3 +-
 3 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/main.js b/lib/toaster/toastergui/static/js/main.js
index c80f716..07aba3d 100644
--- a/lib/toaster/toastergui/static/js/main.js
+++ b/lib/toaster/toastergui/static/js/main.js
@@ -91,3 +91,23 @@ $(document).ready(function() {
     });
 
 });
+
+$(document).ready(function() {
+    //toggle the errors and warnings sections
+    $('.show-errors').click(function() {
+        $('#collapse-errors').addClass('in');
+    });
+    $('.toggle-errors').click(function() {
+        $('#collapse-errors').toggleClass('in');
+    });
+    $('.show-warnings').click(function() {
+        $('#collapse-warnings').addClass('in');
+    });
+    $('.toggle-warnings').click(function() {
+        $('#collapse-warnings').toggleClass('in');
+    });
+    //show warnings section when requested from the previous page
+    if (location.href.search('#warnings') > -1) {
+        $('#collapse-warnings').addClass('in');
+    }
+});
diff --git a/lib/toaster/toastergui/templates/builddashboard.html b/lib/toaster/toastergui/templates/builddashboard.html
index b6506c7..763a28d 100644
--- a/lib/toaster/toastergui/templates/builddashboard.html
+++ b/lib/toaster/toastergui/templates/builddashboard.html
@@ -18,10 +18,10 @@
   <div class="alert {%if build.outcome == build.SUCCEEDED%}alert-success{%elif build.outcome == build.FAILED%}alert-error{%else%}alert-info{%endif%}">
     <div class="row-fluid lead">
             <span class="pull-left"><strong>{%if build.outcome == build.SUCCEEDED%}Completed{%elif build.outcome == build.FAILED%}Failed{%else%}{%endif%}</strong> {{build.completed_on|date:"d/m/y H:i"}} with </span>{%if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}{% if  build.errors_no %}
-            <span class="span2"><i class="icon-minus-sign red"></i><strong><a href="{%url 'builddashboard' build.pk%}" class="error"> {{build.errors_no}} error{{build.errors_no|pluralize}}</a></strong></span>
+            <span class="span2"><i class="icon-minus-sign red"></i><strong><a href="#errors" class="error"> {{build.errors_no}} error{{build.errors_no|pluralize}}</a></strong></span>
 {% endif %}
 {% if  build.warnings_no %}
-            <span class="span2"><i class="icon-warning-sign yellow"></i><strong><a href="{%url 'builddashboard' build.pk%}" class="warning"> {{build.warnings_no}} warning{{build.warnings_no|pluralize}}</a></strong></span>
+            <span class="span2"><i class="icon-warning-sign yellow"></i><strong><a href="#warnings" class="warning"> {{build.warnings_no}} warning{{build.warnings_no|pluralize}}</a></strong></span>
 {% endif %}
             <span class="pull-right">Build time: <a href="build-time.html">{{ build.timespent|sectohms }}</a></span>
 {%endif%}
@@ -29,6 +29,32 @@
   </div>
 </div>
 
+{% if build.errors_no %}
+<div class="accordion span10 pull-right" id="errors">
+  <div class="accordion-group">
+    <div class="accordion-heading">
+      <a class="accordion-toggle error toggle-errors">
+         <h2 id="error-toggle">
+           <i class="icon-minus-sign"></i>
+           {{build.errors_no}} error{{build.errors_no|pluralize}}
+         </h2>
+      </a>
+    </div>
+    <div class="accordion-body collapse in" id="collapse-errors">
+      <div class="accordion-inner">
+        <div class="span10">
+          {% for error in logmessages %}{% if error.level == 2 %}
+            <div class="alert alert-error">
+              <pre>{{error.message}}</pre>
+            </div>
+          {% endif %}{% endfor %}
+        </div>
+      </div>
+    </div>
+  </div>
+</div>
+{% endif %}
+
 {%if build.outcome == build.SUCCEEDED%}
 <!-- built images -->
 <div class="row-fluid span10 pull-right">
@@ -71,4 +97,30 @@
     </div>
 </div>
 
+{% if build.warnings_no %}
+<div class="accordion span10 pull-right" id="warnings">
+  <div class="accordion-group">
+    <div class="accordion-heading">
+      <a class="accordion-toggle warning toggle-warnings">
+        <h2 id="warning-toggle">
+          <i class="icon-warning-sign"></i>
+          {{build.warnings_no}} warning{{build.warnings_no|pluralize}}
+        </h2>
+      </a>
+    </div>
+    <div class="accordion-body collapse" id="collapse-warnings">
+      <div class="accordion-inner">
+        <div class="span10">
+          {% for warning in logmessages %}{% if warning.level == 1 %}
+            <div class="alert alert-warning">
+              <pre>{{warning.message}}</pre>
+            </div>
+          {% endif %}{% endfor %}
+        </div>
+      </div>
+    </div>
+  </div>
+</div>
+{% endif %}
+
 {% endblock %}
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index a499c30..7f61ade 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -356,7 +356,8 @@ def builddashboard(request, build_id):
         return redirect(builds)
     context = {
             'build' : Build.objects.filter(pk=build_id)[0],
-            'recipecount' : Recipe.objects.filter(layer_version__id__in=Layer_Version.objects.filter(build=build_id)).count()
+            'recipecount' : Recipe.objects.filter(layer_version__id__in=Layer_Version.objects.filter(build=build_id)).count(),
+            'logmessages' : LogMessage.objects.filter(build=build_id),
     }
     return render(request, template, context)
 
-- 
1.8.3.2


