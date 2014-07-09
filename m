Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
	[209.85.212.177])
	by mail.openembedded.org (Postfix) with ESMTP id 0ACFE703FE
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Jul 2014 16:55:27 +0000 (UTC)
Received: by mail-wi0-f177.google.com with SMTP id ho1so3120822wib.4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Jul 2014 09:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=ZtSQKeQWweZIT78BIcgdN+QCeCCBw+msYtXuyG9abiI=;
	b=BdEVY6/orwL4x8WjrjVYA4Z0dAdD/ulbhxu/RPQj/DPqfgV/2HGmVWEdl0O5SQq/tm
	QrxTljHO+sLbxDsUHT9zs3A9CQRDw8mXDGEP6EBk27Ar0KSAzPfZAZ4b+O0ljgWoO1K3
	7fDWNos9RTUkVp/hlMbAJnvdyFJ1osSL9qzYWKk1CufMOO10CcbOXkCAy8VZM7UAa3jw
	xr719NLQRobg/Lu0kAHrjJB1nKooqFHRab/EuX3yudZ2cTqGclqfSMp6HIYxxUcBCDPl
	3bsw8RZ2FmGY16etYQ25awZztPDI+fXrhJS0x7OFXj7reveSCrH6tM5l3sa14g19xr5d
	aayQ==
X-Gm-Message-State: ALoCoQmnJApxR27u2Uv/5Nwvd5rbi9yzTZh+NMQiGNpNg5pdHU25Ij9jC1VzGqwf+Qrt2oWddZ9I
X-Received: by 10.194.222.5 with SMTP id qi5mr48518333wjc.62.1404924928879;
	Wed, 09 Jul 2014 09:55:28 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id da9sm21371169wib.5.2014.07.09.09.55.27
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 09 Jul 2014 09:55:27 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 95305560DB6; Wed,  9 Jul 2014 17:55:26 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Jul 2014 17:55:21 +0100
Message-Id: <927a27c68e24cfe13f62ca5f0e60878b04fa4e24.1404924714.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <149693a342fe3a56027943d3ecb8bf2e1d0d652b.1404924714.git.alexandru.damian@intel.com>
References: <149693a342fe3a56027943d3ecb8bf2e1d0d652b.1404924714.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1404924713.git.alexandru.damian@intel.com>
References: <cover.1404924713.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 5/9] toaster: add project pages
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
X-List-Received-Date: Wed, 09 Jul 2014 16:55:29 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We add the new project and project page skeletons.

In the process, we add an identifier in the settings.py
to detect whenever Toaster is running in managed mode,
and a context processor to make this value available
to the template processor.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/toaster                                      |  1 +
 lib/toaster/toastergui/templates/base.html       | 13 ++++++++
 lib/toaster/toastergui/templates/newproject.html | 41 ++++++++++++++++++++++++
 lib/toaster/toastergui/templates/project.html    |  6 ++++
 lib/toaster/toastergui/urls.py                   |  5 +++
 lib/toaster/toastergui/views.py                  | 38 ++++++++++++++++++++++
 lib/toaster/toastermain/settings.py              | 19 ++++++++---
 7 files changed, 119 insertions(+), 4 deletions(-)
 create mode 100644 lib/toaster/toastergui/templates/newproject.html
 create mode 100644 lib/toaster/toastergui/templates/project.html

diff --git a/bin/toaster b/bin/toaster
index 01ffc7a..90cd982 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -139,6 +139,7 @@ if [ -z "$ZSH_NAME" ] && [ `basename \"$0\"` = `basename \"$BASH_SOURCE\"` ]; th
         webserverKillAll
         RUNNING=0
     }
+    export TOASTER_MANAGED=1
     webserverStartAll || (echo "Fail to start the web server, stopping" 1>&2 && exit 1)
     xdg-open http://0.0.0.0:8000/ >/dev/null 2>&1 &
     trap trap_ctrlc SIGINT
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index 9ca9c9a..1407d64 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -58,6 +58,19 @@ function reload_params(params) {
     <div class="navbar-inner">
             <a class="brand logo" href="#"><img src="{% static 'img/logo.png' %}" class="" alt="Yocto logo project"/></a>
             <a class="brand" href="/">Toaster</a>
+				{%if MANAGED %}
+					  <div class="btn-group pull-right">
+						  <a class="btn" href="{% url 'newproject' %}">New project</a>
+						  <button class="btn dropdown-toggle" data-toggle="dropdown">
+							  <i class="icon-caret-down"></i>
+						  </button>
+						  <ul class="dropdown-menu">
+							  <li><a href="#">Clone project</a></li>
+							  <li><a href="#">Export project</a></li>
+							  <li><a href="#">Import project</a></li>
+						  </ul>
+					  </div>
+				{%endif%}
             <a class="pull-right manual" target="_blank" href="http://www.yoctoproject.org/documentation/toaster-manual">
                 <i class="icon-book"></i>
                 Toaster manual
diff --git a/lib/toaster/toastergui/templates/newproject.html b/lib/toaster/toastergui/templates/newproject.html
new file mode 100644
index 0000000..e5a6551
--- /dev/null
+++ b/lib/toaster/toastergui/templates/newproject.html
@@ -0,0 +1,41 @@
+{% extends "base.html" %}
+{% load projecttags %}
+{% load humanize %}
+{% block pagecontent %}
+<div class="row-fluid">
+				<div class="span6">
+				<div class="page-header">
+					<h1>Create a new project</h1>
+				</div>  
+					<form>
+						<fieldset>
+							<label>Project name <span class="muted">(required)</span></label>
+							<input type="text" class="input-xlarge" required name="projectname">
+							<label class="project-form">
+								Project owner
+								<i class="icon-question-sign get-help" title="The go-to person for this project"></i>
+							</label>
+				<form method="POST">
+							<input type="text">
+							<label class="project-form">Owner's email</label>
+							<input type="email" class="input-large" name="email">
+							<label class="project-form">
+								Yocto Project version
+								<i class="icon-question-sign get-help" title="This sets the branch for the Yocto Project core layers (meta, meta-yocto and meta-yocto-bsp), and for the layers you use from the OpenEmbedded Metadata Index"></i>
+							</label>
+							<select>
+								<option>Yocto Project 1.7 "D?"</option>
+								<option>Yocto Project 1.6 "Daisy"</option>
+								<option>Yocto Project 1.5 "Dora"</option>
+							</select>
+				</form>
+						</fieldset>
+									
+						<div class="form-actions">
+							<a href="project-with-targets.html" class="btn btn-primary btn-large">Create project</a>
+						</div>
+					</form> 
+				</div>
+			</div>
+		</div>  
+{% endblock %}
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
new file mode 100644
index 0000000..71adb54
--- /dev/null
+++ b/lib/toaster/toastergui/templates/project.html
@@ -0,0 +1,6 @@
+{% extends "base.html" %}
+{% load projecttags %}
+{% load humanize %}
+{% block pagecontent %}
+
+{% endblock %}
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index 9b583f2..bba4fda 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -65,6 +65,11 @@ urlpatterns = patterns('toastergui.views',
         # urls not linked from the dashboard
         url(r'^layers/$', 'layer', name='all-layers'),
         url(r'^layerversions/(?P<layerversion_id>\d+)/recipes/.*$', 'layer_versions_recipes', name='layer_versions_recipes'),
+
+        # project URLs
+        url(r'^newproject/$', 'newproject', name='newproject'),
+        url(r'^project/$', 'project', name='project'),
+
         # default redirection
         url(r'^$', RedirectView.as_view( url= 'builds/')),
 )
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 1f3e11d..7dc0108 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1758,3 +1758,41 @@ def image_information_dir(request, build_id, target_id, packagefile_id):
     # stubbed for now
     return redirect(builds)
 
+
+import toastermain.settings
+def managedcontextprocessor(request):
+    return { "MANAGED" : toastermain.settings.MANAGED }
+
+
+# we have a set of functions if we're in managed mode, or
+# a default "page not available" simple functions for interactive mode
+if toastermain.settings.MANAGED:
+
+    # new project
+    def newproject(request):
+        template = "newproject.html"
+        context = {}
+        if request.method == "GET":
+            # render new project page
+            return render(request, template, context)
+        elif request.method == "POST":
+            if request.method:
+                return redirect(project)
+            else:
+                return render(request, template, context)
+        raise Exception("Invalid HTTP method for this page")
+
+    # Shows the edit project page
+    def project(request):
+        template = "project.html"
+        context = {}
+        return render(request, template, context)
+
+
+else:
+    # these are pages that are NOT available in interactive mode
+    def newproject(request):
+        raise Exception("page not available in interactive mode")
+
+    def project(request):
+        raise Exception("page not available in interactive mode")
diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index 97f2ff7..09ec2bd 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -75,6 +75,11 @@ if 'DATABASE_URL' in os.environ:
         raise Exception("FIXME: Please implement missing database url schema for url: %s" % dburl)
 
 
+if 'TOASTER_MANAGED' in os.environ and os.environ['TOASTER_MANAGED'] == "1":
+    MANAGED = True
+else:
+    MANAGED = False
+
 # Allows current database settings to be exported as a DATABASE_URL environment variable value
 
 def getDATABASE_URL():
@@ -221,12 +226,11 @@ TEMPLATE_CONTEXT_PROCESSORS = ('django.contrib.auth.context_processors.auth',
  'django.core.context_processors.static',
  'django.core.context_processors.tz',
  'django.contrib.messages.context_processors.messages',
- "django.core.context_processors.request")
+ "django.core.context_processors.request",
+ 'toastergui.views.managedcontextprocessor',
+ )
 
 INSTALLED_APPS = (
-    #'django.contrib.auth',
-    #'django.contrib.contenttypes',
-    #'django.contrib.sessions',
     #'django.contrib.sites',
     #'django.contrib.messages',
     'django.contrib.staticfiles',
@@ -243,6 +247,13 @@ INSTALLED_APPS = (
     'bldcontrol',
 )
 
+# if we run in managed mode, we need user support
+if MANAGED:
+    INSTALLED_APPS = ('django.contrib.auth',
+    'django.contrib.contenttypes',
+    'django.contrib.sessions',) + INSTALLED_APPS
+
+
 # We automatically detect and install applications here if
 # they have a 'models.py' or 'views.py' file
 import os
-- 
1.9.1


