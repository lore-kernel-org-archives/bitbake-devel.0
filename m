Return-Path: <brian.avery@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id E8B117319C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Jul 2016 22:53:55 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 12 Jul 2016 15:53:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,354,1464678000"; d="scan'208";a="1015672964"
Received: from bavery-ws-desk.jf.intel.com ([10.7.201.28])
	by orsmga002.jf.intel.com with ESMTP; 12 Jul 2016 15:53:44 -0700
From: bavery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Jul 2016 15:54:50 -0700
Message-Id: <aef0b1958d97dc92ae433ec05079cffa41ee203d.1468363530.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <4551b56f132497c055f39567946a5d3be347d770.1468363530.git.brian.avery@intel.com>
References: <4551b56f132497c055f39567946a5d3be347d770.1468363530.git.brian.avery@intel.com>
In-Reply-To: <cover.1468363530.git.brian.avery@intel.com>
References: <cover.1468363530.git.brian.avery@intel.com>
Cc: bavery <brian.avery@intel.com>
Subject: [PATCH 09/17] toaster: use has_images() methods to display images correctly
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
X-List-Received-Date: Tue, 12 Jul 2016 22:53:57 -0000

From: Elliot Smith <elliot.smith@intel.com>

In the build dashboard, we had issues with showing images correctly,
as we were using the is_image property of targets to determine
whether a target would have image files. This property can
be set to True if a target refers to an image recipe
(e.g. "core-image-minimal"), even if the task used in the build
didn't produce any image files.

By adding has_images() methods to the Target and Build objects,
which count associated Target_Image_File objects,
we can correctly determine whether a target has image files
associated with it, and if any of the targets for a build has
image files. This means that we can screen out the left-hand
"Images" menu options for builds which contained image-related
targets (e.g. "core-image-minimal") but which didn't produce
any images (e.g. "rootfs" task).

[YOCTO #9500]
[YOCTO #9784]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: bavery <brian.avery@intel.com>
---
 lib/toaster/orm/models.py                          | 28 ++++++++++++++++++++--
 .../toastergui/templates/basebuildpage.html        |  8 ++++---
 lib/toaster/toastergui/views.py                    |  9 ++-----
 3 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 61f6a20..0443a45 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -436,17 +436,32 @@ class Build(models.Model):
             eta += ((eta - self.started_on)*(100-completeper))/completeper
         return eta
 
+    def has_images(self):
+        """
+        Returns True if at least one of the targets for this build has an
+        image file associated with it, False otherwise
+        """
+        targets = Target.objects.filter(build_id=self.id)
+        has_images = False
+        for target in targets:
+            if target.has_images():
+                has_images = True
+                break
+        return has_images
+
     def get_image_file_extensions(self):
         """
-        Get list of file name extensions for images produced by this build;
+        Get string of file name extensions for images produced by this build;
         note that this is the actual list of extensions stored on Target objects
         for this build, and not the value of IMAGE_FSTYPES.
+
+        Returns comma-separated string, e.g. "vmdk, ext4"
         """
         extensions = []
 
         targets = Target.objects.filter(build_id = self.id)
         for target in targets:
-            if (not target.is_image):
+            if not target.is_image:
                 continue
 
             target_image_files = Target_Image_File.objects.filter(
@@ -739,6 +754,12 @@ class Target(models.Model):
             sdk_file.target = self
             sdk_file.save()
 
+    def has_images(self):
+        """
+        Returns True if this target has one or more image files attached to it.
+        """
+        return self.target_image_file_set.all().count() > 0
+
 # kernel artifacts for a target: bzImage and modules*
 class TargetKernelFile(models.Model):
     target = models.ForeignKey(Target)
@@ -775,6 +796,9 @@ class Target_Image_File(models.Model):
 
     @property
     def suffix(self):
+        """
+        Suffix for image file, minus leading "."
+        """
         for suffix in Target_Image_File.SUFFIXES:
             if self.file_name.endswith(suffix):
                 return suffix
diff --git a/lib/toaster/toastergui/templates/basebuildpage.html b/lib/toaster/toastergui/templates/basebuildpage.html
index 856259a..e9927eb 100644
--- a/lib/toaster/toastergui/templates/basebuildpage.html
+++ b/lib/toaster/toastergui/templates/basebuildpage.html
@@ -33,7 +33,7 @@
 
         $("#build-menu li a").each(function(){
           /* Set the page active state in the Build menu */
-          var currentUrl = window.location.href.split('?')[0]; 
+          var currentUrl = window.location.href.split('?')[0];
           if (currentUrl === $(this).prop("href")){
             $(this).parent().addClass("active");
           } else {
@@ -62,11 +62,13 @@
           {% endif %} >
           <a  href="{% url 'builddashboard' build.pk %}">Build summary</a>
         </li>
-        {% if build.target_set.all.0.is_image and build.outcome == 0 %}
+        {% if build.has_images and build.outcome == build.SUCCEEDED %}
           <li class="nav-header">Images</li>
           {% block nav-target %}
             {% for t in build.get_sorted_target_list %}
-            <li id="menu-{{t.target}}"><a href="{% url 'target' build.pk t.pk %}">{{t.target}}</a><li>
+              {% if t.has_images %}
+                <li id="menu-{{t.target}}"><a href="{% url 'target' build.pk t.pk %}">{{t.target}}</a><li>
+              {% endif %}
             {% endfor %}
           {% endblock %}
         {% endif %}
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index a82a261..02caf54 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -471,19 +471,14 @@ def builddashboard( request, build_id ):
     recipeCount = Recipe.objects.filter( layer_version__id__in = layerVersionId ).count( );
     tgts = Target.objects.filter( build_id = build_id ).order_by( 'target' );
 
-    ##
     # set up custom target list with computed package and image data
-    #
-
     targets = [ ]
     ntargets = 0
-    hasImages = False
+
     targetHasNoImages = False
     for t in tgts:
         elem = { }
         elem[ 'target' ] = t
-        if t.is_image:
-            hasImages = True
         npkg = 0
         pkgsz = 0
         package = None
@@ -533,7 +528,7 @@ def builddashboard( request, build_id ):
     context = {
             'build'           : build,
             'project'         : build.project,
-            'hasImages'       : hasImages,
+            'hasImages'       : build.has_images(),
             'ntargets'        : ntargets,
             'targets'         : targets,
             'recipecount'     : recipeCount,
-- 
1.9.1


