Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
	[209.85.220.54])
	by mail.openembedded.org (Postfix) with ESMTP id 60A7D6FFFE
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Dec 2015 03:53:01 +0000 (UTC)
Received: by padhk6 with SMTP id hk6so241428pad.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Dec 2015 19:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=93e/jRC/fQHHvXJge+7BAN5GfLbWaKPkczUQ5g8obQs=;
	b=YaHpO136jmMNRNhnJcUom8PCk5ON/7kJZXgCdV2Z8EuqeIgWYEwSwilQMDZ+eqvm/G
	u+Ajb3FoWMhpHUKWo/G0iwVrdYjrNWsLx/a1Flw2D+HKMT4IXSNRwOuiTDAdXoteYBEb
	NMGzX1wChrCcJlp+l2i9vuNld0akeCYohYzVOHDyxtl2YCNYS+FDJvEKcLXa1EGUvVLc
	/t5JUlc5sjJMAfm4Q8n+dDw2YeI5PPSibeHpq1jYF60n/GUyzwhtlVxttBE9joSzYggz
	6tgoVOlHmbdOdYdsxBxljudZUT5zPG6h3NtpC+hwkX94RptgaoWqS88UHFpo7sMJvOsi
	7a2g==
X-Received: by 10.66.254.161 with SMTP id aj1mr13377604pad.31.1449719582882;
	Wed, 09 Dec 2015 19:53:02 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	c20sm14761349pfd.17.2015.12.09.19.53.02
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 09 Dec 2015 19:53:02 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Dec 2015 19:56:29 -0800
Message-Id: <097beb86dce2a263cd9d0d3aba2e3550b351cf1f.1449719707.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f49f7e1b41ee18a9959be3f3e12856980d58a18b.1449719707.git.avery.brian@gmail.com>
References: <f49f7e1b41ee18a9959be3f3e12856980d58a18b.1449719707.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449719707.git.avery.brian@gmail.com>
References: <cover.1449719707.git.avery.brian@gmail.com>
Subject: [PATCH 04/18] toaster: Create default project with get_or_create* method
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
X-List-Received-Date: Thu, 10 Dec 2015 03:53:02 -0000

From: Elliot Smith <elliot.smith@intel.com>

Rather than maintain data as part of the migrations (as was
done for the default project previously), create the default
(cli builds) project on demand as a by-product of getting
it from the database.

[YOCTO #8364]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/bb/ui/buildinfohelper.py    |  9 +++++++--
 lib/toaster/orm/models.py       | 23 +++++++++++++++--------
 lib/toaster/toastergui/views.py |  2 +-
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index c099551..87e03e7 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -146,7 +146,7 @@ class ORMWrapper(object):
             prj = Project.objects.get(pk = project_id)
 
         else:                           # this build was triggered by a legacy system, or command line interactive mode
-            prj = Project.objects.get_default_project()
+            prj = Project.objects.get_or_create_default_project()
             logger.debug(1, "buildinfohelper: project is not specified, defaulting to %s" % prj)
 
 
@@ -308,6 +308,11 @@ class ORMWrapper(object):
         # then we are wholly responsible for the data
         # and therefore we return the 'real' recipe rather than the build
         # history copy of the recipe.
+        if  recipe_information['layer_version'].build is not None and \
+            recipe_information['layer_version'].build.project == \
+                Project.objects.get_or_create_default_project():
+            return recipe
+
         if built_recipe is None:
             return recipe
 
@@ -345,7 +350,7 @@ class ORMWrapper(object):
         # If we're doing a command line build then associate this new layer with the
         # project to avoid it 'contaminating' toaster data
         project = None
-        if build_obj.project == Project.objects.get_default_project():
+        if build_obj.project == Project.objects.get_or_create_default_project():
             project = build_obj.project
 
         layer_version_object, _ = Layer_Version.objects.get_or_create(
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 0174233..4a868e7 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -91,18 +91,25 @@ class ProjectManager(models.Manager):
 
         return prj
 
-    def create(self, *args, **kwargs):
-        raise Exception("Invalid call to Project.objects.create. Use Project.objects.create_project() to create a project")
-
     # return single object with is_default = True
-    def get_default_project(self):
+    def get_or_create_default_project(self):
         projects = super(ProjectManager, self).filter(is_default = True)
+
         if len(projects) > 1:
-            raise Exception("Inconsistent project data: multiple " +
-                            "default projects (i.e. with is_default=True)")
+            raise Exception('Inconsistent project data: multiple ' +
+                            'default projects (i.e. with is_default=True)')
         elif len(projects) < 1:
-            raise Exception("Inconsistent project data: no default project found")
-        return projects[0]
+            options = {
+                'name': 'Command line builds',
+                'short_description': 'Project for builds started outside Toaster',
+                'is_default': True
+            }
+            project = Project.objects.create(**options)
+            project.save()
+
+            return project
+        else:
+            return projects[0]
 
 class Project(models.Model):
     search_allowed_fields = ['name', 'short_description', 'release__name', 'release__branch_name']
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 243bb09..16f27b8 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -73,7 +73,7 @@ class MimeTypeFinder(object):
 def landing(request):
     # in build mode, we redirect to the command-line builds page
     # if there are any builds for the default (cli builds) project
-    default_project = Project.objects.get_default_project()
+    default_project = Project.objects.get_or_create_default_project()
     default_project_builds = Build.objects.filter(project = default_project)
 
     # we only redirect to projects page if there is a user-generated project
-- 
1.9.1


