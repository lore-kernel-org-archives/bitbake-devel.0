Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f180.google.com (mail-pd0-f180.google.com
	[209.85.192.180])
	by mail.openembedded.org (Postfix) with ESMTP id 29C99732AF
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Feb 2015 18:02:06 +0000 (UTC)
Received: by pdbnh10 with SMTP id nh10so30190916pdb.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Feb 2015 10:02:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=vI4zBebUW/wt9nCvQ6W7X0uvDsmvw3JdZQ2tFPv5ZoU=;
	b=hXP3ttSnB2SR6yPkAGneZh1T+blXZ8VOxIqH4KWAxx8MreqNpD03CcNRaq1r3ktQi5
	qSc3gYWdRvQTO/hxF2IFNjWE3RukZw5OW/1qH5CEU4X23gO6q8rvc1nn2w+aV4GZ+phn
	L7kqypm/Hb/PWc3GBpEW98yPsiz/TBhC3SRIyXue7V+RPkALXF+/OQdSdI6QSnJxWECD
	bJNlkTKhlHWxm57QLYp7YIf4c82SOtjWl0JBtR0Cca8AkfEEkwm3cikhZAqukEYf1+ls
	9vrIlUafd/o9w0nIXR9EuIViIn0Q4F87EIVFfQgCKxxe8gtTqkwhmq4vaSzZyxwk9n7a
	7e8A==
X-Gm-Message-State: ALoCoQmxgPje1Fkc2nXPm5AjpqBBb0+T6t59bgVq92Er5mLp/Xr1E4q6Ksf8ZXVHoyABtaP6/E3h
X-Received: by 10.70.128.202 with SMTP id nq10mr30870477pdb.45.1423504928184; 
	Mon, 09 Feb 2015 10:02:08 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	go1sm16268110pbd.75.2015.02.09.10.02.04
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 09 Feb 2015 10:02:06 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 545BB5661A0; Mon,  9 Feb 2015 18:01:58 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Feb 2015 18:01:39 +0000
Message-Id: <93e4f8c44273f4657c5be4c00b61db12aa875e31.1423504574.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
References: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1423504574.git.alexandru.damian@intel.com>
References: <cover.1423504574.git.alexandru.damian@intel.com>
Subject: [PATCH 09/27] toaster: display Toaster mode and version in debug mode
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
X-List-Received-Date: Mon, 09 Feb 2015 18:02:07 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch displays the current running mode and checked-out git branch
as Toaster version when running in debug mode.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/static/css/default.css | 19 +++++++++++++++++++
 lib/toaster/toastergui/templates/base.html    |  6 ++++++
 lib/toaster/toastergui/views.py               |  8 ++++++--
 lib/toaster/toastermain/settings.py           |  5 +++--
 4 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index 1095254..a866773 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -2,6 +2,25 @@
 .logo img { height: 30px; width: auto !important; }
 .logo { padding-top: 4px !important; padding-bottom:0px !important; }
 
+/* style the version text */
+.version-text {
+	color: #AAA;
+	font-size: 0.6em;
+	display: table-footer-group;
+	padding: 0px;
+	margin: 1px 1px 1px 1px;
+}
+
+.version-brand, .version-brand:hover, a.version-brand:focus  {
+    color: #777;
+    display: block;
+    float: left;
+    font-size: 20px;
+    font-weight: 200;
+    padding: 00px 0px;
+    text-shadow: 0 1px 0 #fff;
+}
+
 /* Style the breadcrumb */
 .breadcrumb { display: inline-block; background-color: transparent; }
 .section { margin: 20px 0; }
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index e95b5e0..6f249bc 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -59,6 +59,12 @@
     <div class="navbar-inner">
             <a class="brand logo" href="#"><img src="{% static 'img/logo.png' %}" class="" alt="Yocto logo project"/></a>
             <a class="brand" href="/">Toaster</a>
+            {% if DEBUG %}
+            <div style="display: inline;" class="version-brand">
+              <p class="version-text">version {{TOASTER_VERSION}}</p>
+              <p class="version-text">{%if MANAGED%}managed{%else%}interactive{%endif%} mode</p>
+            </div>
+            {% endif %}
             <a class="pull-right manual" target="_blank" href="http://www.yoctoproject.org/documentation/toaster-manual">
                 <i class="icon-book"></i>
                 Toaster manual
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index b67a676..4b770ff 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1709,10 +1709,12 @@ if toastermain.settings.MANAGED:
 
     # the context processor that supplies data used across all the pages
     def managedcontextprocessor(request):
+        import subprocess
         ret = {
             "projects": Project.objects.all(),
             "MANAGED" : toastermain.settings.MANAGED,
-            "DEBUG" : toastermain.settings.DEBUG
+            "DEBUG" : toastermain.settings.DEBUG,
+            "TOASTER_VERSION": toastermain.settings.TOASTER_VERSION,
         }
         if 'project_id' in request.session:
             try:
@@ -3057,7 +3059,9 @@ else:
         return {
             "projects": [],
             "MANAGED" : toastermain.settings.MANAGED,
-            "DEBUG" : toastermain.settings.DEBUG
+            "DEBUG" : toastermain.settings.DEBUG,
+            "TOASTER_VERSION": toastermain.settings.TOASTER_VERSION,
+
         }
 
 
diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index ea7c353..b6a42c0 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -211,8 +211,6 @@ MIDDLEWARE_CLASSES = (
     'django.middleware.csrf.CsrfViewMiddleware',
     'django.contrib.auth.middleware.AuthenticationMiddleware',
     'django.contrib.messages.middleware.MessageMiddleware',
-    'django.middleware.cache.UpdateCacheMiddleware',
-    'django.middleware.cache.FetchFromCacheMiddleware',
     # Uncomment the next line for simple clickjacking protection:
     # 'django.middleware.clickjacking.XFrameOptionsMiddleware',
 )
@@ -233,6 +231,9 @@ CACHES = {
 from os.path import dirname as DN
 SITE_ROOT=DN(DN(os.path.abspath(__file__)))
 
+import subprocess
+TOASTER_VERSION = subprocess.Popen('cd %s; git branch | grep "^* " | tr -d "* "' % SITE_ROOT, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE).communicate()[0]
+
 ROOT_URLCONF = 'toastermain.urls'
 
 # Python dotted path to the WSGI application used by Django's runserver.
-- 
1.9.1


