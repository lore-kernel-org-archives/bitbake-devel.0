Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f178.google.com (mail-pd0-f178.google.com
	[209.85.192.178])
	by mail.openembedded.org (Postfix) with ESMTP id E04A873643
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Feb 2015 17:21:06 +0000 (UTC)
Received: by pdjy10 with SMTP id y10so34672952pdj.13
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Feb 2015 09:21:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=faUC3weKLobvR98I56wsvSV4nyQaBO8v3eZINrP9gUE=;
	b=WO8LO/QMJSPwsauJccBLim0V7DbN2g3I/n8Qr0ekrPIIQnQv2zcu/97a1kdxnEFcYm
	LliWfwJXFZ3Ov8vVsBokfu17Phydm0VL4i0jWtthniuO5RWq6yB/VzYzt4u1DqoHPoGb
	a6tltlptUR2lSJkvuIdd1ytO/nXoyZa3Jv2eOw5UcXpcKiP0sfGKNWklJ1Q6AMX298YU
	VnwRTSRErvlRLFjB6wPsKzUIlJj6TmHVRSMAR9XGsvgLuZBLL8Gkbtpc4lWBMh6xW7SA
	+qa+MYK877ycQcopLi/c8CCw2Qj/kSlk9WCAAHrg5UBdbk10Ht64M1j+Pd0ckFAfiesU
	0uXA==
X-Gm-Message-State: ALoCoQmS3m0m6wwKaS1szqeDBn8pUSl1ss7GzhtZDil25Ff+RwZNT/5wDiGDfe5XtL0ZKiB4aIc/
X-Received: by 10.68.57.162 with SMTP id j2mr5372706pbq.120.1424798468371;
	Tue, 24 Feb 2015 09:21:08 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	oe5sm38734404pbc.33.2015.02.24.09.21.07
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 24 Feb 2015 09:21:07 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 95D8D561883; Tue, 24 Feb 2015 17:21:01 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Feb 2015 17:20:53 +0000
Message-Id: <7c805401648abff537e67e4a4570b002cb9f760a.1424798369.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <50c0fc6c7d6afead28271d2f2501f025eb0b160e.1424798369.git.alexandru.damian@intel.com>
References: <50c0fc6c7d6afead28271d2f2501f025eb0b160e.1424798369.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424798369.git.alexandru.damian@intel.com>
References: <cover.1424798369.git.alexandru.damian@intel.com>
Subject: [PATCH 05/12] toasterui: style the Toaster version information
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
X-List-Received-Date: Tue, 24 Feb 2015 17:21:07 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

When debugging is turned on, we show some Toaster version
information in the top bar. Present it so that it can
be easily copied and pasted.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/static/css/default.css  | 3 ++-
 lib/toaster/toastergui/static/js/libtoaster.js | 3 +++
 lib/toaster/toastergui/templates/base.html     | 2 +-
 lib/toaster/toastergui/views.py                | 7 ++++---
 lib/toaster/toastermain/settings.py            | 4 ++--
 5 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index 86cf67a..f97e6c4 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -5,7 +5,8 @@
 /* style the version information */
 .brand > a { color: #777; }
 .brand > a:hover { color: #999; text-decoration: none; }
-.icon-info-sign.get-help { color: #777; font-size: 16px; margin-left: 5px;}
+.icon-info-sign { color: #777; font-size: 16px; margin-left: 5px;}
+.icon-info-sign:hover { color: #999; cursor: pointer; }
 
 /* Style the breadcrumb */
 .breadcrumb { display: inline-block; background-color: transparent; }
diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index 2dc5b0a..ea1522f 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -317,6 +317,9 @@ $(document).ready(function() {
     // initialise the tooltips for the download icons
     $(".icon-download-alt").tooltip({ container: 'body', html: true, delay: { show: 200 } });
 
+    // initialise popover for debug information
+    $(".icon-info-sign").popover( { placement: 'bottom', html: true, container: 'body' });
+
     // linking directly to tabs
     $(function(){
           var hash = window.location.hash;
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index 695ca5d..62cc7ad 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -61,7 +61,7 @@
             <span class="brand">
                 <a href="/">Toaster</a>
                 {% if DEBUG %}
-                    <i class="icon-info-sign get-help heading-help" data-placement="bottom" title="Version: {{TOASTER_VERSION}} <br /> Mode: {%if MANAGED%}build{%else%}analysis{%endif%}"></i>
+                    <i class="icon-info-sign" title="<strong>Toaster version information</strong>" data-content="<dl><dt>Branch</dt><dd>{{TOASTER_BRANCH}}</dd><dt>Revision</dt><dd>{{TOASTER_REVISION}}</dd><dt>Mode</dt><dd>{%if MANAGED%}Build{%else%}Analysis{%endif%}</dd></dl>"></i>
                 {% endif %}
             </span>
             <a class="pull-right manual" target="_blank" href="http://www.yoctoproject.org/documentation/toaster-manual">
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 0284b1a..4960ba0 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1731,7 +1731,8 @@ if toastermain.settings.MANAGED:
             "projects": Project.objects.all(),
             "MANAGED" : toastermain.settings.MANAGED,
             "DEBUG" : toastermain.settings.DEBUG,
-            "TOASTER_VERSION": toastermain.settings.TOASTER_VERSION,
+            "TOASTER_BRANCH": toastermain.settings.TOASTER_BRANCH,
+            "TOASTER_REVISION" : toastermain.settings.TOASTER_REVISION,
         }
         if 'project_id' in request.session:
             try:
@@ -3104,8 +3105,8 @@ else:
             "projects": [],
             "MANAGED" : toastermain.settings.MANAGED,
             "DEBUG" : toastermain.settings.DEBUG,
-            "TOASTER_VERSION": toastermain.settings.TOASTER_VERSION,
-
+            "TOASTER_BRANCH": toastermain.settings.TOASTER_BRANCH,
+            "TOASTER_REVISION" : toastermain.settings.TOASTER_REVISION,
         }
 
 
diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index a7304fa..80f26e0 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -232,8 +232,8 @@ from os.path import dirname as DN
 SITE_ROOT=DN(DN(os.path.abspath(__file__)))
 
 import subprocess
-TOASTER_VERSION = subprocess.Popen('git branch | grep "^* " | tr -d "* "', cwd = SITE_ROOT, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE).communicate()[0]
-TOASTER_VERSION += " " + subprocess.Popen('git rev-parse HEAD ', cwd = SITE_ROOT, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE).communicate()[0]
+TOASTER_BRANCH = subprocess.Popen('git branch | grep "^* " | tr -d "* "', cwd = SITE_ROOT, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE).communicate()[0]
+TOASTER_REVISION = subprocess.Popen('git rev-parse HEAD ', cwd = SITE_ROOT, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE).communicate()[0]
 
 ROOT_URLCONF = 'toastermain.urls'
 
-- 
1.9.1


