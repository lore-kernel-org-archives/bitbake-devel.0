Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
	[209.85.220.44])
	by mail.openembedded.org (Postfix) with ESMTP id B96B76FF72
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Dec 2015 17:59:50 +0000 (UTC)
Received: by pacej9 with SMTP id ej9so47177384pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Dec 2015 09:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=UKA3dMZwEKh647l4pbd4Gy1FxqH4BVvizLLWnzlH3lQ=;
	b=C/dHUzSzmMl0e6zvlG6+3pcnPvmRwDYPP0pOz/AhWlGi/P8JV81ExoYo34eCPRcsJE
	WANGUvNLcpmRA339QTX/3aSc4XXcuVr2OPR9QZ9n9pRl/l2cqcsdcY66Jl0WWGgTAb10
	sEGPsE6Xv4N8WKLqzwFELU6VDkce3z6oYVcpG+Ggs83H9ng85qtLgFDBRqUFWdVKLkcV
	0RKVuuEoq7jpXcQwyf8QHWPbSO4CrD2kuFFStuDbJ102ewBPsN7HOrN+0X6a8AlWeTcB
	AQI4HIKQgq6eirn6sxCF5cUTZ4opFc7IopAX5aKwz+sFfg2nOEyTNRhEuwQY3QAbGCc7
	RIAg==
X-Received: by 10.98.71.157 with SMTP id p29mr6615056pfi.152.1449079191699;
	Wed, 02 Dec 2015 09:59:51 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	e25sm5657267pfb.64.2015.12.02.09.59.50
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Dec 2015 09:59:50 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Dec 2015 10:02:50 -0800
Message-Id: <724f5710eaed2ef2f9de5ad925b46cc766dbf47f.1449078919.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
References: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449078919.git.avery.brian@gmail.com>
References: <cover.1449078919.git.avery.brian@gmail.com>
Subject: [PATCH 18/30] toaster: remove usage of BUILD_MODE variable
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
X-List-Received-Date: Wed, 02 Dec 2015 17:59:50 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

As both modes can be used at the same time we can't have any
difference in UI between modes.

Removed all conditional statements that used BUILD_MODE.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/templates/base.html    |  9 +--------
 lib/toaster/toastergui/templates/landing.html | 10 ----------
 lib/toaster/toastergui/tests.py               |  4 ----
 lib/toaster/toastergui/views.py               | 20 --------------------
 lib/toaster/toastermain/settings.py           |  3 ---
 lib/toaster/toastermain/urls.py               |  9 ++++-----
 6 files changed, 5 insertions(+), 50 deletions(-)

diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index e0b15ce..8081f06 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -79,7 +79,7 @@
             <i class="icon-info-sign" title="<strong>Toaster version information</strong>" data-content="<dl><dt>Branch</dt><dd>{{TOASTER_BRANCH}}</dd><dt>Revision</dt><dd>{{TOASTER_REVISION}}</dd></dl>"></i>
             {% endif %}
           </span>
-          {% if BUILD_MODE and request.resolver_match.url_name != 'landing' and request.resolver_match.url_name != 'newproject' %}
+          {% if request.resolver_match.url_name != 'landing' and request.resolver_match.url_name != 'newproject' %}
           <ul class="nav">
             <li {% if request.resolver_match.url_name == 'all-builds' %}
                 class="active"
@@ -108,13 +108,6 @@
             </li>
           </ul>
           <span class="pull-right divider-vertical"></span>
-
-          <!-- new project button; only show in build mode -->
-          {% if BUILD_MODE %}
-          <div class="btn-group pull-right">
-            <a class="btn" id="new-project-button" href="{% url 'newproject' %}">New project</a>
-          </div>
-          {% endif %}
         </div>
       </div>
     </div>
diff --git a/lib/toaster/toastergui/templates/landing.html b/lib/toaster/toastergui/templates/landing.html
index cafaa1a..a1b5cdc 100644
--- a/lib/toaster/toastergui/templates/landing.html
+++ b/lib/toaster/toastergui/templates/landing.html
@@ -6,9 +6,6 @@
 
 {% block title %} Welcome to Toaster {% endblock %}
 {% block pagecontent %}
-
-  {% if BUILD_MODE %}
-    <!-- build mode -->
     <div class="container-fluid">
       <div class="row-fluid">
         <div class="hero-unit span12 well-transparent">
@@ -62,11 +59,4 @@
         </div>
       </div>
     </div>
-  {% else %}
-    <!-- analysis mode -->
-    <div class="alert alert-info lead top-air">
-      Toaster has not recorded any builds yet. Run a build from the command line to see it here.
-    </div>
-  {% endif %}
-
 {% endblock %}
diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index a631203..c927fe1 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -45,10 +45,6 @@ import string
 PROJECT_NAME = "test project"
 CLI_BUILDS_PROJECT_NAME = 'Command line builds'
 
-# by default, tests are run in build mode; to run in analysis mode,
-# set this to False in individual test cases
-toastermain.settings.BUILD_MODE = True
-
 class ViewTests(TestCase):
     """Tests to verify view APIs."""
 
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 0e255f1..69f5af0 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -76,10 +76,6 @@ def landing(request):
     default_project = Project.objects.get_default_project()
     default_project_builds = Build.objects.filter(project = default_project)
 
-    if (not toastermain.settings.BUILD_MODE) and default_project_builds.count() > 0:
-        args = (default_project.id,)
-        return redirect(reverse('projectbuilds', args = args), permanent = False)
-
     # we only redirect to projects page if there is a user-generated project
     num_builds = Build.objects.all().count()
     user_projects = Project.objects.filter(is_default = False)
@@ -102,9 +98,6 @@ def _get_latest_builds(prj=None):
     if prj is not None:
         queryset = queryset.filter(project = prj)
 
-    if not toastermain.settings.BUILD_MODE:
-        queryset = queryset.exclude(project__is_default=False)
-
     return list(itertools.chain(
         queryset.filter(outcome=Build.IN_PROGRESS).order_by("-started_on"),
         queryset.filter(outcome__lt=Build.IN_PROGRESS).order_by("-started_on")[:3] ))
@@ -1893,10 +1886,6 @@ def managedcontextprocessor(request):
         "projects": projects,
         "non_cli_projects": projects.exclude(is_default=True),
         "DEBUG" : toastermain.settings.DEBUG,
-
-        # True if Toaster is in build mode, False otherwise
-        "BUILD_MODE": toastermain.settings.BUILD_MODE,
-
         "CUSTOM_IMAGE" : toastermain.settings.CUSTOM_IMAGE,
         "TOASTER_BRANCH": toastermain.settings.TOASTER_BRANCH,
         "TOASTER_REVISION" : toastermain.settings.TOASTER_REVISION,
@@ -1939,11 +1928,6 @@ if True:
 
         queryset = Build.objects.all()
 
-        # if in analysis mode, exclude builds for all projects except
-        # command line builds
-        if not toastermain.settings.BUILD_MODE:
-            queryset = queryset.exclude(project__is_default=False)
-
         redirect_page = resolve(request.path_info).url_name
 
         context, pagesize, orderby = _build_list_helper(request,
@@ -3048,10 +3032,6 @@ if True:
         queryset_all = queryset_all.filter(Q(is_default=False) |
                                            q_default_with_builds)
 
-        # if in BUILD_MODE, exclude everything but the command line builds project
-        if not toastermain.settings.BUILD_MODE:
-            queryset_all = queryset_all.exclude(is_default=False)
-
         # boilerplate code that takes a request for an object type and returns a queryset
         # for that object type. copypasta for all needed table searches
         (filter_string, search_term, ordering_string) = _search_tuple(request, Project)
diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index b28ddb2..de686b2 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -92,9 +92,6 @@ if 'DATABASE_URL' in os.environ:
     else:
         raise Exception("FIXME: Please implement missing database url schema for url: %s" % dburl)
 
-BUILD_MODE = False
-if 'TOASTER_MANAGED' in os.environ and os.environ['TOASTER_MANAGED'] == "1":
-    BUILD_MODE = True
 
 # Allows current database settings to be exported as a DATABASE_URL environment variable value
 
diff --git a/lib/toaster/toastermain/urls.py b/lib/toaster/toastermain/urls.py
index 6c4a953..5ce5a92 100644
--- a/lib/toaster/toastermain/urls.py
+++ b/lib/toaster/toastermain/urls.py
@@ -59,12 +59,11 @@ if toastermain.settings.DEBUG_PANEL_ENABLED:
     urlpatterns.insert(1, url(r'', include(debug_toolbar.urls)))
     #logger.info("Enabled django_toolbar extension")
 
+urlpatterns = [
+    # Uncomment the next line to enable the admin:
+    url(r'^admin/', include(admin.site.urls)),
+] + urlpatterns
 
-if toastermain.settings.BUILD_MODE:
-    urlpatterns = [
-        # Uncomment the next line to enable the admin:
-        url(r'^admin/', include(admin.site.urls)),
-    ] + urlpatterns
 # Automatically discover urls.py in various apps, beside our own
 # and map module directories to the patterns
 
-- 
1.9.1


