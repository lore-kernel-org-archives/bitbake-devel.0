Return-Path: <brian.avery@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 1D553731D7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Jul 2016 22:53:56 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 12 Jul 2016 15:53:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,354,1464678000"; 
	d="scan'208,217";a="1015672973"
Received: from bavery-ws-desk.jf.intel.com ([10.7.201.28])
	by orsmga002.jf.intel.com with ESMTP; 12 Jul 2016 15:53:44 -0700
From: bavery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Jul 2016 15:54:53 -0700
Message-Id: <11ce47fd1b85bd30b9f1ec1c84275544d0e0b45e.1468363530.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <4551b56f132497c055f39567946a5d3be347d770.1468363530.git.brian.avery@intel.com>
References: <4551b56f132497c055f39567946a5d3be347d770.1468363530.git.brian.avery@intel.com>
In-Reply-To: <cover.1468363530.git.brian.avery@intel.com>
References: <cover.1468363530.git.brian.avery@intel.com>
Cc: bavery <brian.avery@intel.com>
Subject: [PATCH 12/17] toaster: better display of targets which produced no images
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

SDK targets (populate_sdk) produce SDK artifacts but no image files.
Currently, these targets appear under the "Images" heading in the
build dashboard, even though they aren't strictly image targets.

Change the heading to "Build artifacts". Also remove the section
which states that a build produced no image files: this is not
correct for populate_sdk targets (those targets don't produce
image files under any circumstances); and other changes mean
that all targets which do produce images will now show those
files.

The check for whether to display the "Build artifacts" section also
needs to change, as we show targets here which didn't produce any
images but did produce SDK artifacts.

[YOCTO #8556]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: bavery <brian.avery@intel.com>
---
 .../toastergui/templates/builddashboard.html       | 29 +++---------
 lib/toaster/toastergui/views.py                    | 51 +++++++++++++---------
 2 files changed, 36 insertions(+), 44 deletions(-)

diff --git a/lib/toaster/toastergui/templates/builddashboard.html b/lib/toaster/toastergui/templates/builddashboard.html
index febf8af..32212ea 100644
--- a/lib/toaster/toastergui/templates/builddashboard.html
+++ b/lib/toaster/toastergui/templates/builddashboard.html
@@ -69,11 +69,11 @@
 
 {%if build.outcome == build.SUCCEEDED%}
 <!-- built images -->
-{% if hasImages %}
-    <h2>Images</h2>
+  {% if hasArtifacts %}
+    <h2>Build artifacts</h2>
     {% for target in targets %}
         {% if target.target.is_image %}
-    <div class="well well-transparent dashboard-section">
+    <div class="well well-transparent dashboard-section" data-artifacts-for-target="{{target.target.pk}}">
         <h3><a href="{% url 'target' build.pk target.target.pk %}">{{target.target.target}}</a></h3>
         <dl class="dl-horizontal">
             <dt>Packages included</dt>
@@ -81,26 +81,7 @@
             <dt>Total package size</dt>
             <dd>{{target.pkgsz|filtered_filesizeformat}}</dd>
         </dl>
-        {% if target.targetHasNoImages %}
-            <div class="row">
-              <div class="col-md-7">
-                <div class="alert alert-info">
-                  <p>
-                  <strong>This build did not create any image files</strong>
-                  </p>
-                  <p>
-                  This is probably because valid image and license manifest
-                  files from a previous build already exist in your
-                  <code>build/tmp/deploy</code>
-                  directory. You can
-                  also <a href="{% url 'target' build.pk target.target.pk %}">view the
-                    license manifest information</a> in Toaster.
-                  </p>
-                </div>
-              </div>
-            </div>
-        {% endif %}
-        {% if not target.targetHasNoImages %}
+        {% if target.targetHasImages %}
           <dl class="dl-horizontal">
             <dt>
               Manifests
@@ -163,7 +144,7 @@
     </div>
         {% endif %}
     {% endfor %}
-{% endif %}
+  {% endif %}
 
 {%else%}
 <!-- error dump -->
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 02caf54..baaa288 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -472,46 +472,57 @@ def builddashboard( request, build_id ):
     tgts = Target.objects.filter( build_id = build_id ).order_by( 'target' );
 
     # set up custom target list with computed package and image data
-    targets = [ ]
+    targets = []
     ntargets = 0
 
-    targetHasNoImages = False
+    # True if at least one target for this build has an SDK artifact
+    # or image file
+    has_artifacts = False
+
     for t in tgts:
-        elem = { }
-        elem[ 'target' ] = t
+        elem = {}
+        elem['target'] = t
+
+        target_has_images = False
+        image_files = []
+
         npkg = 0
         pkgsz = 0
         package = None
         for package in Package.objects.filter(id__in = [x.package_id for x in t.target_installed_package_set.all()]):
             pkgsz = pkgsz + package.size
-            if ( package.installed_name ):
+            if package.installed_name:
                 npkg = npkg + 1
-        elem[ 'npkg' ] = npkg
-        elem[ 'pkgsz' ] = pkgsz
-        ti = Target_Image_File.objects.filter( target_id = t.id )
-        imageFiles = [ ]
+        elem['npkg'] = npkg
+        elem['pkgsz'] = pkgsz
+        ti = Target_Image_File.objects.filter(target_id = t.id)
         for i in ti:
-            ndx = i.file_name.rfind( '/' )
-            if ( ndx < 0 ):
+            ndx = i.file_name.rfind('/')
+            if ndx < 0:
                 ndx = 0;
-            f = i.file_name[ ndx + 1: ]
-            imageFiles.append({
+            f = i.file_name[ndx + 1:]
+            image_files.append({
                 'id': i.id,
                 'path': f,
                 'size': i.file_size,
                 'suffix': i.suffix
             })
-        if t.is_image and (len(imageFiles) <= 0 or len(t.license_manifest_path) <= 0):
-            targetHasNoImages = True
-        elem[ 'imageFiles' ] = imageFiles
-        elem[ 'targetHasNoImages' ] = targetHasNoImages
+        if len(image_files) > 0:
+            target_has_images = True
+        elem['targetHasImages'] = target_has_images
+
+        elem['imageFiles'] = image_files
         elem['target_kernel_artifacts'] = t.targetkernelfile_set.all()
 
         target_sdk_files = t.targetsdkfile_set.all()
-        elem['target_sdk_artifacts_count'] = target_sdk_files.count()
+        target_sdk_artifacts_count = target_sdk_files.count()
+        elem['target_sdk_artifacts_count'] = target_sdk_artifacts_count
         elem['target_sdk_artifacts'] = target_sdk_files
 
-        targets.append( elem )
+        if target_has_images or target_sdk_artifacts_count > 0:
+            has_artifacts = True
+
+        targets.append(elem)
 
     ##
     # how many packages in this build - ignore anonymous ones
@@ -528,7 +539,7 @@ def builddashboard( request, build_id ):
     context = {
             'build'           : build,
             'project'         : build.project,
-            'hasImages'       : build.has_images(),
+            'hasArtifacts'    : has_artifacts,
             'ntargets'        : ntargets,
             'targets'         : targets,
             'recipecount'     : recipeCount,
-- 
1.9.1


