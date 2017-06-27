Return-Path: <david.reyna@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id C00D677E9C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jun 2017 20:53:14 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id v5RKrFMR007409
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jun 2017 13:53:15 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.209) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.294.0; Tue, 27 Jun 2017 13:53:15 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 27 Jun 2017 13:44:29 -0700
Message-ID: <13313607fe3333cd9573ac3cc510a413c58baf8d.1498595652.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1498595646.git.David.Reyna@windriver.com>
References: <cover.1498595646.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.209]
Subject: [PATCH 2/5] toaster: git clone progress bar
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
X-List-Received-Date: Tue, 27 Jun 2017 20:53:14 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

If a project has a lot of additional layers, the build may
appear to hang while those layers are checked out.
This patch adds a clone progress bar that is visible before
the parsing progress appears.

[YOCTO #9916]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py   | 12 ++++++++++
 lib/toaster/orm/migrations/0016_clone_progress.py | 24 +++++++++++++++++++
 lib/toaster/orm/models.py                         | 15 ++++++++++++
 lib/toaster/toastergui/static/js/mrbsection.js    | 15 ++++++++++++
 lib/toaster/toastergui/templates/mrb_section.html | 29 ++++++++++++++++++++++-
 lib/toaster/toastergui/widgets.py                 |  4 ++++
 6 files changed, 98 insertions(+), 1 deletion(-)
 create mode 100644 bitbake/lib/toaster/orm/migrations/0016_clone_progress.py

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 62e62fe..2916246 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -85,6 +85,11 @@ class LocalhostBEController(BuildEnvironmentController):
         return local_checkout_path
 
 
+    def setCloneStatus(self,bitbake,status,total,current):
+        bitbake.req.build.repos_cloned=current
+        bitbake.req.build.repos_to_clone=total
+        bitbake.req.build.save()
+
     def setLayers(self, bitbake, layers, targets):
         """ a word of attention: by convention, the first layer for any build will be poky! """
 
@@ -147,7 +152,13 @@ class LocalhostBEController(BuildEnvironmentController):
         logger.info("Using pre-checked out source for layer %s", cached_layers)
 
         # 3. checkout the repositories
+        clone_count=0
+        clone_total=len(gitrepos.keys())
+        self.setCloneStatus(bitbake,'Started',clone_total,clone_count)
         for giturl, commit in gitrepos.keys():
+            self.setCloneStatus(bitbake,'progress',clone_total,clone_count)
+            clone_count += 1
+
             localdirname = os.path.join(self.be.sourcedir, self.getGitCloneDirectory(giturl, commit))
             logger.debug("localhostbecontroller: giturl %s:%s checking out in current directory %s" % (giturl, commit, localdirname))
 
@@ -198,6 +209,7 @@ class LocalhostBEController(BuildEnvironmentController):
                 if name != "bitbake":
                     layerlist.append(localdirpath.rstrip("/"))
 
+        self.setCloneStatus(bitbake,'complete',clone_total,clone_count)
         logger.debug("localhostbecontroller: current layer list %s " % pformat(layerlist))
 
         # 5. create custom layer and add custom recipes to it
diff --git a/lib/toaster/orm/migrations/0016_clone_progress.py b/lib/toaster/orm/migrations/0016_clone_progress.py
new file mode 100644
index 0000000..852b878
--- /dev/null
+++ b/lib/toaster/orm/migrations/0016_clone_progress.py
@@ -0,0 +1,24 @@
+# -*- coding: utf-8 -*-
+from __future__ import unicode_literals
+
+from django.db import migrations, models
+
+class Migration(migrations.Migration):
+
+    dependencies = [
+        ('orm', '0015_layer_local_source_dir'),
+    ]
+
+    operations = [
+        migrations.AddField(
+            model_name='build',
+            name='repos_cloned',
+            field=models.IntegerField(default=0),
+        ),
+        migrations.AddField(
+            model_name='build',
+            name='repos_to_clone',
+            field=models.IntegerField(default=1),
+        ),
+    ]
+
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index a49f9a4..13bd117 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -437,6 +437,12 @@ class Build(models.Model):
     # number of recipes parsed so far for this build
     recipes_parsed = models.IntegerField(default=0)
 
+    # number of repos to clone for this build
+    repos_to_clone = models.IntegerField(default=1)
+
+    # number of repos cloned so far for this build
+    repos_cloned = models.IntegerField(default=0)
+
     @staticmethod
     def get_recent(project=None):
         """
@@ -667,6 +673,13 @@ class Build(models.Model):
         else:
             return False
 
+    def is_cloning(self):
+        """
+        True if the build is still cloning repos
+        """
+        return self.outcome == Build.IN_PROGRESS and \
+            self.repos_cloned < self.repos_to_clone
+
     def is_parsing(self):
         """
         True if the build is still parsing recipes
@@ -698,6 +711,8 @@ class Build(models.Model):
             return 'Cancelling';
         elif self.is_queued():
             return 'Queued'
+        elif self.is_cloning():
+            return 'Cloning'
         elif self.is_parsing():
             return 'Parsing'
         elif self.is_starting():
diff --git a/lib/toaster/toastergui/static/js/mrbsection.js b/lib/toaster/toastergui/static/js/mrbsection.js
index 73d0935..c0c5fa9 100644
--- a/lib/toaster/toastergui/static/js/mrbsection.js
+++ b/lib/toaster/toastergui/static/js/mrbsection.js
@@ -61,6 +61,12 @@ function mrbSectionInit(ctx){
     return (cached.recipes_parsed_percentage !== build.recipes_parsed_percentage);
   }
 
+  // returns true if the number of repos cloned/to clone changed
+  function cloneProgressChanged(build) {
+    var cached = getCached(build);
+    return (cached.repos_cloned_percentage !== build.repos_cloned_percentage);
+  }
+
   function refreshMostRecentBuilds(){
     libtoaster.getMostRecentBuilds(
       libtoaster.ctx.mostRecentBuildsUrl,
@@ -100,6 +106,15 @@ function mrbSectionInit(ctx){
 
             container.html(html);
           }
+          else if (cloneProgressChanged(build)) {
+            // update the clone progress text
+            selector = '#repos-cloned-percentage-' + build.id;
+            $(selector).html(build.repos_cloned_percentage);
+
+            // update the recipe progress bar
+            selector = '#repos-cloned-percentage-bar-' + build.id;
+            $(selector).width(build.repos_cloned_percentage + '%');
+          }
           else if (tasksProgressChanged(build)) {
             // update the task progress text
             selector = '#build-pc-done-' + build.id;
diff --git a/lib/toaster/toastergui/templates/mrb_section.html b/lib/toaster/toastergui/templates/mrb_section.html
index b761ffe..c5b9fe9 100644
--- a/lib/toaster/toastergui/templates/mrb_section.html
+++ b/lib/toaster/toastergui/templates/mrb_section.html
@@ -64,7 +64,9 @@
   </div>
 
   <div data-build-state="<%:state%>">
-    <%if state == 'Parsing'%>
+    <%if state == 'Cloning'%>
+      <%include tmpl='#cloning-repos-build-template'/%>
+    <%else state == 'Parsing'%>
       <%include tmpl='#parsing-recipes-build-template'/%>
     <%else state == 'Queued'%>
       <%include tmpl='#queued-build-template'/%>
@@ -98,6 +100,31 @@
   </div>
 </script>
 
+<!-- cloning repos build -->
+<script id="cloning-repos-build-template" type="text/x-jsrender">
+  <!-- progress bar and parse completion percentage -->
+  <div data-role="build-status" class="col-md-4 col-md-offset-1 progress-info">
+    <!-- progress bar -->
+    <div class="progress">
+      <div id="repos-cloned-percentage-bar-<%:id%>"
+           style="width: <%:repos_cloned_percentage%>%;"
+           class="progress-bar">
+      </div>
+    </div>
+  </div>
+
+  <div class="col-md-4 progress-info">
+    <!-- parse completion percentage -->
+    <span class="glyphicon glyphicon-question-sign get-help get-help-blue"
+          title="Toaster is cloning the repos required for your build">
+    </span>
+
+    Cloning <span id="repos-cloned-percentage-<%:id%>"><%:repos_cloned_percentage%></span>% complete
+
+    <%include tmpl='#cancel-template'/%>
+  </div>
+</script>
+
 <!-- parsing recipes build -->
 <script id="parsing-recipes-build-template" type="text/x-jsrender">
   <!-- progress bar and parse completion percentage -->
diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index 6b7b981..67c1ff9 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -511,6 +511,10 @@ class MostRecentBuildsView(View):
                 int((build_obj.recipes_parsed /
                      build_obj.recipes_to_parse) * 100)
 
+            build['repos_cloned_percentage'] = \
+                int((build_obj.repos_cloned /
+                     build_obj.repos_to_clone) * 100)
+
             tasks_complete_percentage = 0
             if build_obj.outcome in (Build.SUCCEEDED, Build.FAILED):
                 tasks_complete_percentage = 100
-- 
1.9.1


