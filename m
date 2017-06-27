Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 4250377FEC
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jun 2017 20:53:09 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v5RKrAMG003133
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jun 2017 13:53:10 -0700
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.209) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.294.0; Tue, 27 Jun 2017 13:53:10 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 27 Jun 2017 13:44:28 -0700
Message-ID: <fb64fd060be74bac6a4dfbd453eb9448754b5163.1498595651.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1498595646.git.David.Reyna@windriver.com>
References: <cover.1498595646.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.209]
Subject: [PATCH 1/5] toaster: address Django-1.10 API deprecations
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
X-List-Received-Date: Tue, 27 Jun 2017 20:53:09 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

There are four main API deprecations in Django-1.10:
  (a) String view arguments to url() must be replaced by
      the explicit class reference
  (b) New TEMPLATES stucture in settings.py consolidates
      TEMPLATE_DIRS, TEMPLATE_CONTEXT_PROCESSORS,
      TEMPLATE_LOADERS, TEMPLATE_STRING_IF_INVALID, and
      TEMPLATE_DEBUG
  (c) patterns() wrapper in url() is removed, with
      urlpatterns now a simple list
  (d) NoArgsCommand in commands() must be replace by
      BaseCommand, and handle_noargs() changed to
      handle()

Also, the Django version checker must be updated to accept
two digit sub-version numbers (e.g. "1.8" < "1.10")

[YOCTO #11684]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 bin/toaster                                        | 10 +++-
 lib/toaster/bldcollector/urls.py                   | 10 ++--
 .../management/commands/checksettings.py           |  6 +-
 .../bldcontrol/management/commands/runbuilds.py    |  6 +-
 lib/toaster/orm/management/commands/lsupdates.py   |  8 +--
 lib/toaster/toastergui/urls.py                     | 61 +++++++++----------
 .../toastermain/management/commands/buildslist.py  |  6 +-
 lib/toaster/toastermain/settings.py                | 70 +++++++++++++---------
 lib/toaster/toastermain/urls.py                    |  8 ++-
 toaster-requirements.txt                           |  2 +-
 10 files changed, 105 insertions(+), 82 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 61a4a0f..c2e33fe 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -116,8 +116,14 @@ verify_prereq() {
     # Verify Django version
     reqfile=$(python3 -c "import os; print(os.path.realpath('$BBBASEDIR/toaster-requirements.txt'))")
     exp='s/Django\([><=]\+\)\([^,]\+\),\([><=]\+\)\(.\+\)/'
-    exp=$exp'import sys,django;version=django.get_version().split(".");'
-    exp=$exp'sys.exit(not (version \1 "\2".split(".") and version \3 "\4".split(".")))/p'
+    # expand version parts to 2 digits to support 1.10.x > 1.8
+    # (note:helper functions hard to insert in-line)
+    exp=$exp'import sys,django;'
+    exp=$exp'version=["%02d" % int(n) for n in django.get_version().split(".")];'
+    exp=$exp'vmin=["%02d" % int(n) for n in "\2".split(".")];'
+    exp=$exp'vmax=["%02d" % int(n) for n in "\4".split(".")];'
+    exp=$exp'sys.exit(not (version \1 vmin and version \3 vmax))'
+    exp=$exp'/p'
     if ! sed -n "$exp" $reqfile | python3 - ; then
         req=`grep ^Django $reqfile`
         echo "This program needs $req"
diff --git a/lib/toaster/bldcollector/urls.py b/lib/toaster/bldcollector/urls.py
index 64722f2..076afdb 100644
--- a/lib/toaster/bldcollector/urls.py
+++ b/lib/toaster/bldcollector/urls.py
@@ -1,7 +1,7 @@
 #
 # BitBake Toaster Implementation
 #
-# Copyright (C) 2014        Intel Corporation
+# Copyright (C) 2014-2017   Intel Corporation
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
@@ -19,7 +19,9 @@
 
 from django.conf.urls import patterns, include, url
 
-urlpatterns = patterns('bldcollector.views',
+import bldcollector.views
+
+urlpatterns = [
         # landing point for pushing a bitbake_eventlog.json file to this toaster instace
-        url(r'^eventfile$', 'eventfile', name='eventfile'),
-        )
+        url(r'^eventfile$', bldcollector.views.eventfile, name='eventfile'),
+]
diff --git a/lib/toaster/bldcontrol/management/commands/checksettings.py b/lib/toaster/bldcontrol/management/commands/checksettings.py
index 2ed994f..d11166e 100644
--- a/lib/toaster/bldcontrol/management/commands/checksettings.py
+++ b/lib/toaster/bldcontrol/management/commands/checksettings.py
@@ -1,4 +1,4 @@
-from django.core.management.base import NoArgsCommand, CommandError
+from django.core.management.base import BaseCommand, CommandError
 from django.db import transaction
 
 from django.core.management import call_command
@@ -18,7 +18,7 @@ def DN(path):
         return os.path.dirname(path)
 
 
-class Command(NoArgsCommand):
+class Command(BaseCommand):
     args = ""
     help = "Verifies that the configured settings are valid and usable, or prompts the user to fix the settings."
 
@@ -152,7 +152,7 @@ class Command(NoArgsCommand):
 
 
 
-    def handle_noargs(self, **options):
+    def handle(self, **options):
         retval = 0
         retval += self._verify_build_environment()
         retval += self._verify_default_settings()
diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index df11f9d..8eacb5e 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -1,4 +1,4 @@
-from django.core.management.base import NoArgsCommand
+from django.core.management.base import BaseCommand
 from django.db import transaction
 from django.db.models import Q
 
@@ -16,7 +16,7 @@ import os
 logger = logging.getLogger("toaster")
 
 
-class Command(NoArgsCommand):
+class Command(BaseCommand):
     args = ""
     help = "Schedules and executes build requests as possible. "\
            "Does not return (interrupt with Ctrl-C)"
@@ -168,7 +168,7 @@ class Command(NoArgsCommand):
         except Exception as e:
             logger.warn("runbuilds: schedule exception %s" % str(e))
 
-    def handle_noargs(self, **options):
+    def handle(self, **options):
         pidfile_path = os.path.join(os.environ.get("BUILDDIR", "."),
                                     ".runbuilds.pid")
 
diff --git a/lib/toaster/orm/management/commands/lsupdates.py b/lib/toaster/orm/management/commands/lsupdates.py
index 68c6c42..90f07c9 100644
--- a/lib/toaster/orm/management/commands/lsupdates.py
+++ b/lib/toaster/orm/management/commands/lsupdates.py
@@ -4,7 +4,7 @@
 #
 # BitBake Toaster Implementation
 #
-# Copyright (C) 2016        Intel Corporation
+# Copyright (C) 2016-2017   Intel Corporation
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
@@ -19,7 +19,7 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
-from django.core.management.base import NoArgsCommand
+from django.core.management.base import BaseCommand
 
 from orm.models import LayerSource, Layer, Release, Layer_Version
 from orm.models import LayerVersionDependency, Machine, Recipe
@@ -56,7 +56,7 @@ class Spinner(threading.Thread):
         self.signal = False
 
 
-class Command(NoArgsCommand):
+class Command(BaseCommand):
     args = ""
     help = "Updates locally cached information from a layerindex server"
 
@@ -307,5 +307,5 @@ class Command(NoArgsCommand):
 
         os.system('setterm -cursor on')
 
-    def handle_noargs(self, **options):
+    def handle(self, **options):
         self.update()
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index d92f190..1ad79a4 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -1,7 +1,7 @@
 #
 # BitBake Toaster Implementation
 #
-# Copyright (C) 2013        Intel Corporation
+# Copyright (C) 2013-2017    Intel Corporation
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
@@ -25,49 +25,50 @@ from toastergui import buildtables
 from toastergui import typeaheads
 from toastergui import api
 from toastergui import widgets
+from toastergui import views
 
-urlpatterns = patterns('toastergui.views',
+urlpatterns = [
         # landing page
-        url(r'^landing/$', 'landing', name='landing'),
+        url(r'^landing/$', views.landing, name='landing'),
 
         url(r'^builds/$',
             tables.AllBuildsTable.as_view(template_name="builds-toastertable.html"),
             name='all-builds'),
 
         # build info navigation
-        url(r'^build/(?P<build_id>\d+)$', 'builddashboard', name="builddashboard"),
+        url(r'^build/(?P<build_id>\d+)$', views.builddashboard, name="builddashboard"),
         url(r'^build/(?P<build_id>\d+)/tasks/$',
             buildtables.BuildTasksTable.as_view(
                 template_name="buildinfo-toastertable.html"),
             name='tasks'),
 
-        url(r'^build/(?P<build_id>\d+)/task/(?P<task_id>\d+)$', 'task', name='task'),
+        url(r'^build/(?P<build_id>\d+)/task/(?P<task_id>\d+)$', views.task, name='task'),
 
         url(r'^build/(?P<build_id>\d+)/recipes/$',
             buildtables.BuiltRecipesTable.as_view(
                 template_name="buildinfo-toastertable.html"),
             name='recipes'),
 
-        url(r'^build/(?P<build_id>\d+)/recipe/(?P<recipe_id>\d+)/active_tab/(?P<active_tab>\d{1})$', 'recipe', name='recipe'),
+        url(r'^build/(?P<build_id>\d+)/recipe/(?P<recipe_id>\d+)/active_tab/(?P<active_tab>\d{1})$', views.recipe, name='recipe'),
 
-        url(r'^build/(?P<build_id>\d+)/recipe/(?P<recipe_id>\d+)$', 'recipe', name='recipe'),
-        url(r'^build/(?P<build_id>\d+)/recipe_packages/(?P<recipe_id>\d+)$', 'recipe_packages', name='recipe_packages'),
+        url(r'^build/(?P<build_id>\d+)/recipe/(?P<recipe_id>\d+)$', views.recipe, name='recipe'),
+        url(r'^build/(?P<build_id>\d+)/recipe_packages/(?P<recipe_id>\d+)$', views.recipe_packages, name='recipe_packages'),
 
         url(r'^build/(?P<build_id>\d+)/packages/$',
             buildtables.BuiltPackagesTable.as_view(
                 template_name="buildinfo-toastertable.html"),
             name='packages'),
 
-        url(r'^build/(?P<build_id>\d+)/package/(?P<package_id>\d+)$', 'package_built_detail',
+        url(r'^build/(?P<build_id>\d+)/package/(?P<package_id>\d+)$', views.package_built_detail,
                 name='package_built_detail'),
         url(r'^build/(?P<build_id>\d+)/package_built_dependencies/(?P<package_id>\d+)$',
-            'package_built_dependencies', name='package_built_dependencies'),
+            views.package_built_dependencies, name='package_built_dependencies'),
         url(r'^build/(?P<build_id>\d+)/package_included_detail/(?P<target_id>\d+)/(?P<package_id>\d+)$',
-            'package_included_detail', name='package_included_detail'),
+            views.package_included_detail, name='package_included_detail'),
         url(r'^build/(?P<build_id>\d+)/package_included_dependencies/(?P<target_id>\d+)/(?P<package_id>\d+)$',
-            'package_included_dependencies', name='package_included_dependencies'),
+            views.package_included_dependencies, name='package_included_dependencies'),
         url(r'^build/(?P<build_id>\d+)/package_included_reverse_dependencies/(?P<target_id>\d+)/(?P<package_id>\d+)$',
-            'package_included_reverse_dependencies', name='package_included_reverse_dependencies'),
+            views.package_included_reverse_dependencies, name='package_included_reverse_dependencies'),
 
         url(r'^build/(?P<build_id>\d+)/target/(?P<target_id>\d+)$',
             buildtables.InstalledPackagesTable.as_view(
@@ -75,11 +76,11 @@ urlpatterns = patterns('toastergui.views',
             name='target'),
 
 
-        url(r'^dentries/build/(?P<build_id>\d+)/target/(?P<target_id>\d+)$', 'xhr_dirinfo', name='dirinfo_ajax'),
-        url(r'^build/(?P<build_id>\d+)/target/(?P<target_id>\d+)/dirinfo$', 'dirinfo', name='dirinfo'),
-        url(r'^build/(?P<build_id>\d+)/target/(?P<target_id>\d+)/dirinfo_filepath/_(?P<file_path>(?:/[^/\n]+)*)$', 'dirinfo', name='dirinfo_filepath'),
-        url(r'^build/(?P<build_id>\d+)/configuration$', 'configuration', name='configuration'),
-        url(r'^build/(?P<build_id>\d+)/configvars$', 'configvars', name='configvars'),
+        url(r'^dentries/build/(?P<build_id>\d+)/target/(?P<target_id>\d+)$', views.xhr_dirinfo, name='dirinfo_ajax'),
+        url(r'^build/(?P<build_id>\d+)/target/(?P<target_id>\d+)/dirinfo$', views.dirinfo, name='dirinfo'),
+        url(r'^build/(?P<build_id>\d+)/target/(?P<target_id>\d+)/dirinfo_filepath/_(?P<file_path>(?:/[^/\n]+)*)$', views.dirinfo, name='dirinfo_filepath'),
+        url(r'^build/(?P<build_id>\d+)/configuration$', views.configuration, name='configuration'),
+        url(r'^build/(?P<build_id>\d+)/configvars$', views.configvars, name='configvars'),
         url(r'^build/(?P<build_id>\d+)/buildtime$',
             buildtables.BuildTimeTable.as_view(
                 template_name="buildinfo-toastertable.html"),
@@ -97,26 +98,26 @@ urlpatterns = patterns('toastergui.views',
 
         # image information dir
         url(r'^build/(?P<build_id>\d+)/target/(?P<target_id>\d+)/packagefile/(?P<packagefile_id>\d+)$',
-             'image_information_dir', name='image_information_dir'),
+             views.image_information_dir, name='image_information_dir'),
 
         # build download artifact
-        url(r'^build/(?P<build_id>\d+)/artifact/(?P<artifact_type>\w+)/id/(?P<artifact_id>\w+)', 'build_artifact', name="build_artifact"),
+        url(r'^build/(?P<build_id>\d+)/artifact/(?P<artifact_type>\w+)/id/(?P<artifact_id>\w+)', views.build_artifact, name="build_artifact"),
 
         # project URLs
-        url(r'^newproject/$', 'newproject', name='newproject'),
+        url(r'^newproject/$', views.newproject, name='newproject'),
 
         url(r'^projects/$',
             tables.ProjectsTable.as_view(template_name="projects-toastertable.html"),
             name='all-projects'),
 
-        url(r'^project/(?P<pid>\d+)/$', 'project', name='project'),
-        url(r'^project/(?P<pid>\d+)/configuration$', 'projectconf', name='projectconf'),
+        url(r'^project/(?P<pid>\d+)/$', views.project, name='project'),
+        url(r'^project/(?P<pid>\d+)/configuration$', views.projectconf, name='projectconf'),
         url(r'^project/(?P<pid>\d+)/builds/$',
             tables.ProjectBuildsTable.as_view(template_name="projectbuilds-toastertable.html"),
             name='projectbuilds'),
 
         # the import layer is a project-specific functionality;
-        url(r'^project/(?P<pid>\d+)/importlayer$', 'importlayer', name='importlayer'),
+        url(r'^project/(?P<pid>\d+)/importlayer$', views.importlayer, name='importlayer'),
 
         # the table pages that have been converted to ToasterTable widget
         url(r'^project/(?P<pid>\d+)/machines/$',
@@ -142,7 +143,7 @@ urlpatterns = patterns('toastergui.views',
             name="projectlayers"),
 
         url(r'^project/(?P<pid>\d+)/layer/(?P<layerid>\d+)$',
-            'layerdetails', name='layerdetails'),
+            views.layerdetails, name='layerdetails'),
 
         url(r'^project/(?P<pid>\d+)/layer/(?P<layerid>\d+)/recipes/$',
             tables.LayerRecipesTable.as_view(template_name="generic-toastertable-page.html"),
@@ -166,7 +167,7 @@ urlpatterns = patterns('toastergui.views',
             name="customrecipe"),
 
         url(r'^project/(?P<pid>\d+)/customrecipe/(?P<recipe_id>\d+)/download$',
-            'customrecipe_download',
+            views.customrecipe_download,
             name="customrecipedownload"),
 
         url(r'^project/(?P<pid>\d+)/recipe/(?P<recipe_id>\d+)$',
@@ -186,9 +187,9 @@ urlpatterns = patterns('toastergui.views',
             typeaheads.GitRevisionTypeAhead.as_view(),
             name='xhr_gitrevtypeahead'),
 
-        url(r'^xhr_testreleasechange/(?P<pid>\d+)$', 'xhr_testreleasechange',
+        url(r'^xhr_testreleasechange/(?P<pid>\d+)$', views.xhr_testreleasechange,
             name='xhr_testreleasechange'),
-        url(r'^xhr_configvaredit/(?P<pid>\d+)$', 'xhr_configvaredit',
+        url(r'^xhr_configvaredit/(?P<pid>\d+)$', views.xhr_configvaredit,
             name='xhr_configvaredit'),
 
         url(r'^xhr_layer/(?P<pid>\d+)/(?P<layerversion_id>\d+)$',
@@ -200,7 +201,7 @@ urlpatterns = patterns('toastergui.views',
             name='xhr_layer'),
 
         # JS Unit tests
-        url(r'^js-unit-tests/$', 'jsunittests', name='js-unit-tests'),
+        url(r'^js-unit-tests/$', views.jsunittests, name='js-unit-tests'),
 
         # image customisation functionality
         url(r'^xhr_customrecipe/(?P<recipe_id>\d+)'
@@ -237,4 +238,4 @@ urlpatterns = patterns('toastergui.views',
 
           # default redirection
         url(r'^$', RedirectView.as_view(url='landing', permanent=True)),
-)
+]
diff --git a/lib/toaster/toastermain/management/commands/buildslist.py b/lib/toaster/toastermain/management/commands/buildslist.py
index 8dfef0a..70b5812 100644
--- a/lib/toaster/toastermain/management/commands/buildslist.py
+++ b/lib/toaster/toastermain/management/commands/buildslist.py
@@ -1,13 +1,13 @@
-from django.core.management.base import NoArgsCommand, CommandError
+from django.core.management.base import BaseCommand, CommandError
 from orm.models import Build
 import os
 
 
 
-class Command(NoArgsCommand):
+class Command(BaseCommand):
     args    = ""
     help    = "Lists current builds"
 
-    def handle_noargs(self,**options):
+    def handle(self,**options):
         for b in Build.objects.all():
             print("%d: %s %s %s" % (b.pk, b.machine, b.distro, ",".join([x.target for x in b.target_set.all()])))
diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index 1fd649c..54ab31f 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -24,7 +24,6 @@
 import os
 
 DEBUG = True
-TEMPLATE_DEBUG = DEBUG
 
 # Set to True to see the SQL queries in console
 SQL_DEBUG = False
@@ -161,12 +160,47 @@ STATICFILES_FINDERS = (
 # Make this unique, and don't share it with anybody.
 SECRET_KEY = 'NOT_SUITABLE_FOR_HOSTED_DEPLOYMENT'
 
-# List of callables that know how to import templates from various sources.
-TEMPLATE_LOADERS = (
-    'django.template.loaders.filesystem.Loader',
-    'django.template.loaders.app_directories.Loader',
-#     'django.template.loaders.eggs.Loader',
-)
+class InvalidString(str):
+    def __mod__(self, other):
+        from django.template.base import TemplateSyntaxError
+        raise TemplateSyntaxError(
+            "Undefined variable or unknown value for: \"%s\"" % other)
+
+TEMPLATES = [
+    {
+        'BACKEND': 'django.template.backends.django.DjangoTemplates',
+        'DIRS': [
+            # Put strings here, like "/home/html/django_templates" or "C:/www/django/templates".
+            # Always use forward slashes, even on Windows.
+            # Don't forget to use absolute paths, not relative paths.
+        ],
+        'OPTIONS': {
+            'context_processors': [
+                # Insert your TEMPLATE_CONTEXT_PROCESSORS here or use this
+                # list if you haven't customized them:
+                'django.contrib.auth.context_processors.auth',
+                'django.template.context_processors.debug',
+                'django.template.context_processors.i18n',
+                'django.template.context_processors.media',
+                'django.template.context_processors.static',
+                'django.template.context_processors.tz',
+                'django.contrib.messages.context_processors.messages',
+                # Custom
+                'django.core.context_processors.request',
+                'toastergui.views.managedcontextprocessor',
+
+            ],
+            'loaders': [
+                # List of callables that know how to import templates from various sources.
+                'django.template.loaders.filesystem.Loader',
+                'django.template.loaders.app_directories.Loader',
+                #'django.template.loaders.eggs.Loader',
+            ],
+            'string_if_invalid': InvalidString("%s"),
+            'debug': DEBUG,
+        },
+    },
+]
 
 MIDDLEWARE_CLASSES = (
     'django.middleware.common.CommonMiddleware',
@@ -203,22 +237,6 @@ ROOT_URLCONF = 'toastermain.urls'
 # Python dotted path to the WSGI application used by Django's runserver.
 WSGI_APPLICATION = 'toastermain.wsgi.application'
 
-TEMPLATE_DIRS = (
-    # Put strings here, like "/home/html/django_templates" or "C:/www/django/templates".
-    # Always use forward slashes, even on Windows.
-    # Don't forget to use absolute paths, not relative paths.
-)
-
-TEMPLATE_CONTEXT_PROCESSORS = ('django.contrib.auth.context_processors.auth',
- 'django.core.context_processors.debug',
- 'django.core.context_processors.i18n',
- 'django.core.context_processors.media',
- 'django.core.context_processors.static',
- 'django.core.context_processors.tz',
- 'django.contrib.messages.context_processors.messages',
- "django.core.context_processors.request",
- 'toastergui.views.managedcontextprocessor',
- )
 
 INSTALLED_APPS = (
     'django.contrib.auth',
@@ -348,10 +366,4 @@ connection_created.connect(activate_synchronous_off)
 #
 
 
-class InvalidString(str):
-    def __mod__(self, other):
-        from django.template.base import TemplateSyntaxError
-        raise TemplateSyntaxError(
-            "Undefined variable or unknown value for: \"%s\"" % other)
 
-TEMPLATE_STRING_IF_INVALID = InvalidString("%s")
diff --git a/lib/toaster/toastermain/urls.py b/lib/toaster/toastermain/urls.py
index 1f8599e..bb32559 100644
--- a/lib/toaster/toastermain/urls.py
+++ b/lib/toaster/toastermain/urls.py
@@ -23,6 +23,8 @@ from django.conf.urls import patterns, include, url
 from django.views.generic import RedirectView
 from django.views.decorators.cache import never_cache
 
+import bldcollector.views
+
 import logging
 
 logger = logging.getLogger("toaster")
@@ -31,7 +33,7 @@ logger = logging.getLogger("toaster")
 from django.contrib import admin
 admin.autodiscover()
 
-urlpatterns = patterns('',
+urlpatterns = [
 
     # Examples:
     # url(r'^toaster/', include('toaster.foo.urls')),
@@ -42,11 +44,11 @@ urlpatterns = patterns('',
 
     # This is here to maintain backward compatibility and will be deprecated
     # in the future.
-    url(r'^orm/eventfile$', 'bldcollector.views.eventfile'),
+    url(r'^orm/eventfile$', bldcollector.views.eventfile),
 
     # if no application is selected, we have the magic toastergui app here
     url(r'^$', never_cache(RedirectView.as_view(url='/toastergui/', permanent=True))),
-)
+]
 
 import toastermain.settings
 
diff --git a/toaster-requirements.txt b/toaster-requirements.txt
index e61c8e2..3f47650 100644
--- a/toaster-requirements.txt
+++ b/toaster-requirements.txt
@@ -1,3 +1,3 @@
-Django>1.8,<1.9
+Django>1.8,<1.9.9
 beautifulsoup4>=4.4.0
 pytz
-- 
1.9.1


